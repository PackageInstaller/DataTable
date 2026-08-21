local var_0_0 = class("ShipBreakResultMediator", import("..base.ContextMediator"))

function var_0_0.register(arg_1_0)
	if arg_1_0.contextData.newShip and arg_1_0.contextData.oldShip then
		arg_1_0.viewComponent:updateStatistics()
	end

	return
end

function var_0_0.listNotificationInterests(arg_2_0)
	return {}
end

function var_0_0.handleNotification(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1:getName()
	local var_3_1 = arg_3_1:getBody()

	return
end

return var_0_0
