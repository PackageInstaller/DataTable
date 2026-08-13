class = var_0_10000

local var_0_0 = "EducateTargetSetMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".base.EducateContextMediator"))

var_0_1.ON_TARGET_SET = "EducateTargetSetMediator:ON_TARGET_SET"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_TARGET_SET, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10005

		var_2_1(var_2_0, var_2_10005.EDUCATE_SET_TARGET, {
			id = arg_2_1.id
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
