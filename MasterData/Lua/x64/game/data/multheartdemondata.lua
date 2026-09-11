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

	if var_0_1.heroTempData == nil or var_0_1.heroTempData[2] == nil then
		var_0_1.heroTempData = {
			[2] = {}
		}

		if var_0_1.difficultyData[2] == nil then
			var_0_1.difficultyData[2] = {
				heroIdList = {}
			}
		end

		var_10_0:SetTempHeroList(MultHeartDemonCfg[MultHeartDemonCfg.get_id_list_by_activity_id[var_0_1.activityId][1]].trial_hero)

		for iter_10_0, iter_10_1 in ipairs(MultHeartDemonCfg[MultHeartDemonCfg.get_id_list_by_activity_id[var_0_1.activityId][1]].trial_hero) do
			table.insert(var_0_1.heroTempData[2], {
				type = 3,
				id = HeroStandardSystemCfg[iter_10_1].hero_id,
				trialID = iter_10_1,
				heroViewProxy = var_10_0
			})

			var_0_1.difficultyData[2].heroIdList[iter_10_0] = iter_10_1
		end
	end
end

function var_0_0.CheckDifficultyCanEnter(arg_11_0, arg_11_1)
	if not ActivityData:GetActivityIsOpen(var_0_1.activityId) or ActivityData:GetActivityRefreshTime(var_0_1.activityId) <= manager.time:GetServerTime() then
		return false
	end

	local var_11_0 = MultHeartDemonCfg[MultHeartDemonCfg.get_id_list_by_activity_id[var_0_1.activityId][1]]

	if var_0_1.difficultyData == nil then
		return true
	end

	local var_11_1 = var_0_1.difficultyData[arg_11_1]

	if var_0_1.difficultyData[arg_11_1] == nil then
		return true
	end

	return var_0_0:CheckWinOrFail(var_11_1, var_11_0) ~= 0
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

function var_0_1:Init()
	self.maxScore = 0
	self.isLock = false
	self.rankTaskList = {}
	self.heroTempData = {}

	for iter_13_0, iter_13_1 in ipairs(MultHeartDemonRewardCfg.get_id_list_by_reward_type[0]) do
		table.insert(self.rankTaskList, iter_13_1)
	end
end

function var_0_1:InitMultHeartDemonData(arg_14_1)
	self.activityId = arg_14_1.open_edition
	self.difficultyData = self:ParseDifficultyData(arg_14_1.info_list)
	self.challengeStage = arg_14_1.challenge_stage
	self.maxScore = {}

	for iter_14_0, iter_14_1 in ipairs(arg_14_1.max_score_list) do
		self.maxScore[iter_14_1.difficulty] = iter_14_1.max_score
	end

	self:UpdateData()
	self:UpdateHeroHP()
	self:UpdateName()

	local var_14_0 = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.TRIAL)

	var_14_0:SetTempHeroList(MultHeartDemonCfg[MultHeartDemonCfg.get_id_list_by_activity_id[self.activityId][1]].trial_hero)

	self.trialProxy = var_14_0
	self.heroTempData = {}

	if nullable(self.heroTempData, 2) == nil then
		local var_14_1 = {}

		if self.difficultyData[2] == nil then
			self.difficultyData[2] = {
				heroIdList = clone(MultHeartDemonCfg[MultHeartDemonCfg.get_id_list_by_activity_id[self.activityId][1]].trial_hero)
			}
		end

		for iter_14_2, iter_14_3 in ipairs(self.difficultyData[2].heroIdList) do
			table.insert(var_14_1, {
				id = HeroStandardSystemCfg[iter_14_3].hero_id,
				trialID = iter_14_3,
				type = HeroConst.HERO_DATA_TYPE.DEFAULT,
				heroViewProxy = var_14_0
			})
		end

		self.heroTempData[2] = var_14_1
	end

	if nullable(self.heroTempData, 1) == nil and self.difficultyData[1] then
		local var_14_2 = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)
		local var_14_3 = {}

		for iter_14_4, iter_14_5 in ipairs(self.difficultyData[1].heroIdList) do
			if HeroStandardSystemCfg[iter_14_5] then
				table.insert(var_14_3, {
					id = HeroStandardSystemCfg[iter_14_5].hero_id,
					trialID = iter_14_5,
					type = HeroConst.HERO_DATA_TYPE.TRIAL,
					heroViewProxy = var_14_0
				})
			else
				table.insert(var_14_3, {
					trialID = 0,
					id = iter_14_5,
					type = HeroConst.HERO_DATA_TYPE.DEFAULT,
					heroViewProxy = var_14_2
				})
			end
		end

		self.heroTempData[1] = var_14_3
	end

	MultHeartDemonAction.UpdateRewardRedPoint()
