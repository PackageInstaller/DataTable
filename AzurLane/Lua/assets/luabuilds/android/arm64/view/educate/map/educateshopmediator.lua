class = var_0_10000

local var_0_0 = "EducateShopMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.EducateContextMediator"))

var_0_1.ON_SHOPPING = "ON_SHOPPING"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_SHOPPING, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10005

		var_2_1(var_2_0, var_2_10005.EDUCATE_SHOPPING, {
			shopId = arg_2_1.shopId,
			goods = arg_2_1.goods
		})

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_3_0)
	local var_3_0 = {}

	GAME = var_1_10002
	var_3_0[1] = var_1_10002.EDUCATE_SHOPPING_DONE

	return var_3_0
end

function var_0_1.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1
	local var_4_1 = arg_4_1.getName(var_4_0)
	local var_4_2 = arg_4_1:getBody()

	GAME = var_4_0

	if var_4_1 == var_4_0.EDUCATE_SHOPPING_DONE then
		local var_4_3 = arg_4_0.viewComponent
		local var_4_4 = var_4.emit

		EducateBaseUI = var_1_10007

		var_4_4(var_4_3, var_1_10007.EDUCATE_ON_AWARD, {
			items = var_4_2.drops
		})

		local var_4_5 = arg_4_0.viewComponent

		var_4.refreshShops(var_4_5)
	end

	return
end

return var_0_1
