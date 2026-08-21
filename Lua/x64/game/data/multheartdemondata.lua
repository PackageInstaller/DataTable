local var_0_0 = singletonClass("MultHeartDemonData")
local var_0_1 = {}

function var_0_0.Init(arg_1_0)
	var_0_1:Init()
end

function var_0_0.InitMultHeartDemonData(arg_2_0, arg_2_1)
	var_0_1:InitMultHeartDemonData(arg_2_1)
end

function var_0_0.UpdateRewardList(arg_3_0, arg_3_1)
	var_0_1:UpdateRewardList(arg_3_1)
end

function var_0_0.GetDataByPara(arg_4_0, arg_4_1)
	return var_0_1[arg_4_1]
end

function var_0_0.UpdateBattleFinishScore(arg_5_0, arg_5_1)
	var_0_1:UpdateBattleFinishScore(arg_5_1)
end

function var_0_0.UpdateHeroList(arg_6_0, arg_6_1, arg_6_2)
	var_0_1:UpdateHeroList(arg_6_1, arg_6_2)
end

function var_0_0.InitHeroList(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	var_0_1:InitHeroList(arg_7_1, arg_7_2, arg_7_3)

	if arg_7_3 == 2 then
		var_0_1.enterFlag = true
	end
end

function var_0_0.UpdateTempHeroList(arg_8_0, arg_8_1, arg_8_2)
	var_0_1:UpdateTempHeroList(arg_8_1, arg_8_2)
end

function var_0_0.GetAcvivityId(arg_9_0)
	return var_0_1:GetAcvivityId()
end

function var_0_0.GiveUp(arg_10_0, arg_10_1)
	var_0_1.isLock = false
	var_0_1.enterFlag = false
	var_0_1.heroTempData = {}

	local var_10_0 = HeroViewDataProxy.New(3)
	local var_10_1 = MultHeartDemonCfg[MultHeartDemonCfg.get_id_list_by_activity_id[var_0_1.activityId][1]]

	if var_0_1.heroTempData == nil or var_0_1.heroTempData[2] == nil then
		var_0_1.heroTempData = {
			[2] = {}
		}

		if var_0_1.difficultyData[2] == nil then
			var_0_1.difficultyData[2] = {
				heroIdList = {}
			}
		end

		var_10_0:SetTempHeroList(var_10_1.trial_hero)

		for iter_10_0, iter_10_1 in ipairs(var_10_1.trial_hero) do
			local var_10_2 = HeroStandardSystemCfg[iter_10_1]

			table.insert(var_0_1.heroTempData[2], {
				type = 3,
				id = var_10_2.hero_id,
				trialID = iter_10_1,
				heroViewProxy = var_10_0
			})

			var_0_1.difficultyData[2].heroIdList[iter_10_0] = iter_10_1
		end
	end
end

function var_0_0.CheckDifficultyCanEnter(arg_11_0, arg_11_1)
	local var_11_0 = var_0_1.activityId
	local var_11_1 = ActivityData:GetActivityRefreshTime(var_11_0)

	if not ActivityData:GetActivityIsOpen(var_11_0) or var_11_1 <= manager.time:GetServerTime() then
		return false
	end

	local var_11_2 = MultHeartDemonCfg[MultHeartDemonCfg.get_id_list_by_activity_id[var_11_0][1]]

	if var_0_1.difficultyData == nil then
		return true
	end

	local var_11_3 = var_0_1.difficultyData[arg_11_1]

	if var_11_3 == nil then
		return true
	end

	return var_0_0:CheckWinOrFail(var_11_3, var_11_2) ~= 0
end

function var_0_0.CheckWinOrFail(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = true

	if arg_12_1.heroHPList == nil then
		arg_12_1.heroHPList = {}
	end

	for iter_12_0, iter_12_1 in pairs(arg_12_1.heroIdList) do
		var_12_0 = arg_12_1.heroHPList[iter_12_1] == 0 and var_12_0
	end

	if var_12_0 then
		return 1
	end

	local var_12_1 = true

	for iter_12_2, iter_12_3 in pairs(arg_12_2.heart_damon_id) do
		var_12_1 = arg_12_1.heroHPList[iter_12_3] == 0 and var_12_1
	end

	if var_12_1 then
		return 2
	end

	return 0
end

function var_0_1.Init(arg_13_0)
	arg_13_0.maxScore = 0
	arg_13_0.isLock = false
	arg_13_0.rankTaskList = {}
	arg_13_0.heroTempData = {}

	for iter_13_0, iter_13_1 in ipairs(MultHeartDemonRewardCfg.get_id_list_by_reward_type[0]) do
		table.insert(arg_13_0.rankTaskList, iter_13_1)
	end
end

function var_0_1.InitMultHeartDemonData(arg_14_0, arg_14_1)
	arg_14_0.activityId = arg_14_1.open_edition
	arg_14_0.difficultyData = arg_14_0:ParseDifficultyData(arg_14_1.info_list)
	arg_14_0.challengeStage = arg_14_1.challenge_stage
	arg_14_0.maxScore = {}

	for iter_14_0, iter_14_1 in ipairs(arg_14_1.max_score_list) do
		arg_14_0.maxScore[iter_14_1.difficulty] = iter_14_1.max_score
	end

	arg_14_0:UpdateData()
	arg_14_0:UpdateHeroHP()
	arg_14_0:UpdateName()

	local var_14_0 = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.TRIAL)
	local var_14_1 = MultHeartDemonCfg[MultHeartDemonCfg.get_id_list_by_activity_id[arg_14_0.activityId][1]]

	var_14_0:SetTempHeroList(var_14_1.trial_hero)

	arg_14_0.trialProxy = var_14_0
	arg_14_0.heroTempData = {}

	if nullable(arg_14_0.heroTempData, 2) == nil then
		local var_14_2 = {}

		if arg_14_0.difficultyData[2] == nil then
			arg_14_0.difficultyData[2] = {
				heroIdList = clone(var_14_1.trial_hero)
			}
		end

		for iter_14_2, iter_14_3 in ipairs(arg_14_0.difficultyData[2].heroIdList) do
			local var_14_3 = HeroStandardSystemCfg[iter_14_3]

			table.insert(var_14_2, {
				id = var_14_3.hero_id,
				trialID = iter_14_3,
				type = HeroConst.HERO_DATA_TYPE.DEFAULT,
				heroViewProxy = var_14_0
			})
		end

		arg_14_0.heroTempData[2] = var_14_2
	end

	if nullable(arg_14_0.heroTempData, 1) == nil and arg_14_0.difficultyData[1] then
		local var_14_4 = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)
		local var_14_5 = {}

		for iter_14_4, iter_14_5 in ipairs(arg_14_0.difficultyData[1].heroIdList) do
			local var_14_6 = HeroStandardSystemCfg[iter_14_5]

			if var_14_6 then
				table.insert(var_14_5, {
					id = var_14_6.hero_id,
					trialID = iter_14_5,
					type = HeroConst.HERO_DATA_TYPE.TRIAL,
					heroViewProxy = var_14_0
				})
			else
				table.insert(var_14_5, {
					trialID = 0,
					id = iter_14_5,
					type = HeroConst.HERO_DATA_TYPE.DEFAULT,
					heroViewProxy = var_14_4
				})
			end
		end

		arg_14_0.heroTempData[1] = var_14_5
	end

	MultHeartDemonAction.UpdateRewardRedPoint()
