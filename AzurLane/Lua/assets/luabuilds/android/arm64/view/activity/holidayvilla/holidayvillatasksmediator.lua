local var_0_0 = class("HolidayVillaTasksMediator", import("view.base.ContextMediator"))

var_0_0.ON_TASK_SUBMIT = "HolidayVillaTasksMediator.ON_TASK_SUBMIT"
var_0_0.ON_TASK_SUBMIT_ONESTEP = "HolidayVillaTasksMediator.ON_TASK_SUBMIT_ONESTEP"
var_0_0.ON_TASK_GO = "HolidayVillaTasksMediator.ON_TASK_GO"

function var_0_0.register(arg_1_0)
	arg_1_0:BindEvent()

	return
end

function var_0_0.BindEvent(arg_2_0)
	arg_2_0:bind(var_0_0.ON_TASK_SUBMIT_ONESTEP, function(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
		arg_2_0:sendNotification(GAME.SUBMIT_ACTIVITY_TASK, {
			act_id = arg_3_1,
			task_ids = arg_3_2,
			callback = arg_3_3
		})

		return
	end)
	arg_2_0:bind(var_0_0.ON_TASK_GO, function(arg_4_0, arg_4_1, arg_4_2)
		arg_2_0:sendNotification(GAME.TASK_GO, {
			taskVO = arg_4_1
		})

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_5_0)
	return {
		GAME.SUBMIT_TASK_AWARD_DOWN
	}
end

function var_0_0.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:getBody()

	if arg_6_1:getName() == GAME.SUBMIT_TASK_AWARD_DOWN and #var_6_0.awards > 0 then
		arg_6_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_6_0.awards, function()
			arg_6_0.viewComponent:InitData()

			return
		end)
	end

	return
end

return var_0_0
