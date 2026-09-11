local BattleMardukeTowerGameTemplate = class("BattleMardukeTowerGameTemplate", BattleBaseStageTemplate)

function BattleMardukeTowerGameTemplate:Ctor(arg_1_1, arg_1_2)
	BattleMardukeTowerGameTemplate.super.Ctor(self, arg_1_1)

	self.activityID_ = arg_1_2
	self.cfg = BattleTowerGameCfg[arg_1_1]
	self.stageID_ = arg_1_1
	self.heroList_, _, _, self.heroTrialList_ = GetLocalHeroTeam(self:GetType(), self.stageID_, arg_1_2)

	self:InitComboSkillID()
	self:InitChipData()
end

function BattleMardukeTowerGameTemplate:GetDest()
	return self.activityID_
end

function BattleMardukeTowerGameTemplate:GetStageId()
	return self.stageID_
end

function BattleMardukeTowerGameTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.MARDUK_GAME
end

function BattleMardukeTowerGameTemplate:GetMap()
	return self.cfg.map, false
end

function BattleMardukeTowerGameTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

function BattleMardukeTowerGameTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleMardukeTowerGameTemplate:GetAILevel()
	return self.cfg.ai_level
end

return BattleMardukeTowerGameTemplate