end

function var_0_1.UpdateName(arg_15_0)
	arg_15_0.nameTable = {}

	local var_15_0 = MultHeartDemonCfg[MultHeartDemonCfg.get_id_list_by_activity_id[var_0_1.activityId][1]]
	local var_15_1 = string.split(GetI18NText(var_15_0.heart_damon_name), ",")

	for iter_15_0, iter_15_1 in ipairs(var_15_0.heart_damon_id) do
		arg_15_0.nameTable[iter_15_1] = var_15_1[iter_15_0]
	end
end

function var_0_1.UpdateHeroHP(arg_16_0)
	for iter_16_0, iter_16_1 in pairs(arg_16_0.difficultyData) do
		iter_16_1.heroHPList = {}

		for iter_16_2, iter_16_3 in ipairs(iter_16_1.stageData) do
			if iter_16_1.heroHPList[iter_16_3.heroId] == nil then
				iter_16_1.heroHPList[iter_16_3.heroId] = iter_16_3.heroHP
			end

			if iter_16_1.heroHPList[iter_16_3.bossId] == nil then
				iter_16_1.heroHPList[iter_16_3.bossId] = iter_16_3.bossHP
			end
		end
	end
end

function var_0_1.UpdateHeroList(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_0.isLock then
		return
	end

	if arg_17_2 == 1 then
		arg_17_0.difficultyData[arg_17_2] = {
			heroIdList = {}
		}
	end

	for iter_17_0, iter_17_1 in pairs(arg_17_1) do
		arg_17_0.difficultyData[arg_17_2].heroIdList[iter_17_0] = iter_17_1
	end

	manager.notify:CallUpdateFunc(MULT_HEART_DEMON_SAVE_TEAM)
end

function var_0_1.InitHeroList(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = arg_18_1

	if arg_18_1 == nil then
		var_18_0 = arg_18_0.difficultyData[arg_18_3]
	end

	for iter_18_0, iter_18_1 in ipairs(arg_18_2) do
		var_18_0.heroIdList[iter_18_0] = iter_18_1
		arg_18_0.isLock = true
	end
end

function var_0_1.UpdateData(arg_19_0)
	return
end

function var_0_1.UpdateTempHeroList(arg_20_0, arg_20_1, arg_20_2)
	arg_20_0.heroTempData[arg_20_2] = {}
	arg_20_0.heroTempData[arg_20_2] = arg_20_1
end

function var_0_1.ParseDifficultyData(arg_21_0, arg_21_1)
	local var_21_0 = {}

	for iter_21_0, iter_21_1 in ipairs(arg_21_1) do
		var_21_0[iter_21_1.difficulty] = {}
		var_21_0[iter_21_1.difficulty].stageData = arg_21_0:ParseStageData(iter_21_1.stage_info_list)
		var_21_0[iter_21_1.difficulty].heroIdList = {}

		arg_21_0:InitHeroList(var_21_0[iter_21_1.difficulty], iter_21_1.hero_id_list, iter_21_1.difficulty)

		if iter_21_1.difficulty == 2 then
			arg_21_0.enterFlag = iter_21_1.enter_flag
		end
	end

	return var_21_0
end

function var_0_1.ParseStageData(arg_22_0, arg_22_1)
	local var_22_0 = {}

	for iter_22_0, iter_22_1 in ipairs(arg_22_1) do
		local var_22_1 = iter_22_0

		var_22_0[var_22_1] = arg_22_0:DefaultData()
		var_22_0[var_22_1].stageID = iter_22_1.stage_id
		var_22_0[var_22_1].challengeState = iter_22_1.challenge_state

		if iter_22_1.challenge_state ~= 0 then
			var_22_0[var_22_1].maxScore = iter_22_1.max_score
			var_22_0[var_22_1].heroHP = iter_22_1.hero_hp
			var_22_0[var_22_1].bossHP = iter_22_1.boss_hp
			var_22_0[var_22_1].heroId = iter_22_1.hero_id
			var_22_0[var_22_1].bossId = var_0_0:GetBossIdByStageId(iter_22_1.stage_id)
		end
	end

	return var_22_0
end

function var_0_0.GetBossIdByStageId(arg_23_0, arg_23_1)
	local var_23_0 = MultHeartDemonCfg[MultHeartDemonCfg.get_id_list_by_activity_id[var_0_1.activityId][1]]

	for iter_23_0 = 1, 2 do
		for iter_23_1, iter_23_2 in ipairs(var_23_0.stage_id[iter_23_0][2]) do
			if arg_23_1 == iter_23_2 then
				return var_23_0.heart_damon_id[iter_23_1]
			end
		end
	end

	return 0
end

function var_0_1.DefaultData(arg_24_0)
	return {
		challengeState = 0,
		maxScore = 0
	}
end

function var_0_1.UpdateBattleFinishScore(arg_25_0, arg_25_1)
	arg_25_0.battleScore = arg_25_1
end

function var_0_1.GetAcvivityId(arg_26_0, arg_26_1)
	return arg_26_0.activityId
end

return var_0_0
