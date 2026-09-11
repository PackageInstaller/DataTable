local BattleAdvanceMonsterTestTemplate = class("BattleAdvanceMonsterTestTemplate", BattleBaseStageTemplate)

function BattleAdvanceMonsterTestTemplate:Ctor(arg_1_1)
	BattleAdvanceMonsterTestTemplate.super.Ctor(self, arg_1_1)

	self.stageID_ = arg_1_1
	self.cfg = BattleActivityAdvanceMonsterTestCfg[arg_1_1]
end

function BattleAdvanceMonsterTestTemplate:Init()
	self:InitHeroList()
	self:InitComboSkillID()
	self:InitChipData()
end

function BattleAdvanceMonsterTestTemplate:GetDest()
	return self.stageID_
end

function BattleAdvanceMonsterTestTemplate:GetStageId()
	return self.stageID_
end

function BattleAdvanceMonsterTestTemplate:GetActivityID()
	return ActivityConst.ACTIVITY_ADVANCE_MONSTER_TEST
end

function BattleAdvanceMonsterTestTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.ADVANCE_MONSTER_TEST
end

function BattleAdvanceMonsterTestTemplate:GetMap()
	return self.cfg.map, false
end

function BattleAdvanceMonsterTestTemplate:GetAILevel()
	return self.cfg.ai_level
end

function BattleAdvanceMonsterTestTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

function BattleAdvanceMonsterTestTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleAdvanceMonsterTestTemplate:GetStageAffix()
	local var_11_0 = {}
	local var_11_1 = {}
	local var_11_2 = {}
	local var_11_3

	for iter_11_0, iter_11_1 in pairs(ActivityAdvanceMonsterTestCfg.all) do
		if ActivityAdvanceMonsterTestCfg[iter_11_1].stage_id == self.stageID_ then
			var_11_3 = iter_11_1

			break
		end
	end

	if self.cfg.affix_type ~= "" then
		for iter_11_2, iter_11_3 in pairs(self.cfg.affix_type or {}) do
			table.insert(var_11_0, iter_11_3[1])
			table.insert(var_11_1, iter_11_3[2])
			table.insert(var_11_2, iter_11_3[3])
		end
	end

	for iter_11_4, iter_11_5 in pairs(AdvanceMonsterTestData:GetCustomList(var_11_3) or {}) do
		table.insert(var_11_0, ActivityAffixPoolCfg[iter_11_5].affix[1])
		table.insert(var_11_1, ActivityAffixPoolCfg[iter_11_5].affix[2])
		table.insert(var_11_2, ActivityAffixPoolCfg[iter_11_5].affix[3])
	end

	return var_11_0, var_11_1, var_11_2
end

return BattleAdvanceMonsterTestTemplate
