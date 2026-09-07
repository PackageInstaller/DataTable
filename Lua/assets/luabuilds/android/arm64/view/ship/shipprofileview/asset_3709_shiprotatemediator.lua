local ShipRotateMediator = class("ShipRotateMediator", import("...base.ContextMediator"))

function ShipRotateMediator:register()
	return
end

function ShipRotateMediator:listNotificationInterests()
	return {}
end

function ShipRotateMediator:handleNotification(arg_3_1)
	local var_3_0 = arg_3_1:getName()
	local var_3_1 = arg_3_1:getBody()

	return
end

return ShipRotateMediator
