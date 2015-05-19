class ChefsController < ApplicationController
	before_action :reqiure_user, only: [:edit, :update]
	def new
		@chef =Chef.new
	end
	
	def create
		@chef = Chef.new (chef_params)
		if @chef.save
			flash[:success] = "Your account has been created successfuly"
			session[:chef_id]= @chef.id
			redirect_to recipes_path
		else
			render :new

		end
	end

	def edit
		
	end
	def index
		@chefs = Chef.paginate(page: params[:page], per_page: 3)
	end

	def update
		if @chef.update(chef_params)
			flash[:success] = "Your account has been updated"
			redirect_to chef_path(@chef)
		else
			render :edit
		end
	end

	def show
		@chef= Chef.find(params[:id])
		@recipes= @chef.recipes.paginate(page: params[:page], per_page: 4)	
	end	
	private

		def chef_params
			params.require(:chef).permit( :name, :email, :password)
		end
		def reqiure_user
			@chef= Chef.find(params[:id])
			redirect_to root_path if current_user != @chef
		end


end
