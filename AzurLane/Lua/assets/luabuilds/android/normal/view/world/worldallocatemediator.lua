class = var_0_10000

local var_0_0 = "WorldAllocateMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.ContextMediator"))

function var_0_1.register(arg_1_0)
	local var_1_0 = arg_1_0.viewComponent

	var_1.setItem(var_1_0, arg_1_0.contextData.itemVO)

	local var_1_1 = arg_1_0.viewComponent

	var_1.setFleets(var_1_1, arg_1_0.contextData.fleetList)

	local var_1_2 = arg_1_0.viewComponent

	var_1.setConfirmCallback(var_1_2, arg_1_0.contextData.confirmCallback)

	return
end

function var_0_1.listNotificationInterests(arg_2_0)
	local var_2_0 = {}

	GAME = var_1_10002
	var_2_0[1] = var_1_10002.WORLD_ITEM_USE_DONE

	return var_2_0
end

function var_0_1.handleNotification(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1:getName()
	local var_3_1 = arg_3_1
	local var_3_2 = arg_3_1.getBody(var_3_1)

	GAME = var_3_1

	if var_3_0 == var_3_1.WORLD_ITEM_USE_DONE then
		local var_3_3 = arg_3_0.viewComponent

		var_4.flush(var_3_3, var_3_2.item)
	end

	return
end

return var_0_1
