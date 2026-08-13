class = var_0_10000

local var_0_0 = "WeekTaskProgress"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..BaseVO"))

function var_0_1.Ctor(arg_1_0)
	return
end

function var_0_1.Init(arg_2_0, arg_2_1)
	arg_2_0.targets = {}
	arg_2_0.dropData = {}
	arg_2_0.index = 0
	arg_2_0.target = 0
	arg_2_0.progress = 0
	arg_2_0.drops = {}
	arg_2_0.subTasks = {}
	pg = var_2
	arg_2_0.targets = var_2.gameset.weekly_target.description
	pg = var_2
	arg_2_0.dropData = var_2.gameset.weekly_drop_client.description

	local var_2_0

	if not arg_2_1.pt then
		var_2_0 = 0
	end

	arg_2_0.progress = var_2_0
	ipairs = var_2_0

	for iter_2_0, iter_2_1 in var_2_0(arg_2_1.task) do
		WeekPtTask = var_1_10007
		var_1_10007 = var_1_10007.New(iter_2_1)
		arg_2_0.subTasks[var_1_10007.id] = var_1_10007
	end

	table = var_2

	local var_2_1 = var_2.indexof(arg_2_0.targets, arg_2_1.reward_lv)

	arg_2_0:UpdateTarget(var_2_1 or 0)

	return
end

function var_0_1.IsMaximum(arg_3_0)
	return arg_3_0.index >= #arg_3_0.targets
end

function var_0_1.UpdateTarget(arg_4_0, arg_4_1)
	arg_4_0.index = arg_4_1

	local var_4_0

	if not arg_4_0.targets[arg_4_1 + 1] then
		var_4_0 = arg_4_0.targets[#arg_4_0.targets]
	end

	arg_4_0.target = var_4_0

	local var_4_1

	if not arg_4_0.dropData[arg_4_1 + 1] then
		var_4_1 = arg_4_0.dropData[#arg_4_0.dropData]
	end

	arg_4_0.drops = var_4_1

	return
end

function var_0_1.CanUpgrade(arg_5_0)
	return arg_5_0.progress >= arg_5_0.target and not arg_5_0:IsMaximum()
end

function var_0_1.Upgrade(arg_6_0)
	if arg_6_0:CanUpgrade() then
		local var_6_0 = arg_6_0.index + 1

		arg_6_0:UpdateTarget(var_6_0)
	end

	return
end

function var_0_1.GetDropList(arg_7_0)
	return arg_7_0.drops
end

function var_0_1.GetPhase(arg_8_0)
	math = var_1_10001

	return var_1_10001.min(arg_8_0.index + 1, #arg_8_0.targets)
end

function var_0_1.GetTotalPhase(arg_9_0)
	return #arg_9_0.targets
end

function var_0_1.GetProgress(arg_10_0)
	return arg_10_0.progress
end

function var_0_1.GetTarget(arg_11_0)
	return arg_11_0.target
end

function var_0_1.UpdateProgress(arg_12_0, arg_12_1)
	arg_12_0.progress = arg_12_1

	return
end

function var_0_1.AddProgress(arg_13_0, arg_13_1)
	arg_13_0.progress = arg_13_0.progress + arg_13_1

	return
end

function var_0_1.GetAllPhaseDrops(arg_14_0)
	local var_14_0 = {
		type = 1,
		resIcon = "Props/weekly_pt",
		dropList = arg_14_0.dropData,
		targets = arg_14_0.targets,
		level = arg_14_0.index,
		count = arg_14_0.progress
	}

	i18n = var_2
	var_14_0.resName = var_2("week_task_pt_name")

	return var_14_0
end

function var_0_1.ReachMaxPt(arg_15_0)
	return arg_15_0.targets[#arg_15_0.targets] <= arg_15_0.progress
end

function var_0_1.GetSubTasks(arg_16_0)
	return arg_16_0.subTasks
end

function var_0_1.RemoveSubTasks(arg_17_0, arg_17_1)
	ipairs = var_1_10002

	for iter_17_0, iter_17_1 in var_1_10002(arg_17_1) do
		arg_17_0:RemoveSubTask(iter_17_1)
	end

	return
end

function var_0_1.RemoveSubTask(arg_18_0, arg_18_1)
	arg_18_0.subTasks[arg_18_1] = nil

	return
end

function var_0_1.AddSubTask(arg_19_0, arg_19_1)
	arg_19_0.subTasks[arg_19_1.id] = arg_19_1

	return
end

function var_0_1.UpdateSubTask(arg_20_0, arg_20_1)
	assert = var_1_10002

	var_1_10002(arg_20_0.subTasks[arg_20_1.id], "should exist task >> " .. arg_20_1.id)

	arg_20_0.subTasks[arg_20_1.id] = arg_20_1

	return
end

function var_0_1.GetSubTask(arg_21_0, arg_21_1)
	return arg_21_0.subTasks[arg_21_1]
end

function var_0_1.AnySubTaskCanSubmit(arg_22_0)
	if arg_22_0:ReachMaxPt() then
		return false
	end

	pairs = var_1

	for iter_22_0, iter_22_1 in var_1(arg_22_0.subTasks) do
		if iter_22_1:isFinish() then
			return true
		end
	end

	return false
end

function var_0_1.GetCanSubmitSubTaskCnt(arg_23_0)
	local var_23_0 = arg_23_0

	if arg_23_0.ReachMaxPt(var_23_0) then
		return 0
	end

	local var_23_1 = 0

	pairs = var_23_0

	for iter_23_0, iter_23_1 in var_23_0(arg_23_0.subTasks) do
		if iter_23_1:isFinish() then
			var_23_1 = var_23_1 + 1
		end
	end

	return var_23_1
end

return var_0_1
