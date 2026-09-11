local BattleOsirisRaceTrialTemplate = class("BattleOsirisRaceTrialTemplate", BattleBaseStageTemplate)

function BattleOsirisRaceTrialTemplate:Ctor(arg_1_1, arg_1_2)
	self.super.Ctor(self, arg_1_1)

	self.id_ = arg_1_1
	self.activityID_ = arg_1_2
	self.cfg_ = BattleRaceTrialStageCfg[ActivityRaceTrialCfg[arg_1_1].stage_id]
	self.heroList_, _, _, self.heroTrialList_ = GetLocalHeroTeam(self:GetType(), arg_1_1, arg_1_2)

	self:InitComboSkillID()
	self:InitChipData()
end

function BattleOsirisRaceTrialTemplate:GetDest()
	return self.id_
end

function BattleOsirisRaceTrialTemplate:GetStageId()
	return self.id_
end

function BattleOsirisRaceTrialTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.RACE_TRIAL
end

function BattleOsirisRaceTrialTemplate:GetMap()
	return self.cfg_.map, false
end

function BattleOsirisRaceTrialTemplate:GetAILevel()
	return self.cfg_.ai_level
end

function BattleOsirisRaceTrialTemplate:GetEnemyLevel()
	return self.cfg_.monster_level
end

function BattleOsirisRaceTrialTemplate:GetStageAffix()
	local var_8_1 = {}
	local var_8_2 = {}
	local var_8_3 = {}

	for iter_8_0, iter_8_1 in ipairs((RaceTrialData:GetCustomList(self.activityID_))) do
		table.insert(var_8_1, ActivityAffixPoolCfg[iter_8_1].affix[1])
		table.insert(var_8_2, ActivityAffixPoolCfg[iter_8_1].affix[2])
		table.insert(var_8_3, ActivityAffixPoolCfg[iter_8_1].affix[3])
	end

	return var_8_1, var_8_2, var_8_3
end

function BattleOsirisRaceTrialTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleOsirisRaceTrialTemplate:GetMaxRaceData()
	for iter_10_0, iter_10_1 in ipairs(ActivityRaceTrialCfg.all) do
		if ActivityRaceTrialCfg[iter_10_1].id == self.id_ then
			return ActivityRaceTrialCfg[iter_10_1].race, 3
		end
	end
end

return BattleOsirisRaceTrialTemplate
