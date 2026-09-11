local BattleBaseTeachStageTemplate = class("BattleBaseTeachStageTemplate", BattleBaseStageTemplate)

function BattleBaseTeachStageTemplate:Ctor(arg_1_1)
	BattleBaseTeachStageTemplate.super.Ctor(self, arg_1_1)

	self.id = arg_1_1
	self.cfg = BattleBaseTeachStageCfg[self.id]
end

function BattleBaseTeachStageTemplate:Init()
	self:InitHeroList()
	self:InitComboSkillID()
	self:InitChipData()
end

function BattleBaseTeachStageTemplate:GetDest()
	return self.id
end

function BattleBaseTeachStageTemplate:GetStageId()
	return self.id
end

function BattleBaseTeachStageTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BASE_TEACHING
end

function BattleBaseTeachStageTemplate:GetMap()
	return self.cfg.map, false
end

function BattleBaseTeachStageTemplate:GetAILevel()
	return self.cfg.ai_level
end

function BattleBaseTeachStageTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

function BattleBaseTeachStageTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

return BattleBaseTeachStageTemplate
