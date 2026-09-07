local EducateCalendarMediator = class("EducateCalendarMediator", import(".base.EducateContextMediator"))

function EducateCalendarMediator:register()
	return
end

function EducateCalendarMediator:listNotificationInterests()
	return {}
end

function EducateCalendarMediator:handleNotification(arg_3_1)
	local var_3_0 = arg_3_1:getName()
	local var_3_1 = arg_3_1:getBody()

	return
end

return EducateCalendarMediator
