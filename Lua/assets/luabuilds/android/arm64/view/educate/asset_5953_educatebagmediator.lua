local EducateBagMediator = class("EducateBagMediator", import(".base.EducateContextMediator"))

function EducateBagMediator:register()
	return
end

function EducateBagMediator:listNotificationInterests()
	return {}
end

function EducateBagMediator:handleNotification(arg_3_1)
	local var_3_0 = arg_3_1:getName()
	local var_3_1 = arg_3_1:getBody()

	return
end

return EducateBagMediator
