class = var_0_10000

local var_0_0 = "SixYearUsTaskMediator"

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
				local var_4_0 = arg_1_0

				var_1.settleTownGold(var_4_0, {
					arg_3_1.id
				}, arg_4_0)

				return
			end,
			function(arg_5_0)
				arg_1_0.awardIndex = 0
				arg_1_0.showAwards = {}

				local var_5_0 = arg_1_0
				local var_5_1 = var_1.sendNotification

				GAME = var_3_10003

				local var_5_2 = var_3_10003.SUBMIT_ACTIVITY_TASK
				local var_5_3 = {}
				local var_5_4 = arg_3_1

				var_5_3.act_id = var_5.getActId(var_5_4)
				var_5_3.task_ids = {
					arg_3_1.id
				}

				var_5_1(var_5_0, var_5_2, var_5_3, arg_3_2)

				return
			end
		}, function()
			return
		end)

		return
	end)

	local var_1_0 = arg_1_0

	arg_1_0.bind(var_1_0, var_0_1.ON_TASK_SUBMIT_ONESTEP, function(arg_7_0, arg_7_1)
		seriesAsync = var_2_10002

		var_2_10002({
			function(arg_8_0)
				local var_8_0 = arg_1_0

				var_1.settleTownGold(var_8_0, arg_7_1, arg_8_0)

				return
			end,
			function(arg_9_0)
				local var_9_0 = arg_1_0
				local var_9_1 = var_1.getSubmitDatas(var_9_0, arg_7_1)

				arg_1_0.awardIndex = 0

				local var_9_2 = arg_1_0

				var_9_2.showAwards = {}
				pairs = var_9_2

				for iter_9_0, iter_9_1 in var_9_2(var_9_1) do
					arg_1_0.awardIndex = arg_1_0.awardIndex + 1

					local var_9_3 = arg_1_0
					local var_9_4 = var_7.sendNotification

					GAME = var_3_10009

					var_9_4(var_9_3, var_3_10009.SUBMIT_ACTIVITY_TASK, {
						act_id = iter_9_0,
						task_ids = iter_9_1
					})
				end

				return
			end
		}, function()
			return
		end)

		return
	end)

	getProxy = var_1
	ActivityProxy = var_1_0

	local var_1_1 = var_1(var_1_0)
	local var_1_2 = var_1.getActivityByType

	ActivityConst = var_3

	if not var_1_2(var_1_1, var_3.ACTIVITY_TYPE_TOWN) or var_1:isEnd() then
		assert = var_1_1

		var_1_1(nil, "not exist act")

		return
	end

	arg_1_0.townActId = var_1.id

	return
end

function var_0_1.isSubmitTownGoldTask(arg_11_0, arg_11_1)
	pg = var_1_10002

	return var_1_10002.task_data_template[arg_11_1].sub_type == 1006 and var_2.target_id == "1004"
end

function var_0_1.settleTownGold(arg_12_0, arg_12_1, arg_12_2)
	underscore = var_1_10003

	if var_1_10003.any(arg_12_1, function(arg_13_0)
		local var_13_0 = arg_12_0

		return var_1.isSubmitTownGoldTask(var_13_0, arg_13_0)
	end) then
		local var_12_0 = arg_12_0
		local var_12_1 = arg_12_0.sendNotification

		GAME = var_5

		local var_12_2 = var_5.ACTIVITY_TOWN_OP
		local var_12_3 = {
			activity_id = arg_12_0.townActId
		}

		TownActivity = var_7
		var_12_3.cmd = var_7.OPERATION.SETTLE_GOLD
		var_12_3.callback = arg_12_2

		var_12_1(var_12_0, var_12_2, var_12_3)
	else
		arg_12_2()
	end

	return
end

function var_0_1.listNotificationInterests(arg_14_0)
	local var_14_0 = {}

	GAME = var_1_10002
	var_14_0[1] = var_1_10002.SUBMIT_ACTIVITY_TASK_DONE
	GAME = var_2
	var_14_0[2] = var_2.ACTIVITY_UPDATED

	return var_14_0
