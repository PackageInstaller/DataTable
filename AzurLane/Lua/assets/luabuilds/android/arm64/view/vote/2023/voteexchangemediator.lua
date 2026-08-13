class = var_0_10000

local var_0_0 = "VoteExchangeMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.GO_TASK = "VoteExchangeMediator:GO_TASK"
var_0_1.SKIP_TASK = "VoteExchangeMediator:SKIP_TASK"
var_0_1.SUBMIT_TASK = "VoteExchangeMediator:SUBMIT_TASK"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.GO_TASK, function(arg_2_0)
		local var_2_0 = arg_1_0
		local var_2_1 = var_1.sendNotification

		GAME = var_2_10004

		local var_2_2 = var_2_10004.GO_SCENE

		SCENE = var_2_10005

		local var_2_3 = var_2_10005.TASK
		local var_2_4 = {}

		TaskScene = var_2_10007
		var_2_4.page = var_2_10007.PAGE_TYPE_ROUTINE

		var_2_1(var_2_0, var_2_2, var_2_3, var_2_4)

		return
	end)
	arg_1_0:bind(var_0_1.SKIP_TASK, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10005

		var_3_1(var_3_0, var_2_10005.TASK_GO, {
			taskVO = arg_3_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.SUBMIT_TASK, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0
		local var_4_1 = var_2.sendNotification

		GAME = var_2_10005

		var_4_1(var_4_0, var_2_10005.SUBMIT_TASK, arg_4_1)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_5_0)
	local var_5_0 = {}

	GAME = var_1_10002
	var_5_0[1] = var_1_10002.SUBMIT_TASK_DONE

	return var_5_0
end

function var_0_1.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1
	local var_6_1 = arg_6_1.getName(var_6_0)
	local var_6_2 = arg_6_1:getBody()

	GAME = var_6_0

	if var_6_1 == var_6_0.SUBMIT_TASK_DONE then
		local var_6_3 = arg_6_0.viewComponent

		var_4.Flush(var_6_3)
	end

	return
end

return var_0_1
