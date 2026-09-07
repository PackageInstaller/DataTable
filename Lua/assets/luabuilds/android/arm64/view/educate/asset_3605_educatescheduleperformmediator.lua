local EducateSchedulePerformMediator = class("EducateSchedulePerformMediator", import(".base.EducateContextMediator"))

EducateSchedulePerformMediator.WEEKDAY_UPDATE = "WEEKDAY_UPDATE"

function EducateSchedulePerformMediator:register()
	self:bind(EducateSchedulePerformMediator.WEEKDAY_UPDATE, function(arg_2_0, arg_2_1)
		self:sendNotification(EducateProxy.TIME_WEEKDAY_UPDATED, {
			weekDay = arg_2_1
		})

		return
	end)

	return
end

function EducateSchedulePerformMediator:listNotificationInterests()
	return {}
end

function EducateSchedulePerformMediator:handleNotification(arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1:getBody()

	return
end

return EducateSchedulePerformMediator
