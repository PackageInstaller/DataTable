local Physics2dMediator = class("Physics2dMediator", import("..base.ContextMediator"))

function Physics2dMediator:register()
	return
end

function Physics2dMediator:listNotificationInterests()
	return {}
end

function Physics2dMediator:handleNotification(arg_3_1)
	local var_3_0 = arg_3_1:getName()
	local var_3_1 = arg_3_1:getBody()

	return
end

return Physics2dMediator
