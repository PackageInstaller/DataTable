class = var_0_10000

local var_0_0 = "BlackFridayServerShopPurchasePanel"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".NewServerShopPurchasePanel"))

function var_0_1.OnConfirm(arg_1_0)
	pg = var_1_10001

	local var_1_0 = var_1_10001.m02
	local var_1_1 = var_1.sendNotification

	GAME = var_1_10003

	local var_1_2 = var_1_10003.NEW_SERVER_SHOP_SHOPPING
	local var_1_3 = {}

	ActivityConst = var_1_10005
	var_1_3.actType = var_1_10005.ACTIVITY_TYPE_BLACK_FRIDAY_SHOP
	var_1_3.id = arg_1_0.commodity.id
	var_1_3.selectedList = arg_1_0.selectedList

	var_1_1(var_1_0, var_1_2, var_1_3)

	return
end

return var_0_1
