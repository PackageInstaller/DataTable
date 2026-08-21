local var_0_0 = class("BlackFridayServerShopPurchasePanel", import(".NewServerShopPurchasePanel"))

function var_0_0.OnConfirm(arg_1_0)
	pg.m02:sendNotification(GAME.NEW_SERVER_SHOP_SHOPPING, {
		actType = ActivityConst.ACTIVITY_TYPE_BLACK_FRIDAY_SHOP,
		id = arg_1_0.commodity.id,
		selectedList = arg_1_0.selectedList
	})

	return
end

return var_0_0
