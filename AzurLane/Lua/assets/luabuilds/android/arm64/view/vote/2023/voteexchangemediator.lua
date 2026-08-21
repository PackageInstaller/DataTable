local var_0_0 = class("VoteExchangeMediator", import("view.base.ContextMediator"))

var_0_0.GO_TASK = "VoteExchangeMediator:GO_TASK"
var_0_0.SKIP_TASK = "VoteExchangeMediator:SKIP_TASK"
var_0_0.SUBMIT_TASK = "VoteExchangeMediator:SUBMIT_TASK"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.GO_TASK, function(arg_2_0)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.TASK, {
			page = TaskScene.PAGE_TYPE_ROUTINE
		})

		return
	end)
	arg_1_0:bind(var_0_0.SKIP_TASK, function(arg_3_0, arg_3_1)
		arg_1_0:sendNotification(GAME.TASK_GO, {
			taskVO = arg_3_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.SUBMIT_TASK, function(arg_4_0, arg_4_1)
		arg_1_0:sendNotification(GAME.SUBMIT_TASK, arg_4_1)

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_5_0)
	return {
		GAME.SUBMIT_TASK_DONE
	}
end

function var_0_0.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:getBody()

	if arg_6_1:getName() == GAME.SUBMIT_TASK_DONE then
		arg_6_0.viewComponent:Flush()
	end

	return
end

return var_0_0
