local BattleSoloHeartDemonTemplate = class("BattleSoloHeartDemonTemplate", BattleBaseStageTemplate)

function BattleSoloHeartDemonTemplate:Ctor(arg_1_1, arg_1_2)
	BattleSoloHeartDemonTemplate.super.Ctor(self, arg_1_1)

	self.id = arg_1_1
	self.activityID_ = arg_1_2
	self.cfg = BattleSoloHeartDemonCfg[arg_1_1]
end

function BattleSoloHeartDemonTemplate:Init()
	self:InitHeroList()
	self:InitComboSkillID()
	self:InitChipData()
end

function BattleSoloHeartDemonTemplate:GetDest()
	return self.id
end

function BattleSoloHeartDemonTemplate:GetStageId()
	return self.id
end

function BattleSoloHeartDemonTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.SOLO_HEART_DEMON
end

function BattleSoloHeartDemonTemplate:GetMap()
	return self.cfg.map, false
end

function BattleSoloHeartDemonTemplate:GetAILevel()
	return self.cfg.ai_level
end

function BattleSoloHeartDemonTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

function BattleSoloHeartDemonTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleSoloHeartDemonTemplate:GetAddUserExp()
	return self.cfg.user_exp or 0
end

function BattleSoloHeartDemonTemplate:GetAddHeroExp()
	return self.cfg.hero_exp or 0
end

function BattleSoloHeartDemonTemplate:GetCost()
	return self.cfg.cost or 0
end

return BattleSoloHeartDemonTemplate
