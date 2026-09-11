local BattleHeroTeachStageTemplate = class("BattleHeroTeachStageTemplate", BattleBaseStageTemplate)

function BattleHeroTeachStageTemplate:Ctor(arg_1_1)
	BattleHeroTeachStageTemplate.super.Ctor(self, arg_1_1)

	self.id = arg_1_1
	self.cfg = BattleHeroTeachStageCfg[self.id]
end

function BattleHeroTeachStageTemplate:Init()
	self:InitHeroList()
	self:InitChipData()
end

function BattleHeroTeachStageTemplate:GetDest()
	return self.id
end

function BattleHeroTeachStageTemplate:GetStageId()
	return self.id
end

function BattleHeroTeachStageTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_HERO_TEACHING
end

function BattleHeroTeachStageTemplate:GetMap()
	return self.cfg.map, false
end

function BattleHeroTeachStageTemplate:GetAILevel()
	return self.cfg.ai_level
end

function BattleHeroTeachStageTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

function BattleHeroTeachStageTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

return BattleHeroTeachStageTemplate
