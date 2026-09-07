local EducateScheduleResultMediator = class("EducateScheduleResultMediator", import(".base.EducateContextMediator"))

function EducateScheduleResultMediator:register()
	return
end

function EducateScheduleResultMediator:listNotificationInterests()
	return {}
end

function EducateScheduleResultMediator:handleNotification(arg_3_1)
	local var_3_0 = arg_3_1:getName()
	local var_3_1 = arg_3_1:getBody()

	return
end

return EducateScheduleResultMediator
