local BattleTowerDefenceStageTemplate = class("BattleTowerDefenceStageTemplate", BattleBaseStageTemplate)

function BattleTowerDefenceStageTemplate:Ctor(arg_1_1, arg_1_2)
	BattleTowerDefenceStageTemplate.super.Ctor(self, arg_1_1)

	self.id = arg_1_1
	self.activityID = arg_1_2
	self.cfg = BattleShotStageCfg[self.id]
end

function BattleTowerDefenceStageTemplate:Init()
	self:InitHeroList()
	self:InitChipData()
end

function BattleTowerDefenceStageTemplate:GetDest()
	return self.activityID
end

function BattleTowerDefenceStageTemplate:GetStageId()
	return self.id
end

function BattleTowerDefenceStageTemplate:GetActivityID()
	return self.activityID
end

function BattleTowerDefenceStageTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.TOWER_DEFENCE
end

function BattleTowerDefenceStageTemplate:GetMap()
	return self.cfg.map, false
end

function BattleTowerDefenceStageTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

function BattleTowerDefenceStageTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

return BattleTowerDefenceStageTemplate
