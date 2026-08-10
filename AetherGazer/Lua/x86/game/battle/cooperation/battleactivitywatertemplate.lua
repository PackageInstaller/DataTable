local var_0_0 = class("BattleActivityWaterTemplate", BattleBaseStageTemplate)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.cfg = BattleActivityWaterCfg[arg_1_1]
	arg_1_0.activityID_ = arg_1_2

	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.id = arg_1_1
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitHeroList()
	arg_2_0:InitComboSkillID()
	arg_2_0:InitChipData()
end

function var_0_0.GetHeroTeam(arg_3_0)
	return arg_3_0.heroList_, arg_3_0.heroTrialList_
end

function var_0_0.GetLayerId(arg_4_0)
	return arg_4_0.layer_
end

function var_0_0.GetLayer(arg_5_0)
	return arg_5_0.layer_
end

function var_0_0.GetStageIndex(arg_6_0)
	return arg_6_0.stageIndex_
end

function var_0_0.GetDest(arg_7_0)
	return arg_7_0.id
end

function var_0_0.GetStageId(arg_8_0)
	return arg_8_0.id
end

function var_0_0.GetType(arg_9_0)
	return BattleConst.STAGE_TYPE_NEW.ACTIVITY_SUMMER_WATER
end

function var_0_0.GetMap(arg_10_0)
	return arg_10_0.cfg.map, false
end

function var_0_0.GetAILevel(arg_11_0)
	return arg_11_0.cfg.ai_level
end

function var_0_0.GetEnemyLevel(arg_12_0)
	return arg_12_0.cfg.monster_level
end

function var_0_0.GetAttributeFactor(arg_13_0)
	local var_13_0 = arg_13_0.cfg

	if var_13_0.attribute_factor and var_13_0.attribute_factor[3] then
		local var_13_1 = var_13_0.attribute_factor[1] / 1000
		local var_13_2 = var_13_0.attribute_factor[2] / 1000
		local var_13_3 = var_13_0.attribute_factor[3] / 1000

		return Vector3.New(var_13_1, var_13_2, var_13_3)
	end

	return Vector3.New(1, 1, 1)
end

function var_0_0.SetMainActivityId(arg_14_0, arg_14_1)
	arg_14_0.mainActivityId_ = arg_14_1
end

function var_0_0.GetMainActivityId(arg_15_0)
	return arg_15_0.mainActivityId_
end

return var_0_0
