local var_0_0 = singletonClass("CultivateHeroData")

function var_0_0.Init(arg_1_0)
	arg_1_0.dailyTaskStatus_ = {}
	arg_1_0.heroTaskInfoList_ = {}
	arg_1_0.accumulateTaskInfoList_ = {}
	arg_1_0.accumulateTaskAllReceivedList_ = {}
end

function var_0_0:SetData(arg_2_1)
	self.heroTaskInfoList_[arg_2_1.activity_id] = {}
	self.accumulateTaskInfoList_[arg_2_1.activity_id] = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.task_info_list) do
		self.heroTaskInfoList_[arg_2_1.activity_id][iter_2_1.id] = {
			progress = iter_2_1.progress
		}

		if CultivateHeroTaskCfg[iter_2_1.id].condition <= iter_2_1.progress then
			self.heroTaskInfoList_[arg_2_1.activity_id][iter_2_1.id].isCompleted = true
		end
	end

	for iter_2_2, iter_2_3 in ipairs(arg_2_1.got_reward_task_id_list) do
		self.heroTaskInfoList_[arg_2_1.activity_id][iter_2_3] = self.heroTaskInfoList_[arg_2_1.activity_id][iter_2_3] or {}
		self.heroTaskInfoList_[arg_2_1.activity_id][iter_2_3].isCompleted = true
		self.heroTaskInfoList_[arg_2_1.activity_id][iter_2_3].isReceived = true
	end

	self.dailyTaskStatus_[arg_2_1.activity_id] = arg_2_1.daily_pt_task_got_flag == true and true or nil

	for iter_2_4, iter_2_5 in ipairs(arg_2_1.got_point_id_list) do
		self.accumulateTaskInfoList_[arg_2_1.activity_id][iter_2_5] = {
			isReceived = true
		}
	end

	self.accumulateTaskAllReceivedList_[arg_2_1.activity_id] = nil

	self:RefreshDailyRedPoint(arg_2_1.activity_id)
	self:RefreshAccumulateRedPoint(arg_2_1.activity_id)
	self:RefreshHeroTaskRedPoint(arg_2_1.activity_id)
	self:RefreshSelectRedPoint(arg_2_1.activity_id)
end

function var_0_0:UpdateDailyTask(arg_3_1)
	self.dailyTaskStatus_[arg_3_1.activity_id] = arg_3_1.daily_pt_task_got_flag == true and true or nil

	self:RefreshDailyRedPoint(arg_3_1.activity_id)
end

function var_0_0:UpdateHeroTask(arg_4_1)
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1.task_info_list) do
		var_4_0[CultivateHeroTaskCfg[iter_4_1.id].activity_id] = true
		self.heroTaskInfoList_[CultivateHeroTaskCfg[iter_4_1.id].activity_id][iter_4_1.id] = {
			progress = iter_4_1.progress
		}

		if CultivateHeroTaskCfg[iter_4_1.id].condition <= iter_4_1.progress then
			self.heroTaskInfoList_[CultivateHeroTaskCfg[iter_4_1.id].activity_id][iter_4_1.id].isCompleted = true
		end
	end

	for iter_4_2, iter_4_3 in pairs(var_4_0) do
		self:RefreshHeroTaskRedPoint(iter_4_2)
	end
end

function var_0_0:GetSortHeroTaskList(arg_5_1, arg_5_2)
	local var_5_0 = {}
	local var_5_1 = {}
	local var_5_2 = {}
	local var_5_3 = {}

	for iter_5_0, iter_5_1 in pairs(CultivateHeroTaskCfg.get_id_list_by_group_id[arg_5_1]) do
		if self.heroTaskInfoList_[arg_5_2][iter_5_1].isReceived == true then
			table.insert(var_5_3, iter_5_1)
		elseif self.heroTaskInfoList_[arg_5_2][iter_5_1].isCompleted == true then
			table.insert(var_5_1, iter_5_1)
		else
			table.insert(var_5_2, iter_5_1)
		end
	end

	local var_5_4 = handler(self, self.Compare)

	table.sort(var_5_1, var_5_4)
	table.sort(var_5_2, var_5_4)
	table.sort(var_5_3, var_5_4)
	table.insertto(var_5_0, var_5_1)
	table.insertto(var_5_0, var_5_2)
	table.insertto(var_5_0, var_5_3)

	return var_5_0, #var_5_1 > 0
end

function var_0_0.Compare(arg_6_0, arg_6_1, arg_6_2)
	return CultivateHeroTaskCfg[arg_6_1].id < CultivateHeroTaskCfg[arg_6_2].id
end

function var_0_0.IsHeroTaskCompleted(arg_7_0, arg_7_1, arg_7_2)
	return CultivateHeroData:GetHeroTaskInfoList(arg_7_1)[arg_7_2].isCompleted
end

function var_0_0.IsHeroTaskReceived(arg_8_0, arg_8_1, arg_8_2)
	return CultivateHeroData:GetHeroTaskInfoList(arg_8_1)[arg_8_2].isReceived
end

function var_0_0:GetDailyTaskStatus()
	return self.dailyTaskStatus_
end

function var_0_0:GetCompletedTaskList()
	return self.completedTaskList_ or {}
end

function var_0_0:GetReceivedTaskList()
	return self.receivedTaskList_ or {}
end

function var_0_0:GetHeroTaskInfoList(arg_12_1)
	if arg_12_1 ~= nil then
		return self.heroTaskInfoList_[arg_12_1] or {}
	end

	return self.heroTaskInfoList_
end

function var_0_0:GetAccumulateTaskInfoList(arg_13_1)
	if arg_13_1 ~= nil then
		return self.accumulateTaskInfoList_[arg_13_1] or {}
	end

	return self.accumulateTaskInfoList_
