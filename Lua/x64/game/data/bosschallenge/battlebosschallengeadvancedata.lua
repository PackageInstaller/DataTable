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

function var_0_0.InitData(arg_2_0, arg_2_1)
	arg_2_0.chooseModeID_ = arg_2_1.advance_id

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.boss_list) do
		local var_2_0 = {}

		for iter_2_2, iter_2_3 in ipairs(iter_2_1.time_index_list) do
			table.insert(var_2_0, iter_2_3)
		end

		local var_2_1 = {}

		for iter_2_4, iter_2_5 in ipairs(iter_2_1.affix_index_list) do
			table.insert(var_2_1, iter_2_5)
		end

		local var_2_2 = BossChallengeAdvancePoolCfg[iter_2_1.id].boss_id

		arg_2_0.bossData_[iter_2_0] = {
			id = iter_2_1.id,
			templateID = var_2_2,
			timestamp = iter_2_1.unlock_timestamp,
			maxPoint = iter_2_1.max_point,
			multipleIndex = iter_2_1.diffculty_index,
			condition = {
				[BossConst.TYPE_STAGE] = var_2_0,
				[BossConst.TYPE_AFFIX] = var_2_1
			}
		}
		arg_2_0.lockHero_[iter_2_0] = {}

		for iter_2_6, iter_2_7 in ipairs(iter_2_1.used_heroes) do
			table.insert(arg_2_0.lockHero_[iter_2_0], iter_2_7)
		end

		arg_2_0.lastHeroTeam_[iter_2_0] = {
			0,
			0,
			0
		}

		for iter_2_8, iter_2_9 in ipairs(iter_2_1.last_heroes_cfg) do
			arg_2_0.lastHeroTeam_[iter_2_0][iter_2_8] = iter_2_9 or 0
		end
	end

	for iter_2_10 = #arg_2_0.bossData_, #arg_2_1.boss_list + 1, -1 do
		arg_2_0.bossData_[iter_2_10] = nil
		arg_2_0.lockHero_[iter_2_10] = {}
		arg_2_0.lastHeroTeam_[iter_2_10] = {}
	end

	arg_2_0.receiveRewardList_ = {}

	for iter_2_11, iter_2_12 in ipairs(arg_2_1.receive_point_list) do
		table.insert(arg_2_0.receiveRewardList_, iter_2_12)
	end

	arg_2_0:SortRewardList()
	arg_2_0:CalcRedPoint()
end

function var_0_0.GetChooseModeID(arg_3_0)
	return arg_3_0.chooseModeID_
end

function var_0_0.GetBossList(arg_4_0)
	return arg_4_0.bossData_
end

function var_0_0.ResetBoss(arg_5_0, arg_5_1)
	arg_5_0.bossData_[arg_5_1].maxPoint = 0
	arg_5_0.lockHero_[arg_5_1] = {}

	arg_5_0:SortRewardList()
	arg_5_0:CalcRedPoint()
end

function var_0_0.GetMaxPoint(arg_6_0, arg_6_1)
	return arg_6_0.bossData_[arg_6_1].maxPoint or 0
end

function var_0_0.GetTotalPoint(arg_7_0)
	local var_7_0 = 0

	for iter_7_0, iter_7_1 in pairs(arg_7_0.bossData_) do
		var_7_0 = var_7_0 + iter_7_1.maxPoint
	end

	return var_7_0
end

