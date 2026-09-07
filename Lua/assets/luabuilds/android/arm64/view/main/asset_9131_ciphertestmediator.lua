local CipherTestMediator = class("CipherTestMediator", import("..base.ContextMediator"))

function CipherTestMediator:register()
	return
end

function CipherTestMediator:listNotificationInterests()
	return {}
end

function CipherTestMediator:handleNotification(arg_3_1)
	local var_3_0 = arg_3_1:getName()
	local var_3_1 = arg_3_1:getBody()

	return
end

return CipherTestMediator
