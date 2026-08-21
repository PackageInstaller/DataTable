local var_0_0 = class("BattleWhackMoleTemplate", BattleBaseStageTemplate)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.id_ = arg_1_1
	arg_1_0.whackMoleID_ = arg_1_2
	arg_1_0.cfg = BattleWhackMoleStageCfg[arg_1_0.id_]

	arg_1_0:InitHeroList()
end

function var_0_0.GetHeroTeam(arg_2_0)
	return arg_2_0.heroList_, arg_2_0.heroTrialList_
end

function var_0_0.GetDest(arg_3_0)
	return arg_3_0.whackMoleID_
end

function var_0_0.GetStageId(arg_4_0)
	return arg_4_0.id_
end

function var_0_0.GetType(arg_5_0)
	return BattleConst.STAGE_TYPE_NEW.ACTIVITY_WHACK_MOLE
end

function var_0_0.GetMap(arg_6_0)
	return arg_6_0.cfg.map, false
end

function var_0_0.SetBattleResult(arg_7_0, arg_7_1)
	arg_7_0.battleResult_ = arg_7_1
end

function var_0_0.GetBattleResult(arg_8_0)
	return arg_8_0.battleResult_
end

function var_0_0.SetScore(arg_9_0, arg_9_1)
	arg_9_0.score_ = arg_9_1
end

function var_0_0.GetScore(arg_10_0)
	return arg_10_0.score_
end

return var_0_0
