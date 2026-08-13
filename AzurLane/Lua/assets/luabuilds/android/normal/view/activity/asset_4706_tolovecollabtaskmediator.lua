class = var_0_10000

local var_0_0 = "ToLoveCollabTaskMediator"

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
		seriesAsync = var_2_10003

		var_2_10003({
			function(arg_4_0)
				arg_1_0.awardIndex = 0
				arg_1_0.showAwards = {}

				local var_4_0 = arg_1_0
				local var_4_1 = var_1.sendNotification

				GAME = var_3_10003

				local var_4_2 = var_3_10003.SUBMIT_ACTIVITY_TASK
				local var_4_3 = {}
				local var_4_4 = arg_3_1

				var_4_3.act_id = var_5.getActId(var_4_4)
				var_4_3.task_ids = {
					arg_3_1.id
				}

				var_4_1(var_4_0, var_4_2, var_4_3, arg_3_2)

				return
			end
		}, function()
			return
		end)

		return
	end)
	arg_1_0:bind(var_0_1.ON_TASK_SUBMIT_ONESTEP, function(arg_6_0, arg_6_1)
		seriesAsync = var_2_10002

		var_2_10002({
			function(arg_7_0)
				local var_7_0 = arg_1_0
				local var_7_1 = var_1.getSubmitDatas(var_7_0, arg_6_1)

				arg_1_0.awardIndex = 0

				local var_7_2 = arg_1_0

				var_7_2.showAwards = {}
				pairs = var_7_2

				for iter_7_0, iter_7_1 in var_7_2(var_7_1) do
					arg_1_0.awardIndex = arg_1_0.awardIndex + 1

					local var_7_3 = arg_1_0
					local var_7_4 = var_7.sendNotification

					GAME = var_3_10009

					var_7_4(var_7_3, var_3_10009.SUBMIT_ACTIVITY_TASK, {
						act_id = iter_7_0,
						task_ids = iter_7_1
					})
				end

				return
			end
		}, function()
			return
		end)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_9_0)
	local var_9_0 = {}

	GAME = var_1_10002
	var_9_0[1] = var_1_10002.SUBMIT_ACTIVITY_TASK_DONE
	GAME = var_2
	var_9_0[2] = var_2.ACTIVITY_UPDATED

	return var_9_0
end

function var_0_1.handleNotification(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1:getName()
	local var_10_1 = arg_10_1
	local var_10_2 = arg_10_1.getBody(var_10_1)

	GAME = var_10_1

	local var_10_4

	if var_10_0 == var_10_1.SUBMIT_ACTIVITY_TASK_DONE then
		if arg_10_0.awardIndex > 0 then
			arg_10_0.awardIndex = arg_10_0.awardIndex - 1
		end

		ipairs = var_10_4

		for iter_10_0, iter_10_1 in var_10_4(var_10_2.awards) do
			table = var_1_10009

			var_1_10009.insert(arg_10_0.showAwards, iter_10_1)
		end

		if arg_10_0.awardIndex == 0 then
			local var_10_3 = arg_10_0.viewComponent

			var_10_4 = var_10_4.emit
			BaseUI = var_6

			var_10_4(var_10_3, var_6.ON_ACHIEVE, arg_10_0.showAwards, function()
				local var_11_0 = arg_10_0.viewComponent

				var_0.Show(var_11_0)

				return
			end)

			arg_10_0.showAwards = {}
		end
	else
		GAME = var_10_4

		if var_10_0 == var_10_4.ACTIVITY_UPDATED then
			local var_10_5 = arg_10_0.viewComponent

			var_4.Show(var_10_5)
		end
	end

	return
end

function var_0_1.getSubmitDatas(arg_12_0, arg_12_1)
	getProxy = var_1_10002
	TaskProxy = var_1_10003

	local var_12_0 = var_1_10002(var_1_10003)
	local var_12_1 = {}

	for iter_12_0 = 1, #arg_12_1 do
		local var_12_2 = arg_12_1[iter_12_0]

		if var_12_0:getTaskById(var_12_2) and var_9:getActId() then
			if not var_12_1[var_9:getActId()] then
				var_12_1[var_10] = {}
			end

			table = var_11

			var_11.insert(var_12_1[var_10], var_12_2)
		end
	end

	return var_12_1
end

function var_0_1.GetTaskRedTip()
	getProxy = var_1_10000
	ActivityProxy = var_1_10001

	local var_13_0 = var_1_10000(var_1_10001)
	local var_13_1 = var_0.getActivityById

	ActivityConst = var_1_10002

	if var_13_1(var_13_0, var_1_10002.TOLOVE_TASK_ID) and not var_0:isEnd() then
		local var_13_2 = var_0
		local var_13_3 = var_0.getConfig(var_13_2, "config_data")

		pairs = var_13_2

		for iter_13_0, iter_13_1 in var_13_2(var_13_3) do
			getProxy = var_1_10007
			TaskProxy = var_1_10008
			var_1_10008 = var_1_10007(var_1_10008)

			if var_1_10007.getTaskVO(var_1_10008, iter_13_1) and var_1_10007:getTaskStatus() == 1 then
				return true
			end
		end
	end

	return false
end

return var_0_1
