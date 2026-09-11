local BattleActivityWaterGunnerTemplate = class("BattleActivityWaterGunnerTemplate", BattleBaseStageTemplate)

function BattleActivityWaterGunnerTemplate:Ctor(arg_1_1, arg_1_2)
	self.cfg = BattleActivityWaterGunnerCfg[arg_1_1]
	self.activityID_ = arg_1_2

	BattleActivityWaterGunnerTemplate.super.Ctor(self, arg_1_1)

	self.id = arg_1_1
end

function BattleActivityWaterGunnerTemplate:Init()
	self:InitHeroList()
	self:InitComboSkillID()
	self:InitChipData()
end

function BattleActivityWaterGunnerTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleActivityWaterGunnerTemplate:GetLayerId()
	return self.layer_
end

function BattleActivityWaterGunnerTemplate:GetLayer()
	return self.layer_
end

function BattleActivityWaterGunnerTemplate:GetStageIndex()
	return self.stageIndex_
end

function BattleActivityWaterGunnerTemplate:GetDest()
	return self.id
end

function BattleActivityWaterGunnerTemplate:GetStageId()
	return self.id
end

function BattleActivityWaterGunnerTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.ACTIVITY_SUMMER_WATER
end

function BattleActivityWaterGunnerTemplate:GetMap()
	return self.cfg.map, false
end

function BattleActivityWaterGunnerTemplate:GetAILevel()
	return self.cfg.ai_level
end

function BattleActivityWaterGunnerTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

function BattleActivityWaterGunnerTemplate:GetAttributeFactor()
	if self.cfg.attribute_factor and self.cfg.attribute_factor[3] then
		return Vector3.New(self.cfg.attribute_factor[1] / 1000, self.cfg.attribute_factor[2] / 1000, self.cfg.attribute_factor[3] / 1000)
	end

	return Vector3.New(1, 1, 1)
end

function BattleActivityWaterGunnerTemplate:SetMainActivityId(arg_14_1)
	self.mainActivityId_ = arg_14_1
end

function BattleActivityWaterGunnerTemplate:GetMainActivityId()
	return self.mainActivityId_
end

function BattleActivityWaterGunnerTemplate:GetIsCooperation()
	return false, {
		self.serverTeamPlayer
	}
end

return BattleActivityWaterGunnerTemplate