function var_0_0.GetPointValue(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.bossData_[arg_8_1]
	local var_8_1 = BossChallengeAdvanceCfg[arg_8_0.chooseModeID_].difficult_point[var_8_0.multipleIndex]

	for iter_8_0, iter_8_1 in pairs(var_8_0.condition[BossConst.TYPE_STAGE]) do
		var_8_1 = var_8_1 + StageChallengeConditionPoolCfg[iter_8_1].point
	end

	for iter_8_2, iter_8_3 in pairs(var_8_0.condition[BossConst.TYPE_AFFIX]) do
		var_8_1 = var_8_1 + ActivityAffixPoolCfg[iter_8_3].point
	end

	return var_8_1
end

function var_0_0.SetBossMultipleIndex(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.bossData_[arg_9_1].multipleIndex = arg_9_2
end

function var_0_0.GetBossAffixList(arg_10_0, arg_10_1, arg_10_2)
	return arg_10_0.bossData_[arg_10_1].condition[arg_10_2]
end

function var_0_0.SetBossCondition(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if arg_11_0:IsActiveBossCondition(arg_11_1, arg_11_2, arg_11_3) then
		table.removebyvalue(arg_11_0.bossData_[arg_11_1].condition[arg_11_2], arg_11_3)

		return
	end

	if arg_11_2 == BossConst.TYPE_STAGE then
		arg_11_0:SetBossConditionStage(arg_11_1, arg_11_3)
	else
		arg_11_0:SetBossAffix(arg_11_1, arg_11_3)
	end
end

function var_0_0.IsActiveBossCondition(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	return table.keyof(arg_12_0.bossData_[arg_12_1].condition[arg_12_2], arg_12_3) ~= nil
end

function var_0_0.SetBossConditionStage(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = BossConst.TYPE_STAGE
	local var_13_1 = StageChallengeConditionPoolCfg[arg_13_2].condition[1]

	for iter_13_0, iter_13_1 in pairs(arg_13_0.bossData_[arg_13_1].condition[var_13_0]) do
		if var_13_1 == StageChallengeConditionPoolCfg[iter_13_1].condition[1] then
			table.remove(arg_13_0.bossData_[arg_13_1].condition[var_13_0], iter_13_0)

			break
		end
	end

	table.insert(arg_13_0.bossData_[arg_13_1].condition[var_13_0], arg_13_2)
end

function var_0_0.SetBossAffix(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = BossConst.TYPE_AFFIX
	local var_14_1 = ActivityAffixPoolCfg[arg_14_2]

	for iter_14_0, iter_14_1 in pairs(arg_14_0.bossData_[arg_14_1].condition[var_14_0]) do
		if var_14_1.affix[1] == ActivityAffixPoolCfg[iter_14_1].affix[1] then
			table.remove(arg_14_0.bossData_[arg_14_1].condition[var_14_0], iter_14_0)

			break
		end
	end

	table.insert(arg_14_0.bossData_[arg_14_1].condition[var_14_0], arg_14_2)
end

function var_0_0.SetBossTarget(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	arg_15_0.bossData_[arg_15_1].multipleIndex = arg_15_2
	arg_15_0.bossData_[arg_15_1].condition = arg_15_3
end

function var_0_0.GetLockHero(arg_16_0)
	return arg_16_0.lockHero_
end

function var_0_0.SetCacheHeroTeam(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0.lastHeroTeam_[arg_17_1] = arg_17_2
end

function var_0_0.GetCacheHeroTeam(arg_18_0, arg_18_1)
	return arg_18_0.lastHeroTeam_[arg_18_1] or {
		0,
		0,
		0
	}
end

function var_0_0.ModifyReceiveReward(arg_19_0, arg_19_1)
	table.insert(arg_19_0.receiveRewardList_, arg_19_1)
	arg_19_0:SortRewardList()
	arg_19_0:CalcRedPoint()
end

function var_0_0.ModifyAllReceiveReward(arg_20_0)
	local var_20_0 = BossChallengeAdvanceCfg[arg_20_0.chooseModeID_]
	local var_20_1 = arg_20_0:GetTotalPoint()

	for iter_20_0, iter_20_1 in ipairs(var_20_0.reward) do
		if var_20_1 >= iter_20_1[1] and not table.keyof(arg_20_0.receiveRewardList_, iter_20_1[1]) then
			table.insert(arg_20_0.receiveRewardList_, iter_20_1[1])
		end
	end

	arg_20_0:SortRewardList()
	arg_20_0:CalcRedPoint()
end

function var_0_0.GetReceiveRewardList(arg_21_0)
	return arg_21_0.receiveRewardList_
end

function var_0_0.GetSortRewardList(arg_22_0)
	return arg_22_0.sortRewardList_
end

function var_0_0.SortRewardList(arg_23_0)
	local var_23_0 = arg_23_0:GetTotalPoint()
	local var_23_1 = {}
	local var_23_2 = {}
	local var_23_3 = {}

	for iter_23_0, iter_23_1 in ipairs(BossChallengeAdvanceCfg[arg_23_0.chooseModeID_].reward) do
		if table.keyof(arg_23_0.receiveRewardList_, iter_23_1[1]) then
			table.insert(var_23_2, iter_23_0)
		elseif var_23_0 > iter_23_1[1] then
			table.insert(var_23_1, iter_23_0)
		else
			table.insert(var_23_3, iter_23_0)
		end
	end

	table.insertto(var_23_1, var_23_3)
	table.insertto(var_23_1, var_23_2)

	arg_23_0.sortRewardList_ = var_23_1
end

function var_0_0.CalcRedPoint(arg_24_0)
	local var_24_0 = BossChallengeAdvanceCfg[arg_24_0.chooseModeID_]
	local var_24_1 = arg_24_0:GetTotalPoint()

	for iter_24_0, iter_24_1 in ipairs(var_24_0.reward) do
		if var_24_1 >= iter_24_1[1] and not table.keyof(arg_24_0.receiveRewardList_, iter_24_1[1]) then
			manager.redPoint:setTip(RedPointConst.BOSS_CHALLENGE_ADVANCE, 1)

			return
		end
	end

	manager.redPoint:setTip(RedPointConst.BOSS_CHALLENGE_ADVANCE, 0)
end

return var_0_0
