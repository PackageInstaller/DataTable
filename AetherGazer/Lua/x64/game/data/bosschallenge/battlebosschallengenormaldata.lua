local var_0_0 = singletonClass("BattleBossChallengeNormalData")

function var_0_0.Init(arg_1_0)
	arg_1_0.areaID_ = 1
	arg_1_0.bossList_ = {}
	arg_1_0.bossUnlockTimeList_ = {
		0,
		0,
		0
	}
	arg_1_0.finishIndex_ = {
		0,
		0,
		0
	}
	arg_1_0.lockHero_ = {
		{},
		{},
		{}
	}
	arg_1_0.lastHeroTeam_ = {}
	arg_1_0.cacheHeroTeam_ = {}
	arg_1_0.usedCnt_ = 0
	arg_1_0.threeStarList_ = {}
	arg_1_0.receiveStarList_ = {}
	arg_1_0.selectDifficult_ = {}
end

local var_0_1 = -1
local var_0_2 = 0

function var_0_0.InitData(arg_2_0, arg_2_1)
	arg_2_0.threeStarList_ = {}

	manager.redPoint:setTip(RedPointConst.BOSS_CHALLENGE_NORMAL, 0)

	arg_2_0.receiveStarList_ = {}
	arg_2_0.areaID_ = arg_2_1.area_id == 0 and 1 or arg_2_1.area_id

	arg_2_0:SetUsedCnt(arg_2_1.use_times)

	arg_2_0.bossList_ = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.receive_star_list) do
		arg_2_0.receiveStarList_[iter_2_0] = iter_2_1
	end

	for iter_2_2, iter_2_3 in ipairs(arg_2_1.boss_challenge_list) do
		arg_2_0.bossList_[iter_2_2] = iter_2_3.group_id
		arg_2_0.bossUnlockTimeList_[iter_2_2] = iter_2_3.unlock_timestamp or 0
		arg_2_0.finishIndex_[iter_2_2] = (table.keyof(StageGroupCfg[iter_2_3.group_id].stage_list, iter_2_3.finish_stage) or 0) + 1

		if arg_2_0.finishIndex_[iter_2_2] > BossChallengeCfg[arg_2_0.areaID_].level_amount then
			arg_2_0.finishIndex_[iter_2_2] = BossChallengeCfg[arg_2_0.areaID_].level_amount
		end

		arg_2_0.lockHero_[iter_2_2] = {}

		for iter_2_4, iter_2_5 in ipairs(iter_2_3.used_heroes) do
			table.insert(arg_2_0.lockHero_[iter_2_2], iter_2_5)
		end

		arg_2_0.lastHeroTeam_[iter_2_2] = {
			0,
			0,
			0
		}

		for iter_2_6, iter_2_7 in ipairs(iter_2_3.last_heroes_cfg) do
			arg_2_0.lastHeroTeam_[iter_2_2][iter_2_6] = iter_2_7 or 0
		end

		for iter_2_8, iter_2_9 in ipairs(iter_2_3.star_info) do
			arg_2_0.threeStarList_[iter_2_9.stage_id] = {}

			arg_2_0:ClientModifyThreeStar(iter_2_9.stage_id, iter_2_9.star_list)
		end
	end

	arg_2_0.selectDifficult_ = {}

	local var_2_0 = StageTools.CalcBossChallengeStar()
	local var_2_1 = {
		22,
		26,
		35,
		40
	}

	if var_0_1 > 0 then
		print(var_2_0)

		for iter_2_10, iter_2_11 in pairs(var_2_1) do
			if iter_2_11 > var_0_2 and iter_2_11 <= var_2_0 and var_2_0 > var_0_2 then
				SendMessageManagerToSDK("bossrush_star", {
					curStarCnt = iter_2_11
				})
			end
		end

		if math.floor(var_2_0 % 3) == 0 and var_2_0 > var_0_2 then
			SendMessageManagerToSDK("bossrush_star", {
				curStarCnt = var_2_0
			})
		end
	end

	var_0_1 = 1
	var_0_2 = var_2_0
end

function var_0_0.GetBossChallengeCfg(arg_3_0)
	return BossChallengeCfg[arg_3_0.areaID_]
end

