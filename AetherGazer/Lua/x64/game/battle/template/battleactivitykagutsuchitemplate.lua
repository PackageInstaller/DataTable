local var_0_0 = class("BattleActivityKagutsuchiTemplate", BattleBaseStageTemplate)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.id = arg_1_1
	arg_1_0.activityID_ = arg_1_2
	arg_1_0.cfg = BattleKagutsuchiStageCfg[arg_1_1]
	arg_1_0.day = KagutsuchiWorkData:GetDay()

	local var_1_0 = KagutsuchiWorkData:GetIndexByStageId(arg_1_1)

	arg_1_0.cost = KagutsuchiWorkData:GetPlayGridData(var_1_0):GetCost()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitHeroList()
	arg_2_0:InitComboSkillID()
	arg_2_0:InitChipData()
end

function var_0_0.GetDest(arg_3_0)
	return arg_3_0:GetStageId()
end

function var_0_0.GetStageId(arg_4_0)
	return arg_4_0.id
end

function var_0_0.GetType(arg_5_0)
	return BattleConst.STAGE_TYPE_NEW.ACTIVITY_JJT_MAP_GAME
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
	local var_13_0 = {}
	local var_13_1 = {}
	local var_13_2 = {}
	local var_13_3 = KagutsuchiTalentData:GetUnlockTalentIdList()

	for iter_13_0, iter_13_1 in pairs(var_13_3) do
		table.insert(var_13_0, TalentTreeCfg[iter_13_1].affix_id)
		table.insert(var_13_1, KagutsuchiTalentData:GetTalentLevel(iter_13_1))
		table.insert(var_13_2, TalentTreeCfg[iter_13_1].affix_user)
	end

	return var_13_0, var_13_1, var_13_2
end

function var_0_0.GetAttributeFactor(arg_14_0)
	return KagutsuchiWorkData:GetAttributeFactor()
end

function var_0_0.GetDay(arg_15_0)
	return arg_15_0.day
end

function var_0_0.GetGridCost(arg_16_0)
	return arg_16_0.cost or 0
end

return var_0_0
