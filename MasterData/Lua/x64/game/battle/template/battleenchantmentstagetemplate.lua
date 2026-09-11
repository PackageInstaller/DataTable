local BattleEnchantmentStageTemplate = class("BattleEnchantmentStageTemplate", BattleBaseStageTemplate)

function BattleEnchantmentStageTemplate:Ctor(arg_1_1)
	BattleEnchantmentStageTemplate.super.Ctor(self, arg_1_1)

	self.id = arg_1_1
	self.cfg = BattleEnchantmentStageCfg[arg_1_1]
end

function BattleEnchantmentStageTemplate:Init()
	self:InitHeroList()
	self:InitComboSkillID()
	self:InitChipData()
end

function BattleEnchantmentStageTemplate:GetDest()
	return self.id
end

function BattleEnchantmentStageTemplate:GetStageId()
	return self.id
end

function BattleEnchantmentStageTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ENCHANTMENT
end

function BattleEnchantmentStageTemplate:GetMap()
	return self.cfg.map, false
end

function BattleEnchantmentStageTemplate:GetAILevel()
	return self.cfg.ai_level
end

function BattleEnchantmentStageTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

function BattleEnchantmentStageTemplate:GetStageAffix()
	local var_9_0 = {}
	local var_9_1 = {}
	local var_9_2 = {}

	for iter_9_0, iter_9_1 in pairs((type(self.cfg.affix_type) == "table" or nil) and (self.cfg.affix_type or {}) or {}) do
		table.insert(var_9_0, iter_9_1[1])
		table.insert(var_9_1, iter_9_1[2])
		table.insert(var_9_2, iter_9_1[3])
	end

	return var_9_0, var_9_1, var_9_2
end

function BattleEnchantmentStageTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleEnchantmentStageTemplate:GetAddUserExp()
	return self.cfg.user_exp or 0
end

function BattleEnchantmentStageTemplate:GetAddHeroExp()
	return self.cfg.hero_exp or 0
end

function BattleEnchantmentStageTemplate:GetCost()
	return self.cfg.cost or 0
end

return BattleEnchantmentStageTemplate