function var_0_0.GetStageList(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0.bossList_[arg_4_1]

	return StageGroupCfg[var_4_0].stage_list[arg_4_2]
end

function var_0_0.GetBossList(arg_5_0)
	return arg_5_0.bossList_
end

function var_0_0.GetBossUnlockTime(arg_6_0, arg_6_1)
	return arg_6_0.bossUnlockTimeList_[arg_6_1] or 0
end

function var_0_0.ResetBoss(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.bossList_[arg_7_1]

	for iter_7_0, iter_7_1 in ipairs(StageGroupCfg[var_7_0].stage_list) do
		arg_7_0.threeStarList_[iter_7_1] = {
			0,
			0,
			0
		}
	end

	arg_7_0.finishIndex_[arg_7_1] = 1
	arg_7_0.lockHero_[arg_7_1] = {}
	arg_7_0.lastHeroTeam_[arg_7_1] = {
		0,
		0,
		0
	}
	arg_7_0.selectDifficult_[arg_7_1] = 1

	arg_7_0:CalcRedPoint()
end

function var_0_0.GetFinishIndex(arg_8_0, arg_8_1)
	return arg_8_0.finishIndex_[arg_8_1]
end

function var_0_0.SetUsedCnt(arg_9_0, arg_9_1)
	arg_9_0.usedCnt_ = arg_9_1
end

function var_0_0.GetUsedCnt(arg_10_0)
	return arg_10_0.usedCnt_
end

function var_0_0.GetLockHero(arg_11_0)
	return arg_11_0.lockHero_
end

function var_0_0.SetCacheHeroTeam(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0.lastHeroTeam_[arg_12_1] = arg_12_2
end

function var_0_0.GetCacheHeroTeam(arg_13_0, arg_13_1)
	return arg_13_0.lastHeroTeam_[arg_13_1] or {
		0,
		0,
		0
	}
end

function var_0_0.SetSelectDifficult(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0.selectDifficult_[arg_14_1] = arg_14_2

	saveData("BossChallenge", "difficult" .. arg_14_1, arg_14_2)
end

function var_0_0.GetSelectDifficult(arg_15_0, arg_15_1)
	if arg_15_0.selectDifficult_[arg_15_1] then
		return arg_15_0.selectDifficult_[arg_15_1]
	end

	local var_15_0 = getData("BossChallenge", "difficult" .. arg_15_1) or arg_15_0.finishIndex_[arg_15_1]

	if var_15_0 > arg_15_0.finishIndex_[arg_15_1] then
		return arg_15_0.finishIndex_[arg_15_1]
	else
		return var_15_0
	end
end

function var_0_0.GetThreeStarList(arg_16_0)
	return arg_16_0.threeStarList_
end

function var_0_0.GetStarList(arg_17_0, arg_17_1)
	return arg_17_0.threeStarList_[arg_17_1] or {
		0,
		0,
		0
	}
end

function var_0_0.ClientModifyThreeStar(arg_18_0, arg_18_1, arg_18_2)
	for iter_18_0, iter_18_1 in ipairs(arg_18_2) do
		arg_18_0.threeStarList_[arg_18_1][iter_18_0] = arg_18_0.threeStarList_[arg_18_1][iter_18_0] == 1 and 1 or iter_18_1
	end

	arg_18_0:CalcRedPoint()
end

function var_0_0.GetReceiveStarList(arg_19_0)
	return arg_19_0.receiveStarList_
end

function var_0_0.SetReceiveStarList(arg_20_0, arg_20_1)
	table.insert(arg_20_0.receiveStarList_, arg_20_1)
	arg_20_0:CalcRedPoint()
end

function var_0_0.CalcRedPoint(arg_21_0)
	local var_21_0 = StageTools.CalcBossChallengeStar()
	local var_21_1 = arg_21_0:GetBossChallengeCfg()

	for iter_21_0, iter_21_1 in ipairs(var_21_1.reward) do
		if var_21_0 >= iter_21_1[1] and not table.keyof(arg_21_0.receiveStarList_, iter_21_1[1]) then
			manager.redPoint:setTip(RedPointConst.BOSS_CHALLENGE_NORMAL, 1)

			return
		end
	end

	manager.redPoint:setTip(RedPointConst.BOSS_CHALLENGE_NORMAL, 0)
end

return var_0_0
