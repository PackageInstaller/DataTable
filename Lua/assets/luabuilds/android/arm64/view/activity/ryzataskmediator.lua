local var_0_0 = class("RyzaTaskMediator", import("..base.ContextMediator"))

var_0_0.SUBMIT_TASK_ALL = "activity submit task all"
var_0_0.SUBMIT_TASK = "activity submit task "
var_0_0.TASK_GO = "activity task go "
var_0_0.SHOW_DETAIL = "activity task show detail"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.SUBMIT_TASK_ALL, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.SUBMIT_ACTIVITY_TASK, {
			act_id = arg_2_1.activityId,
			task_ids = arg_2_1.ids
		})

		return
	end)
	arg_1_0:bind(var_0_0.SUBMIT_TASK, function(arg_3_0, arg_3_1)
		arg_1_0:sendNotification(GAME.SUBMIT_ACTIVITY_TASK, {
			act_id = arg_3_1.activityId,
			task_ids = {
				arg_3_1.id
			}
		})

		return
	end)
	arg_1_0:bind(var_0_0.TASK_GO, function(arg_4_0, arg_4_1)
		arg_1_0:sendNotification(GAME.TASK_GO, {
			taskVO = arg_4_1.taskVO
		})

		return
	end)
	arg_1_0:bind(var_0_0.SHOW_DETAIL, function(arg_5_0, arg_5_1)
		arg_1_0:addSubLayers(Context.New({
			mediator = AtelierMaterialDetailMediator,
			viewComponent = AtelierMaterialDetailLayer,
			data = {
				material = arg_5_1
			}
		}))

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_6_0)
	return {
		GAME.SUBMIT_ACTIVITY_TASK_DONE
	}
end

function var_0_0.handleNotification(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1:getBody()

	if arg_7_1:getName() == GAME.SUBMIT_ACTIVITY_TASK_DONE then
		if #var_7_0.awards > 0 then
			arg_7_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_7_0.awards)
		end

		if var_7_0.callback then
			-- block empty
		end

		arg_7_0.viewComponent:updateTask(true)
	end

	return
end

return var_0_0
