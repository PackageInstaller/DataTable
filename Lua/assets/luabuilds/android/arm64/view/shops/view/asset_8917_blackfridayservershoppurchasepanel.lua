local BlackFridayServerShopPurchasePanel = class("BlackFridayServerShopPurchasePanel", import(".NewServerShopPurchasePanel"))

function BlackFridayServerShopPurchasePanel:OnConfirm()
	pg.m02:sendNotification(GAME.NEW_SERVER_SHOP_SHOPPING, {
		actType = ActivityConst.ACTIVITY_TYPE_BLACK_FRIDAY_SHOP,
		id = self.commodity.id,
		selectedList = self.selectedList
	})

	return
end

return BlackFridayServerShopPurchasePanel
