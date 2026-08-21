local var_0_0 = class("BattleChallengeRogueTeamTemplate", BattleBaseStageTemplate)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.id = arg_1_1
	arg_1_0.nodeID = arg_1_2
	arg_1_0.cfg = BattleStageTools.GetStageCfg(arg_1_0:GetType(), arg_1_1)
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitHeroList()
	arg_2_0:InitComboSkillID()
	arg_2_0:InitChipData()
end

function var_0_0.GetDest(arg_3_0)
	return arg_3_0.nodeID
end

function var_0_0.GetStageId(arg_4_0)
	return arg_4_0.id
end

function var_0_0.GetType(arg_5_0)
	return BattleConst.STAGE_TYPE_NEW.CHALLENGE_ROGUE_TEAM
end

function var_0_0.GetMap(arg_6_0)
	return arg_6_0.cfg.map, false
end

function var_0_0.GetAILevel(arg_7_0)
	return arg_7_0.cfg.ai_level
end

function var_0_0.GetEnemyLevel(arg_8_0)
	return arg_8_0.cfg.monster_level
end

function var_0_0.GetHeroTeam(arg_9_0)
	return arg_9_0.heroList_, arg_9_0.heroTrialList_
end

function var_0_0.GetActivityID(arg_10_0)
	return arg_10_0.activityID_
end

function var_0_0.UpdateRoleDatas(arg_11_0, arg_11_1)
	arg_11_0.serverTeamPlayer = arg_11_1
	arg_11_0.roleDataInLua = {}

	local var_11_0 = arg_11_0:GetSystemHeroTeam()

	for iter_11_0, iter_11_1 in ipairs(arg_11_1.heroList) do
		local var_11_1 = iter_11_1.trialID ~= 0 and iter_11_1.trialID or var_11_0[iter_11_0] or 0
		local var_11_2 = BattleController.GetInstance():SetChallengeRogueTeamHeroData(iter_11_1, var_11_1, arg_11_1.playerID, arg_11_1.level)

		table.insert(arg_11_0.roleDataInLua, var_11_2)
	end

	arg_11_0:SetMaxRaceData()
end

function var_0_0.GetChipManagerID(arg_12_0)
	return 0
end

function var_0_0.GetStageAffix(arg_13_0)
	local var_13_0 = {}
	local var_13_1 = {}
	local var_13_2 = {}
	local var_13_3 = ChallengeRogueTeamData:TreasureGetList()

	for iter_13_0, iter_13_1 in pairs(var_13_3) do
		local var_13_4 = iter_13_1.id
		local var_13_5 = ChallengeRogueTeamTools.GetTreasureAffix(var_13_4, iter_13_1.rare)

		table.insert(var_13_0, var_13_5[1])
		table.insert(var_13_1, var_13_5[2])
		table.insert(var_13_2, var_13_5[3])
	end

	local var_13_6 = ChallengeRogueTeamData:SuitSkillGetID()

	if var_13_6 ~= 0 then
		local var_13_7 = ChallengeRogueTeamTools.GetItemIDByCampID(var_13_6)
		local var_13_8 = ChallengeRogueTeamTools.GetTreasureAffix(var_13_7)

		table.insert(var_13_0, var_13_8[1])
		table.insert(var_13_1, var_13_8[2])
		table.insert(var_13_2, var_13_8[3])
	end

	local var_13_9, var_13_10 = ChallengeRogueTeamData:GetTeamBuffAffixList(arg_13_0.roleDataInLua)

	for iter_13_2, iter_13_3 in pairs(var_13_9) do
		table.insert(var_13_0, iter_13_3)

		if ChallengeRogueTeamTools.HasTeamEffectMaxLevel() then
			table.insert(var_13_1, 3)
		else
			table.insert(var_13_1, var_13_10[iter_13_3])
		end

		table.insert(var_13_2, 3)
	end

	local var_13_11 = ChallengeRogueTeamData:EffectItemGetDataList(ChallengeRogueTeamConst.ITEM_TYPE.RELIC)

	for iter_13_4, iter_13_5 in ipairs(var_13_11) do
		local var_13_12 = ChallengeRogueTeamTools.GetRelicAffix(iter_13_5.id)

		for iter_13_6, iter_13_7 in ipairs(var_13_12) do
			table.insert(var_13_0, iter_13_7[1])
			table.insert(var_13_1, iter_13_7[2])
			table.insert(var_13_2, iter_13_7[3])
		end
	end

	local var_13_13 = ChallengeRogueTeamData:EffectItemGetDataList(ChallengeRogueTeamConst.ITEM_TYPE.SKILL)

	for iter_13_8, iter_13_9 in ipairs(var_13_13) do
		local var_13_14 = ChallengeRogueTeamTools.GetSkillTreeAffix(iter_13_9.id)

		for iter_13_10, iter_13_11 in ipairs(var_13_14) do
			table.insert(var_13_0, iter_13_11[1])
			table.insert(var_13_1, iter_13_11[2])
			table.insert(var_13_2, iter_13_11[3])
		end
	end

	local var_13_15 = ChallengeRogueTeamData:GetCacheTemplateID()
	local var_13_16 = ChallengeRogueTeamData:GetSelectDifficultyID(var_13_15)

	for iter_13_12, iter_13_13 in ipairs(RogueTeamDifficultyCfg[var_13_16].affix) do
		table.insert(var_13_0, iter_13_13[1])
		table.insert(var_13_1, iter_13_13[2])
		table.insert(var_13_2, iter_13_13[3])
	end

	local var_13_17, var_13_18 = ChallengeRogueTeamData:GetOptionalAffix()

	for iter_13_14, iter_13_15 in ipairs(var_13_18) do
		local var_13_19 = ActivityAffixPoolCfg[iter_13_15].affix

		if var_13_19 then
			table.insert(var_13_0, var_13_19[1])
			table.insert(var_13_1, var_13_19[2])
			table.insert(var_13_2, var_13_19[3])
		end
	end

	local var_13_20 = ChallengeRogueTeamData:GetActiveFetters()
	local var_13_21 = RogueTeamFettersCfg[var_13_20.fettersId]

	if var_13_21 and IsConditionAchieved(var_13_21.condition) then
		local var_13_22 = var_13_21.affix_id

		table.insert(var_13_0, var_13_22[1])
		table.insert(var_13_1, var_13_22[2])
		table.insert(var_13_2, var_13_22[3])
	end

	local var_13_23 = ChallengeRogueTeamData:GetLastDifficultyID(var_13_15) or 1
	local var_13_24 = RogueTeamDifficultyCfg[var_13_23].params[1]
	local var_13_25 = ChallengeRogueTeamData:PathGetRogueTeamMapID(var_13_15)
	local var_13_26 = RogueTeamMapCfg[var_13_25].monster_level_coefficient[1]
	local var_13_27 = ChallengeRogueTeamTools.GetRougeTeamSettingList(ChallengeRogueTeamConst.SETTING_VALUE.ATTACK_AFIX, var_13_15)

	table.insert(var_13_0, var_13_27[1])
	table.insert(var_13_1, var_13_27[2] * var_13_26 * var_13_24 / 1000)
	table.insert(var_13_2, var_13_27[3])

	return var_13_0, var_13_1, var_13_2
