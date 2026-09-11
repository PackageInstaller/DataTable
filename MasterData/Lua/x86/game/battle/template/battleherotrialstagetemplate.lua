local BattleHeroTrialStageTemplate = class("BattleHeroTrialStageTemplate", BattleBaseStageTemplate)

function BattleHeroTrialStageTemplate:Ctor(arg_1_1, arg_1_2)
	BattleHeroTrialStageTemplate.super.Ctor(self, arg_1_1)

	self.id = arg_1_1
	self.activityID_ = arg_1_2
	self.cfg = BattleHeroTrialStageCfg[arg_1_1]
end

function BattleHeroTrialStageTemplate:Init()
	self:InitHeroList()
	self:InitComboSkillID()
	self:InitChipData()
end

function BattleHeroTrialStageTemplate:GetDest()
	return HeroTrialData:GetHeroTrialID(self.id)
end

function BattleHeroTrialStageTemplate:GetStageId()
	return self.id
end

function BattleHeroTrialStageTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.HERO_TRIAL
end

function BattleHeroTrialStageTemplate:GetMap()
	return self.cfg.map, false
end

function BattleHeroTrialStageTemplate:GetAILevel()
	return self.cfg.ai_level
end

function BattleHeroTrialStageTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

function BattleHeroTrialStageTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleHeroTrialStageTemplate:GetAddUserExp()
	return self.cfg.user_exp or 0
end

function BattleHeroTrialStageTemplate:GetAddHeroExp()
	return self.cfg.hero_exp or 0
end

function BattleHeroTrialStageTemplate:GetCost()
	return self.cfg.cost or 0
end

return BattleHeroTrialStageTemplate
