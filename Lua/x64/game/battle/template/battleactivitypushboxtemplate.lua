local var_0_0 = class("BattleActivityPushBoxTemplate", BattleBaseStageTemplate)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.id_ = arg_1_1
	arg_1_0.destID_ = arg_1_3
	arg_1_0.activityID_ = arg_1_2
	arg_1_0.stageID_ = arg_1_1
	arg_1_0.cfg = BattleStageTools.GetStageCfg(arg_1_0:GetType(), arg_1_0:GetStageId())
	arg_1_0.heroList_, _, _, arg_1_0.heroTrialList_ = GetLocalHeroTeam(arg_1_0:GetType(), arg_1_0.stageID_, arg_1_2)

	arg_1_0:InitComboSkillID()
	arg_1_0:InitChipData()
end

function var_0_0.GetDest(arg_2_0)
	return arg_2_0.destID_
end

function var_0_0.GetStageId(arg_3_0)
	return arg_3_0.stageID_
end

function var_0_0.GetType(arg_4_0)
	return BattleConst.STAGE_TYPE_NEW.PUSH_BOX_BATTLE
end

function var_0_0.GetMap(arg_5_0)
	return arg_5_0.cfg.map, false
end

function var_0_0.GetHeroTeam(arg_6_0)
	return arg_6_0.heroList_, arg_6_0.heroTrialList_
end

function var_0_0.GetActivityID(arg_7_0)
	return arg_7_0.activityID_
end

function var_0_0.GetThreeStar(arg_8_0)
	return {}
end

function var_0_0.GetCost(arg_9_0)
	return ActivityCelebrationOrderCfg[arg_9_0:GetDest()].cost or 0
end

function var_0_0.GetStageAffix(arg_10_0)
	local var_10_0 = {}
	local var_10_1 = {}
	local var_10_2 = {}
	local var_10_3 = ActivityCelebrationOrderCfg[arg_10_0:GetDest()].affix_list

	for iter_10_0, iter_10_1 in pairs(var_10_3 or {}) do
		table.insert(var_10_0, iter_10_1[1])
		table.insert(var_10_1, iter_10_1[2])
		table.insert(var_10_2, iter_10_1[3])
	end

	return var_10_0, var_10_1, var_10_2
end

function var_0_0.GetAddUserExp(arg_11_0)
	return arg_11_0.cfg.user_exp or 0
end

function var_0_0.GetAddHeroExp(arg_12_0)
	return arg_12_0.cfg.hero_exp or 0
end

function var_0_0.GetAILevel(arg_13_0)
	return arg_13_0.cfg.ai_level
end

function var_0_0.GetEnemyLevel(arg_14_0)
	return arg_14_0.cfg.monster_level
end

return var_0_0
