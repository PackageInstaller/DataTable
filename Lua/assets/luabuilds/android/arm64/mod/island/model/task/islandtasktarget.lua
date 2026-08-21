local var_0_0 = class("IslandTaskTarget", import("model.vo.BaseVO"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.target_id
	arg_1_0.configId = arg_1_0.id
	arg_1_0.progress = arg_1_1.target_count or 0

	return
end

function var_0_0.bindConfigTable(arg_2_0)
	return pg.island_task_target
end

function var_0_0.GetName(arg_3_0)
	return arg_3_0:getConfig("name")
end

function var_0_0.GetType(arg_4_0)
	return arg_4_0:getConfig("type")
end

function var_0_0.GetTargetParam(arg_5_0)
	return arg_5_0:getConfig("target_param")
end

function var_0_0.GetTargetId(arg_6_0)
	return arg_6_0:getConfig("target_param")[1]
end

function var_0_0.GetTargetNum(arg_7_0)
	return arg_7_0:getConfig("target_num")
end

function var_0_0.GetTrackParma(arg_8_0)
	return arg_8_0:getConfig("tips")
end

function var_0_0.GetProgress(arg_9_0)
	local var_9_0 = arg_9_0:GetType()

	if var_9_0 == IslandTaskTargetType.TASK_DAILY_IN_WEEK then
		return arg_9_0.progress + IslandTaskHelper.GetRuntimeData(var_9_0, arg_9_0:GetTargetParam())
	end

	if table.contains(IslandTaskTargetType.GetRuntimeTypes(), var_9_0) then
		return IslandTaskHelper.GetRuntimeData(var_9_0, arg_9_0:GetTargetParam())
	end

	return arg_9_0.progress
end

function var_0_0.UpdateProgress(arg_10_0, arg_10_1)
	arg_10_0.progress = arg_10_1

	return
end

function var_0_0.IsFinish(arg_11_0)
	return arg_11_0:GetProgress() / arg_11_0:GetTargetNum() >= 1
end

function var_0_0.CheckTypeAndTargetId(arg_12_0, arg_12_1, arg_12_2)
	return arg_12_0:GetType() == arg_12_1 and arg_12_0:GetTargetId() == arg_12_2
end

return var_0_0
