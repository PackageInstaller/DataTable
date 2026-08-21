local var_0_0 = class("WeekTaskProgress", import("..BaseVO"))

function var_0_0.Ctor(arg_1_0)
	return
end

function var_0_0.Init(arg_2_0, arg_2_1)
	arg_2_0.targets = {}
	arg_2_0.dropData = {}
	arg_2_0.index = 0
	arg_2_0.target = 0
	arg_2_0.progress = 0
	arg_2_0.drops = {}
	arg_2_0.subTasks = {}
	arg_2_0.targets = pg.gameset.weekly_target.description
	arg_2_0.dropData = pg.gameset.weekly_drop_client.description
	arg_2_0.progress = arg_2_1.pt or 0

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.task) do
		local var_2_0 = WeekPtTask.New(iter_2_1)

		arg_2_0.subTasks[var_2_0.id] = var_2_0
	end

	arg_2_0:UpdateTarget(table.indexof(arg_2_0.targets, arg_2_1.reward_lv) or 0)

	return
end

function var_0_0.IsMaximum(arg_3_0)
	return arg_3_0.index >= #arg_3_0.targets
end

function var_0_0.UpdateTarget(arg_4_0, arg_4_1)
	arg_4_0.index = arg_4_1
	arg_4_0.target = arg_4_0.targets[arg_4_1 + 1] or arg_4_0.targets[#arg_4_0.targets]
	arg_4_0.drops = arg_4_0.dropData[arg_4_1 + 1] or arg_4_0.dropData[#arg_4_0.dropData]

	return
end

function var_0_0.CanUpgrade(arg_5_0)
	return arg_5_0.progress >= arg_5_0.target and not arg_5_0:IsMaximum()
end

function var_0_0.Upgrade(arg_6_0)
	if arg_6_0:CanUpgrade() then
		arg_6_0:UpdateTarget(arg_6_0.index + 1)
	end

	return
end

function var_0_0.GetDropList(arg_7_0)
	return arg_7_0.drops
end

function var_0_0.GetPhase(arg_8_0)
	return math.min(arg_8_0.index + 1, #arg_8_0.targets)
end

function var_0_0.GetTotalPhase(arg_9_0)
	return #arg_9_0.targets
end

function var_0_0.GetProgress(arg_10_0)
	return arg_10_0.progress
end

function var_0_0.GetTarget(arg_11_0)
	return arg_11_0.target
end

function var_0_0.UpdateProgress(arg_12_0, arg_12_1)
	arg_12_0.progress = arg_12_1

	return
end

function var_0_0.AddProgress(arg_13_0, arg_13_1)
	arg_13_0.progress = arg_13_0.progress + arg_13_1

	return
end

function var_0_0.GetAllPhaseDrops(arg_14_0)
	return {
		type = 1,
		resIcon = "Props/weekly_pt",
		dropList = arg_14_0.dropData,
		targets = arg_14_0.targets,
		level = arg_14_0.index,
		count = arg_14_0.progress,
		resName = i18n("week_task_pt_name")
	}
end

function var_0_0.ReachMaxPt(arg_15_0)
	return arg_15_0.targets[#arg_15_0.targets] <= arg_15_0.progress
end

function var_0_0.GetSubTasks(arg_16_0)
	return arg_16_0.subTasks
end

function var_0_0.RemoveSubTasks(arg_17_0, arg_17_1)
	for iter_17_0, iter_17_1 in ipairs(arg_17_1) do
		arg_17_0:RemoveSubTask(iter_17_1)
	end

	return
end

function var_0_0.RemoveSubTask(arg_18_0, arg_18_1)
	arg_18_0.subTasks[arg_18_1] = nil

	return
end

function var_0_0.AddSubTask(arg_19_0, arg_19_1)
	arg_19_0.subTasks[arg_19_1.id] = arg_19_1

	return
end

function var_0_0.UpdateSubTask(arg_20_0, arg_20_1)
	assert(arg_20_0.subTasks[arg_20_1.id], "should exist task >> " .. arg_20_1.id)

	arg_20_0.subTasks[arg_20_1.id] = arg_20_1

	return
end

function var_0_0.GetSubTask(arg_21_0, arg_21_1)
	return arg_21_0.subTasks[arg_21_1]
end

function var_0_0.AnySubTaskCanSubmit(arg_22_0)
	if arg_22_0:ReachMaxPt() then
		return false
	end

	for iter_22_0, iter_22_1 in pairs(arg_22_0.subTasks) do
		if iter_22_1:isFinish() then
			return true
		end
	end

	return false
end

function var_0_0.GetCanSubmitSubTaskCnt(arg_23_0)
	if arg_23_0:ReachMaxPt() then
		return 0
	end

	local var_23_0 = 0

	for iter_23_0, iter_23_1 in pairs(arg_23_0.subTasks) do
		if iter_23_1:isFinish() then
			var_23_0 = var_23_0 + 1
		end
	end

	return var_23_0
end

return var_0_0
