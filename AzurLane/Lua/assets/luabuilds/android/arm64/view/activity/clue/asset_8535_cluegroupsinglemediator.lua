class = var_0_10000

local var_0_0 = "ClueGroupSingleMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.OPEN_CLUE_JUMP = "ClueGroupSingleMediator.OPEN_CLUE_JUMP"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.OPEN_CLUE_JUMP, function(arg_2_0, arg_2_1)
		print = var_2_10002

		var_2_10002(arg_2_1)

		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		ClueMapMediator = var_2_10005

		var_2_1(var_2_0, var_2_10005.OPEN_CLUE_JUMP, {
			jumpID = arg_2_1
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
