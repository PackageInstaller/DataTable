local var_0_0 = class("BattleTowerDefenceStageTemplate", BattleBaseStageTemplate)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.id = arg_1_1
	arg_1_0.activityID = arg_1_2
	arg_1_0.cfg = BattleShotStageCfg[arg_1_0.id]
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitHeroList()
	arg_2_0:InitChipData()
end

function var_0_0.GetDest(arg_3_0)
	return arg_3_0.activityID
end

function var_0_0.GetStageId(arg_4_0)
	return arg_4_0.id
end

function var_0_0.GetActivityID(arg_5_0)
	return arg_5_0.activityID
end

function var_0_0.GetType(arg_6_0)
	return BattleConst.STAGE_TYPE_NEW.TOWER_DEFENCE
end

function var_0_0.GetMap(arg_7_0)
	return arg_7_0.cfg.map, false
end

function var_0_0.GetEnemyLevel(arg_8_0)
	return arg_8_0.cfg.monster_level
end

function var_0_0.GetHeroTeam(arg_9_0)
	return arg_9_0.heroList_, arg_9_0.heroTrialList_
end

return var_0_0
