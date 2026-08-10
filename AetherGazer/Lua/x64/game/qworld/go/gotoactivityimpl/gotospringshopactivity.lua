GotoActivityBase = import("game.qworld.go.gotoActivityImpl.GotoActivityBase")

local var_0_0 = class("GotoSpringShopActivity", GotoActivityBase)

function var_0_0.OnEnter(arg_1_0)
	JumpTools.GoToSystem("/springFestivalShop", {
		hideHomeBtn = 1,
		infoKey = "SANDPLAY_SHOP_TIP_2",
		shopId = ShopConst.SHOP_ID.SPRING_FESTIVAL_UP,
		showShops = {
			ShopConst.SHOP_ID.SPRING_FESTIVAL_UP,
			ShopConst.SHOP_ID.SPRING_FESTIVAL_DOWN
		}
	}, ViewConst.SYSTEM_ID.SHOP)
end

return var_0_0
