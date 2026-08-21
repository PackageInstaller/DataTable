local var_0_0 = class("BuildingUpgradeMediator", import("view.base.ContextMediator"))

var_0_0.ACTIVITY_OPERATION = "ACTIVITY_OPERATION"

function var_0_0.register(arg_1_0)
	arg_1_0:BindEvent()

	local var_1_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BUILDING_BUFF)

	assert(var_1_0, "Building Activity Not Found")
	arg_1_0.viewComponent:UpdateActivity(var_1_0)

	return
end

function var_0_0.BindEvent(arg_2_0)
	arg_2_0:bind(var_0_0.ACTIVITY_OPERATION, function(arg_3_0, arg_3_1)
		arg_2_0:sendNotification(GAME.ACTIVITY_OPERATION, arg_3_1)

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_4_0)
	return {
		ActivityProxy.ACTIVITY_UPDATED
	}
end

function var_0_0.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:getBody()

	if arg_5_1:getName() == ActivityProxy.ACTIVITY_UPDATED and var_5_0:getConfig("type") == ActivityConst.ACTIVITY_TYPE_BUILDING_BUFF then
		arg_5_0.viewComponent:UpdateActivity(var_5_0)
		arg_5_0.viewComponent:Set(var_5_0)
	end

	return
end

return var_0_0
