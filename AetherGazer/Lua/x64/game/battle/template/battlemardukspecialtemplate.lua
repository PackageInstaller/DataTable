local var_0_0 = class("BattleMardukSpecialTemplate", BattleBaseStageTemplate)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.id = arg_1_1
	arg_1_0.activityID_ = arg_1_2
	arg_1_0.cfg = BattleQuickTrainingCfg[arg_1_1]
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitHeroList()
	arg_2_0:InitComboSkillID()
	arg_2_0:InitChipData()
end

function var_0_0.GetStageId(arg_3_0)
	return arg_3_0.id
end

function var_0_0.GetType(arg_4_0)
	return BattleConst.STAGE_TYPE_NEW.MARDUK_SPECIAL
end

function var_0_0.GetMap(arg_5_0)
	return arg_5_0.cfg.map, false
end

function var_0_0.GetAILevel(arg_6_0)
	return arg_6_0.cfg.ai_level or 0
end

function var_0_0.GetEnemyLevel(arg_7_0)
	return arg_7_0.cfg.monster_level or 0
end

function var_0_0.GetStageAffix(arg_8_0)
	local var_8_0 = {}
	local var_8_1 = {}
	local var_8_2 = {}

	table.insert(var_8_0, arg_8_0.cfg.affix_type_in_map[1])
	table.insert(var_8_1, arg_8_0.cfg.affix_type_in_map[2])
	table.insert(var_8_2, arg_8_0.cfg.affix_type_in_map[3])

	return var_8_0, var_8_1, var_8_2
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

function var_0_0.GetAttributeFactor(arg_12_0)
	local var_12_0 = arg_12_0.cfg

	if var_12_0.attribute_factor and var_12_0.attribute_factor[3] then
		local var_12_1 = var_12_0.attribute_factor[1] / 1000
		local var_12_2 = var_12_0.attribute_factor[2] / 1000
		local var_12_3 = var_12_0.attribute_factor[3] / 1000

		return Vector3.New(var_12_1, var_12_2, var_12_3)
	end

	return Vector3.New(1, 1, 1)
end

return var_0_0
