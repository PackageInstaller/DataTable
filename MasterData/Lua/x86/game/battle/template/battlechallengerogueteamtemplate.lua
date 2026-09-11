local BattleChallengeRogueTeamTemplate = class("BattleChallengeRogueTeamTemplate", BattleBaseStageTemplate)

function BattleChallengeRogueTeamTemplate:Ctor(arg_1_1, arg_1_2)
	BattleChallengeRogueTeamTemplate.super.Ctor(self, arg_1_1)

	self.id = arg_1_1
	self.nodeID = arg_1_2
	self.cfg = BattleStageTools.GetStageCfg(self:GetType(), arg_1_1)
end

function BattleChallengeRogueTeamTemplate:Init()
	self:InitHeroList()
	self:InitComboSkillID()
	self:InitChipData()
end

function BattleChallengeRogueTeamTemplate:GetDest()
	return self.nodeID
end

function BattleChallengeRogueTeamTemplate:GetStageId()
	return self.id
end

function BattleChallengeRogueTeamTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.CHALLENGE_ROGUE_TEAM
end

function BattleChallengeRogueTeamTemplate:GetMap()
	return self.cfg.map, false
end

function BattleChallengeRogueTeamTemplate:GetAILevel()
	return self.cfg.ai_level
end

function BattleChallengeRogueTeamTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

function BattleChallengeRogueTeamTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleChallengeRogueTeamTemplate:GetActivityID()
	return self.activityID_
end

function BattleChallengeRogueTeamTemplate:UpdateRoleDatas(arg_11_1)
	self.serverTeamPlayer = arg_11_1
	self.roleDataInLua = {}

	local var_11_0 = self:GetSystemHeroTeam()

	for iter_11_0, iter_11_1 in ipairs(arg_11_1.heroList) do
		table.insert(self.roleDataInLua, (BattleController.GetInstance():SetChallengeRogueTeamHeroData(iter_11_1, (iter_11_1.trialID ~= 0 or nil) and (iter_11_1.trialID or var_11_0[iter_11_0] or 0), arg_11_1.playerID, arg_11_1.level)))
	end

	self:SetMaxRaceData()
end

function BattleChallengeRogueTeamTemplate:GetChipManagerID()
	return 0
end

function BattleChallengeRogueTeamTemplate:GetStageAffix()
	local var_13_0 = {}
	local var_13_1 = {}
	local var_13_2 = {}

	for iter_13_0, iter_13_1 in pairs((ChallengeRogueTeamData:TreasureGetList())) do
		local var_13_3 = ChallengeRogueTeamTools.GetTreasureAffix(iter_13_1.id, iter_13_1.rare)

		table.insert(var_13_0, var_13_3[1])
		table.insert(var_13_1, var_13_3[2])
		table.insert(var_13_2, var_13_3[3])
	end

	local var_13_4 = ChallengeRogueTeamData:SuitSkillGetID()

	if var_13_4 ~= 0 then
		local var_13_5 = ChallengeRogueTeamTools.GetTreasureAffix((ChallengeRogueTeamTools.GetItemIDByCampID(var_13_4)))

		table.insert(var_13_0, var_13_5[1])
		table.insert(var_13_1, var_13_5[2])
		table.insert(var_13_2, var_13_5[3])
	end

	local var_13_6, var_13_7 = ChallengeRogueTeamData:GetTeamBuffAffixList(self.roleDataInLua)

	for iter_13_2, iter_13_3 in pairs(var_13_6) do
		table.insert(var_13_0, iter_13_3)

		if ChallengeRogueTeamTools.HasTeamEffectMaxLevel() then
			table.insert(var_13_1, 3)
		else
			table.insert(var_13_1, var_13_7[iter_13_3])
		end

		table.insert(var_13_2, 3)
	end

	for iter_13_4, iter_13_5 in ipairs((ChallengeRogueTeamData:EffectItemGetDataList(ChallengeRogueTeamConst.ITEM_TYPE.RELIC))) do
		for iter_13_6, iter_13_7 in ipairs((ChallengeRogueTeamTools.GetRelicAffix(iter_13_5.id))) do
			table.insert(var_13_0, iter_13_7[1])
			table.insert(var_13_1, iter_13_7[2])
			table.insert(var_13_2, iter_13_7[3])
		end
	end

	for iter_13_8, iter_13_9 in ipairs((ChallengeRogueTeamData:EffectItemGetDataList(ChallengeRogueTeamConst.ITEM_TYPE.SKILL))) do
		for iter_13_10, iter_13_11 in ipairs((ChallengeRogueTeamTools.GetSkillTreeAffix(iter_13_9.id))) do
			table.insert(var_13_0, iter_13_11[1])
			table.insert(var_13_1, iter_13_11[2])
			table.insert(var_13_2, iter_13_11[3])
		end
	end

	local var_13_8 = ChallengeRogueTeamData:GetCacheTemplateID()

	for iter_13_12, iter_13_13 in ipairs(RogueTeamDifficultyCfg[ChallengeRogueTeamData:GetSelectDifficultyID(var_13_8)].affix) do
		table.insert(var_13_0, iter_13_13[1])
		table.insert(var_13_1, iter_13_13[2])
		table.insert(var_13_2, iter_13_13[3])
	end

	local var_13_9, var_13_10 = ChallengeRogueTeamData:GetOptionalAffix()

	for iter_13_14, iter_13_15 in ipairs(var_13_10) do
		if ActivityAffixPoolCfg[iter_13_15].affix then
			table.insert(var_13_0, ActivityAffixPoolCfg[iter_13_15].affix[1])
			table.insert(var_13_1, ActivityAffixPoolCfg[iter_13_15].affix[2])
			table.insert(var_13_2, ActivityAffixPoolCfg[iter_13_15].affix[3])
		end
	end

	local var_13_11 = RogueTeamFettersCfg[ChallengeRogueTeamData:GetActiveFetters().fettersId]

	if var_13_11 and IsConditionAchieved(var_13_11.condition) then
		table.insert(var_13_0, var_13_11.affix_id[1])
		table.insert(var_13_1, var_13_11.affix_id[2])
		table.insert(var_13_2, var_13_11.affix_id[3])
	end

	local var_13_12 = RogueTeamDifficultyCfg[ChallengeRogueTeamData:GetLastDifficultyID(var_13_8) or 1].params[1]
	local var_13_13 = ChallengeRogueTeamTools.GetRougeTeamSettingList(ChallengeRogueTeamConst.SETTING_VALUE.ATTACK_AFIX, var_13_8)

	table.insert(var_13_0, var_13_13[1])
	table.insert(var_13_1, var_13_13[2] * RogueTeamMapCfg[ChallengeRogueTeamData:PathGetRogueTeamMapID(var_13_8)].monster_level_coefficient[1] * var_13_12 / 1000)
	table.insert(var_13_2, var_13_13[3])

	return var_13_0, var_13_1, var_13_2
