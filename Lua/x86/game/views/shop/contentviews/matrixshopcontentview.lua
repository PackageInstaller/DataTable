local var_0_0 = import("game.views.shop.contentViews.ShopExchangeContentView")
local var_0_1 = class("MatrixShopContentView", var_0_0)

function var_0_1.GetExchangeGoodList(arg_1_0)
	return (ShopTools.FilterShopDataList(arg_1_0.shopId_, true))
end

return var_0_1
