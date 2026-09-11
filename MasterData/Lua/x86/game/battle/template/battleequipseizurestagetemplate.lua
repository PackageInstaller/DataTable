local BattleEquipSeizureStageTemplate = class("BattleEquipSeizureStageTemplate", BattleBaseStageTemplate)

function BattleEquipSeizureStageTemplate:Ctor(arg_1_1)
	BattleEquipSeizureStageTemplate.super.Ctor(self, arg_1_1)

	self.id = arg_1_1
	self.cfg = BattleEquipSeizureStageCfg[arg_1_1]
end

function BattleEquipSeizureStageTemplate:Init()
	self:InitHeroList()
	self:InitComboSkillID()
	self:InitChipData()
end

function BattleEquipSeizureStageTemplate:GetDest()
	return self.id
end

function BattleEquipSeizureStageTemplate:GetStageId()
	return self.id
end

function BattleEquipSeizureStageTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.EQUIP_SEIZURE
end

function BattleEquipSeizureStageTemplate:GetMap()
	return self.cfg.map, false
end

function BattleEquipSeizureStageTemplate:GetAILevel()
	return self.cfg.ai_level
end

function BattleEquipSeizureStageTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

function BattleEquipSeizureStageTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleEquipSeizureStageTemplate:GetStageAffix()
	local var_10_0 = {}
	local var_10_1 = {}
	local var_10_2 = {}

	for iter_10_0, iter_10_1 in pairs((type(self.cfg.affix_type) == "table" or nil) and (self.cfg.affix_type or {}) or {}) do
		table.insert(var_10_0, iter_10_1[1])
		table.insert(var_10_1, iter_10_1[2])
		table.insert(var_10_2, iter_10_1[3])
	end

	for iter_10_2, iter_10_3 in ipairs(EquipSeizureData:GetAffixIDList()) do
		table.insert(var_10_0, ActivityAffixPoolCfg[iter_10_3].affix[1])
		table.insert(var_10_1, ActivityAffixPoolCfg[iter_10_3].affix[2])
		table.insert(var_10_2, ActivityAffixPoolCfg[iter_10_3].affix[3])
	end

	return var_10_0, var_10_1, var_10_2
end

return BattleEquipSeizureStageTemplate
