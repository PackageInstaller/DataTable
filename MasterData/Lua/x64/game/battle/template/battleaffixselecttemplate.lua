local BattleAffixSelectTemplate = class("BattleAffixSelectTemplate", BattleBaseStageTemplate)

function BattleAffixSelectTemplate:Ctor(arg_1_1, arg_1_2)
	BattleAffixSelectTemplate.super.Ctor(self, arg_1_1)

	self.id = arg_1_1
	self.activityID_ = arg_1_2
	self.cfg = BattleActivityAffixSelectCfg[arg_1_1]
	self.roleDataInLua = {}
end

function BattleAffixSelectTemplate:Init()
	self:InitHeroList()
	self:InitComboSkillID()
	self:InitChipData()
end

function BattleAffixSelectTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleAffixSelectTemplate:GetDest()
	return self.activityID_
end

function BattleAffixSelectTemplate:GetStageId()
	return self.id
end

function BattleAffixSelectTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.AFFIX_SELECT
end

function BattleAffixSelectTemplate:GetMap()
	return self.cfg.map, false
end

function BattleAffixSelectTemplate:GetAILevel()
	return self.cfg.ai_level
end

function BattleAffixSelectTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

function BattleAffixSelectTemplate:GetAttributeFactor()
	if self.cfg.attribute_factor and self.cfg.attribute_factor[3] then
		return Vector3.New(self.cfg.attribute_factor[1] / 1000, self.cfg.attribute_factor[2] / 1000, self.cfg.attribute_factor[3] / 1000)
	end

	return Vector3.New(1, 1, 1)
end

function BattleAffixSelectTemplate:GetStageAffix()
	local var_11_0 = {}
	local var_11_1 = {}
	local var_11_2 = {}

	for iter_11_0, iter_11_1 in pairs(ActivityAffixSelectData:GetAffix(self.activityID_) or {}) do
		table.insert(var_11_0, iter_11_1[1])
		table.insert(var_11_1, iter_11_1[2])
		table.insert(var_11_2, iter_11_1[3])
	end

	return var_11_0, var_11_1, var_11_2
end

return BattleAffixSelectTemplate
