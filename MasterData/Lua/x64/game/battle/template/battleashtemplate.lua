local BattleAshTemplate = class("BattleAshTemplate", BattleBaseStageTemplate)

function BattleAshTemplate:Ctor(arg_1_1, arg_1_2)
	BattleAshTemplate.super.Ctor(self, arg_1_1)

	self.id = arg_1_1
	self.activityId = AshShootStageCfg[arg_1_2.stageId].activity_id
	self.data = arg_1_2
	self.cfg = BattleAshShootStageCfg[arg_1_1]
	self.roleDataInLua = {}
end

function BattleAshTemplate:Init()
	self:InitHeroList()
	self:InitComboSkillID()
	self:InitChipData()
end

function BattleAshTemplate:InitHeroList()
	self.heroList_, self.heroTrialList_ = {}, {}

	table.insert(self.heroList_, 6142)
	table.insert(self.heroTrialList_, 614201)
end

function BattleAshTemplate:GetDest()
	return self.id
end

function BattleAshTemplate:GetStageId()
	return self.id
end

function BattleAshTemplate:GetActivityID()
	return self.activityId
end

function BattleAshTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.ASH_BATTLE
end

function BattleAshTemplate:GetMap()
	return self.cfg.map, false
end

function BattleAshTemplate:GetName()
	return self.cfg.name
end

function BattleAshTemplate:GetAILevel()
	return self.cfg.ai_level or 0
end

function BattleAshTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

function BattleAshTemplate:GetStageAffix()
	local var_12_0 = {}
	local var_12_1 = {}
	local var_12_2 = {}

	for iter_12_0, iter_12_1 in ipairs(self.data.skill) do
		if AshShootEffectCfg[iter_12_1] and AshShootEffectCfg[iter_12_1].affix_id and AshShootEffectCfg[iter_12_1].affix_id ~= "" then
			table.insert(var_12_0, AshShootEffectCfg[iter_12_1].affix_id[1])
			table.insert(var_12_1, AshShootEffectCfg[iter_12_1].affix_id[2])
			table.insert(var_12_2, AshShootEffectCfg[iter_12_1].affix_id[3])
		end
	end

	for iter_12_2, iter_12_3 in ipairs(self.data.item) do
		if AshShootEffectCfg[iter_12_3.id] and AshShootEffectCfg[iter_12_3.id].affix_id and AshShootEffectCfg[iter_12_3.id].affix_id ~= "" then
			table.insert(var_12_0, AshShootEffectCfg[iter_12_3.id].affix_id[1])
			table.insert(var_12_1, AshShootEffectCfg[iter_12_3.id].affix_id[2])
			table.insert(var_12_2, AshShootEffectCfg[iter_12_3.id].affix_id[3])
		end
	end

	for iter_12_4, iter_12_5 in ipairs(self.data.weapon) do
		if AshShootWeaponCfg[iter_12_5.id] and AshShootWeaponCfg[iter_12_5.id].affix_id and AshShootWeaponCfg[iter_12_5.id].affix_id ~= "" then
			table.insert(var_12_0, AshShootWeaponCfg[iter_12_5.id].affix_id[1])
			table.insert(var_12_1, AshShootWeaponCfg[iter_12_5.id].affix_id[2])
			table.insert(var_12_2, AshShootWeaponCfg[iter_12_5.id].affix_id[3])
		end
	end

	return var_12_0, var_12_1, var_12_2
end

function BattleAshTemplate:GetChooseSkill()
	return self.data.skill or {}
end

function BattleAshTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleAshTemplate:GetOpts()
	local var_15_0 = {}

	table.insert(var_15_0, {
		key = 1,
		value = self:GetChooseSkill()
	})

	return var_15_0
end

return BattleAshTemplate
