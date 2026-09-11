local BattleResidentHeroTrialStageTemplate = class("BattleResidentHeroTrialStageTemplate", BattleBaseStageTemplate)

function BattleResidentHeroTrialStageTemplate:Ctor(arg_1_1)
	BattleResidentHeroTrialStageTemplate.super.Ctor(self, arg_1_1)

	self.id = arg_1_1
	self.cfg = BattleResidentHeroTrialStageCfg[arg_1_1]
end

function BattleResidentHeroTrialStageTemplate:Init()
	self:InitHeroList()
	self:InitComboSkillID()
	self:InitChipData()
end

function BattleResidentHeroTrialStageTemplate:GetDest()
	return self.id
end

function BattleResidentHeroTrialStageTemplate:GetStageId()
	return self.id
end

function BattleResidentHeroTrialStageTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.RESIDENT_HERO_TRIAL
end

function BattleResidentHeroTrialStageTemplate:GetMap()
	return self.cfg.map, false
end

function BattleResidentHeroTrialStageTemplate:GetAILevel()
	return self.cfg.ai_level
end

function BattleResidentHeroTrialStageTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

function BattleResidentHeroTrialStageTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleResidentHeroTrialStageTemplate:GetAddUserExp()
	return self.cfg.user_exp or 0
end

function BattleResidentHeroTrialStageTemplate:GetAddHeroExp()
	return self.cfg.hero_exp or 0
end

function BattleResidentHeroTrialStageTemplate:GetCost()
	return self.cfg.cost or 0
end

return BattleResidentHeroTrialStageTemplate
