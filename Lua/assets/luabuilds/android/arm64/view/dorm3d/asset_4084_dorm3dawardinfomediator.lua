local Dorm3dAwardInfoMediator = class("Dorm3dAwardInfoMediator", import("view.base.ContextMediator"))

function Dorm3dAwardInfoMediator:register()
	return
end

function Dorm3dAwardInfoMediator:listNotificationInterests()
	return {}
end

function Dorm3dAwardInfoMediator:handleNotification(arg_3_1)
	local var_3_0 = arg_3_1:getName()
	local var_3_1 = arg_3_1:getBody()

	return
end

return Dorm3dAwardInfoMediator
