local BattleDamageTestTemplate = class("BattleDamageTestTemplate", BattleBaseStageTemplate)

function BattleDamageTestTemplate:Ctor(arg_1_1, arg_1_2)
	BattleDamageTestTemplate.super.Ctor(self, arg_1_1)

	self.id = arg_1_1
	self.damageTestId = arg_1_2
	self.cfg = BattleDamageTestCfg[self.id]
end

function BattleDamageTestTemplate:Init()
	self:InitHeroList()
	self:InitComboSkillID()
	self:InitChipData()
end

function BattleDamageTestTemplate:GetDest()
	return self.id
end

function BattleDamageTestTemplate:GetStageId()
	return self.id
end

function BattleDamageTestTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.DAMAGE_TEST
end

function BattleDamageTestTemplate:GetActivityID()
	return self.damageTestId
end

function BattleDamageTestTemplate:GetMap()
	return self.cfg.map, false
end

function BattleDamageTestTemplate:GetAILevel()
	return self.cfg.ai_level
end

function BattleDamageTestTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

function BattleDamageTestTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleDamageTestTemplate:GetStageAffix()
	local var_11_0 = {}
	local var_11_1 = {}
	local var_11_2 = {}

	for iter_11_0, iter_11_1 in pairs((DamageTestData:GetAffixList(self.damageTestId, BossConst.TYPE_AFFIX))) do
		table.insert(var_11_0, ActivityAffixPoolCfg[iter_11_1].affix[1])
		table.insert(var_11_1, ActivityAffixPoolCfg[iter_11_1].affix[2])
		table.insert(var_11_2, ActivityAffixPoolCfg[iter_11_1].affix[3])
	end

	return var_11_0, var_11_1, var_11_2
end

function BattleDamageTestTemplate:GetThreeStar()
	if self.cfg.three_star_need == "" then
		return {}
	end

	return self.cfg.three_star_need
end

function BattleDamageTestTemplate:GetAttributeFactor()
	return Vector3.New(1, 1, 1)
end

return BattleDamageTestTemplate
