class = var_0_10000

local var_0_0 = "Dorm3dBaseMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

function var_0_1.GetDefaultSystemClasses()
	DormConst = var_1_10000

	return var_1_10000.GetDefaultSystemClasses()
end

function var_0_1.handleNotification(arg_2_0, arg_2_1)
	var_0_1.super.handleNotification(arg_2_0, arg_2_1)

	local var_2_0 = arg_2_1:getName()
	local var_2_1 = arg_2_1:getBody()

	if arg_2_0.viewComponent.systemManager then
		local var_2_2 = arg_2_0.viewComponent.systemManager

		var_4.BroadcastNotification(var_2_2, var_2_0, var_2_1)
	end

	return
end

function var_0_1.listNotificationInterests(arg_3_0)
	underscore = var_1_10001

	local var_3_0 = var_1_10001.keys
	local var_3_1

	if not arg_3_0.handleDic then
		var_3_1 = {}
	end

	local var_3_2 = var_3_0(var_3_1)

	if arg_3_0.viewComponent and arg_3_0.viewComponent.systemManager then
		table = var_2

		local var_3_3 = var_2.mergeArray

		var_1_10003 = var_3_2

		local var_3_4 = arg_3_0.viewComponent.systemManager

		var_3_2 = var_3_3(var_1_10003, var_4.GetAllInterests(var_3_4), true)
	else
		local var_3_5 = arg_3_0.GetDefaultSystemClasses()

		ipairs = var_1_10003

		for iter_3_0, iter_3_1 in var_1_10003(var_3_5) do
			if iter_3_1.GetInterests then
				table = var_8
				var_3_2 = var_8.mergeArray(var_3_2, iter_3_1.GetInterests())
			end
		end
	end

	return var_3_2
end

return var_0_1
