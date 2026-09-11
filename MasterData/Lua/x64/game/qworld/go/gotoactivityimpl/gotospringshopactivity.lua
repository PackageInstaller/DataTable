GotoActivityBase = import("game.qworld.go.gotoActivityImpl.GotoActivityBase")

local GotoSpringShopActivity = class("GotoSpringShopActivity", GotoActivityBase)

function GotoSpringShopActivity:OnEnter()
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

return GotoSpringShopActivity
