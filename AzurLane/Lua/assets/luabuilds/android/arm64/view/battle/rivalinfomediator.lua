class = var_0_10000

local var_0_0 = "RivalInfoMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.ContextMediator"))

var_0_1.START_BATTLE = "RivalInfoMediator:START_BATTLE"

function var_0_1.register(arg_1_0)
	assert = var_1_10001

	var_1_10001(arg_1_0.contextData.rival, "rival should exist")

	assert = var_1_10001

	var_1_10001(arg_1_0.contextData.type, "type should exist")

	local var_1_0 = arg_1_0.viewComponent

	var_1.setRival(var_1_0, arg_1_0.contextData.rival)
	arg_1_0:bind(var_0_1.START_BATTLE, function(arg_2_0)
		local var_2_0
		local var_2_1 = arg_1_0.contextData.type

		RivalInfoLayer = var_2_10003

		if var_2_1 == var_2_10003.TYPE_BATTLE then
			SYSTEM_DUEL = var_2_0
		end

		local var_2_2 = arg_1_0
		local var_2_3 = var_2.sendNotification

		GAME = var_2_10005

		var_2_3(var_2_2, var_2_10005.MILITARY_STARTED, {
			rivalId = arg_1_0.contextData.rival.id,
			system = var_2_0
		})

		local var_2_4 = arg_1_0.viewComponent
		local var_2_5 = var_2.emit

		BaseUI = var_5

		var_2_5(var_2_4, var_5.ON_CLOSE)

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
