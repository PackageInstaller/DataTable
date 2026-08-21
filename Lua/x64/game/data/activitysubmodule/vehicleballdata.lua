local var_0_0 = singletonClass("VehicleBallData")

function var_0_0.Init(arg_1_0, arg_1_1)
	arg_1_0.passedStageList_ = {}
	arg_1_0.openStageList_ = {}
	arg_1_0.stageProcess_ = 0
	arg_1_0.lastPassedStage_ = 0

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.stages) do
		table.insert(arg_1_0.passedStageList_, iter_1_1)

		arg_1_0.stageProcess_ = math.max(arg_1_0.stageProcess_, MergeBallStageCfg[iter_1_1].ult_progress)
	end

	for iter_1_2, iter_1_3 in ipairs(arg_1_0.passedStageList_) do
		local var_1_0 = table.indexof(MergeBallStageCfg.all, iter_1_3)

		arg_1_0.openStageList_[var_1_0] = MergeBallStageCfg.all[var_1_0]
	end

	local var_1_1 = math.min(#arg_1_0.openStageList_ + 1, BilliardGameConst.StageCount)

	arg_1_0.openStageList_[var_1_1] = MergeBallStageCfg.all[var_1_1]
	arg_1_0.selectedVehicleId_ = arg_1_1.using_vehicle or MergeBallVehicleCfg[MergeBallVehicleCfg.all[1]]
	arg_1_0.unlockBuffList_ = {}
	arg_1_0.buffRewardList_ = {}

	for iter_1_4, iter_1_5 in ipairs(arg_1_1.unlock_buffs) do
		arg_1_0.unlockBuffList_[iter_1_5.key] = true
		arg_1_0.buffRewardList_[iter_1_5.key] = iter_1_5.value
	end

	arg_1_0:UpdateIllustrateRedPoint()
end

function var_0_0.UpdatePassVehicleStage(arg_2_0, arg_2_1)
	table.insert(arg_2_0.passedStageList_, arg_2_1)

	for iter_2_0, iter_2_1 in ipairs(arg_2_0.passedStageList_) do
		arg_2_0.stageProcess_ = math.max(arg_2_0.stageProcess_, MergeBallStageCfg[iter_2_1].ult_progress)
	end

	arg_2_0.openStageList_ = {}

	for iter_2_2, iter_2_3 in ipairs(arg_2_0.passedStageList_) do
		local var_2_0 = table.indexof(MergeBallStageCfg.all, iter_2_3)

		arg_2_0.openStageList_[var_2_0] = MergeBallStageCfg.all[var_2_0]
	end

	local var_2_1 = math.min(#arg_2_0.openStageList_ + 1, BilliardGameConst.StageCount)

	arg_2_0.openStageList_[var_2_1] = MergeBallStageCfg.all[var_2_1]
end

function var_0_0.SetLastPassedStage(arg_3_0, arg_3_1)
	arg_3_0.lastPassedStage_ = arg_3_1
end

function var_0_0.GetLastPassedStage(arg_4_0)
	return arg_4_0.lastPassedStage_
end

function var_0_0.GetPassedStageList(arg_5_0)
	return arg_5_0.passedStageList_
end

function var_0_0.GetOpenStageList(arg_6_0)
	return arg_6_0.openStageList_
end

function var_0_0.SetSelectedVehicleId(arg_7_0, arg_7_1)
	arg_7_0.selectedVehicleId_ = arg_7_1

	manager.notify:Invoke(WULUO_SELECT_VEHICLE_UPDATE)
end

function var_0_0.GetSelectedVehicleId(arg_8_0)
	return arg_8_0.selectedVehicleId_
end

function var_0_0.GetStageProcess(arg_9_0)
	return arg_9_0.stageProcess_
end

function var_0_0.UpdateUnlockBuffList(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0.unlockBuffList_[arg_10_1] = arg_10_2
end

function var_0_0.GetUnlockBuffList(arg_11_0)
	return arg_11_0.unlockBuffList_
end

function var_0_0.IsBuffUnlocked(arg_12_0, arg_12_1)
	return arg_12_0.unlockBuffList_[arg_12_1] ~= nil
end

function var_0_0.UpdateBuffRewardState(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0.buffRewardList_[arg_13_1] = arg_13_2

	arg_13_0:UpdateIllustrateRedPoint(arg_13_1)
	manager.notify:Invoke(WULUO_VEHICLE_ILLUSTRATE_REWARD_UPDATE)
end

function var_0_0.GetBuffRewardState(arg_14_0, arg_14_1)
	return arg_14_0.buffRewardList_[arg_14_1]
end

function var_0_0.InitRedPointGroup(arg_15_0)
	manager.notify:RegistListener(OSIRIS_TASK_UPDATE, handler(arg_15_0, arg_15_0.UpdateTaskRedPoint))

	local var_15_0 = RedPointConst.WULO_VEHICLE_BALL_LIMITED_TASK .. ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_LIMITED_TASK
	local var_15_1 = ActivityCfg[ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_LIMITED_TASK]
	local var_15_2 = {}

	for iter_15_0, iter_15_1 in pairs(var_15_1.sub_activity_list) do
		local var_15_3 = RedPointConst.WULO_VEHICLE_BALL_LIMITED_TASK_TAG .. iter_15_1

		table.insert(var_15_2, var_15_3)
	end

	manager.redPoint:addGroup(var_15_0, var_15_2)

	local var_15_4 = {}

	for iter_15_2, iter_15_3 in pairs(AssignmentCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_LIMITED_TASK]) do
		local var_15_5 = RedPointConst.WULO_VEHICLE_BALL_LIMITED_TASK_POINT .. iter_15_3

		table.insert(var_15_4, var_15_5)
	end

	manager.redPoint:addGroup(var_15_0, var_15_4)

	for iter_15_4, iter_15_5 in ipairs(MergeBallBuffCfg.all) do
		if #MergeBallBuffCfg[iter_15_5].reward > 0 then
			manager.redPoint:addGroup(RedPointConst.WULO_ILLUSTRATE, {
				RedPointConst.WULO_ILLUSTRATE .. iter_15_5
			})
		end
	end

	local var_15_6 = RedPointConst.WULO_VEHICLE_BALL_RESIDENT_TASK .. ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_MAIN
	local var_15_7 = ActivityTools.GetRedPointKey(ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_MAIN) .. ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_MAIN

	manager.redPoint:addGroup(var_15_7, {
		RedPointConst.WULO_ILLUSTRATE,
		var_15_6
	})
	arg_15_0:UpdateTaskRedPoint()
end

function var_0_0.UpdateIllustrateRedPoint(arg_16_0, arg_16_1)
	if arg_16_1 == nil then
		for iter_16_0, iter_16_1 in ipairs(MergeBallBuffCfg.all) do
			if #MergeBallBuffCfg[iter_16_1].reward > 0 then
				manager.redPoint:setTip(RedPointConst.WULO_ILLUSTRATE .. iter_16_1, arg_16_0.buffRewardList_[iter_16_1] == BilliardGameConst.VehicleBallBuffRewardState.CAN_RECEIVE_REWARD and 1 or 0)
			end
		end
	else
		manager.redPoint:setTip(RedPointConst.WULO_ILLUSTRATE .. arg_16_1, arg_16_0.buffRewardList_[arg_16_1] == BilliardGameConst.VehicleBallBuffRewardState.CAN_RECEIVE_REWARD and 1 or 0)
	end
end

function var_0_0.UpdateTaskRedPoint(arg_17_0)
	local var_17_0 = ActivityCfg[ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_LIMITED_TASK]

	arg_17_0:TaskRedSet(var_17_0.sub_activity_list, RedPointConst.WULO_VEHICLE_BALL_LIMITED_TASK_TAG)
	arg_17_0:TaskRedSet({
		ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_LIMITED_TASK
	}, RedPointConst.WULO_VEHICLE_BALL_LIMITED_TASK_TAG)
	arg_17_0:TaskRedSet({
		ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_MAIN
	}, RedPointConst.WULO_VEHICLE_BALL_RESIDENT_TASK)

	for iter_17_0, iter_17_1 in pairs(AssignmentCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_LIMITED_TASK]) do
		local var_17_1 = 0
		local var_17_2 = TaskData2:GetTaskProgress(iter_17_1)
		local var_17_3 = AssignmentCfg[iter_17_1]

		if not TaskData2:GetTaskComplete(iter_17_1) and var_17_2 >= var_17_3.need then
			var_17_1 = 1
		end

		manager.redPoint:setTip(RedPointConst.WULO_VEHICLE_BALL_LIMITED_TASK_POINT .. iter_17_1, var_17_1)
	end
end

function var_0_0.TaskRedSet(arg_18_0, arg_18_1, arg_18_2)
	for iter_18_0, iter_18_1 in pairs(arg_18_1) do
		local var_18_0 = ActivityData:GetActivityIsOpen(iter_18_1)

		for iter_18_2, iter_18_3 in pairs(AssignmentCfg.get_id_list_by_activity_id[iter_18_1]) do
			local var_18_1 = arg_18_2 .. iter_18_1

			if var_18_0 then
				local var_18_2 = TaskData2:GetTaskProgress(iter_18_3)
				local var_18_3 = AssignmentCfg[iter_18_3]

				if TaskData2:GetTaskComplete(iter_18_3) then
					manager.redPoint:setTip(var_18_1, 0)
				elseif var_18_2 >= var_18_3.need then
					manager.redPoint:setTip(var_18_1, 1)

					break
				else
					manager.redPoint:setTip(var_18_1, 0)
				end
			else
				manager.redPoint:setTip(var_18_1, 0)
			end
		end
	end
end

return var_0_0
