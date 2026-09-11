local BattleSeaWarfareStageTemplate = class("BattleSeaWarfareStageTemplate", BattleBaseStageTemplate)

function BattleSeaWarfareStageTemplate:Ctor(arg_1_1)
	BattleSeaWarfareStageTemplate.super.Ctor(self, arg_1_1)

	self.id_ = arg_1_1
	self.stageID_ = arg_1_1
	self.cfg_ = BattleSeaWarfareStageCfg[self.stageID_]
	self.destID_ = arg_1_1

	self:InitHeroList()
end

function BattleSeaWarfareStageTemplate:SetSeaWarfareStageID(arg_2_1)
	self.seaWarfareStageID_ = arg_2_1
end

function BattleSeaWarfareStageTemplate:GetSeaWarfareStageID()
	return self.seaWarfareStageID_
end

function BattleSeaWarfareStageTemplate:Init()
	self:InitHeroList()
end

function BattleSeaWarfareStageTemplate:GetDest()
	return self.seaWarfareStageID_
end

function BattleSeaWarfareStageTemplate:GetStageId()
	return self.stageID_
end

function BattleSeaWarfareStageTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.SEA_WARFARE
end

function BattleSeaWarfareStageTemplate:GetMap()
	return self.cfg_.map, false
end

function BattleSeaWarfareStageTemplate:GetEnemyLevel()
	return self.cfg_.monster_level
end

function BattleSeaWarfareStageTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleSeaWarfareStageTemplate:GetActivityID()
	return self.activityId_
end

function BattleSeaWarfareStageTemplate:SetMarinerIDList(arg_12_1)
	self.marinerIDList_ = arg_12_1
end

function BattleSeaWarfareStageTemplate:SetSkillID(arg_13_1)
	self.skillID_ = arg_13_1
end

function BattleSeaWarfareStageTemplate:GetStageAffix()
	local var_14_0 = {}
	local var_14_1 = {}
	local var_14_2 = {}

	if self.marinerIDList_ then
		for iter_14_0, iter_14_1 in ipairs(self.marinerIDList_) do
			var_14_0[#var_14_0 + 1] = SeaWarfareSkillCfg[iter_14_1].affix_list[1]
			var_14_1[#var_14_1 + 1] = SeaWarfareSkillCfg[iter_14_1].affix_list[2]
			var_14_2[#var_14_2 + 1] = SeaWarfareSkillCfg[iter_14_1].affix_list[3]
		end
	end

	if self.skillID_ then
		var_14_0[#var_14_0 + 1] = SeaWarfareSkillCfg[self.skillID_].affix_list[1]
		var_14_1[#var_14_1 + 1] = SeaWarfareSkillCfg[self.skillID_].affix_list[2]
		var_14_2[#var_14_2 + 1] = SeaWarfareSkillCfg[self.skillID_].affix_list[3]
	end

	return var_14_0, var_14_1, var_14_2
end

function BattleSeaWarfareStageTemplate:GetServerExtant()
	return self.skillID_
end

return BattleSeaWarfareStageTemplate
