class = var_0_10000

local var_0_0 = "IslandTaskTarget"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("model.vo.BaseVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.target_id
	arg_1_0.configId = arg_1_0.id

	local var_1_0

	if not arg_1_1.target_count then
		var_1_0 = 0
	end

	arg_1_0.progress = var_1_0

	return
end

function var_0_1.bindConfigTable(arg_2_0)
	pg = var_1_10001

	return var_1_10001.island_task_target
end

function var_0_1.GetName(arg_3_0)
	return arg_3_0:getConfig("name")
end

function var_0_1.GetType(arg_4_0)
	return arg_4_0:getConfig("type")
end

function var_0_1.GetTargetParam(arg_5_0)
	return arg_5_0:getConfig("target_param")
end

function var_0_1.GetTargetId(arg_6_0)
	return arg_6_0:getConfig("target_param")[1]
end

function var_0_1.GetTargetNum(arg_7_0)
	return arg_7_0:getConfig("target_num")
end

function var_0_1.GetTrackParma(arg_8_0)
	return arg_8_0:getConfig("tips")
end

function var_0_1.GetProgress(arg_9_0)
	local var_9_0 = arg_9_0
	local var_9_1 = arg_9_0.GetType(var_9_0)

	IslandTaskTargetType = var_1_10002

	local var_9_2

	if var_9_1 == var_1_10002.TASK_DAILY_IN_WEEK then
		var_9_2 = arg_9_0.progress
		IslandTaskHelper = var_9_0

		return var_9_2 + var_9_0.GetRuntimeData(var_9_1, arg_9_0:GetTargetParam())
	end

	table = var_9_2

	local var_9_3 = var_9_2.contains

	IslandTaskTargetType = var_1_10004

	if var_9_3(var_1_10004.GetRuntimeTypes(), var_9_1) then
		IslandTaskHelper = var_2

		return var_2.GetRuntimeData(var_9_1, arg_9_0:GetTargetParam())
	end

	return arg_9_0.progress
end

function var_0_1.UpdateProgress(arg_10_0, arg_10_1)
	arg_10_0.progress = arg_10_1

	return
end

function var_0_1.IsFinish(arg_11_0)
	return arg_11_0:GetProgress() / arg_11_0:GetTargetNum() >= 1
end

function var_0_1.CheckTypeAndTargetId(arg_12_0, arg_12_1, arg_12_2)
	return arg_12_0:GetType() == arg_12_1 and arg_12_0:GetTargetId() == arg_12_2
end

return var_0_1
