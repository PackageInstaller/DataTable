class = var_0_10000

local var_0_0 = "NewCommanderMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.ContextMediator"))

var_0_1.ON_LOCK = "NewCommanderMediator:ON_LOCK"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_LOCK, function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = arg_1_0
		local var_2_1 = var_3.sendNotification

		GAME = var_2_10006

		var_2_1(var_2_0, var_2_10006.COMMANDER_LOCK, {
			commanderId = arg_2_1,
			flag = arg_2_2
		})

		return
	end)

	local var_1_0 = arg_1_0.contextData.commander

	assert = var_1_10002

	var_1_10002(var_1_0, "commander can not be nil")

	return
end

function var_0_1.listNotificationInterests(arg_3_0)
	local var_3_0 = {}

	GAME = var_1_10002
	var_3_0[1] = var_1_10002.COMMANDER_LOCK_DONE

	return var_3_0
end

function var_0_1.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1
	local var_4_1 = arg_4_1.getName(var_4_0)
	local var_4_2 = arg_4_1:getBody()

	GAME = var_4_0

	if var_4_1 == var_4_0.COMMANDER_LOCK_DONE then
		local var_4_3 = arg_4_0.viewComponent

		var_4.updateLockState(var_4_3)
	end

	return
end

return var_0_1
