local var_0_0 = singletonClass("BattleBossChallengeAdvanceData")

function var_0_0.Init(arg_1_0)
	arg_1_0.chooseModeID_ = 0
	arg_1_0.bossData_ = {}
	arg_1_0.lockHero_ = {
		{},
		{},
		{}
	}
	arg_1_0.lastHeroTeam_ = {}
	arg_1_0.cacheHeroTeam_ = {}
	arg_1_0.receiveRewardList_ = {}
	arg_1_0.sortRewardList_ = {}

	manager.redPoint:setTip(RedPointConst.BOSS_CHALLENGE_ADVANCE, 0)
end

function var_0_0:InitData(arg_2_1)
	self.chooseModeID_ = arg_2_1.advance_id

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.boss_list) do
		local var_2_0 = {}

		for iter_2_2, iter_2_3 in ipairs(iter_2_1.time_index_list) do
			table.insert(var_2_0, iter_2_3)
		end

		local var_2_1 = {}

		for iter_2_4, iter_2_5 in ipairs(iter_2_1.affix_index_list) do
			table.insert(var_2_1, iter_2_5)
		end

		self.bossData_[iter_2_0] = {
			id = iter_2_1.id,
			templateID = BossChallengeAdvancePoolCfg[iter_2_1.id].boss_id,
			timestamp = iter_2_1.unlock_timestamp,
			maxPoint = iter_2_1.max_point,
			multipleIndex = iter_2_1.diffculty_index,
			condition = {
				[BossConst.TYPE_STAGE] = var_2_0,
				[BossConst.TYPE_AFFIX] = var_2_1
			}
		}
		self.lockHero_[iter_2_0] = {}

		for iter_2_6, iter_2_7 in ipairs(iter_2_1.used_heroes) do
			table.insert(self.lockHero_[iter_2_0], iter_2_7)
		end

		self.lastHeroTeam_[iter_2_0] = {
			0,
			0,
			0
		}

		for iter_2_8, iter_2_9 in ipairs(iter_2_1.last_heroes_cfg) do
			self.lastHeroTeam_[iter_2_0][iter_2_8] = iter_2_9 or 0
		end
	end

	for iter_2_10 = #self.bossData_, #arg_2_1.boss_list + 1, -1 do
		self.bossData_[iter_2_10] = nil
		self.lockHero_[iter_2_10] = {}
		self.lastHeroTeam_[iter_2_10] = {}
	end

	self.receiveRewardList_ = {}

	for iter_2_11, iter_2_12 in ipairs(arg_2_1.receive_point_list) do
		table.insert(self.receiveRewardList_, iter_2_12)
	end

	self:SortRewardList()
	self:CalcRedPoint()
end

function var_0_0:GetChooseModeID()
	return self.chooseModeID_
end

function var_0_0:GetBossList()
	return self.bossData_
end

function var_0_0:ResetBoss(arg_5_1)
	self.bossData_[arg_5_1].maxPoint = 0
	self.lockHero_[arg_5_1] = {}

	self:SortRewardList()
	self:CalcRedPoint()
end

function var_0_0:GetMaxPoint(arg_6_1)
	return self.bossData_[arg_6_1].maxPoint or 0
end

function var_0_0:GetTotalPoint()
	local var_7_0 = 0

	for iter_7_0, iter_7_1 in pairs(self.bossData_) do
		var_7_0 = var_7_0 + iter_7_1.maxPoint
	end

	return var_7_0
end

function var_0_0:GetPointValue(arg_8_1)
	local var_8_0 = BossChallengeAdvanceCfg[self.chooseModeID_].difficult_point[self.bossData_[arg_8_1].multipleIndex]

	for iter_8_0, iter_8_1 in pairs(self.bossData_[arg_8_1].condition[BossConst.TYPE_STAGE]) do
		var_8_0 = var_8_0 + StageChallengeConditionPoolCfg[iter_8_1].point
	end

	for iter_8_2, iter_8_3 in pairs(self.bossData_[arg_8_1].condition[BossConst.TYPE_AFFIX]) do
		var_8_0 = var_8_0 + ActivityAffixPoolCfg[iter_8_3].point
	end

	return var_8_0
end

function var_0_0:SetBossMultipleIndex(arg_9_1, arg_9_2)
	self.bossData_[arg_9_1].multipleIndex = arg_9_2
end

function var_0_0:GetBossAffixList(arg_10_1, arg_10_2)
	return self.bossData_[arg_10_1].condition[arg_10_2]
end

