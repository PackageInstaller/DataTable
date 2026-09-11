local var_0_0 = singletonClass("GodEaterData")

function var_0_0.Init(arg_1_0)
	arg_1_0.activityID = 0
	arg_1_0.rewardTime = 0
	arg_1_0.rewardNum = 0
	arg_1_0.hubLv = 0
	arg_1_0.nowExp = 0
	arg_1_0.totalExp = 0
	arg_1_0.init = false
	arg_1_0.initRed = false
	arg_1_0.stageData_ = {}
	arg_1_0.curHeroID_ = 0
	arg_1_0.heroGiftGetIDList_ = {}
end

function var_0_0.InitData(arg_2_0, arg_2_1)
	return
end

function var_0_0:UpdateData(arg_3_1)
	self.init = true
	self.rewardTime = arg_3_1.start_time or 0
	self.activityID = arg_3_1.activity_id or 0

	self:UpdateHudLevel()
	self:UpdateRedPoint(self.activityID)
end

function var_0_0:UpdateHudLevel()
	local var_4_0 = ItemTools.getItemNum(CurrencyConst.ACTIVITY_GOD_EATER_HUB_EXP)

	self.hubLv = GodEaterTool.HubExpToLevel(var_4_0)
	self.totalExp = var_4_0

	self:UpdateRedPoint(self.activityID)
	WeekBossAction.UpdateRedPoint()
end

function var_0_0:UpdateRedPoint(arg_5_1)
	local var_5_0

	if ActivityCfg.get_id_list_by_sub_activity_list[arg_5_1] then
		var_5_0 = ActivityCfg.get_id_list_by_sub_activity_list[arg_5_1][1] or 0
	end

	local var_5_1 = TaskTools:GetFinishTaskIDList((TaskTools:GetTaskIDList(TaskConst.TASK_TYPE.ACTIVITY_GOD_EATER_1)))
	local var_5_2 = {}

	for iter_5_0, iter_5_1 in ipairs((TaskTools:GetCanGetActivityTaskList(ActivityConst.ACTIVITY_GODEATER_MAIN_KEY))) do
		if AssignmentCfg[iter_5_1.id].type == 3002 then
			table.insert(var_5_2, iter_5_1)
		end
	end

	if not self.initRed then
		local var_5_3 = ActivityTools.GetRedPointKey(arg_5_1) .. arg_5_1

		manager.redPoint:addGroup(RedPointConst.ACTIVITY_GODEATER_HUB_REWARD_ALL, {
			RedPointConst.ACTIVITY_GODEATER_HUB_REWARD,
			RedPointConst.ACTIVITY_GODEATER_HUB_FULL_REWARD
		})

		local var_5_4 = {
			RedPointConst.ACTIVITY_GODEATER_HUB_REWARD_ALL,
			RedPointConst.ACTIVITY_GODEATER_TASK_REWARD_1,
			RedPointConst.ACTIVITY_GODEATER_TASK_REWARD_2,
			RedPointConst.ACTIVITY_GODEATER_HERO_GIFT
		}

		for iter_5_2, iter_5_3 in ipairs(ActivityCfg[var_5_0].sub_activity_list or {}) do
			table.insert(var_5_4, ActivityTools.GetRedPointKey(var_5_0) .. iter_5_3)
		end

		manager.redPoint:addGroup(var_5_3, var_5_4)
		manager.redPoint:addGroup(ActivityTools.GetRedPointKey(var_5_0) .. var_5_0, {
			var_5_3
		})
		manager.redPoint:addGroup(RedPointConst.ACTIVITY_GODEATER_TASK_REWARD_ALL, {
			RedPointConst.ACTIVITY_GODEATER_TASK_REWARD_1,
			RedPointConst.ACTIVITY_GODEATER_TASK_REWARD_2
		})
	end

	local var_5_5 = {}
	local var_5_6 = {}

	for iter_5_4, iter_5_5 in ipairs(var_5_1) do
		if AssignmentCfg[iter_5_5].phase <= self.hubLv then
			table.insert(var_5_5, iter_5_5)
		end
	end

	for iter_5_6, iter_5_7 in ipairs((TaskTools:GetFinishTaskIDList((TaskTools:GetTaskIDList(TaskConst.TASK_TYPE.ACTIVITY_GOD_EATER_3))))) do
		if AssignmentCfg[iter_5_7].phase <= self.hubLv then
			table.insert(var_5_6, iter_5_7)
		end
	end

	if #var_5_5 > 0 or #var_5_6 > 0 then
		manager.redPoint:setTip(RedPointConst.ACTIVITY_GODEATER_TASK_REWARD_1, 1)
	else
		manager.redPoint:setTip(RedPointConst.ACTIVITY_GODEATER_TASK_REWARD_1, 0)
	end

	if #var_5_2 > 0 then
		manager.redPoint:setTip(RedPointConst.ACTIVITY_GODEATER_TASK_REWARD_2, 1)
	else
		manager.redPoint:setTip(RedPointConst.ACTIVITY_GODEATER_TASK_REWARD_2, 0)
	end

	if #TaskTools:GetCanGetActivityTaskList(ActivityConst.ACTIVITY_CIVILIZATION) > 0 then
		manager.redPoint:setTip(RedPointConst.ACTIVITY_CODEATER_CIVILIZATION, 1)
	else
		manager.redPoint:setTip(RedPointConst.ACTIVITY_CODEATER_CIVILIZATION, 0)
	end

	self:UpdateHeroGiftRedPoint(ActivityConst.ACTIVITY_GODEATER_HERO_GIFT)

	self.initRed = true
