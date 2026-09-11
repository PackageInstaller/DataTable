local BattleActivityRaceStageTemplate = class("BattleActivityRaceStageTemplate", BattleBaseStageTemplate)

function BattleActivityRaceStageTemplate:Ctor(arg_1_1, arg_1_2)
	BattleActivityRaceStageTemplate.super.Ctor(self, arg_1_1)

	self.id = arg_1_1
	self.activityID_ = arg_1_2
	self.cfg = BattleActivityRaceStageCfg[arg_1_1]
end

function BattleActivityRaceStageTemplate:Init()
	self:InitHeroList()
	self:InitComboSkillID()
	self:InitChipData()
end

function BattleActivityRaceStageTemplate:GetDest()
	return table.keyof(ActivityRaceCfg[self.activityID_].stage_list, self.id)
end

function BattleActivityRaceStageTemplate:GetStageId()
	return self.id
end

function BattleActivityRaceStageTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.ACTIVITY_RACE
end

function BattleActivityRaceStageTemplate:GetMap()
	return self.cfg.map, false
end

function BattleActivityRaceStageTemplate:GetAILevel()
	return self.cfg.ai_level or 0
end

function BattleActivityRaceStageTemplate:GetEnemyLevel()
	return self.cfg.monster_level or 0
end

function BattleActivityRaceStageTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleActivityRaceStageTemplate:GetAddUserExp()
	return self.cfg.user_exp or 0
end

function BattleActivityRaceStageTemplate:GetAddHeroExp()
	return self.cfg.hero_exp or 0
end

function BattleActivityRaceStageTemplate:GetCost()
	return self.cfg.cost or 0
end

function BattleActivityRaceStageTemplate:GetStageAffix()
	local var_13_0 = {}
	local var_13_1 = {}
	local var_13_2 = {}

	for iter_13_0, iter_13_1 in pairs((ActivityRaceData:GetUnlockAffixList(self.activityID_))) do
		table.insert(var_13_0, ActivityAffixPoolCfg[iter_13_1].affix[1])
		table.insert(var_13_1, ActivityAffixPoolCfg[iter_13_1].affix[2])
		table.insert(var_13_2, ActivityAffixPoolCfg[iter_13_1].affix[3])
	end

	table.insert(var_13_0, ActivityAffixPoolCfg[ActivityRaceCfg[self.activityID_].race_buff].affix[1])
	table.insert(var_13_1, ActivityAffixPoolCfg[ActivityRaceCfg[self.activityID_].race_buff].affix[2])
	table.insert(var_13_2, ActivityAffixPoolCfg[ActivityRaceCfg[self.activityID_].race_buff].affix[3])

	return var_13_0, var_13_1, var_13_2
end

return BattleActivityRaceStageTemplate
