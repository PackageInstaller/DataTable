local ShopCanteenMaterialContentView = class("ShopCanteenMaterialContentView", (import("game.views.shop.contentViews.ShopContentViewWithPoster")))

function ShopCanteenMaterialContentView.GetAssetPath()
	return "Widget/System/Shop/contentViews/canteenView"
end

return ShopCanteenMaterialContentView
