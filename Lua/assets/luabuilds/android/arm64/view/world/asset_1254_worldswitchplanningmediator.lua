local WorldSwitchPlanningMediator = class("WorldSwitchPlanningMediator", import("view.base.ContextMediator"))

WorldSwitchPlanningMediator.OnConfirm = "WorldSwitchPlanningMediator.OnConfirm"
WorldSwitchPlanningMediator.OnMove = "WorldSwitchPlanningMediator.OnMove"

function WorldSwitchPlanningMediator:register()
	self:bind(WorldSwitchPlanningMediator.OnConfirm, function(arg_2_0)
		self:sendNotification(WorldMediator.OnStartAutoSwitch)

		return
	end)
	self:bind(WorldSwitchPlanningMediator.OnMove, function(arg_3_0, arg_3_1)
		self:sendNotification(WorldMediator.OnMoveAndOpenLayer, arg_3_1)

		return
	end)

	return
end

function WorldSwitchPlanningMediator:listNotificationInterests()
	return {}
end

function WorldSwitchPlanningMediator:handleNotification(arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1:getBody()

	return
end

return WorldSwitchPlanningMediator
