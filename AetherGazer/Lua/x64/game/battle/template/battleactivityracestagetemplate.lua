local var_0_0 = class("BattleActivityRaceStageTemplate", BattleBaseStageTemplate)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.id = arg_1_1
	arg_1_0.activityID_ = arg_1_2
	arg_1_0.cfg = BattleActivityRaceStageCfg[arg_1_1]
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitHeroList()
	arg_2_0:InitComboSkillID()
	arg_2_0:InitChipData()
end

function var_0_0.GetDest(arg_3_0)
	local var_3_0 = ActivityRaceCfg[arg_3_0.activityID_].stage_list

	return table.keyof(var_3_0, arg_3_0.id)
end

function var_0_0.GetStageId(arg_4_0)
	return arg_4_0.id
end

function var_0_0.GetType(arg_5_0)
	return BattleConst.STAGE_TYPE_NEW.ACTIVITY_RACE
end

function var_0_0.GetMap(arg_6_0)
	return arg_6_0.cfg.map, false
end

function var_0_0.GetAILevel(arg_7_0)
	return arg_7_0.cfg.ai_level or 0
end

function var_0_0.GetEnemyLevel(arg_8_0)
	return arg_8_0.cfg.monster_level or 0
end

function var_0_0.GetHeroTeam(arg_9_0)
	return arg_9_0.heroList_, arg_9_0.heroTrialList_
end

function var_0_0.GetAddUserExp(arg_10_0)
	return arg_10_0.cfg.user_exp or 0
end

function var_0_0.GetAddHeroExp(arg_11_0)
	return arg_11_0.cfg.hero_exp or 0
end

function var_0_0.GetCost(arg_12_0)
	return arg_12_0.cfg.cost or 0
end

function var_0_0.GetStageAffix(arg_13_0)
	local var_13_0 = {}
	local var_13_1 = {}
	local var_13_2 = {}
	local var_13_3 = ActivityRaceData:GetUnlockAffixList(arg_13_0.activityID_)

	for iter_13_0, iter_13_1 in pairs(var_13_3) do
		local var_13_4 = ActivityAffixPoolCfg[iter_13_1].affix

		table.insert(var_13_0, var_13_4[1])
		table.insert(var_13_1, var_13_4[2])
		table.insert(var_13_2, var_13_4[3])
	end

	local var_13_5 = ActivityRaceCfg[arg_13_0.activityID_].race_buff
	local var_13_6 = ActivityAffixPoolCfg[var_13_5].affix

	table.insert(var_13_0, var_13_6[1])
	table.insert(var_13_1, var_13_6[2])
	table.insert(var_13_2, var_13_6[3])

	return var_13_0, var_13_1, var_13_2
end

return var_0_0
