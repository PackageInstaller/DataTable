local BattleOsirisDemonStageTemplate = class("BattleOsirisDemonStageTemplate", BattleBaseStageTemplate)

function BattleOsirisDemonStageTemplate:Ctor(arg_1_1, arg_1_2)
	BattleOsirisDemonStageTemplate.super.Ctor(self, arg_1_1)

	self.id = arg_1_1
	self.activityID_ = arg_1_2
	self.cfg = BattleHeartDemonStageCfg[arg_1_1]
end

function BattleOsirisDemonStageTemplate:Init()
	self:InitHeroList()
	self:InitComboSkillID()
	self:InitChipData()
end

function BattleOsirisDemonStageTemplate:GetDest()
	return self.activityID_
end

function BattleOsirisDemonStageTemplate:GetStageId()
	return self.id
end

function BattleOsirisDemonStageTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.OSIRIS_DEMON
end

function BattleOsirisDemonStageTemplate:GetMap()
	return self.cfg.map, false
end

function BattleOsirisDemonStageTemplate:GetAILevel()
	return self.cfg.ai_level
end

function BattleOsirisDemonStageTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

function BattleOsirisDemonStageTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleOsirisDemonStageTemplate:GetAddUserExp()
	return self.cfg.user_exp or 0
end

function BattleOsirisDemonStageTemplate:GetAddHeroExp()
	return self.cfg.hero_exp or 0
end

function BattleOsirisDemonStageTemplate:GetCost()
	return self.cfg.cost or 0
end

function BattleOsirisDemonStageTemplate:GetStageAffix()
	local var_13_0 = {}
	local var_13_1 = {}
	local var_13_2 = {}

	for iter_13_0, iter_13_1 in ipairs((TalentTreeData:GetTalentListByTheme((ActivityTools.GetActivityTheme(DemonChallengeCfg[self.activityID_].activity_id))))) do
		table.insert(var_13_0, iter_13_1[1])
		table.insert(var_13_1, iter_13_1[2])
		table.insert(var_13_2, iter_13_1[3])
	end

	for iter_13_2, iter_13_3 in pairs((type(self.cfg.affix_type) == "table" or nil) and (self.cfg.affix_type or {}) or {}) do
		table.insert(var_13_0, iter_13_3[1])
		table.insert(var_13_1, iter_13_3[2])
		table.insert(var_13_2, iter_13_3[3])
	end

	return var_13_0, var_13_1, var_13_2
end

return BattleOsirisDemonStageTemplate
