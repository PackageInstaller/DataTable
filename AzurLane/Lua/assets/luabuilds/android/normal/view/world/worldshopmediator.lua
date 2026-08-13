class = var_0_10000

local var_0_0 = "WorldShopMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.BUY_ITEM = "WorldShopMediator:BUY_ITEM"

function var_0_1.register(arg_1_0)
	local var_1_0 = arg_1_0

	arg_1_0.bind(var_1_0, var_0_1.BUY_ITEM, function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = arg_1_0
		local var_2_1 = var_3.sendNotification

		GAME = var_2_10005

		var_2_1(var_2_0, var_2_10005.SHOPPING, {
			id = arg_2_1,
			count = arg_2_2
		})

		return
	end)

	getProxy = var_1
	PlayerProxy = var_1_0

	local var_1_1 = var_1(var_1_0)
	local var_1_2 = arg_1_0.viewComponent

	var_2.setPlayer(var_1_2, var_1_1:getRawData())

	return
end

function var_0_1.listNotificationInterests(arg_3_0)
	local var_3_0 = {}

	PlayerProxy = var_1_10002
	var_3_0[1] = var_1_10002.UPDATED
	GAME = var_2
	var_3_0[2] = var_2.SHOPPING_DONE

	return var_3_0
end

function var_0_1.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1
	local var_4_2 = arg_4_1.getBody(var_4_1)

	PlayerProxy = var_4_1

	if var_4_0 == var_4_1.UPDATED then
		local var_4_3 = arg_4_0.viewComponent

		var_4.setPlayer(var_4_3, var_4_2)
	else
		GAME = var_4

		if var_4_0 == var_4.SHOPPING_DONE and #var_4_2.awards > 0 then
			local var_4_4 = arg_4_0.viewComponent
			local var_4_5 = var_4.emit

			BaseUI = var_1_10006

			var_4_5(var_4_4, var_1_10006.ON_AWARD, {
				items = var_4_2.awards
			})
		end
	end

	return
end

return var_0_1
