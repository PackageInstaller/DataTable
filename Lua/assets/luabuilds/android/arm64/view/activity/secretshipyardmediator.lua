local var_0_0 = class("SecretShipyardMediator", import("..base.ContextMediator"))

var_0_0.GO_MINI_GAME = "go minigame"
var_0_0.SUBMIT_TASK = "submit task"
var_0_0.TASK_GO = "task go"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.GO_MINI_GAME, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.GO_MINI_GAME, arg_2_1)

		return
	end)
	arg_1_0:bind(var_0_0.SUBMIT_TASK, function(arg_3_0, arg_3_1)
		arg_1_0:sendNotification(GAME.SUBMIT_TASK, arg_3_1)

		return
	end)
	arg_1_0:bind(var_0_0.TASK_GO, function(arg_4_0, arg_4_1)
		arg_1_0:sendNotification(GAME.TASK_GO, {
			taskVO = arg_4_1
		})

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_5_0)
	return {
		GAME.SUBMIT_TASK_DONE,
		ActivityProxy.ACTIVITY_OPERATION_DONE
	}
end

function var_0_0.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:getName()

	if var_6_0 == GAME.SUBMIT_TASK_DONE then
		arg_6_0.viewComponent:emit(BaseUI.ON_ACHIEVE, arg_6_1:getBody(), function()
			arg_6_0.viewComponent:updateTaskLayers()

			return
		end)
	elseif var_6_0 == ActivityProxy.ACTIVITY_OPERATION_DONE then
		arg_6_0.viewComponent:updateTaskLayers()
	end

	return
end

return var_0_0
