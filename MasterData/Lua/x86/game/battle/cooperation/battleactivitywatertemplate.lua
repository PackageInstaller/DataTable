local BattleActivityWaterTemplate = class("BattleActivityWaterTemplate", BattleBaseStageTemplate)

function BattleActivityWaterTemplate:Ctor(arg_1_1, arg_1_2)
	self.cfg = BattleActivityWaterCfg[arg_1_1]
	self.activityID_ = arg_1_2

	BattleActivityWaterTemplate.super.Ctor(self, arg_1_1)

	self.id = arg_1_1
end

function BattleActivityWaterTemplate:Init()
	self:InitHeroList()
	self:InitComboSkillID()
	self:InitChipData()
end

function BattleActivityWaterTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleActivityWaterTemplate:GetLayerId()
	return self.layer_
end

function BattleActivityWaterTemplate:GetLayer()
	return self.layer_
end

function BattleActivityWaterTemplate:GetStageIndex()
	return self.stageIndex_
end

function BattleActivityWaterTemplate:GetDest()
	return self.id
end

function BattleActivityWaterTemplate:GetStageId()
	return self.id
end

function BattleActivityWaterTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.ACTIVITY_SUMMER_WATER
end

function BattleActivityWaterTemplate:GetMap()
	return self.cfg.map, false
end

function BattleActivityWaterTemplate:GetAILevel()
	return self.cfg.ai_level
end

function BattleActivityWaterTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

function BattleActivityWaterTemplate:GetAttributeFactor()
	if self.cfg.attribute_factor and self.cfg.attribute_factor[3] then
		return Vector3.New(self.cfg.attribute_factor[1] / 1000, self.cfg.attribute_factor[2] / 1000, self.cfg.attribute_factor[3] / 1000)
	end

	return Vector3.New(1, 1, 1)
end

function BattleActivityWaterTemplate:SetMainActivityId(arg_14_1)
	self.mainActivityId_ = arg_14_1
end

function BattleActivityWaterTemplate:GetMainActivityId()
	return self.mainActivityId_
end

return BattleActivityWaterTemplate
