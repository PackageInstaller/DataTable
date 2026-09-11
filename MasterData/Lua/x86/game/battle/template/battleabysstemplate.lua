local BattleAbyssTemplate = class("BattleAbyssTemplate", BattleBaseStageTemplate)

function BattleAbyssTemplate:Ctor(arg_1_1, arg_1_2)
	self.cfg = BattleAbyssCfg[arg_1_1]
	self.activityID_ = arg_1_2.activityID
	self.curActivityID_ = arg_1_2.curActivityID

	BattleAbyssTemplate.super.Ctor(self, arg_1_1)

	self.id = arg_1_1
end

function BattleAbyssTemplate:Init()
	self:InitHeroList()
	self:InitComboSkillID()
	self:InitChipData()
end

function BattleAbyssTemplate:SetStageData(arg_3_1, arg_3_2)
	self.stageIndex_ = arg_3_2
	self.layerCfg_ = AbyssData:GetAbyssCfg(arg_3_1)
	self.layer_ = self.layerCfg_.level
	self.stageCfg_ = self.layerCfg_.stage_list[arg_3_2]
end

function BattleAbyssTemplate:SetCurActivityID(arg_4_1)
	self.curActivityID_ = arg_4_1
end

function BattleAbyssTemplate:GetActivityID()
	return self.curActivityID_
end

function BattleAbyssTemplate:GetLayerId()
	return self.layer_
end

function BattleAbyssTemplate:GetLayer()
	return self.layer_
end

function BattleAbyssTemplate:GetStageIndex()
	return self.stageIndex_
end

function BattleAbyssTemplate:IsBoss()
	return self.stageCfg_[1] == 3
end

function BattleAbyssTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleAbyssTemplate:GetDest()
	return self.id
end

function BattleAbyssTemplate:GetStageId()
	return self.id
end

function BattleAbyssTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.ABYSS
end

function BattleAbyssTemplate:GetMap()
	return self.cfg.map, false
end

function BattleAbyssTemplate:GetAILevel()
	return self.cfg.ai_level
end

function BattleAbyssTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

function BattleAbyssTemplate:GetAttributeFactor()
	if self.cfg.attribute_factor and self.cfg.attribute_factor[3] then
		local var_17_0 = self.cfg.attribute_factor[3] / 1000

		if self.layerCfg_.stage_list[self.stageIndex_][1] == 3 then
			local var_17_1 = AbyssData:GetStageData(self.layer_, self.stageIndex_)

			var_17_0 = math.ceil(AbyssBossHpCfg[self.layerCfg_.stage_list[self.stageIndex_][2]].boss_hp[var_17_1.phase] * var_17_1.boss_hp_rate / 1000) / AbyssBossHpCfg[self.layerCfg_.stage_list[self.stageIndex_][2]].boss_hp[var_17_1.phase]
		end

		return Vector3.New(self.cfg.attribute_factor[1] / 1000, self.cfg.attribute_factor[2] / 1000, var_17_0)
	end

	return Vector3.New(1, 1, 1)
end

return BattleAbyssTemplate
