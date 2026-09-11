BattleBaseCooperationTemplate = import("game.battle.cooperation.BattleBaseCooperationTemplate")

local BattleActivityWaterCooperationTemplate = class("BattleActivityWaterCooperationTemplate", BattleBaseCooperationTemplate)

function BattleActivityWaterCooperationTemplate:Ctor(arg_1_1, arg_1_2)
	self.cfg = BattleActivityWaterCooperationCfg[arg_1_1]
	self.activityID_ = arg_1_2

	BattleActivityWaterCooperationTemplate.super.Ctor(self)

	self.id = arg_1_1

	self:InitComboSkillID()
	self:InitChipData()
end

function BattleActivityWaterCooperationTemplate:InitComboSkillID()
	self.comboSkillID_ = BattleTeamData:GetComboInfo(self:GetType(), self.activityID_)
end

function BattleActivityWaterCooperationTemplate:GetLayerId()
	return self.layer_
end

function BattleActivityWaterCooperationTemplate:GetLayer()
	return self.layer_
end

function BattleActivityWaterCooperationTemplate:GetStageIndex()
	return self.stageIndex_
end

function BattleActivityWaterCooperationTemplate:GetDest()
	return self.id
end

function BattleActivityWaterCooperationTemplate:GetStageId()
	return self.id
end

function BattleActivityWaterCooperationTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.ACTIVITY_WATER_COOPERATION
end

function BattleActivityWaterCooperationTemplate:GetMap()
	return self.cfg.map, false
end

function BattleActivityWaterCooperationTemplate:GetAILevel()
	return self.cfg.ai_level
end

function BattleActivityWaterCooperationTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

function BattleActivityWaterCooperationTemplate:GetHeroDataByPos(arg_12_1)
	return (BattleActivityWaterCooperationTemplate.super.GetHeroDataByPos(self, arg_12_1))
end

function BattleActivityWaterCooperationTemplate:GetAttributeFactor()
	if self.cfg.attribute_factor and self.cfg.attribute_factor[3] then
		return Vector3.New(self.cfg.attribute_factor[1] / 1000, self.cfg.attribute_factor[2] / 1000, self.cfg.attribute_factor[3] / 1000)
	end

	return Vector3.New(1, 1, 1)
end

function BattleActivityWaterCooperationTemplate:SetMainActivityId(arg_14_1)
	self.mainActivityId_ = arg_14_1
end

function BattleActivityWaterCooperationTemplate:GetMainActivityId()
	return self.mainActivityId_
end

return BattleActivityWaterCooperationTemplate