end

function BattleChallengeRogueTeamTemplate:GetAttributeFactor()
	local var_14_0 = RogueTeamDifficultyCfg[ChallengeRogueTeamData:GetSelectDifficultyID((ChallengeRogueTeamData:GetCacheTemplateID()))].params
	local var_14_1 = var_14_0[1] / 1000
	local var_14_2 = var_14_0[2] / 1000
	local var_14_3 = var_14_0[3] / 1000

	if self.cfg.attribute_factor and type(self.cfg.attribute_factor) == "table" and self.cfg.attribute_factor[3] then
		var_14_1 = self.cfg.attribute_factor[1] / 1000 * var_14_1
		var_14_2 = self.cfg.attribute_factor[2] / 1000 * var_14_2
		var_14_3 = self.cfg.attribute_factor[3] / 1000 * var_14_3
	end

	if RogueTeamMapCfg[ChallengeRogueTeamData:PathGetRogueTeamMapID((ChallengeRogueTeamData:GetActiveTemplateID()))].monster_level_coefficient and type(RogueTeamMapCfg[ChallengeRogueTeamData:PathGetRogueTeamMapID((ChallengeRogueTeamData:GetActiveTemplateID()))].monster_level_coefficient) == "table" and RogueTeamMapCfg[ChallengeRogueTeamData:PathGetRogueTeamMapID((ChallengeRogueTeamData:GetActiveTemplateID()))].monster_level_coefficient[3] then
		var_14_1 = RogueTeamMapCfg[ChallengeRogueTeamData:PathGetRogueTeamMapID((ChallengeRogueTeamData:GetActiveTemplateID()))].monster_level_coefficient[1] / 1000 * var_14_1
		var_14_2 = RogueTeamMapCfg[ChallengeRogueTeamData:PathGetRogueTeamMapID((ChallengeRogueTeamData:GetActiveTemplateID()))].monster_level_coefficient[2] / 1000 * var_14_2
		var_14_3 = RogueTeamMapCfg[ChallengeRogueTeamData:PathGetRogueTeamMapID((ChallengeRogueTeamData:GetActiveTemplateID()))].monster_level_coefficient[3] / 1000 * var_14_3
	end

	return Vector3.New(var_14_1, var_14_2, var_14_3)
end

function BattleChallengeRogueTeamTemplate:GetBattleParams()
	return ChallengeRogueTeamData:SuitSkillGetEnergyValue()
end

function BattleChallengeRogueTeamTemplate:GetRevive()
	return true, 0, ChallengeRogueTeamData:AttributeGetValue(ChallengeRogueTeamConst.ATTRIBUTE_ENUM.REVIVE_CNT), 1, (ChallengeRogueTeamData:AttributeGetValue(ChallengeRogueTeamConst.ATTRIBUTE_ENUM.REVIVE_LIMIT_CNT))
end

function BattleChallengeRogueTeamTemplate:GetResurrectHP()
	return 0
end

function BattleChallengeRogueTeamTemplate:GetResurrectImmediately()
	return true
end

function BattleChallengeRogueTeamTemplate:InitComboSkillID()
	reserveParams = ReserveTools.CheckReserveParams(self:GetReserveParams())
	self.comboSkillID_ = ReserveTools.GetReserveTemplateByReserveType(reserveParams.reserveType):GetComboSkillID(reserveParams, self.heroList_)
end

function BattleChallengeRogueTeamTemplate:GetChipManagerID()
	return 0
end

function BattleChallengeRogueTeamTemplate:GetChipList()
	return {}
end

return BattleChallengeRogueTeamTemplate