end

function var_0_1.handleNotification(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1:getName()
	local var_15_1 = arg_15_1
	local var_15_2 = arg_15_1.getBody(var_15_1)

	GAME = var_15_1

	local var_15_4

	if var_15_0 == var_15_1.SUBMIT_ACTIVITY_TASK_DONE then
		if arg_15_0.awardIndex > 0 then
			arg_15_0.awardIndex = arg_15_0.awardIndex - 1
		end

		ipairs = var_15_4

		for iter_15_0, iter_15_1 in var_15_4(var_15_2.awards) do
			table = var_1_10009

			var_1_10009.insert(arg_15_0.showAwards, iter_15_1)
		end

		if arg_15_0.awardIndex == 0 then
			local var_15_3 = arg_15_0.viewComponent

			var_15_4 = var_15_4.emit
			BaseUI = var_6

			var_15_4(var_15_3, var_6.ON_ACHIEVE, arg_15_0.showAwards, function()
				local var_16_0 = arg_15_0.viewComponent

				var_0.Show(var_16_0)

				return
			end)

			arg_15_0.showAwards = {}
		end
	else
		GAME = var_15_4

		if var_15_0 == var_15_4.ACTIVITY_UPDATED then
			local var_15_5 = arg_15_0.viewComponent

			var_4.Show(var_15_5)
		end
	end

	return
end

function var_0_1.getSubmitDatas(arg_17_0, arg_17_1)
	getProxy = var_1_10002
	TaskProxy = var_1_10003

	local var_17_0 = var_1_10002(var_1_10003)
	local var_17_1 = {}

	for iter_17_0 = 1, #arg_17_1 do
		local var_17_2 = arg_17_1[iter_17_0]

		if var_17_0:getTaskById(var_17_2) and var_9:getActId() then
			if not var_17_1[var_9:getActId()] then
				var_17_1[var_10] = {}
			end

			table = var_11

			var_11.insert(var_17_1[var_10], var_17_2)
		end
	end

	return var_17_1
end

function var_0_1.GetTaskRedTip()
	getProxy = var_1_10000
	ActivityProxy = var_1_10001

	local var_18_0 = var_1_10000(var_1_10001)
	local var_18_1 = var_0.getActivityById

	ActivityConst = var_1_10002

	local var_18_2 = var_18_1(var_18_0, var_1_10002.SIX_YEAR_US_TASK_ACT_ID)

	getProxy = var_18_0
	ActivityProxy = var_2

	local var_18_3 = var_18_0(var_2)
	local var_18_4 = var_1.getActivityById

	ActivityConst = var_1_10003

	local var_18_5 = var_18_4(var_18_3, var_1_10003.SIX_YEAR_US_TASK_2_ACT_ID)

	if var_18_2 and not var_18_2:isEnd() then
		local var_18_6 = var_18_2
		local var_18_7 = var_18_2.getConfig(var_18_6, "config_data")

		pairs = var_18_6

		for iter_18_0, iter_18_1 in var_18_6(var_18_7) do
			getProxy = var_1_10008
			TaskProxy = var_1_10009
			var_1_10009 = var_1_10008(var_1_10009)

			if var_1_10008.getTaskVO(var_1_10009, iter_18_1) and var_1_10008:getTaskStatus() == 1 then
				return true
			end
		end
	end

	if var_18_5 and not var_18_5:isEnd() then
		local var_18_8 = var_18_5
		local var_18_9 = var_18_5.getConfig(var_18_8, "config_data")

		pairs = var_18_8

		for iter_18_2, iter_18_3 in var_18_8(var_18_9) do
			getProxy = var_1_10008
			TaskProxy = var_1_10009
			var_1_10009 = var_1_10008(var_1_10009)

			if var_1_10008.getTaskVO(var_1_10009, iter_18_3) and var_1_10008:getTaskStatus() == 1 then
				return true
			end
		end
	end

	return false
end

return var_0_1
