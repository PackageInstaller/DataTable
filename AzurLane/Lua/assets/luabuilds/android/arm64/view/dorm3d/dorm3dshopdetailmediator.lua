class = var_0_10000

local var_0_0 = "Dorm3dShopDetailMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.SHOPPING = "Dorm3dShopDetailMediator.SHOPPING"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.SHOPPING, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10005

		var_2_1(var_2_0, var_2_10005.SHOPPING, {
			id = arg_2_1.shopId,
			count = arg_2_1.count,
			silentTip = arg_2_1.silentTip
		})

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_3_0)
	local var_3_0 = {}

	GAME = var_1_10002
	var_3_0[1] = var_1_10002.SHOPPING_DONE

	return var_3_0
end

function var_0_1.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1
	local var_4_1 = arg_4_1.getName(var_4_0)
	local var_4_2 = arg_4_1:getBody()

	GAME = var_4_0

	if var_4_1 == var_4_0.SHOPPING_DONE then
		local var_4_3 = arg_4_0.viewComponent

		var_4.closeView(var_4_3)
	end

	return
end

function var_0_1.remove(arg_5_0)
	return
end

return var_0_1
