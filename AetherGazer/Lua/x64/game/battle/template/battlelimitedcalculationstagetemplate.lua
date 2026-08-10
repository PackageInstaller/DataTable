local var_0_0 = class("BattleLimitedCalculationStageTemplate", BattleBaseStageTemplate)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.super.Ctor(arg_1_0)

	arg_1_0.id_ = arg_1_1
	arg_1_0.activityID_ = arg_1_2

	local var_1_0 = LimitedCalculationData:GetCurDifficulty(arg_1_0.activityID_)

	arg_1_0.difficultyCfg_ = ActivityLimitCalculationCfg[var_1_0]
	arg_1_0.cfg_ = BattleLimitedCalculationStageCfg[arg_1_0.id_]
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitHeroList()
	arg_2_0:InitComboSkillID()
	arg_2_0:InitChipData()
end

function var_0_0.GetDest(arg_3_0)
	return arg_3_0.difficultyCfg_.activity_id
end

function var_0_0.GetActivityID(arg_4_0)
	return arg_4_0.activityID_
end

function var_0_0.GetStageId(arg_5_0)
	return arg_5_0.id_
end

function var_0_0.GetType(arg_6_0)
	return BattleConst.STAGE_TYPE_NEW.LIMITED_CALCULATION
end

function var_0_0.GetMap(arg_7_0)
	return arg_7_0.cfg_.map, false
end

function var_0_0.GetAILevel(arg_8_0)
	return arg_8_0.cfg_.ai_level
end

function var_0_0.GetEnemyLevel(arg_9_0)
	return arg_9_0.cfg_.monster_level
end

function var_0_0.GetHeroTeam(arg_10_0)
	return arg_10_0.heroList_, arg_10_0.heroTrialList_
end

function var_0_0.GetStageAffix(arg_11_0)
	local var_11_0 = {}
	local var_11_1 = {}
	local var_11_2 = {}
	local var_11_3 = arg_11_0.difficultyCfg_.player_affix or {}
	local var_11_4 = arg_11_0.difficultyCfg_.enemy_affix or {}

	for iter_11_0, iter_11_1 in ipairs(var_11_3) do
		table.insert(var_11_0, iter_11_1[1])
		table.insert(var_11_1, iter_11_1[2])
		table.insert(var_11_2, iter_11_1[3])
	end

	for iter_11_2, iter_11_3 in ipairs(var_11_4) do
		table.insert(var_11_0, iter_11_3[1])
		table.insert(var_11_1, iter_11_3[2])
		table.insert(var_11_2, iter_11_3[3])
	end

	return var_11_0, var_11_1, var_11_2
end

return var_0_0
