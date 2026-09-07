local EducateNewsMediator = class("EducateNewsMediator", import(".base.EducateContextMediator"))

function EducateNewsMediator:register()
	return
end

function EducateNewsMediator:listNotificationInterests()
	return {}
end

function EducateNewsMediator:handleNotification(arg_3_1)
	local var_3_0 = arg_3_1:getName()
	local var_3_1 = arg_3_1:getBody()

	return
end

return EducateNewsMediator
