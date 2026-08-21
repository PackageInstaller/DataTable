local var_0_0 = class("BattleSlayerStageTemplate", BattleBaseStageTemplate)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.entrust_activity_id = arg_1_1
	arg_1_0.parkour_activity_id = arg_1_2

	local var_1_0 = ActivityParkourCfg[arg_1_1].stage_id

	arg_1_0.super.Ctor(arg_1_0, var_1_0)

	arg_1_0.id_ = var_1_0
	arg_1_0.cfg = BattleParkourStageCfg[var_1_0]
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitHeroList()
	arg_2_0:InitComboSkillID()
	arg_2_0:InitChipData()
end

function var_0_0.GetDest(arg_3_0)
	return arg_3_0.entrust_activity_id
end

function var_0_0.GetStageId(arg_4_0)
	return arg_4_0.id_
end

function var_0_0.GetType(arg_5_0)
	return BattleConst.STAGE_TYPE_NEW.PARKOUR
end

function var_0_0.GetMap(arg_6_0)
	return arg_6_0.cfg.map, false
end

function var_0_0.GetEnemyLevel(arg_7_0)
	return arg_7_0.cfg.monster_level
end

function var_0_0.GetStageAffix(arg_8_0)
	local var_8_0 = {}
	local var_8_1 = {}
	local var_8_2 = {}

	return var_8_0, var_8_1, var_8_2
end

function var_0_0.GetHeroTeam(arg_9_0)
	return arg_9_0.heroList_, arg_9_0.heroTrialList_
end

function var_0_0.GetActivityID(arg_10_0)
	return arg_10_0.parkour_activity_id
end

function var_0_0.GetThreeStar(arg_11_0)
	return arg_11_0.cfg.three_star_need
end

return var_0_0
