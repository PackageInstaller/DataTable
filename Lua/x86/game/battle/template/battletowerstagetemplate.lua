local var_0_0 = class("BattleTowerStageTemplate", BattleBaseStageTemplate)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.id = arg_1_1
	arg_1_0.cfg = BattleTowerStageCfg[arg_1_0.id]
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitHeroList()
	arg_2_0:InitComboSkillID()
	arg_2_0:InitChipData()
end

function var_0_0.GetDest(arg_3_0)
	return arg_3_0.id
end

function var_0_0.GetStageId(arg_4_0)
	return arg_4_0.id
end

function var_0_0.GetType(arg_5_0)
	return BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_TOWER
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

function var_0_0.GetStageAffix(arg_9_0)
	local var_9_0 = {}
	local var_9_1 = {}
	local var_9_2 = {}
	local var_9_3 = type(arg_9_0.cfg.affix_type) == "table" and arg_9_0.cfg.affix_type or {}

	for iter_9_0, iter_9_1 in pairs(var_9_3 or {}) do
		table.insert(var_9_0, iter_9_1[1])
		table.insert(var_9_1, iter_9_1[2])
		table.insert(var_9_2, iter_9_1[3])
	end

	return var_9_0, var_9_1, var_9_2
end

function var_0_0.GetSettingShowAffix(arg_10_0)
	local var_10_0 = {}
	local var_10_1, var_10_2, var_10_3 = arg_10_0:GetBattleStageAffix()
	local var_10_4 = #var_10_1

	for iter_10_0 = 1, var_10_4 do
		table.insert(var_10_0, {
			var_10_1[iter_10_0],
			var_10_2[iter_10_0],
			var_10_3[iter_10_0]
		})
	end

	local var_10_5 = type(arg_10_0.cfg.affix_type_in_map) == "table" and arg_10_0.cfg.affix_type_in_map or {}

	for iter_10_1, iter_10_2 in pairs(var_10_5 or {}) do
		table.insert(var_10_0, iter_10_2)
	end

	return var_10_0
end

function var_0_0.GetHeroTeam(arg_11_0)
	return arg_11_0.heroList_, arg_11_0.heroTrialList_
end

return var_0_0
