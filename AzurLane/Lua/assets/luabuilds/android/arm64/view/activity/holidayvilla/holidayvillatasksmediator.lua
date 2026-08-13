class = var_0_10000

local var_0_0 = "HolidayVillaTasksMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.ON_TASK_SUBMIT = "HolidayVillaTasksMediator.ON_TASK_SUBMIT"
var_0_1.ON_TASK_SUBMIT_ONESTEP = "HolidayVillaTasksMediator.ON_TASK_SUBMIT_ONESTEP"
var_0_1.ON_TASK_GO = "HolidayVillaTasksMediator.ON_TASK_GO"

function var_0_1.register(arg_1_0)
	arg_1_0:BindEvent()

	return
end

function var_0_1.BindEvent(arg_2_0)
	arg_2_0:bind(var_0_1.ON_TASK_SUBMIT_ONESTEP, function(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
		local var_3_0 = arg_2_0
		local var_3_1 = var_4.sendNotification

		GAME = var_2_10007

		var_3_1(var_3_0, var_2_10007.SUBMIT_ACTIVITY_TASK, {
			act_id = arg_3_1,
			task_ids = arg_3_2,
			callback = arg_3_3
		})

		return
	end)
	arg_2_0:bind(var_0_1.ON_TASK_GO, function(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = arg_2_0
		local var_4_1 = var_3.sendNotification

		GAME = var_2_10006

		var_4_1(var_4_0, var_2_10006.TASK_GO, {
			taskVO = arg_4_1
		})

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_5_0)
	local var_5_0 = {}

	GAME = var_1_10002
	var_5_0[1] = var_1_10002.SUBMIT_TASK_AWARD_DOWN

	return var_5_0
end

function var_0_1.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1
	local var_6_1 = arg_6_1.getName(var_6_0)
	local var_6_2 = arg_6_1:getBody()

	GAME = var_6_0

	if var_6_1 == var_6_0.SUBMIT_TASK_AWARD_DOWN and #var_6_2.awards > 0 then
		local var_6_3 = arg_6_0.viewComponent
		local var_6_4 = var_4.emit

		BaseUI = var_1_10007

		var_6_4(var_6_3, var_1_10007.ON_ACHIEVE, var_6_2.awards, function()
			local var_7_0 = arg_6_0.viewComponent

			var_0.InitData(var_7_0)

			return
		end)
	end

	return
end

return var_0_1
