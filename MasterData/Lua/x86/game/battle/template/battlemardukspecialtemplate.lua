local BattleMardukSpecialTemplate = class("BattleMardukSpecialTemplate", BattleBaseStageTemplate)

function BattleMardukSpecialTemplate:Ctor(arg_1_1, arg_1_2)
	BattleMardukSpecialTemplate.super.Ctor(self, arg_1_1)

	self.id = arg_1_1
	self.activityID_ = arg_1_2
	self.cfg = BattleQuickTrainingCfg[arg_1_1]
end

function BattleMardukSpecialTemplate:Init()
	self:InitHeroList()
	self:InitComboSkillID()
	self:InitChipData()
end

function BattleMardukSpecialTemplate:GetStageId()
	return self.id
end

function BattleMardukSpecialTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.MARDUK_SPECIAL
end

function BattleMardukSpecialTemplate:GetMap()
	return self.cfg.map, false
end

function BattleMardukSpecialTemplate:GetAILevel()
	return self.cfg.ai_level or 0
end

function BattleMardukSpecialTemplate:GetEnemyLevel()
	return self.cfg.monster_level or 0
end

function BattleMardukSpecialTemplate:GetStageAffix()
	local var_8_0 = {}
	local var_8_1 = {}
	local var_8_2 = {}

	table.insert(var_8_0, self.cfg.affix_type_in_map[1])
	table.insert(var_8_1, self.cfg.affix_type_in_map[2])
	table.insert(var_8_2, self.cfg.affix_type_in_map[3])

	return var_8_0, var_8_1, var_8_2
end

function BattleMardukSpecialTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleMardukSpecialTemplate:GetAddUserExp()
	return self.cfg.user_exp or 0
end

function BattleMardukSpecialTemplate:GetAddHeroExp()
	return self.cfg.hero_exp or 0
end

function BattleMardukSpecialTemplate:GetAttributeFactor()
	if self.cfg.attribute_factor and self.cfg.attribute_factor[3] then
		return Vector3.New(self.cfg.attribute_factor[1] / 1000, self.cfg.attribute_factor[2] / 1000, self.cfg.attribute_factor[3] / 1000)
	end

	return Vector3.New(1, 1, 1)
end

return BattleMardukSpecialTemplate
