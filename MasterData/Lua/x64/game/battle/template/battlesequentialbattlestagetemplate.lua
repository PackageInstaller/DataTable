local BattleSequentialBattleStageTemplate = class("BattleSequentialBattleStageTemplate", BattleBaseStageTemplate)

function BattleSequentialBattleStageTemplate:Ctor(arg_1_1, arg_1_2)
	BattleSequentialBattleStageTemplate.super.Ctor(self, arg_1_1)

	self.id = arg_1_1
	self.cfg = BattleSequentialBattleStageCfg[arg_1_1]
	self.activityID_ = arg_1_2
	self.currentStageIndex_ = SequentialBattleData:GetCurrentFinishStageIndex(arg_1_2) + 1
end

function BattleSequentialBattleStageTemplate:Init()
	self:InitHeroList()
	self:InitComboSkillID()
	self:InitChipData()
end

function BattleSequentialBattleStageTemplate:GetDest()
	return self.id
end

function BattleSequentialBattleStageTemplate:GetStageId()
	return self.id
end

function BattleSequentialBattleStageTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.SEQUENTIAL_BATTLE
end

function BattleSequentialBattleStageTemplate:GetMap()
	return self.cfg.map, false
end

function BattleSequentialBattleStageTemplate:GetAILevel()
	return self.cfg.ai_level
end

function BattleSequentialBattleStageTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

function BattleSequentialBattleStageTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleSequentialBattleStageTemplate:GetStageAffix()
	local var_10_0 = {}
	local var_10_1 = {}
	local var_10_2 = {}

	for iter_10_0, iter_10_1 in ipairs((SequentialBattleTools.GetEnabledBuff(self.activityID_, self.currentStageIndex_))) do
		table.insert(var_10_0, SequentialBattleBuffCfg[iter_10_1].affix_id)
		table.insert(var_10_1, 1)
		table.insert(var_10_2, 3)
	end

	return var_10_0, var_10_1, var_10_2
end

return BattleSequentialBattleStageTemplate
