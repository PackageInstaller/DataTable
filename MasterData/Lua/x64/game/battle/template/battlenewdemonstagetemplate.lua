local BattleNewDemonStageTemplate = class("BattleNewDemonStageTemplate", BattleBaseStageTemplate)

function BattleNewDemonStageTemplate:Ctor(arg_1_1, arg_1_2)
	BattleNewDemonStageTemplate.super.Ctor(self, arg_1_1)

	self.id = arg_1_1
	self.activityID_ = arg_1_2
	self.cfg = BattleNewHeartDemonStageCfg[arg_1_1]
end

function BattleNewDemonStageTemplate:Init()
	self:InitHeroList()
	self:InitComboSkillID()
	self:InitChipData()
end

function BattleNewDemonStageTemplate:GetDest()
	return self.activityID_
end

function BattleNewDemonStageTemplate:GetStageId()
	return self.id
end

function BattleNewDemonStageTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.NEW_DEMON
end

function BattleNewDemonStageTemplate:GetMap()
	return self.cfg.map, false
end

function BattleNewDemonStageTemplate:GetAILevel()
	return self.cfg.ai_level
end

function BattleNewDemonStageTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

function BattleNewDemonStageTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleNewDemonStageTemplate:GetAddUserExp()
	return self.cfg.user_exp or 0
end

function BattleNewDemonStageTemplate:GetAddHeroExp()
	return self.cfg.hero_exp or 0
end

function BattleNewDemonStageTemplate:GetCost()
	return self.cfg.cost or 0
end

function BattleNewDemonStageTemplate:GetStageAffix()
	local var_13_0 = {}
	local var_13_1 = {}
	local var_13_2 = {}

	for iter_13_0, iter_13_1 in pairs((type(self.cfg.affix_type) == "table" or nil) and (self.cfg.affix_type or {}) or {}) do
		table.insert(var_13_0, iter_13_1[1])
		table.insert(var_13_1, iter_13_1[2])
		table.insert(var_13_2, iter_13_1[3])
	end

	return var_13_0, var_13_1, var_13_2
end

return BattleNewDemonStageTemplate
