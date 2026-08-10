local var_0_0 = class("BattleOsirisDemonStageTemplate", BattleBaseStageTemplate)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.id = arg_1_1
	arg_1_0.activityID_ = arg_1_2
	arg_1_0.cfg = BattleHeartDemonStageCfg[arg_1_1]
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitHeroList()
	arg_2_0:InitComboSkillID()
	arg_2_0:InitChipData()
end

function var_0_0.GetDest(arg_3_0)
	return arg_3_0.activityID_
end

function var_0_0.GetStageId(arg_4_0)
	return arg_4_0.id
end

function var_0_0.GetType(arg_5_0)
	return BattleConst.STAGE_TYPE_NEW.OSIRIS_DEMON
end

function var_0_0.GetMap(arg_6_0)
	return arg_6_0.cfg.map, false
end

function var_0_0.GetAILevel(arg_7_0)
	return arg_7_0.cfg.ai_level
end

function var_0_0.GetEnemyLevel(arg_8_0)
	return arg_8_0.cfg.monster_level
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

function var_0_0.GetCost(arg_12_0)
	return arg_12_0.cfg.cost or 0
end

function var_0_0.GetStageAffix(arg_13_0)
	local var_13_0 = ActivityTools.GetActivityTheme(DemonChallengeCfg[arg_13_0.activityID_].activity_id)
	local var_13_1 = TalentTreeData:GetTalentListByTheme(var_13_0)
	local var_13_2 = {}
	local var_13_3 = {}
	local var_13_4 = {}

	for iter_13_0, iter_13_1 in ipairs(var_13_1) do
		table.insert(var_13_2, iter_13_1[1])
		table.insert(var_13_3, iter_13_1[2])
		table.insert(var_13_4, iter_13_1[3])
	end

	local var_13_5 = type(arg_13_0.cfg.affix_type) == "table" and arg_13_0.cfg.affix_type or {}

	for iter_13_2, iter_13_3 in pairs(var_13_5 or {}) do
		table.insert(var_13_2, iter_13_3[1])
		table.insert(var_13_3, iter_13_3[2])
		table.insert(var_13_4, iter_13_3[3])
	end

	return var_13_2, var_13_3, var_13_4
end

return var_0_0
