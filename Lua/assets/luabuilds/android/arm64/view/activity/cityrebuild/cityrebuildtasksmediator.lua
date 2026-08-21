local var_0_0 = class("CityRebuildTasksMediator", import("view.base.ContextMediator"))

var_0_0.ON_SUBMIT_TASK = "CityRebuildTasksMediator.ON_SUBMIT_TASK"
var_0_0.ON_TASK_SUBMIT_ONESTEP = "CityRebuildTasksMediator.ON_TASK_SUBMIT_ONESTEP"
var_0_0.ON_TASK_GO = "CityRebuildTasksMediator.ON_TASK_GO"
var_0_0.STORE_ACTIVITY_AWARDS = "CityRebuildTasksMediator.STORE_ACTIVITY_AWARDS"

function var_0_0.register(arg_1_0)
	arg_1_0:BindEvent()

	arg_1_0.submitTaskIndex = 0
	arg_1_0.tempAwards = {}

	return
end

function var_0_0.BindEvent(arg_2_0)
	arg_2_0:bind(var_0_0.ON_SUBMIT_TASK, function(arg_3_0, arg_3_1, arg_3_2)
		arg_2_0.submitTaskIndex = arg_2_0.submitTaskIndex + 1

		arg_2_0:sendNotification(GAME.SUBMIT_TASK, arg_3_1, arg_3_2)

		return
	end)
	arg_2_0:bind(var_0_0.ON_TASK_SUBMIT_ONESTEP, function(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
		arg_2_0.submitTaskIndex = arg_2_0.submitTaskIndex + 1

		arg_2_0:sendNotification(GAME.SUBMIT_ACTIVITY_TASK, {
			act_id = arg_4_1,
			task_ids = arg_4_2,
			callback = arg_4_3
		})

		return
	end)
	arg_2_0:bind(var_0_0.ON_TASK_GO, function(arg_5_0, arg_5_1, arg_5_2)
		arg_2_0:sendNotification(GAME.TASK_GO, {
			taskVO = arg_5_1
		})

		return
	end)
	arg_2_0:bind(var_0_0.STORE_ACTIVITY_AWARDS, function(arg_6_0, arg_6_1, arg_6_2)
		arg_2_0.storeActivityAwardFlag = arg_6_1
		arg_2_0.taskCount = arg_6_2

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_7_0)
	return {
		GAME.SUBMIT_TASK_AWARD_DOWN,
		ActivityProxy.ACTIVITY_UPDATED
	}
end

function var_0_0.handleNotification(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1:getName()
	local var_8_1 = arg_8_1:getBody()

	if var_8_0 == GAME.SUBMIT_TASK_AWARD_DOWN then
		arg_8_0.submitTaskIndex = arg_8_0.submitTaskIndex - 1

		if #var_8_1.awards > 0 then
			for iter_8_0, iter_8_1 in ipairs(var_8_1.awards) do
				table.insert(arg_8_0.tempAwards, iter_8_1)
			end
		end

		onNextTick(function()
			if arg_8_0.submitTaskIndex == 0 and #arg_8_0.tempAwards > 0 then
				arg_8_0.viewComponent:emit(BaseUI.ON_ACHIEVE, arg_8_0.tempAwards, function()
					arg_8_0.viewComponent:InitData()

					return
				end)

				arg_8_0.tempAwards = {}
			end

			return
		end)
	elseif var_8_0 == ActivityProxy.ACTIVITY_UPDATED then
		onNextTick(function()
			if arg_8_0.submitTaskIndex == 0 and #arg_8_0.tempAwards > 0 then
				arg_8_0.viewComponent:InitData()
			end

			return
		end)
	end

	return
end

return var_0_0
