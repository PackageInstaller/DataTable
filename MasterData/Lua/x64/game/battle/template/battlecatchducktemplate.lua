local BattleCatchDuckTemplate = class("BattleCatchDuckTemplate", BattleBaseStageTemplate)

function BattleCatchDuckTemplate:Ctor(arg_1_1)
	BattleCatchDuckTemplate.super.Ctor(self, arg_1_1)

	self.id_ = arg_1_1
	self.stageID_ = arg_1_1
	self.cfg = BattleCatchDuckStageCfg[self.stageID_]
	self.destID_ = arg_1_1
end

function BattleCatchDuckTemplate:Init()
	self:InitHeroList()
end

function BattleCatchDuckTemplate:GetDest()
	return self.destID_
end

function BattleCatchDuckTemplate:GetStageId()
	return self.stageID_
end

function BattleCatchDuckTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.ACTIVITY_CATCH_DUCK
end

function BattleCatchDuckTemplate:GetMap()
	return self.cfg.map, false
end

function BattleCatchDuckTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

function BattleCatchDuckTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

return BattleCatchDuckTemplate
