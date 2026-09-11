local var_0_0 = singletonClass("VehicleBallData")

function var_0_0:Init(arg_1_1)
	self.passedStageList_ = {}
	self.openStageList_ = {}
	self.stageProcess_ = 0
	self.lastPassedStage_ = 0

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.stages) do
		table.insert(self.passedStageList_, iter_1_1)

		self.stageProcess_ = math.max(self.stageProcess_, MergeBallStageCfg[iter_1_1].ult_progress)
	end

	for iter_1_2, iter_1_3 in ipairs(self.passedStageList_) do
		local var_1_0 = table.indexof(MergeBallStageCfg.all, iter_1_3)

		self.openStageList_[var_1_0] = MergeBallStageCfg.all[var_1_0]
	end

	local var_1_1 = math.min(#self.openStageList_ + 1, BilliardGameConst.StageCount)

	self.openStageList_[var_1_1] = MergeBallStageCfg.all[var_1_1]
	self.selectedVehicleId_ = arg_1_1.using_vehicle or MergeBallVehicleCfg[MergeBallVehicleCfg.all[1]]
	self.unlockBuffList_ = {}
	self.buffRewardList_ = {}

	for iter_1_4, iter_1_5 in ipairs(arg_1_1.unlock_buffs) do
		self.unlockBuffList_[iter_1_5.key] = true
		self.buffRewardList_[iter_1_5.key] = iter_1_5.value
	end

	self:UpdateIllustrateRedPoint()
end

function var_0_0:UpdatePassVehicleStage(arg_2_1)
	table.insert(self.passedStageList_, arg_2_1)

	for iter_2_0, iter_2_1 in ipairs(self.passedStageList_) do
		self.stageProcess_ = math.max(self.stageProcess_, MergeBallStageCfg[iter_2_1].ult_progress)
	end

	self.openStageList_ = {}

	for iter_2_2, iter_2_3 in ipairs(self.passedStageList_) do
		local var_2_0 = table.indexof(MergeBallStageCfg.all, iter_2_3)

		self.openStageList_[var_2_0] = MergeBallStageCfg.all[var_2_0]
	end

	local var_2_1 = math.min(#self.openStageList_ + 1, BilliardGameConst.StageCount)

	self.openStageList_[var_2_1] = MergeBallStageCfg.all[var_2_1]
end

function var_0_0.SetLastPassedStage(arg_3_0, arg_3_1)
	arg_3_0.lastPassedStage_ = arg_3_1
end

function var_0_0:GetLastPassedStage()
	return self.lastPassedStage_
end

function var_0_0:GetPassedStageList()
	return self.passedStageList_
end

function var_0_0:GetOpenStageList()
	return self.openStageList_
end

function var_0_0.SetSelectedVehicleId(arg_7_0, arg_7_1)
	arg_7_0.selectedVehicleId_ = arg_7_1

	manager.notify:Invoke(WULUO_SELECT_VEHICLE_UPDATE)
end

function var_0_0:GetSelectedVehicleId()
	return self.selectedVehicleId_
end

function var_0_0:GetStageProcess()
	return self.stageProcess_
end

function var_0_0:UpdateUnlockBuffList(arg_10_1, arg_10_2)
	self.unlockBuffList_[arg_10_1] = arg_10_2
end

function var_0_0:GetUnlockBuffList()
	return self.unlockBuffList_
end

function var_0_0:IsBuffUnlocked(arg_12_1)
	return self.unlockBuffList_[arg_12_1] ~= nil
end

function var_0_0:UpdateBuffRewardState(arg_13_1, arg_13_2)
	self.buffRewardList_[arg_13_1] = arg_13_2

	self:UpdateIllustrateRedPoint(arg_13_1)
	manager.notify:Invoke(WULUO_VEHICLE_ILLUSTRATE_REWARD_UPDATE)
end

function var_0_0:GetBuffRewardState(arg_14_1)
	return self.buffRewardList_[arg_14_1]
end

function var_0_0:InitRedPointGroup()
	manager.notify:RegistListener(OSIRIS_TASK_UPDATE, handler(self, self.UpdateTaskRedPoint))

	local var_15_0 = {}

	for iter_15_0, iter_15_1 in pairs(ActivityCfg[ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_LIMITED_TASK].sub_activity_list) do
		table.insert(var_15_0, RedPointConst.WULO_VEHICLE_BALL_LIMITED_TASK_TAG .. iter_15_1)
	end

	manager.redPoint:addGroup(RedPointConst.WULO_VEHICLE_BALL_LIMITED_TASK .. ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_LIMITED_TASK, var_15_0)

	local var_15_1 = {}

	for iter_15_2, iter_15_3 in pairs(AssignmentCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_LIMITED_TASK]) do
		table.insert(var_15_1, RedPointConst.WULO_VEHICLE_BALL_LIMITED_TASK_POINT .. iter_15_3)
	end

	manager.redPoint:addGroup(RedPointConst.WULO_VEHICLE_BALL_LIMITED_TASK .. ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_LIMITED_TASK, var_15_1)

	for iter_15_4, iter_15_5 in ipairs(MergeBallBuffCfg.all) do
		if #MergeBallBuffCfg[iter_15_5].reward > 0 then
			manager.redPoint:addGroup(RedPointConst.WULO_ILLUSTRATE, {
				RedPointConst.WULO_ILLUSTRATE .. iter_15_5
			})
		end
	end

	manager.redPoint:addGroup(ActivityTools.GetRedPointKey(ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_MAIN) .. ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_MAIN, {
		RedPointConst.WULO_ILLUSTRATE,
		RedPointConst.WULO_VEHICLE_BALL_RESIDENT_TASK .. ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_MAIN
	})
	self:UpdateTaskRedPoint()
end

function var_0_0:UpdateIllustrateRedPoint(arg_16_1)
	if arg_16_1 == nil then
		for iter_16_0, iter_16_1 in ipairs(MergeBallBuffCfg.all) do
			if #MergeBallBuffCfg[iter_16_1].reward > 0 then
				manager.redPoint:setTip(RedPointConst.WULO_ILLUSTRATE .. iter_16_1, self.buffRewardList_[iter_16_1] == BilliardGameConst.VehicleBallBuffRewardState.CAN_RECEIVE_REWARD and 1 or 0)
			end
		end
	else
		manager.redPoint:setTip(RedPointConst.WULO_ILLUSTRATE .. arg_16_1, self.buffRewardList_[arg_16_1] == BilliardGameConst.VehicleBallBuffRewardState.CAN_RECEIVE_REWARD and 1 or 0)
	end
end

function var_0_0:UpdateTaskRedPoint()
	self:TaskRedSet(ActivityCfg[ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_LIMITED_TASK].sub_activity_list, RedPointConst.WULO_VEHICLE_BALL_LIMITED_TASK_TAG)
	self:TaskRedSet({
		ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_LIMITED_TASK
	}, RedPointConst.WULO_VEHICLE_BALL_LIMITED_TASK_TAG)
	self:TaskRedSet({
		ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_MAIN
	}, RedPointConst.WULO_VEHICLE_BALL_RESIDENT_TASK)

	for iter_17_0, iter_17_1 in pairs(AssignmentCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_LIMITED_TASK]) do
		manager.redPoint:setTip(RedPointConst.WULO_VEHICLE_BALL_LIMITED_TASK_POINT .. iter_17_1, (not TaskData2:GetTaskComplete(iter_17_1) and TaskData2:GetTaskProgress(iter_17_1) >= AssignmentCfg[iter_17_1].need or nil) and 1)
	end
end

function var_0_0.TaskRedSet(arg_18_0, arg_18_1, arg_18_2)
	for iter_18_0, iter_18_1 in pairs(arg_18_1) do
		local var_18_0 = ActivityData:GetActivityIsOpen(iter_18_1)

		for iter_18_2, iter_18_3 in pairs(AssignmentCfg.get_id_list_by_activity_id[iter_18_1]) do
			if var_18_0 then
				local var_18_1 = TaskData2:GetTaskProgress(iter_18_3)

				if TaskData2:GetTaskComplete(iter_18_3) then
					manager.redPoint:setTip(arg_18_2 .. iter_18_1, 0)
				elseif var_18_1 >= AssignmentCfg[iter_18_3].need then
					manager.redPoint:setTip(arg_18_2 .. iter_18_1, 1)

					break
				else
					manager.redPoint:setTip(arg_18_2 .. iter_18_1, 0)
				end
			else
				manager.redPoint:setTip(arg_18_2 .. iter_18_1, 0)
			end
		end
	end
end

return var_0_0
