local var_0_0 = class("BattleAdvanceMonsterTestTemplate", BattleBaseStageTemplate)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.stageID_ = arg_1_1
	arg_1_0.cfg = BattleActivityAdvanceMonsterTestCfg[arg_1_1]
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitHeroList()
	arg_2_0:InitComboSkillID()
	arg_2_0:InitChipData()
end

function var_0_0.GetDest(arg_3_0)
	return arg_3_0.stageID_
end

function var_0_0.GetStageId(arg_4_0)
	return arg_4_0.stageID_
end

function var_0_0.GetActivityID(arg_5_0)
	return ActivityConst.ACTIVITY_ADVANCE_MONSTER_TEST
end

function var_0_0.GetType(arg_6_0)
	return BattleConst.STAGE_TYPE_NEW.ADVANCE_MONSTER_TEST
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

function var_0_0.GetStageAffix(arg_11_0)
	local var_11_0 = {}
	local var_11_1 = {}
	local var_11_2 = {}
	local var_11_3

	for iter_11_0, iter_11_1 in pairs(ActivityAdvanceMonsterTestCfg.all) do
		if ActivityAdvanceMonsterTestCfg[iter_11_1].stage_id == arg_11_0.stageID_ then
			var_11_3 = iter_11_1

			break
		end
	end

	if arg_11_0.cfg.affix_type ~= "" then
		for iter_11_2, iter_11_3 in pairs(arg_11_0.cfg.affix_type or {}) do
			table.insert(var_11_0, iter_11_3[1])
			table.insert(var_11_1, iter_11_3[2])
			table.insert(var_11_2, iter_11_3[3])
		end
	end

	local var_11_4 = AdvanceMonsterTestData:GetCustomList(var_11_3)

	for iter_11_4, iter_11_5 in pairs(var_11_4 or {}) do
		local var_11_5 = ActivityAffixPoolCfg[iter_11_5].affix

		table.insert(var_11_0, var_11_5[1])
		table.insert(var_11_1, var_11_5[2])
		table.insert(var_11_2, var_11_5[3])
	end

	return var_11_0, var_11_1, var_11_2
end

return var_0_0
