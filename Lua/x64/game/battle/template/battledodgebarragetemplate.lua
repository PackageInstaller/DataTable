local var_0_0 = class("BattleDodgeBarrageTemplate", BattleBaseStageTemplate)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.id_ = arg_1_1
	arg_1_0.stageID_ = arg_1_1
	arg_1_0.cfg = BattleDodgeBarrageCfg[arg_1_0.stageID_]
	arg_1_0.destID_ = arg_1_1
	arg_1_0.activityId_ = arg_1_2
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitHeroList()
end

function var_0_0.GetDest(arg_3_0)
	return arg_3_0.destID_
end

function var_0_0.GetStageId(arg_4_0)
	return arg_4_0.stageID_
end

function var_0_0.GetType(arg_5_0)
	return BattleConst.STAGE_TYPE_NEW.ACTIVITY_DODGE_BARRAGE
end

function var_0_0.GetMap(arg_6_0)
	return arg_6_0.cfg.map, false
end

function var_0_0.GetEnemyLevel(arg_7_0)
	return arg_7_0.cfg.monster_level
end

function var_0_0.GetHeroTeam(arg_8_0)
	return arg_8_0.heroList_, arg_8_0.heroTrialList_
end

function var_0_0.GetActivityID(arg_9_0)
	return arg_9_0.activityId_
end

return var_0_0
