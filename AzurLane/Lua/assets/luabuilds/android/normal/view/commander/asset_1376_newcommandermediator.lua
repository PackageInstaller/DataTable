class = var_0_10000

local var_0_0 = "NewCommanderMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.ContextMediator"))

var_0_1.ON_LOCK = "NewCommanderMediator:ON_LOCK"

function var_0_1.register(arg_1_0)
	local var_1_0 = arg_1_0

	arg_1_0.bind(var_1_0, var_0_1.ON_LOCK, function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = arg_1_0
		local var_2_1 = var_3.sendNotification

		GAME = var_2_10005

		var_2_1(var_2_0, var_2_10005.COMMANDER_LOCK, {
			commanderId = arg_2_1,
			flag = arg_2_2
		})

		return
	end)

	local var_1_1 = arg_1_0.contextData.commander

	assert = var_1_0

	var_1_0(var_1_1, "commander can not be nil")

	return
end

function var_0_1.listNotificationInterests(arg_3_0)
	local var_3_0 = {}

	GAME = var_1_10002
	var_3_0[1] = var_1_10002.COMMANDER_LOCK_DONE

	return var_3_0
end

function var_0_1.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1
	local var_4_2 = arg_4_1.getBody(var_4_1)

	GAME = var_4_1

	if var_4_0 == var_4_1.COMMANDER_LOCK_DONE then
		local var_4_3 = arg_4_0.viewComponent

		var_4.updateLockState(var_4_3)
	end

	return
end

return var_0_1