end

function var_0_0.UpdateHeroGiftRedPoint(arg_6_0, arg_6_1)
	if ActivityData:GetActivityIsOpen(arg_6_1) and not GodEaterData:GetHeroGiftIsGet(ActivityPointRewardCfg.get_id_list_by_activity_id[arg_6_1][1]) then
		manager.redPoint:setTip(RedPointConst.ACTIVITY_GODEATER_HERO_GIFT, 1)
	else
		manager.redPoint:setTip(RedPointConst.ACTIVITY_GODEATER_HERO_GIFT, 0)
	end
end

function var_0_0:InitGoldMinerData(arg_7_1)
	manager.redPoint:appendGroup(ActivityTools.GetRedPointKey(340001) .. 340001, RedPointConst.ACTIVITY_GODEATER_GOLD_MINER_STAGE)

	self.curHeroID_ = arg_7_1.data.role

	for iter_7_0, iter_7_1 in ipairs(arg_7_1.data.info) do
		print(iter_7_1.stage_id)

		self.stageData_[iter_7_1.stage_id] = iter_7_1.star
	end

	self:CheckGoldMinerStage()
end

function var_0_0:CheckGoldMinerStage()
	local var_8_0 = false

	for iter_8_0, iter_8_1 in ipairs(ActivityGodEaterGoldminerStageCfg.all) do
		if iter_8_0 == 1 and self:GetStageStar(iter_8_1) <= 0 then
			var_8_0 = true
		elseif ActivityData:GetActivityIsOpen(iter_8_1) and self:GetStageStar(ActivityGodEaterGoldminerStageCfg.all[iter_8_0 - 1]) > 0 and self:GetStageStar(iter_8_1) <= 0 then
			var_8_0 = true
		end
	end

	manager.redPoint:setTip(RedPointConst.ACTIVITY_GODEATER_GOLD_MINER_STAGE, var_8_0 and 1 or 0)
end

function var_0_0:GetStageStar(arg_9_1)
	if self.stageData_[arg_9_1] then
		return self.stageData_[arg_9_1]
	else
		return 0
	end
end

function var_0_0:SetStageStar(arg_10_1, arg_10_2)
	self.stageData_[arg_10_1] = self.stageData_[arg_10_1] and math.max(self.stageData_[arg_10_1], arg_10_2) or arg_10_2

	self:CheckGoldMinerStage()
end

function var_0_0.SetGoldActivityId(arg_11_0, arg_11_1)
	arg_11_0.goldStageActivityId_ = arg_11_1
end

function var_0_0:GetGoldActivityId()
	return self.goldStageActivityId_
end

function var_0_0.SetCurHeroID(arg_13_0, arg_13_1)
	arg_13_0.curHeroID_ = arg_13_1
end

function var_0_0:GetCurHeroID()
	return self.curHeroID_
end

function var_0_0:SetHeroGiftData(arg_15_1)
	if arg_15_1.activity_id == ActivityConst.ACTIVITY_GODEATER_HERO_GIFT then
		self.heroGiftGetIDList_ = {}

		for iter_15_0, iter_15_1 in ipairs(arg_15_1.id_list) do
			table.insert(self.heroGiftGetIDList_, iter_15_1)
		end
	end

	self:UpdateHeroGiftRedPoint(ActivityConst.ACTIVITY_GODEATER_HERO_GIFT)
end

function var_0_0:GetHeroGiftIsGet(arg_16_1)
	return table.indexof(self.heroGiftGetIDList_, arg_16_1)
end

function var_0_0:SetHeroGiftIsGet(arg_17_1)
	table.insert(self.heroGiftGetIDList_, arg_17_1)
end

return var_0_0
