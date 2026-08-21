local var_0_0 = class("EducateSchedulePerformMediator", import(".base.EducateContextMediator"))

var_0_0.WEEKDAY_UPDATE = "WEEKDAY_UPDATE"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.WEEKDAY_UPDATE, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(EducateProxy.TIME_WEEKDAY_UPDATED, {
			weekDay = arg_2_1
		})

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_3_0)
	return {}
end

function var_0_0.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1:getBody()

	return
end

return var_0_0
