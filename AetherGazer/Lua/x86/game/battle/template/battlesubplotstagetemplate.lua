local var_0_0 = class("BattleSubPlotStageTemplate", BattleBaseStageTemplate)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.id = arg_1_1
	arg_1_0.activityID_ = arg_1_2
end

function var_0_0.Init(arg_2_0)
	arg_2_0.cfg = BattleActivityStoryStageCfg[arg_2_0:GetStageId()]

	if BattleConst.BATTLE_TAG.STORY == arg_2_0.cfg.tag then
		arg_2_0.heroList_ = {}
		arg_2_0.heroTrialList_ = {}
	else
		arg_2_0:InitHeroList()
	end

	arg_2_0:InitComboSkillID()
	arg_2_0:InitChipData()
end

function var_0_0.GetClearTime(arg_3_0)
	local var_3_0 = BattleStageData:GetStageData()[arg_3_0.id]

	if var_3_0 and var_3_0.clear_times then
		return var_3_0.clear_times
	else
		return 0
	end
end

function var_0_0.GetDest(arg_4_0)
	return arg_4_0.id
end

function var_0_0.GetStageId(arg_5_0)
	return arg_5_0.id
end

function var_0_0.GetType(arg_6_0)
	return BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_SUB_PLOT
end

function var_0_0.GetMap(arg_7_0)
	return arg_7_0.cfg.map, false
end

function var_0_0.GetAILevel(arg_8_0)
	return arg_8_0.cfg.ai_level
end

function var_0_0.GetEnemyLevel(arg_9_0)
	return arg_9_0.cfg.monster_level
end

function var_0_0.GetHeroTeam(arg_10_0)
	return arg_10_0.heroList_, arg_10_0.heroTrialList_
end

function var_0_0.GetAddUserExp(arg_11_0)
	return arg_11_0.cfg.user_exp or 0
end

function var_0_0.GetAddHeroExp(arg_12_0)
	return arg_12_0.cfg.hero_exp or 0
end

function var_0_0.GetCost(arg_13_0)
	return arg_13_0.cfg.cost or 0
end

function var_0_0.GetRevive(arg_14_0)
	if type(arg_14_0.cfg.is_revive) ~= "table" or BattleConst.BATTLE_TAG.STORY == arg_14_0.cfg.tag then
		return false, 0, 0, 0
	end

	local var_14_0 = arg_14_0.cfg.is_revive
	local var_14_1 = var_14_0[1] and true or false
	local var_14_2 = var_14_0[1] or 0
	local var_14_3 = var_14_0[1] and ItemTools.getItemNum(var_14_0[1]) or 0
	local var_14_4 = var_14_0[2] or 0

	return var_14_1, var_14_2, var_14_3, var_14_4
end

return var_0_0
