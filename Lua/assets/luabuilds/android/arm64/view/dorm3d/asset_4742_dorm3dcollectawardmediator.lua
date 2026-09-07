local Dorm3dCollectAwardMediator = class("Dorm3dCollectAwardMediator", import("view.base.ContextMediator"))

function Dorm3dCollectAwardMediator:register()
	return
end

function Dorm3dCollectAwardMediator:listNotificationInterests()
	return {}
end

function Dorm3dCollectAwardMediator:handleNotification(arg_3_1)
	local var_3_0 = arg_3_1:getName()
	local var_3_1 = arg_3_1:getBody()

	return
end

return Dorm3dCollectAwardMediator