function var_0_0:SetBossCondition(arg_11_1, arg_11_2, arg_11_3)
	if self:IsActiveBossCondition(arg_11_1, arg_11_2, arg_11_3) then
		table.removebyvalue(self.bossData_[arg_11_1].condition[arg_11_2], arg_11_3)

		return
	end

	if arg_11_2 == BossConst.TYPE_STAGE then
		self:SetBossConditionStage(arg_11_1, arg_11_3)
	else
		self:SetBossAffix(arg_11_1, arg_11_3)
	end
end

function var_0_0:IsActiveBossCondition(arg_12_1, arg_12_2, arg_12_3)
	return table.keyof(self.bossData_[arg_12_1].condition[arg_12_2], arg_12_3) ~= nil
end

function var_0_0:SetBossConditionStage(arg_13_1, arg_13_2)
	for iter_13_0, iter_13_1 in pairs(self.bossData_[arg_13_1].condition[BossConst.TYPE_STAGE]) do
		if StageChallengeConditionPoolCfg[arg_13_2].condition[1] == StageChallengeConditionPoolCfg[iter_13_1].condition[1] then
			table.remove(self.bossData_[arg_13_1].condition[BossConst.TYPE_STAGE], iter_13_0)

			break
		end
	end

	table.insert(self.bossData_[arg_13_1].condition[BossConst.TYPE_STAGE], arg_13_2)
end

function var_0_0:SetBossAffix(arg_14_1, arg_14_2)
	for iter_14_0, iter_14_1 in pairs(self.bossData_[arg_14_1].condition[BossConst.TYPE_AFFIX]) do
		if ActivityAffixPoolCfg[arg_14_2].affix[1] == ActivityAffixPoolCfg[iter_14_1].affix[1] then
			table.remove(self.bossData_[arg_14_1].condition[BossConst.TYPE_AFFIX], iter_14_0)

			break
		end
	end

	table.insert(self.bossData_[arg_14_1].condition[BossConst.TYPE_AFFIX], arg_14_2)
end

function var_0_0:SetBossTarget(arg_15_1, arg_15_2, arg_15_3)
	self.bossData_[arg_15_1].multipleIndex = arg_15_2
	self.bossData_[arg_15_1].condition = arg_15_3
end

function var_0_0:GetLockHero()
	return self.lockHero_
end

function var_0_0:SetCacheHeroTeam(arg_17_1, arg_17_2)
	self.lastHeroTeam_[arg_17_1] = arg_17_2
end

function var_0_0:GetCacheHeroTeam(arg_18_1)
	return self.lastHeroTeam_[arg_18_1] or {
		0,
		0,
		0
	}
end

function var_0_0:ModifyReceiveReward(arg_19_1)
	table.insert(self.receiveRewardList_, arg_19_1)
	self:SortRewardList()
	self:CalcRedPoint()
end

function var_0_0:ModifyAllReceiveReward()
	local var_20_0 = self:GetTotalPoint()

	for iter_20_0, iter_20_1 in ipairs(BossChallengeAdvanceCfg[self.chooseModeID_].reward) do
		if var_20_0 >= iter_20_1[1] and not table.keyof(self.receiveRewardList_, iter_20_1[1]) then
			table.insert(self.receiveRewardList_, iter_20_1[1])
		end
	end

	self:SortRewardList()
	self:CalcRedPoint()
end

function var_0_0:GetReceiveRewardList()
	return self.receiveRewardList_
end

function var_0_0:GetSortRewardList()
	return self.sortRewardList_
end

function var_0_0:SortRewardList()
	local var_23_0 = self:GetTotalPoint()
	local var_23_1 = {}
	local var_23_2 = {}
	local var_23_3 = {}

	for iter_23_0, iter_23_1 in ipairs(BossChallengeAdvanceCfg[self.chooseModeID_].reward) do
		if table.keyof(self.receiveRewardList_, iter_23_1[1]) then
			table.insert(var_23_2, iter_23_0)
		elseif var_23_0 > iter_23_1[1] then
			table.insert(var_23_1, iter_23_0)
		else
			table.insert(var_23_3, iter_23_0)
		end
	end

	table.insertto(var_23_1, var_23_3)
	table.insertto(var_23_1, var_23_2)

	self.sortRewardList_ = var_23_1
end

function var_0_0:CalcRedPoint()
	local var_24_0 = self:GetTotalPoint()

	for iter_24_0, iter_24_1 in ipairs(BossChallengeAdvanceCfg[self.chooseModeID_].reward) do
		if var_24_0 >= iter_24_1[1] and not table.keyof(self.receiveRewardList_, iter_24_1[1]) then
			manager.redPoint:setTip(RedPointConst.BOSS_CHALLENGE_ADVANCE, 1)

			return
		end
	end

	manager.redPoint:setTip(RedPointConst.BOSS_CHALLENGE_ADVANCE, 0)
end

return var_0_0
