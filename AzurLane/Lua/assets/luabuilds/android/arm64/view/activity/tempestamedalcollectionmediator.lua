class = var_0_10000

local var_0_0 = "TempestaMedalCollectionMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.ContextMediator"))

var_0_1.ON_TASK_SUBMIT = "TempestaMedalCollectionMediator.ON_TASK_SUBMIT"
var_0_1.ON_TASK_GO = "TempestaMedalCollectionMediator.ON_TASK_GO"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_TASK_SUBMIT, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10005

		var_2_1(var_2_0, var_2_10005.SUBMIT_TASK, arg_2_1.id)

		return
	end)

	local var_1_0 = arg_1_0

	arg_1_0.bind(var_1_0, var_0_1.ON_TASK_GO, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10005

		var_3_1(var_3_0, var_2_10005.TASK_GO, {
			taskVO = arg_3_1
		})

		return
	end)

	getProxy = var_1
	ActivityProxy = var_1_0

	local var_1_1 = var_1(var_1_0)
	local var_1_2 = var_1.getActivityById

	ActivityConst = var_4

	local var_1_3 = var_1_2(var_1_1, var_4.PIRATE_MEDAL_ACT_ID)
	local var_1_4 = arg_1_0.viewComponent

	var_2.setActivity(var_1_4, var_1_3)

	return
end

function var_0_1.initNotificationHandleDic(arg_4_0)
	local var_4_0 = {}

	GAME = var_1_10002
	var_4_0[var_1_10002.SUBMIT_TASK_DONE] = function(arg_5_0, arg_5_1)
		local var_5_0 = arg_5_1:getBody()
		local var_5_1 = arg_5_0.viewComponent
		local var_5_2 = var_3.emit

		BaseUI = var_2_10006

		var_5_2(var_5_1, var_2_10006.ON_ACHIEVE, var_5_0, function()
			local var_6_0 = arg_5_0.viewComponent

			var_0.updateTaskLayers(var_6_0)

			return
		end)

		return
	end
	GAME = var_2
	var_4_0[var_2.SUBMIT_ACTIVITY_TASK_DONE] = function(arg_7_0, arg_7_1)
		local var_7_0 = arg_7_1:getBody()
		local var_7_1 = arg_7_0.viewComponent
		local var_7_2 = var_3.emit

		BaseUI = var_2_10006

		var_7_2(var_7_1, var_2_10006.ON_ACHIEVE, var_7_0.awards, function()
			local var_8_0 = arg_7_0.viewComponent

			var_0.updateTaskLayers(var_8_0)

			return
		end)

		return
	end
	arg_4_0.handleDic = var_4_0

	return
end

return var_0_1
