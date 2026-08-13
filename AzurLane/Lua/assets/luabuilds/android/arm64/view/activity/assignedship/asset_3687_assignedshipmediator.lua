class = var_0_10000

local var_0_0 = "AssignedShipMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.ContextMediator"))

var_0_1.ON_USE_ITEM = "AssignedShipMediator:ON_USE_ITEM"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_USE_ITEM, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		local var_2_0 = arg_1_0
		local var_2_1 = var_4.sendNotification

		GAME = var_2_10007

		var_2_1(var_2_0, var_2_10007.USE_ITEM, {
			id = arg_2_1,
			count = arg_2_2,
			arg = arg_2_3
		})

		return
	end)

	local var_1_0 = arg_1_0.viewComponent

	var_1.setItemVO(var_1_0, arg_1_0.contextData.itemVO)

	return
end

function var_0_1.listNotificationInterests(arg_3_0)
	local var_3_0 = {}

	GAME = var_1_10002
	var_3_0[1] = var_1_10002.USE_ITEM_DONE

	return var_3_0
end

function var_0_1.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1
	local var_4_1 = arg_4_1.getName(var_4_0)
	local var_4_2 = arg_4_1:getBody()

	GAME = var_4_0

	if var_4_1 == var_4_0.USE_ITEM_DONE then
		local var_4_3 = arg_4_0.viewComponent
		local var_4_4 = var_4.emit

		BaseUI = var_1_10007

		var_4_4(var_4_3, var_1_10007.ON_ACHIEVE, var_4_2.drops, function()
			triggerButton = var_2_10000

			var_2_10000(arg_4_0.viewComponent.backBtn)

			return
		end)
	end

	return
end

return var_0_1
