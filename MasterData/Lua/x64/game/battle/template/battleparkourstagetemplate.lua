local BattleSlayerStageTemplate = class("BattleSlayerStageTemplate", BattleBaseStageTemplate)

function BattleSlayerStageTemplate:Ctor(arg_1_1, arg_1_2)
	self.entrust_activity_id = arg_1_1
	self.parkour_activity_id = arg_1_2

	self.super.Ctor(self, ActivityParkourCfg[arg_1_1].stage_id)

	self.id_ = ActivityParkourCfg[arg_1_1].stage_id
	self.cfg = BattleParkourStageCfg[ActivityParkourCfg[arg_1_1].stage_id]
end

function BattleSlayerStageTemplate:Init()
	self:InitHeroList()
	self:InitComboSkillID()
	self:InitChipData()
end

function BattleSlayerStageTemplate:GetDest()
	return self.entrust_activity_id
end

function BattleSlayerStageTemplate:GetStageId()
	return self.id_
end

function BattleSlayerStageTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.PARKOUR
end

function BattleSlayerStageTemplate:GetMap()
	return self.cfg.map, false
end

function BattleSlayerStageTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

function BattleSlayerStageTemplate:GetStageAffix()
	return {}, {}, {}
end

function BattleSlayerStageTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleSlayerStageTemplate:GetActivityID()
	return self.parkour_activity_id
end

function BattleSlayerStageTemplate:GetThreeStar()
	return self.cfg.three_star_need
end

return BattleSlayerStageTemplate
