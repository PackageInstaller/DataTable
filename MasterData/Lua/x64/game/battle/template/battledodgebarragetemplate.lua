local BattleDodgeBarrageTemplate = class("BattleDodgeBarrageTemplate", BattleBaseStageTemplate)

function BattleDodgeBarrageTemplate:Ctor(arg_1_1, arg_1_2)
	BattleDodgeBarrageTemplate.super.Ctor(self, arg_1_1)

	self.id_ = arg_1_1
	self.stageID_ = arg_1_1
	self.cfg = BattleDodgeBarrageCfg[self.stageID_]
	self.destID_ = arg_1_1
	self.activityId_ = arg_1_2
end

function BattleDodgeBarrageTemplate:Init()
	self:InitHeroList()
end

function BattleDodgeBarrageTemplate:GetDest()
	return self.destID_
end

function BattleDodgeBarrageTemplate:GetStageId()
	return self.stageID_
end

function BattleDodgeBarrageTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.ACTIVITY_DODGE_BARRAGE
end

function BattleDodgeBarrageTemplate:GetMap()
	return self.cfg.map, false
end

function BattleDodgeBarrageTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

function BattleDodgeBarrageTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleDodgeBarrageTemplate:GetActivityID()
	return self.activityId_
end

return BattleDodgeBarrageTemplate
