local BattleEquipStageTemplate = class("BattleEquipStageTemplate", BattleBaseStageTemplate)

function BattleEquipStageTemplate:Ctor(arg_1_1)
	BattleEquipStageTemplate.super.Ctor(self, arg_1_1)

	self.id = arg_1_1
	self.cfg = BattleDailyStageCfg[arg_1_1]
end

function BattleEquipStageTemplate:Init()
	self:InitHeroList()
	self:InitComboSkillID()
	self:InitChipData()
end

function BattleEquipStageTemplate:GetDest()
	return self.id
end

function BattleEquipStageTemplate:GetStageId()
	return self.id
end

function BattleEquipStageTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_DAILY
end

function BattleEquipStageTemplate:GetMap()
	return self.cfg.map, false
end

function BattleEquipStageTemplate:GetAILevel()
	return self.cfg.ai_level
end

function BattleEquipStageTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

function BattleEquipStageTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleEquipStageTemplate:GetAddUserExp()
	return self.cfg.user_exp or 0
end

function BattleEquipStageTemplate:GetAddHeroExp()
	return self.cfg.hero_exp or 0
end

function BattleEquipStageTemplate:GetCost()
	return self.cfg.cost or 0
end

return BattleEquipStageTemplate
