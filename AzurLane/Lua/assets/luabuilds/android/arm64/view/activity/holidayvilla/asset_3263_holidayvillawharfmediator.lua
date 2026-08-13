class = var_0_10000

local var_0_0 = "HolidayVillaWharfMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.ON_TASK_SUBMIT_ONESTEP = "HolidayVillaWharfMediator.ON_TASK_SUBMIT_ONESTEP"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_TASK_SUBMIT_ONESTEP, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		local var_2_0 = arg_1_0
		local var_2_1 = var_4.sendNotification

		GAME = var_2_10007

		var_2_1(var_2_0, var_2_10007.SUBMIT_ACTIVITY_TASK, {
			act_id = arg_2_1,
			task_ids = arg_2_2,
			callback = arg_2_3
		})

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_3_0)
	local var_3_0 = {}

	GAME = var_1_10002
	var_3_0[1] = var_1_10002.SUBMIT_ACTIVITY_TASK_DONE

	return var_3_0
end

function var_0_1.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1
	local var_4_1 = arg_4_1.getName(var_4_0)
	local var_4_2 = arg_4_1:getBody()

	GAME = var_4_0

	if var_4_1 == var_4_0.SUBMIT_ACTIVITY_TASK_DONE then
		local var_4_3 = arg_4_0.viewComponent

		var_4.SetAwardsShow(var_4_3, var_4_2.awards)

		local var_4_4 = arg_4_0.viewComponent

		var_4.RefreshData(var_4_4)

		local var_4_5 = arg_4_0.viewComponent

		var_4.Show(var_4_5)

		local var_4_6 = arg_4_0.viewComponent

		var_4.ShowCompletePage(var_4_6)
	end

	return
end

return var_0_1
