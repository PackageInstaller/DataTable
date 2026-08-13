class = var_0_10000

local var_0_0 = "AuctionGameTaskMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.ON_TASK_GO = "AuctionGameTaskMediator::ON_TASK_GO"
var_0_1.ON_TASK_SUBMIT = "AuctionGameTaskMediator::ON_TASK_SUBMIT"
var_0_1.ON_ACTIVITY_TASK_SUBMIT_ONESTEP = "AuctionGameTaskMediator::ON_ACTIVITY_TASK_SUBMIT_ONESTEP"

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
	arg_1_0:bind(var_0_1.ON_TASK_SUBMIT, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10004

		var_3_1(var_3_0, var_2_10004.SUBMIT_TASK, arg_3_1.id)

		return
	end)
	arg_1_0:bind(var_0_1.ON_ACTIVITY_TASK_SUBMIT_ONESTEP, function(arg_4_0, arg_4_1, arg_4_2)
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

function var_0_1.initNotificationHandleDic(arg_5_0)
	local var_5_0 = {}

	GAME = var_1_10002
	var_5_0[var_1_10002.SUBMIT_TASK_DONE] = function(arg_6_0, arg_6_1)
		getProxy = var_2_10002
		ContextProxy = var_2_10003

		local var_6_0 = var_2_10002(var_2_10003)
		local var_6_1 = var_2.GetPrevContext(var_6_0, 0).mediator

		ActivityMediator = var_6_0

		if not (var_6_1 == var_6_0) and #arg_6_1:getBody().awards > 0 then
			local var_6_2 = arg_6_0.viewComponent
			local var_6_3 = var_3.emit

			BaseUI = var_2_10005

			var_6_3(var_6_2, var_2_10005.ON_ACHIEVE, arg_6_1:getBody().awards)
		end

		local var_6_4 = arg_6_0.viewComponent

		var_3.RefreshUI(var_6_4)

		return
	end
	GAME = var_2
	var_5_0[var_2.SUBMIT_ACTIVITY_TASK_DONE] = function(arg_7_0, arg_7_1)
		getProxy = var_2_10002
		ContextProxy = var_2_10003

		local var_7_0 = var_2_10002(var_2_10003)
		local var_7_1 = var_2.GetPrevContext(var_7_0, 0).mediator

		CoreActivityMainMediator = var_7_0

		if not (var_7_1 == var_7_0) and #arg_7_1:getBody().awards > 0 then
			local var_7_2 = arg_7_0.viewComponent
			local var_7_3 = var_3.emit

			BaseUI = var_2_10005

			var_7_3(var_7_2, var_2_10005.ON_ACHIEVE, arg_7_1:getBody().awards)
		end

		local var_7_4 = arg_7_0.viewComponent

		var_3.RefreshUI(var_7_4)

		return
	end
	GAME = var_2
	var_5_0[var_2.TOTAL_TASK_UPDATED] = function(arg_8_0, arg_8_1)
		local var_8_0 = arg_8_0.viewComponent

		var_2.RefreshUI(var_8_0)

		return
	end
	arg_5_0.handleDic = var_5_0

	return
end

function var_0_1.remove(arg_9_0)
	return
end

return var_0_1
