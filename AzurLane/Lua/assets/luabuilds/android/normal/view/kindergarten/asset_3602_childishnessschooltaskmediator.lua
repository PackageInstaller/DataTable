class = var_0_10000

local var_0_0 = "ChildishnessSchoolTaskMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.ON_TASK_GO = "event on task go"
var_0_1.ON_TASK_SUBMIT = "event on task submit"
var_0_1.ON_TASK_SUBMIT_ONESTEP = "event on task submit one step"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_TASK_GO, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10004

		var_2_1(var_2_0, var_2_10004.TASK_GO, {
			taskVO = arg_2_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_TASK_SUBMIT, function(arg_3_0, arg_3_1, arg_3_2)
		local var_3_0 = arg_1_0
		local var_3_1 = var_3.sendNotification

		GAME = var_2_10005

		var_3_1(var_3_0, var_2_10005.SUBMIT_TASK, arg_3_1.id, arg_3_2)

		return
	end)
	arg_1_0:bind(var_0_1.ON_TASK_SUBMIT_ONESTEP, function(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = arg_1_0
		local var_4_1 = var_3.sendNotification

		GAME = var_2_10005

		var_4_1(var_4_0, var_2_10005.SUBMIT_ACTIVITY_TASK, {
			act_id = arg_4_1,
			task_ids = arg_4_2
		})

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_5_0)
	local var_5_0 = {}

	GAME = var_1_10002
	var_5_0[1] = var_1_10002.SUBMIT_TASK_DONE
	GAME = var_2
	var_5_0[2] = var_2.SUBMIT_AVATAR_TASK_DONE
	GAME = var_2
	var_5_0[3] = var_2.SUBMIT_ACTIVITY_TASK_DONE

	return var_5_0
end

function var_0_1.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:getName()
	local var_6_1 = arg_6_1
	local var_6_2 = arg_6_1.getBody(var_6_1)

	GAME = var_6_1

	local var_6_4

	if var_6_0 == var_6_1.SUBMIT_TASK_DONE then
		local var_6_3 = arg_6_0.viewComponent

		var_6_4 = var_6_4.emit
		BaseUI = var_1_10006

		var_6_4(var_6_3, var_1_10006.ON_ACHIEVE, var_6_2)

		local var_6_5 = arg_6_0.viewComponent

		var_6_4.Show(var_6_5)

		goto label_6_0
	end

	GAME = var_6_4

	if var_6_0 ~= var_6_4.SUBMIT_AVATAR_TASK_DONE then
		GAME = var_4

		if var_6_0 == var_4.SUBMIT_ACTIVITY_TASK_DONE then
			local var_6_6 = arg_6_0.viewComponent
			local var_6_7 = var_4.emit

			BaseUI = var_1_10006

			var_6_7(var_6_6, var_1_10006.ON_ACHIEVE, var_6_2.awards)

			local var_6_8 = arg_6_0.viewComponent

			var_4.Show(var_6_8)
		end

		::label_6_0::

		return
	end
end

return var_0_1
