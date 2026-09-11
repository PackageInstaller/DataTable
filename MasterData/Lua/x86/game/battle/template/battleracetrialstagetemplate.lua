local BattleRaceTrialStageTemplate = class("BattleRaceTrialStageTemplate", BattleBaseStageTemplate)

function BattleRaceTrialStageTemplate:Ctor(arg_1_1, arg_1_2)
	self.super.Ctor(self, arg_1_1)

	self.id_ = arg_1_1
	self.activityID_ = arg_1_2
	self.cfg_ = BattleRaceTrialStageCfg[ActivityRaceTrialCfg[arg_1_1].stage_id]
end

function BattleRaceTrialStageTemplate:Init()
	self:InitHeroList()
	self:InitComboSkillID()
	self:InitChipData()
end

function BattleRaceTrialStageTemplate:GetDest()
	return self.id_
end

function BattleRaceTrialStageTemplate:GetStageId()
	return self.id_
end

function BattleRaceTrialStageTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.RACE_TRIAL
end

function BattleRaceTrialStageTemplate:GetMap()
	return self.cfg_.map, false
end

function BattleRaceTrialStageTemplate:GetAILevel()
	return self.cfg_.ai_level
end

function BattleRaceTrialStageTemplate:GetEnemyLevel()
	return self.cfg_.monster_level
end

function BattleRaceTrialStageTemplate:GetStageAffix()
	local var_9_1 = {}
	local var_9_2 = {}
	local var_9_3 = {}

	for iter_9_0, iter_9_1 in ipairs((RaceTrialData:GetCustomList(self.activityID_))) do
		table.insert(var_9_1, ActivityAffixPoolCfg[iter_9_1].affix[1])
		table.insert(var_9_2, ActivityAffixPoolCfg[iter_9_1].affix[2])
		table.insert(var_9_3, ActivityAffixPoolCfg[iter_9_1].affix[3])
	end

	return var_9_1, var_9_2, var_9_3
end

function BattleRaceTrialStageTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleRaceTrialStageTemplate:GetMaxRaceData()
	return ActivityRaceTrialCfg[self.id_].race, 3
end

return BattleRaceTrialStageTemplate
