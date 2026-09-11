local BattleTowerStageTemplate = class("BattleTowerStageTemplate", BattleBaseStageTemplate)

function BattleTowerStageTemplate:Ctor(arg_1_1)
	BattleTowerStageTemplate.super.Ctor(self, arg_1_1)

	self.id = arg_1_1
	self.cfg = BattleTowerStageCfg[self.id]
end

function BattleTowerStageTemplate:Init()
	self:InitHeroList()
	self:InitComboSkillID()
	self:InitChipData()
end

function BattleTowerStageTemplate:GetDest()
	return self.id
end

function BattleTowerStageTemplate:GetStageId()
	return self.id
end

function BattleTowerStageTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_TOWER
end

function BattleTowerStageTemplate:GetMap()
	return self.cfg.map, false
end

function BattleTowerStageTemplate:GetAILevel()
	return self.cfg.ai_level
end

function BattleTowerStageTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

function BattleTowerStageTemplate:GetStageAffix()
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

function BattleTowerStageTemplate:GetSettingShowAffix()
	local var_10_0 = {}
	local var_10_1, var_10_2, var_10_3 = self:GetBattleStageAffix()

	for iter_10_0 = 1, #var_10_1 do
		table.insert(var_10_0, {
			var_10_1[iter_10_0],
			var_10_2[iter_10_0],
			var_10_3[iter_10_0]
		})
	end

	for iter_10_1, iter_10_2 in pairs((type(self.cfg.affix_type_in_map) == "table" or nil) and (self.cfg.affix_type_in_map or {}) or {}) do
		table.insert(var_10_0, iter_10_2)
	end

	return var_10_0
end

function BattleTowerStageTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

return BattleTowerStageTemplate
