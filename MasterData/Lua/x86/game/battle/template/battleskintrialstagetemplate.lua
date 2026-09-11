local BattleSkinTrialStageTemplate = class("BattleSkinTrialStageTemplate", BattleBaseStageTemplate)

function BattleSkinTrialStageTemplate:Ctor(arg_1_1, arg_1_2)
	BattleSkinTrialStageTemplate.super.Ctor(self, arg_1_1)

	self.id = arg_1_1
	self.activityID_ = arg_1_2
	self.cfg = BattleSkinTrialStageCfg[arg_1_1]
end

function BattleSkinTrialStageTemplate:Init()
	self:InitHeroList()
	self:InitComboSkillID()
	self:InitChipData()
end

function BattleSkinTrialStageTemplate:GetDest()
	return SkinTrialData:GetSkinTrialID(self.id)
end

function BattleSkinTrialStageTemplate:GetStageId()
	return self.id
end

function BattleSkinTrialStageTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.SKIN_TRIAL
end

function BattleSkinTrialStageTemplate:GetMap()
	return self.cfg.map, false
end

function BattleSkinTrialStageTemplate:GetAILevel()
	return self.cfg.ai_level
end

function BattleSkinTrialStageTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

function BattleSkinTrialStageTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleSkinTrialStageTemplate:GetAddUserExp()
	return self.cfg.user_exp or 0
end

function BattleSkinTrialStageTemplate:GetAddHeroExp()
	return self.cfg.hero_exp or 0
end

function BattleSkinTrialStageTemplate:GetCost()
	return self.cfg.cost or 0
end

return BattleSkinTrialStageTemplate
