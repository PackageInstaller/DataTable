local AppreciatePicFullScreenMediator = class("AppreciatePicFullScreenMediator", import("..base.ContextMediator"))

function AppreciatePicFullScreenMediator:register()
	return
end

function AppreciatePicFullScreenMediator:listNotificationInterests()
	return {}
end

function AppreciatePicFullScreenMediator:handleNotification(arg_3_1)
	local var_3_0 = arg_3_1:getName()
	local var_3_1 = arg_3_1:getBody()

	return
end

return AppreciatePicFullScreenMediator
