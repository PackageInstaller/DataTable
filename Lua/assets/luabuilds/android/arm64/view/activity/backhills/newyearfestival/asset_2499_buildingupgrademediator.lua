local BuildingUpgradeMediator = class("BuildingUpgradeMediator", import("view.base.ContextMediator"))

BuildingUpgradeMediator.ACTIVITY_OPERATION = "ACTIVITY_OPERATION"

function BuildingUpgradeMediator:register()
	self:BindEvent()

	local var_1_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BUILDING_BUFF)

	assert(var_1_0, "Building Activity Not Found")
	self.viewComponent:UpdateActivity(var_1_0)

	return
end

function BuildingUpgradeMediator:BindEvent()
	self:bind(BuildingUpgradeMediator.ACTIVITY_OPERATION, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.ACTIVITY_OPERATION, arg_3_1)

		return
	end)

	return
end

function BuildingUpgradeMediator:listNotificationInterests()
	return {
		ActivityProxy.ACTIVITY_UPDATED
	}
end

function BuildingUpgradeMediator:handleNotification(arg_5_1)
	local var_5_0 = arg_5_1:getBody()

	if arg_5_1:getName() == ActivityProxy.ACTIVITY_UPDATED and var_5_0:getConfig("type") == ActivityConst.ACTIVITY_TYPE_BUILDING_BUFF then
		self.viewComponent:UpdateActivity(var_5_0)
		self.viewComponent:Set(var_5_0)
	end

	return
end

return BuildingUpgradeMediator
