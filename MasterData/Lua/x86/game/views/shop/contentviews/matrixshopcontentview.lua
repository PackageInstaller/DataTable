local MatrixShopContentView = class("MatrixShopContentView", (import("game.views.shop.contentViews.ShopExchangeContentView")))

function MatrixShopContentView:GetExchangeGoodList()
	return (ShopTools.FilterShopDataList(self.shopId_, true))
end

return MatrixShopContentView
