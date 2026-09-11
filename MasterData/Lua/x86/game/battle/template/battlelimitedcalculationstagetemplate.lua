local BattleLimitedCalculationStageTemplate = class("BattleLimitedCalculationStageTemplate", BattleBaseStageTemplate)

function BattleLimitedCalculationStageTemplate:Ctor(arg_1_1, arg_1_2)
	self.super.Ctor(self)

	self.id_ = arg_1_1
	self.activityID_ = arg_1_2
	self.difficultyCfg_ = ActivityLimitCalculationCfg[LimitedCalculationData:GetCurDifficulty(self.activityID_)]
	self.cfg_ = BattleLimitedCalculationStageCfg[self.id_]
end

function BattleLimitedCalculationStageTemplate:Init()
	self:InitHeroList()
	self:InitComboSkillID()
	self:InitChipData()
end

function BattleLimitedCalculationStageTemplate:GetDest()
	return self.difficultyCfg_.activity_id
end

function BattleLimitedCalculationStageTemplate:GetActivityID()
	return self.activityID_
end

function BattleLimitedCalculationStageTemplate:GetStageId()
	return self.id_
end

function BattleLimitedCalculationStageTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.LIMITED_CALCULATION
end

function BattleLimitedCalculationStageTemplate:GetMap()
	return self.cfg_.map, false
end

function BattleLimitedCalculationStageTemplate:GetAILevel()
	return self.cfg_.ai_level
end

function BattleLimitedCalculationStageTemplate:GetEnemyLevel()
	return self.cfg_.monster_level
end

function BattleLimitedCalculationStageTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleLimitedCalculationStageTemplate:GetStageAffix()
	local var_11_0 = {}
	local var_11_1 = {}
	local var_11_2 = {}
	local var_11_3 = self.difficultyCfg_.enemy_affix or {}

	for iter_11_0, iter_11_1 in ipairs(self.difficultyCfg_.player_affix or {}) do
		table.insert(var_11_0, iter_11_1[1])
		table.insert(var_11_1, iter_11_1[2])
		table.insert(var_11_2, iter_11_1[3])
	end

	for iter_11_2, iter_11_3 in ipairs(var_11_3) do
		table.insert(var_11_0, iter_11_3[1])
		table.insert(var_11_1, iter_11_3[2])
		table.insert(var_11_2, iter_11_3[3])
	end

	return var_11_0, var_11_1, var_11_2
end

return BattleLimitedCalculationStageTemplate
