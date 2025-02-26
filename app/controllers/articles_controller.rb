class ArticlesController < ApplicationController
  http_basic_authenticate_with name: "vinicius", password: "2879", except: [:index, :show]

  def new
    @article = Article.new
  end

  def edit
    find_article
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new
    end
  end

  def update
    find_article

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit
    end
  end

  def show
    find_article
  end

  def index
    @articles = Article.all
  end

  def destroy
    find_article
    @article.destroy

    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :text)
  end

  def find_article
    @article = Article.find(params[:id])
  end
end
