class = var_0_10000

local var_0_0 = "RyzaTaskMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.ContextMediator"))

var_0_1.SUBMIT_TASK_ALL = "activity submit task all"
var_0_1.SUBMIT_TASK = "activity submit task "
var_0_1.TASK_GO = "activity task go "
var_0_1.SHOW_DETAIL = "activity task show detail"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.SUBMIT_TASK_ALL, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10004

		var_2_1(var_2_0, var_2_10004.SUBMIT_ACTIVITY_TASK, {
			act_id = arg_2_1.activityId,
			task_ids = arg_2_1.ids
		})

		return
	end)
	arg_1_0:bind(var_0_1.SUBMIT_TASK, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10004

		var_3_1(var_3_0, var_2_10004.SUBMIT_ACTIVITY_TASK, {
			act_id = arg_3_1.activityId,
			task_ids = {
				arg_3_1.id
			}
		})

		return
	end)
	arg_1_0:bind(var_0_1.TASK_GO, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0
		local var_4_1 = var_2.sendNotification

		GAME = var_2_10004

		var_4_1(var_4_0, var_2_10004.TASK_GO, {
			taskVO = arg_4_1.taskVO
		})

		return
	end)
	arg_1_0:bind(var_0_1.SHOW_DETAIL, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_1_0
		local var_5_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_5_2 = var_2_10004.New
		local var_5_3 = {}

		AtelierMaterialDetailMediator = var_2_10006
		var_5_3.mediator = var_2_10006
		AtelierMaterialDetailLayer = var_2_10006
		var_5_3.viewComponent = var_2_10006
		var_5_3.data = {
			material = arg_5_1
		}

		var_5_1(var_5_0, var_5_2(var_5_3))

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_6_0)
	local var_6_0 = {}

	GAME = var_1_10002
	var_6_0[1] = var_1_10002.SUBMIT_ACTIVITY_TASK_DONE

	return var_6_0
end

function var_0_1.handleNotification(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1:getName()
	local var_7_1 = arg_7_1
	local var_7_2 = arg_7_1.getBody(var_7_1)

	GAME = var_7_1

	if var_7_0 == var_7_1.SUBMIT_ACTIVITY_TASK_DONE then
		if #var_7_2.awards > 0 then
			local var_7_3 = arg_7_0.viewComponent
			local var_7_4 = var_4.emit

			BaseUI = var_1_10006

			var_7_4(var_7_3, var_1_10006.ON_ACHIEVE, var_7_2.awards)
		end

		if var_7_2.callback then
			-- block empty
		end

		local var_7_5 = arg_7_0.viewComponent

		var_4.updateTask(var_7_5, true)
	end

	return
end

return var_0_1
