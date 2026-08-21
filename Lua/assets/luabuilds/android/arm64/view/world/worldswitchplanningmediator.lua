local var_0_0 = class("WorldSwitchPlanningMediator", import("view.base.ContextMediator"))

var_0_0.OnConfirm = "WorldSwitchPlanningMediator.OnConfirm"
var_0_0.OnMove = "WorldSwitchPlanningMediator.OnMove"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.OnConfirm, function(arg_2_0)
		arg_1_0:sendNotification(WorldMediator.OnStartAutoSwitch)

		return
	end)
	arg_1_0:bind(var_0_0.OnMove, function(arg_3_0, arg_3_1)
		arg_1_0:sendNotification(WorldMediator.OnMoveAndOpenLayer, arg_3_1)

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_4_0)
	return {}
end

function var_0_0.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1:getBody()

	return
end

return var_0_0
