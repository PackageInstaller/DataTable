class = var_0_10000

local var_0_0 = "WorldSwitchPlanningMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.OnConfirm = "WorldSwitchPlanningMediator.OnConfirm"
var_0_1.OnMove = "WorldSwitchPlanningMediator.OnMove"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.OnConfirm, function(arg_2_0)
		local var_2_0 = arg_1_0
		local var_2_1 = var_1.sendNotification

		WorldMediator = var_2_10004

		var_2_1(var_2_0, var_2_10004.OnStartAutoSwitch)

		return
	end)
	arg_1_0:bind(var_0_1.OnMove, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		WorldMediator = var_2_10005

		var_3_1(var_3_0, var_2_10005.OnMoveAndOpenLayer, arg_3_1)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_4_0)
	return {}
end

function var_0_1.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1:getBody()

	return
end

return var_0_1
