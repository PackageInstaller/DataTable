local var_0_0 = class("BattleMardukeTowerGameTemplate", BattleBaseStageTemplate)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.activityID_ = arg_1_2
	arg_1_0.cfg = BattleTowerGameCfg[arg_1_1]
	arg_1_0.stageID_ = arg_1_1
	arg_1_0.heroList_, _, _, arg_1_0.heroTrialList_ = GetLocalHeroTeam(arg_1_0:GetType(), arg_1_0.stageID_, arg_1_2)

	arg_1_0:InitComboSkillID()
	arg_1_0:InitChipData()
end

function var_0_0.GetDest(arg_2_0)
	return arg_2_0.activityID_
end

function var_0_0.GetStageId(arg_3_0)
	return arg_3_0.stageID_
end

function var_0_0.GetType(arg_4_0)
	return BattleConst.STAGE_TYPE_NEW.MARDUK_GAME
end

function var_0_0.GetMap(arg_5_0)
	return arg_5_0.cfg.map, false
end

function var_0_0.GetEnemyLevel(arg_6_0)
	return arg_6_0.cfg.monster_level
end

function var_0_0.GetHeroTeam(arg_7_0)
	return arg_7_0.heroList_, arg_7_0.heroTrialList_
end

function var_0_0.GetAILevel(arg_8_0)
	return arg_8_0.cfg.ai_level
end

return var_0_0
