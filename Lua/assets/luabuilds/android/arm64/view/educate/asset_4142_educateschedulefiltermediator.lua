local EducateScheduleFilterMediator = class("EducateScheduleFilterMediator", import(".base.EducateContextMediator"))

function EducateScheduleFilterMediator:register()
	return
end

function EducateScheduleFilterMediator:listNotificationInterests()
	return {}
end

function EducateScheduleFilterMediator:handleNotification(arg_3_1)
	local var_3_0 = arg_3_1:getName()
	local var_3_1 = arg_3_1:getBody()

	return
end

return EducateScheduleFilterMediator
