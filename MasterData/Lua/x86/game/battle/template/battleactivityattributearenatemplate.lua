local BattleActivityAttributeArenaTemplate = class("BattleActivityAttributeArenaTemplate", BattleBaseStageTemplate)

function BattleActivityAttributeArenaTemplate:Ctor(arg_1_1, arg_1_2, arg_1_3)
	BattleActivityAttributeArenaTemplate.super.Ctor(self, arg_1_1)

	self.id_ = arg_1_1
	self.activityID_ = arg_1_2
	self.stageID_ = arg_1_1
	self.cfg = BattleAttributeArenaCfg[self.stageID_]
	self.destID_ = arg_1_3
end

function BattleActivityAttributeArenaTemplate:Init()
	self:InitHeroList()
	self:InitComboSkillID()
	self:InitChipData()
end

function BattleActivityAttributeArenaTemplate:GetDest()
	return self.destID_
end

function BattleActivityAttributeArenaTemplate:GetStageId()
	return self.stageID_
end

function BattleActivityAttributeArenaTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.ACTIVITY_ATTRIBUTE_ARENA
end

function BattleActivityAttributeArenaTemplate:GetMap()
	return self.cfg.map, false
end

function BattleActivityAttributeArenaTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

function BattleActivityAttributeArenaTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleActivityAttributeArenaTemplate:GetActivityID()
	return self.activityID_
end

return BattleActivityAttributeArenaTemplate
