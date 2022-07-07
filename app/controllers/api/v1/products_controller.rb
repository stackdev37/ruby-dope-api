class Api::V1::ProductsController < ApplicationController
  # index renders all times in the table
  def index
    products = Product.all
    render json: products, status: 200
  end

  # if the product saves successfully, we render json data for the product
  # if the product does not save correctly, we render json error code
  def create
    product = Product.new(
      name: prod_params[:name], 
      brand: prod_params[:brand], 
      price: prod_params[:price], 
      description: prod_params[:description]
    )
    if product.save
      render json: product, status: 200
    else
      render json: {error: 'error creating review.'}
    end
  end

  # This method looks up the product by id, it we find out. 
  # Otherwise, we render error message
  def show
    product = Product.find_by(id: params[:id])
    if product
      render json: product, status: 200
    else
      render json: {error: 'product not found'}
    end
  end

  private
    def prod_params
      params.require(:product).permit([
        :name, 
        :brand, 
        :price, 
        :description
      ])
    end
end
