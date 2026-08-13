class = var_0_10000

local var_0_0 = "AterialYumiaCoreBuffMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.SUBMIT_TASK = "AterialYumiaCoreBuffMediator.SUBMIT_TASK"

function var_0_1.register(arg_1_0)
	local var_1_0 = arg_1_0

	arg_1_0.bind(var_1_0, var_0_1.SUBMIT_TASK, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10004

		var_2_1(var_2_0, var_2_10004.SUBMIT_TASK, arg_2_1)

		return
	end)

	getProxy = var_1
	ActivityProxy = var_1_0

	local var_1_1 = var_1(var_1_0)
	local var_1_2 = var_1.getActivityById

	ActivityConst = var_3

	local var_1_3 = var_1_2(var_1_1, var_3.YUMIA_EXPEDITION_BUFF_ACT_ID)
	local var_1_4 = arg_1_0.viewComponent

	var_2.SetActivity(var_1_4, var_1_3)

	return
end

function var_0_1.initNotificationHandleDic(arg_3_0)
	local var_3_0 = {}

	GAME = var_1_10002
	var_3_0[var_1_10002.SUBMIT_TASK_AWARD_DOWN] = function(arg_4_0, arg_4_1)
		local var_4_0 = arg_4_1:getBody()
		local var_4_1 = arg_4_0.viewComponent

		var_3.UpdateView(var_4_1)

		local var_4_2 = arg_4_0.viewComponent

		var_3.ShowUpgrade(var_4_2, nil, true)

		return
	end
	arg_3_0.handleDic = var_3_0

	return
end

return var_0_1