end

function var_0_1:UpdateName()
	self.nameTable = {}

	local var_15_0 = string.split(GetI18NText(MultHeartDemonCfg[MultHeartDemonCfg.get_id_list_by_activity_id[var_0_1.activityId][1]].heart_damon_name), ",")

	for iter_15_0, iter_15_1 in ipairs(MultHeartDemonCfg[MultHeartDemonCfg.get_id_list_by_activity_id[var_0_1.activityId][1]].heart_damon_id) do
		self.nameTable[iter_15_1] = var_15_0[iter_15_0]
	end
end

function var_0_1:UpdateHeroHP()
	for iter_16_0, iter_16_1 in pairs(self.difficultyData) do
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

function var_0_1:UpdateHeroList(arg_17_1, arg_17_2)
	if self.isLock then
		return
	end

	if arg_17_2 == 1 then
		self.difficultyData[arg_17_2] = {
			heroIdList = {}
		}
	end

	for iter_17_0, iter_17_1 in pairs(arg_17_1) do
		self.difficultyData[arg_17_2].heroIdList[iter_17_0] = iter_17_1
	end

	manager.notify:CallUpdateFunc(MULT_HEART_DEMON_SAVE_TEAM)
end

function var_0_1:InitHeroList(arg_18_1, arg_18_2, arg_18_3)
	for iter_18_0, iter_18_1 in ipairs(arg_18_2) do
		((arg_18_1 == nil or nil) and self.difficultyData[arg_18_3]).heroIdList[iter_18_0] = iter_18_1
		self.isLock = true
	end
end

function var_0_1.UpdateData(arg_19_0)
	return
end

function var_0_1:UpdateTempHeroList(arg_20_1, arg_20_2)
	self.heroTempData[arg_20_2] = {}
	self.heroTempData[arg_20_2] = arg_20_1
end

function var_0_1:ParseDifficultyData(arg_21_1)
	local var_21_0 = {}

	for iter_21_0, iter_21_1 in ipairs(arg_21_1) do
		var_21_0[iter_21_1.difficulty] = {}
		var_21_0[iter_21_1.difficulty].stageData = self:ParseStageData(iter_21_1.stage_info_list)
		var_21_0[iter_21_1.difficulty].heroIdList = {}

		self:InitHeroList(var_21_0[iter_21_1.difficulty], iter_21_1.hero_id_list, iter_21_1.difficulty)

		if iter_21_1.difficulty == 2 then
			self.enterFlag = iter_21_1.enter_flag
		end
	end

	return var_21_0
end

function var_0_1:ParseStageData(arg_22_1)
	local var_22_0 = {}

	for iter_22_0, iter_22_1 in ipairs(arg_22_1) do
		var_22_0[iter_22_0] = self:DefaultData()
		var_22_0[iter_22_0].stageID = iter_22_1.stage_id
		var_22_0[iter_22_0].challengeState = iter_22_1.challenge_state

		if iter_22_1.challenge_state ~= 0 then
			var_22_0[iter_22_0].maxScore = iter_22_1.max_score
			var_22_0[iter_22_0].heroHP = iter_22_1.hero_hp
			var_22_0[iter_22_0].bossHP = iter_22_1.boss_hp
			var_22_0[iter_22_0].heroId = iter_22_1.hero_id
			var_22_0[iter_22_0].bossId = var_0_0:GetBossIdByStageId(iter_22_1.stage_id)
		end
	end

	return var_22_0
end

function var_0_0.GetBossIdByStageId(arg_23_0, arg_23_1)
	for iter_23_0 = 1, 2 do
		for iter_23_1, iter_23_2 in ipairs(MultHeartDemonCfg[MultHeartDemonCfg.get_id_list_by_activity_id[var_0_1.activityId][1]].stage_id[iter_23_0][2]) do
			if arg_23_1 == iter_23_2 then
				return MultHeartDemonCfg[MultHeartDemonCfg.get_id_list_by_activity_id[var_0_1.activityId][1]].heart_damon_id[iter_23_1]
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

function var_0_1:GetAcvivityId(arg_26_1)
	return self.activityId
end

return var_0_0
