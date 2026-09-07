local ShipBreakResultMediator = class("ShipBreakResultMediator", import("..base.ContextMediator"))

function ShipBreakResultMediator:register()
	if self.contextData.newShip and self.contextData.oldShip then
		self.viewComponent:updateStatistics()
	end

	return
end

function ShipBreakResultMediator:listNotificationInterests()
	return {}
end

function ShipBreakResultMediator:handleNotification(arg_3_1)
	local var_3_0 = arg_3_1:getName()
	local var_3_1 = arg_3_1:getBody()

	return
end

return ShipBreakResultMediator
