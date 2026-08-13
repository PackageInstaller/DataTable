class = var_0_10000

local var_0_0 = "CityRebuildTasksMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.ON_SUBMIT_TASK = "CityRebuildTasksMediator.ON_SUBMIT_TASK"
var_0_1.ON_TASK_SUBMIT_ONESTEP = "CityRebuildTasksMediator.ON_TASK_SUBMIT_ONESTEP"
var_0_1.ON_TASK_GO = "CityRebuildTasksMediator.ON_TASK_GO"
var_0_1.STORE_ACTIVITY_AWARDS = "CityRebuildTasksMediator.STORE_ACTIVITY_AWARDS"

function var_0_1.register(arg_1_0)
	arg_1_0:BindEvent()

	arg_1_0.submitTaskIndex = 0
	arg_1_0.tempAwards = {}

	return
end

function var_0_1.BindEvent(arg_2_0)
	arg_2_0:bind(var_0_1.ON_SUBMIT_TASK, function(arg_3_0, arg_3_1, arg_3_2)
		arg_2_0.submitTaskIndex = arg_2_0.submitTaskIndex + 1

		local var_3_0 = arg_2_0
		local var_3_1 = var_3.sendNotification

		GAME = var_2_10006

		var_3_1(var_3_0, var_2_10006.SUBMIT_TASK, arg_3_1, arg_3_2)

		return
	end)
	arg_2_0:bind(var_0_1.ON_TASK_SUBMIT_ONESTEP, function(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
		arg_2_0.submitTaskIndex = arg_2_0.submitTaskIndex + 1

		local var_4_0 = arg_2_0
		local var_4_1 = var_4.sendNotification

		GAME = var_2_10007

		var_4_1(var_4_0, var_2_10007.SUBMIT_ACTIVITY_TASK, {
			act_id = arg_4_1,
			task_ids = arg_4_2,
			callback = arg_4_3
		})

		return
	end)
	arg_2_0:bind(var_0_1.ON_TASK_GO, function(arg_5_0, arg_5_1, arg_5_2)
		local var_5_0 = arg_2_0
		local var_5_1 = var_3.sendNotification

		GAME = var_2_10006

		var_5_1(var_5_0, var_2_10006.TASK_GO, {
			taskVO = arg_5_1
		})

		return
	end)
	arg_2_0:bind(var_0_1.STORE_ACTIVITY_AWARDS, function(arg_6_0, arg_6_1, arg_6_2)
		arg_2_0.storeActivityAwardFlag = arg_6_1
		arg_2_0.taskCount = arg_6_2

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_7_0)
	local var_7_0 = {}

	GAME = var_1_10002
	var_7_0[1] = var_1_10002.SUBMIT_TASK_AWARD_DOWN
	ActivityProxy = var_2
	var_7_0[2] = var_2.ACTIVITY_UPDATED

	return var_7_0
end

function var_0_1.handleNotification(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1
	local var_8_1 = arg_8_1.getName(var_8_0)
	local var_8_2 = arg_8_1:getBody()

	GAME = var_8_0

	if var_8_1 == var_8_0.SUBMIT_TASK_AWARD_DOWN then
		arg_8_0.submitTaskIndex = arg_8_0.submitTaskIndex - 1

		if #var_8_2.awards > 0 then
			ipairs = var_4

			for iter_8_0, iter_8_1 in var_4(var_8_2.awards) do
				table = var_1_10009

				var_1_10009.insert(arg_8_0.tempAwards, iter_8_1)
			end
		end

		onNextTick = var_4

		var_4(function()
			if arg_8_0.submitTaskIndex == 0 and #arg_8_0.tempAwards > 0 then
				local var_9_0 = arg_8_0.viewComponent
				local var_9_1 = var_0.emit

				BaseUI = var_2_10003

				var_9_1(var_9_0, var_2_10003.ON_ACHIEVE, arg_8_0.tempAwards, function()
					local var_10_0 = arg_8_0.viewComponent

					var_0.InitData(var_10_0)

					return
				end)

				arg_8_0.tempAwards = {}
			end

			return
		end)
	else
		ActivityProxy = var_4

		if var_8_1 == var_4.ACTIVITY_UPDATED then
			onNextTick = var_4

			var_4(function()
				if arg_8_0.submitTaskIndex == 0 and #arg_8_0.tempAwards > 0 then
					local var_11_0 = arg_8_0.viewComponent

					var_0.InitData(var_11_0)
				end

				return
			end)
		end
	end

	return
end

return var_0_1
