local BattleSurviveSoloStageTemplate = class("BattleSurviveSoloStageTemplate", BattleBaseStageTemplate)

function BattleSurviveSoloStageTemplate:Ctor(arg_1_1, arg_1_2)
	BattleSurviveSoloStageTemplate.super.Ctor(self, arg_1_1)

	self.id = arg_1_1
	self.activityID_ = arg_1_2
	self.cfg = BattleSoloSlayerCfg[arg_1_1]
end

function BattleSurviveSoloStageTemplate:Init()
	self:InitHeroList()
	self:InitComboSkillID()
	self:InitChipData()
end

function BattleSurviveSoloStageTemplate:GetDest()
	return self.id
end

function BattleSurviveSoloStageTemplate:GetStageId()
	return self.id
end

function BattleSurviveSoloStageTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.SURVIVE_SOLO
end

function BattleSurviveSoloStageTemplate:GetMap()
	return self.cfg.map, false
end

function BattleSurviveSoloStageTemplate:GetAILevel()
	return self.cfg.ai_level or 0
end

function BattleSurviveSoloStageTemplate:GetEnemyLevel()
	return self.cfg.monster_level or 0
end

function BattleSurviveSoloStageTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleSurviveSoloStageTemplate:GetAddUserExp()
	return self.cfg.user_exp or 0
end

function BattleSurviveSoloStageTemplate:GetAddHeroExp()
	return self.cfg.hero_exp or 0
end

function BattleSurviveSoloStageTemplate:GetCost()
	return self.cfg.cost or 0
end

function BattleSurviveSoloStageTemplate:GetActivityID()
	return self.activityID_ or 0
end

return BattleSurviveSoloStageTemplate
