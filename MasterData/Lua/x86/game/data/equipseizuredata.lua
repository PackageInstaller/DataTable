local var_0_0 = singletonClass("EquipSeizureData")

function var_0_0.Init(arg_1_0)
	arg_1_0.stageID_ = nil
	arg_1_0.challengeRate_ = 1
	arg_1_0.affixIDList_ = {}
	arg_1_0.receivedList_ = {}
	arg_1_0.canReceiveList_ = {}
	arg_1_0.affixRefreshTimestamp_ = 0
	arg_1_0.todayMaxScore_ = 0
	arg_1_0.sumScore_ = 0
	arg_1_0.nextRefreshTimestamp_ = 0
end

function var_0_0:InitData(arg_2_1)
	self.stageID_ = arg_2_1.stage_id
	self.challengeRate_ = arg_2_1.challenge_rate or 1
	self.affixRefreshTimestamp_ = arg_2_1.affix_info.refresh_timestamp or 0
	self.affixIDList_ = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.affix_info.affix_id_list) do
		table.insert(self.affixIDList_, iter_2_1)
	end

	self.todayMaxScore_ = arg_2_1.today_max_score or 0
	self.sumScore_ = arg_2_1.sum_score or 0
	self.nextRefreshTimestamp_ = arg_2_1.refresh_timestamp or 0

	if self.affixRefreshTimestamp_ > self.nextRefreshTimestamp_ then
		self.affixRefreshTimestamp_ = self.nextRefreshTimestamp_
	end

	self.receivedList_ = {}

	for iter_2_2, iter_2_3 in ipairs(arg_2_1.got_reward_id_list) do
		table.insert(self.receivedList_, iter_2_3)
	end

	self:CheckRedPoint()
	self:SortRewardList()
end

function var_0_0:RefreshBattleScore(arg_3_1)
	self.isValid_ = arg_3_1.is_valid
	self.resultScore_ = arg_3_1.score or 0

	if arg_3_1.is_valid and self.resultScore_ > self.todayMaxScore_ then
		self.todayMaxScore_ = self.resultScore_
		self.sumScore_ = arg_3_1.sum_score or self.sumScore_

		self:CheckRedPoint()
		self:SortRewardList()
	end
end

function var_0_0:GetStageID()
	return self.stageID_
end

function var_0_0:GetChallengeRate()
	return self.challengeRate_
end

function var_0_0:GetAffixRefreshTimestamp()
	return self.affixRefreshTimestamp_
end

function var_0_0:GetAffixIDList()
	return self.affixIDList_
end

function var_0_0:GetTodayMaxScore()
	return self.todayMaxScore_
end

function var_0_0:GetTotalScore()
	return self.sumScore_
end

function var_0_0:NextRefreshTimestamp()
	return self.nextRefreshTimestamp_
end

function var_0_0:GetResultScore()
	return self.resultScore_
end

function var_0_0:GetCanReceiveList()
	return self.canReceiveList_
end

function var_0_0:GetReceiveList()
	return self.receivedList_
end

function var_0_0:GetSortRewardList()
	return self.sortRewardList_
end

function var_0_0:ReceiveReward(arg_15_1)
	for iter_15_0, iter_15_1 in ipairs(arg_15_1) do
		table.insert(self.receivedList_, iter_15_1)
	end

	self:CheckRedPoint()
	self:SortRewardList()
end

function var_0_0:SortRewardList()
	self.canReceiveList_ = {}

	local var_16_0 = {}
	local var_16_1 = self:GetTotalScore()

	for iter_16_0, iter_16_1 in ipairs(EquipSeizurePointRewardCfg.all) do
		if var_16_1 < EquipSeizurePointRewardCfg[iter_16_1].need then
			table.insert(var_16_0, iter_16_1)
		elseif table.keyof(self.receivedList_, iter_16_1) == nil then
			table.insert(self.canReceiveList_, iter_16_1)
		end
	end

	local var_16_2 = {}

	table.insertto(var_16_2, self.canReceiveList_)
	table.insertto(var_16_2, var_16_0)
	table.insertto(var_16_2, self.receivedList_)

	self.sortRewardList_ = var_16_2
end

function var_0_0:CheckRedPoint()
	local var_17_0 = self:GetTotalScore()

	for iter_17_0, iter_17_1 in ipairs(EquipSeizurePointRewardCfg.all) do
		if var_17_0 >= EquipSeizurePointRewardCfg[iter_17_1].need and not table.keyof(self.receivedList_, iter_17_1) then
			manager.redPoint:setTip(RedPointConst.EQUIP_SEIZURE_REWARD, 1)

			return
		end
	end

	manager.redPoint:setTip(RedPointConst.EQUIP_SEIZURE_REWARD, 0)
end

return var_0_0