end

function var_0_0:SetReceivedHeroTaskList(arg_14_1, arg_14_2)
	for iter_14_0, iter_14_1 in ipairs(arg_14_1) do
		self.heroTaskInfoList_[arg_14_2][iter_14_1].isReceived = true
	end

	self:RefreshAccumulateRedPoint(arg_14_2)
	self:RefreshHeroTaskRedPoint(arg_14_2)
end

function var_0_0:SetReceivedAccumulateTask(arg_15_1, arg_15_2)
	self.accumulateTaskInfoList_[arg_15_2][arg_15_1] = self.accumulateTaskInfoList_[arg_15_2][arg_15_1] or {}
	self.accumulateTaskInfoList_[arg_15_2][arg_15_1].isReceived = true

	self:RefreshAccumulateRedPoint(arg_15_2)
end

function var_0_0:SetReceivedDailyTask(arg_16_1)
	self.dailyTaskStatus_[arg_16_1] = true

	self:RefreshDailyRedPoint(arg_16_1)
	self:RefreshAccumulateRedPoint(arg_16_1)
end

function var_0_0.GetSelectHeroID(arg_17_0, arg_17_1)
	return getData(string.format("CultivateHero_%d", arg_17_1), "selectHeroID")
end

function var_0_0.SetSelectHeroID(arg_18_0, arg_18_1, arg_18_2)
	saveData(string.format("CultivateHero_%d", arg_18_1), "selectHeroID", arg_18_2)
	manager.redPoint:setTip(string.format("%s_%s_Select", RedPointConst.CULTIVATE_HERO, arg_18_1), 0)
end

function var_0_0:RefreshSelectRedPoint(arg_19_1)
	manager.redPoint:setTip(string.format("%s_%s_Select", RedPointConst.CULTIVATE_HERO, arg_19_1), self:GetSelectHeroID(arg_19_1) == nil and 1 or 0)
end

function var_0_0:RefreshDailyRedPoint(arg_20_1)
	if self:IsAllReceived(arg_20_1) == true then
		return
	end

	manager.redPoint:setTip(string.format("%s_%s_Daily_Reward", RedPointConst.CULTIVATE_HERO, arg_20_1), (100 <= ActivityPtData:GetCurrentActivityPt(ActivityPtConst.TASK_DAILY_ACTIVITY_PT) and CultivateHeroData:GetDailyTaskStatus()[arg_20_1] ~= true or nil) and 1)
end

function var_0_0:RefreshAccumulateRedPoint(arg_21_1)
	if self:IsAllReceived(arg_21_1) == true then
		return
	end

	local var_21_0 = ItemTools.getItemNum(ActivityCultivateHeroCfg[arg_21_1].coin_id)
	local var_21_1 = 0

	for iter_21_0, iter_21_1 in ipairs(ActivityPointRewardCfg.get_id_list_by_activity_id[arg_21_1]) do
		if var_21_0 >= ActivityPointRewardCfg[iter_21_1].need and (self.accumulateTaskInfoList_[arg_21_1][iter_21_1] and self.accumulateTaskInfoList_[arg_21_1][iter_21_1].isReceived) ~= true then
			var_21_1 = 1

			break
		end
	end

	manager.redPoint:setTip(string.format("%s_%s_Accumulate_Reward", RedPointConst.CULTIVATE_HERO, arg_21_1), var_21_1)
end

function var_0_0:RefreshHeroTaskRedPoint(arg_22_1)
	if self:IsAllReceived(arg_22_1) == true then
		return
	end

	for iter_22_0, iter_22_1 in ipairs(ActivityCultivateHeroCfg[arg_22_1].group) do
		local var_22_0 = 0

		for iter_22_2, iter_22_3 in ipairs(CultivateHeroTaskCfg.get_id_list_by_group_id[iter_22_1]) do
			if self.heroTaskInfoList_[arg_22_1][iter_22_3].isCompleted == true and not self.heroTaskInfoList_[arg_22_1][iter_22_3].isReceived then
				var_22_0 = 1

				break
			end
		end

		manager.redPoint:setTip(string.format("%s_%s_%s_Task_Reward", RedPointConst.CULTIVATE_HERO, arg_22_1, iter_22_1), var_22_0)
	end
end

function var_0_0:IsAllReceived(arg_23_1)
	local var_23_0

	if self.accumulateTaskAllReceivedList_[arg_23_1] == true or self.accumulateTaskInfoList_[arg_23_1] == nil then
		do return true end

		var_23_0 = true
	end

	for iter_23_0, iter_23_1 in ipairs(ActivityPointRewardCfg.get_id_list_by_activity_id[arg_23_1]) do
		if not (self.accumulateTaskInfoList_[arg_23_1][iter_23_1] and self.accumulateTaskInfoList_[arg_23_1][iter_23_1].isReceived) then
			var_23_0 = false

			break
		end
	end

	self.accumulateTaskAllReceivedList_[arg_23_1] = var_23_0

	if var_23_0 == true then
		manager.redPoint:setTip(string.format("%s_%s_Daily_Reward", RedPointConst.CULTIVATE_HERO, arg_23_1), 0)
		manager.redPoint:setTip(string.format("%s_%s_Accumulate_Reward", RedPointConst.CULTIVATE_HERO, arg_23_1), 0)

		for iter_23_2, iter_23_3 in ipairs(ActivityCultivateHeroCfg[arg_23_1].group) do
			manager.redPoint:setTip(string.format("%s_%s_%s_Task_Reward", RedPointConst.CULTIVATE_HERO, arg_23_1, iter_23_3), 0)
		end
	end

	return var_23_0
end

return var_0_0
