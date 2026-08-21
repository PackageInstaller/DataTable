local var_0_0 = class("BattleOsirisRaceTrialTemplate", BattleBaseStageTemplate)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.id_ = arg_1_1
	arg_1_0.activityID_ = arg_1_2
	arg_1_0.cfg_ = BattleRaceTrialStageCfg[ActivityRaceTrialCfg[arg_1_1].stage_id]
	arg_1_0.heroList_, _, _, arg_1_0.heroTrialList_ = GetLocalHeroTeam(arg_1_0:GetType(), arg_1_1, arg_1_2)

	arg_1_0:InitComboSkillID()
	arg_1_0:InitChipData()
end

function var_0_0.GetDest(arg_2_0)
	return arg_2_0.id_
end

function var_0_0.GetStageId(arg_3_0)
	return arg_3_0.id_
end

function var_0_0.GetType(arg_4_0)
	return BattleConst.STAGE_TYPE_NEW.RACE_TRIAL
end

function var_0_0.GetMap(arg_5_0)
	return arg_5_0.cfg_.map, false
end

function var_0_0.GetAILevel(arg_6_0)
	return arg_6_0.cfg_.ai_level
end

function var_0_0.GetEnemyLevel(arg_7_0)
	return arg_7_0.cfg_.monster_level
end

function var_0_0.GetStageAffix(arg_8_0)
	local var_8_0
	local var_8_1 = {}
	local var_8_2 = {}
	local var_8_3 = {}
	local var_8_4 = RaceTrialData:GetCustomList(arg_8_0.activityID_)

	for iter_8_0, iter_8_1 in ipairs(var_8_4) do
		local var_8_5 = ActivityAffixPoolCfg[iter_8_1].affix

		table.insert(var_8_1, var_8_5[1])
		table.insert(var_8_2, var_8_5[2])
		table.insert(var_8_3, var_8_5[3])
	end

	return var_8_1, var_8_2, var_8_3
end

function var_0_0.GetHeroTeam(arg_9_0)
	return arg_9_0.heroList_, arg_9_0.heroTrialList_
end

function var_0_0.GetMaxRaceData(arg_10_0)
	local var_10_0
	local var_10_1 = ActivityRaceTrialCfg.all

	for iter_10_0, iter_10_1 in ipairs(var_10_1) do
		local var_10_2 = ActivityRaceTrialCfg[iter_10_1]

		if var_10_2.id == arg_10_0.id_ then
			return var_10_2.race, 3
		end
	end
end

return var_0_0
