class = var_0_10000

local var_0_0 = "SkirmishProxy"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".NetProxy"))

function var_0_1.register(arg_1_0)
	arg_1_0.data = {}

	arg_1_0:BuildSkirmishData()

	return
end

var_0_1.SkirmishMap = 1250022

function var_0_1.BuildSkirmishData(arg_2_0)
	SkirmishVO = var_1_10001

	local var_2_0 = var_1_10001.bindConfigTable()

	pairs = var_1_10002

	for iter_2_0, iter_2_1 in var_1_10002(var_2_0.all) do
		local var_2_1 = var_2_0[iter_2_1]

		SkirmishVO = var_1_10008
		var_1_10008 = var_1_10008.New(var_2_1.id)
		table = var_1_10009

		var_1_10009.insert(arg_2_0.data, var_1_10008)
	end

	return
end

function var_0_1.TryFetchNewTask(arg_3_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_3_0 = var_1_10001(var_1_10003)
	local var_3_1 = var_1.getActivityById

	ActivityConst = var_1_10005

	if var_3_1(var_3_0, var_1_10005.ACTIVITY_ID_US_SKIRMISH_RE) and not var_2:isEnd() then
		updateActivityTaskStatus = var_3

		return var_3(var_2)
	end

	return
end

function var_0_1.UpdateSkirmishProgress(arg_4_0)
	getProxy = var_1_10001
	TaskProxy = var_1_10003

	local var_4_0 = var_1_10001(var_1_10003)

	getProxy = var_1_10002
	ActivityProxy = var_1_10004

	local var_4_1 = var_1_10002(var_1_10004)
	local var_4_2 = arg_4_0.data
	local var_4_3 = var_4_1
	local var_4_4 = var_4_1.getActivityById

	ActivityConst = var_1_10007

	local var_4_5 = var_4_4(var_4_3, var_1_10007.ACTIVITY_ID_US_SKIRMISH_RE)

	math = var_1_10005

	local var_4_6 = var_1_10005.min(var_4_5:getDayIndex(), #var_4_2)
	local var_4_7 = false

	for iter_4_0 = #var_4_2, 1, -1 do
		local var_4_8 = var_4_2[iter_4_0]
		local var_4_9 = var_11.getConfig(var_4_8, "task_id")
		local var_4_10 = var_4_0
		local var_4_11 = var_4_0.getTaskVO(var_4_10, var_4_9)
		local var_4_12

		if var_4_6 < iter_4_0 then
			SkirmishVO = var_4_10
			var_4_12 = var_4_10.StateInactive
		elseif var_4_11 then
			if var_4_11:isReceive() then
				SkirmishVO = var_4_10
				var_4_12 = var_4_10.StateClear
				var_4_7 = var_4_7 or iter_4_0 <= var_4_6
			elseif not var_4_11:isFinish() then
				SkirmishVO = var_4_10
				var_4_12 = var_4_10.StateWorking
				var_4_7 = true
			else
				SkirmishVO = var_4_10
				var_4_12 = var_4_10.StateWorking
				var_4_7 = true
			end
		elseif var_4_7 then
			SkirmishVO = var_4_10
			var_4_12 = var_4_10.StateClear
		else
			SkirmishVO = var_4_10
			var_4_12 = var_4_10.StateActive
		end

		var_11:SetState(var_4_12)
	end

	return
end

return var_0_1
