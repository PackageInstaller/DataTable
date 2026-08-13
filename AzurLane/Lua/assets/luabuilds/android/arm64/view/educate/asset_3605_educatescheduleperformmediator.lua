class = var_0_10000

local var_0_0 = "EducateSchedulePerformMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".base.EducateContextMediator"))

var_0_1.WEEKDAY_UPDATE = "WEEKDAY_UPDATE"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.WEEKDAY_UPDATE, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		EducateProxy = var_2_10005

		var_2_1(var_2_0, var_2_10005.TIME_WEEKDAY_UPDATED, {
			weekDay = arg_2_1
		})

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_3_0)
	return {}
end

function var_0_1.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1:getBody()

	return
end

return var_0_1