end

function var_0_0.GetAttributeFactor(arg_14_0)
	local var_14_0 = ChallengeRogueTeamData:GetCacheTemplateID()
	local var_14_1 = ChallengeRogueTeamData:GetSelectDifficultyID(var_14_0)
	local var_14_2 = RogueTeamDifficultyCfg[var_14_1].params
	local var_14_3 = var_14_2[1] / 1000
	local var_14_4 = var_14_2[2] / 1000
	local var_14_5 = var_14_2[3] / 1000
	local var_14_6 = arg_14_0.cfg

	if var_14_6.attribute_factor and type(var_14_6.attribute_factor) == "table" and var_14_6.attribute_factor[3] then
		var_14_3 = var_14_6.attribute_factor[1] / 1000 * var_14_3
		var_14_4 = var_14_6.attribute_factor[2] / 1000 * var_14_4
		var_14_5 = var_14_6.attribute_factor[3] / 1000 * var_14_5
	end

	local var_14_7 = ChallengeRogueTeamData:GetActiveTemplateID()
	local var_14_8 = ChallengeRogueTeamData:PathGetRogueTeamMapID(var_14_7)
	local var_14_9 = RogueTeamMapCfg[var_14_8]

	if var_14_9.monster_level_coefficient and type(var_14_9.monster_level_coefficient) == "table" and var_14_9.monster_level_coefficient[3] then
		var_14_3 = var_14_9.monster_level_coefficient[1] / 1000 * var_14_3
		var_14_4 = var_14_9.monster_level_coefficient[2] / 1000 * var_14_4
		var_14_5 = var_14_9.monster_level_coefficient[3] / 1000 * var_14_5
	end

	return Vector3.New(var_14_3, var_14_4, var_14_5)
end

function var_0_0.GetBattleParams(arg_15_0)
	return ChallengeRogueTeamData:SuitSkillGetEnergyValue()
end

function var_0_0.GetRevive(arg_16_0)
	local var_16_0 = ChallengeRogueTeamData:AttributeGetValue(ChallengeRogueTeamConst.ATTRIBUTE_ENUM.REVIVE_CNT)
	local var_16_1 = ChallengeRogueTeamData:AttributeGetValue(ChallengeRogueTeamConst.ATTRIBUTE_ENUM.REVIVE_LIMIT_CNT)

	return true, 0, var_16_0, 1, var_16_1
end

function var_0_0.GetResurrectHP(arg_17_0)
	return 0
end

function var_0_0.GetResurrectImmediately(arg_18_0)
	return true
end

function var_0_0.InitComboSkillID(arg_19_0)
	reserveParams = ReserveTools.CheckReserveParams(arg_19_0:GetReserveParams())
	arg_19_0.comboSkillID_ = ReserveTools.GetReserveTemplateByReserveType(reserveParams.reserveType):GetComboSkillID(reserveParams, arg_19_0.heroList_)
end

function var_0_0.GetChipManagerID(arg_20_0)
	return 0
end

function var_0_0.GetChipList(arg_21_0)
	return {}
end

return var_0_0
