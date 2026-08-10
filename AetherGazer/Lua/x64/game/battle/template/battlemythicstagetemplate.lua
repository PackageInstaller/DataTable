local var_0_0 = class("BattleMythicStageTemplate", BattleBaseStageTemplate)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.id = arg_1_1
	arg_1_0.dest = arg_1_2

	var_0_0.super.Ctor(arg_1_0, arg_1_0.id)

	arg_1_0.cfg = BattleMythicStageCfg[arg_1_0.id]
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitHeroList()
	arg_2_0:InitComboSkillID()
	arg_2_0:InitChipData()
end

function var_0_0.GetDest(arg_3_0)
	return arg_3_0.dest
end

function var_0_0.GetStageId(arg_4_0)
	return arg_4_0.id
end

function var_0_0.GetType(arg_5_0)
	return BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MYTHIC
end

function var_0_0.GetMap(arg_6_0)
	return arg_6_0.cfg.map, false
end

function var_0_0.GetAILevel(arg_7_0)
	return arg_7_0.cfg.ai_level
end

function var_0_0.GetAttributeFactor(arg_8_0)
	return MythicData:GetAttributeFactor(arg_8_0.dest)
end

function var_0_0.GetEnemyLevel(arg_9_0)
	return MythicData:GetMonsterLevel(arg_9_0.dest)
end

function var_0_0.GetStageAffix(arg_10_0)
	local var_10_0 = {}
	local var_10_1 = {}
	local var_10_2 = {}
	local var_10_3 = MythicData:GetMonsterAffix()
	local var_10_4 = MythicData:GetHeroAffix()

	for iter_10_0, iter_10_1 in pairs(var_10_3 or {}) do
		table.insert(var_10_0, iter_10_1[1])
		table.insert(var_10_1, iter_10_1[2])
		table.insert(var_10_2, iter_10_1[3])
	end

	for iter_10_2, iter_10_3 in pairs(var_10_4 or {}) do
		table.insert(var_10_0, iter_10_3[1])
		table.insert(var_10_1, iter_10_3[2])
		table.insert(var_10_2, iter_10_3[3])
	end

	return var_10_0, var_10_1, var_10_2
end

function var_0_0.GetHeroTeam(arg_11_0)
	return arg_11_0.heroList_, arg_11_0.heroTrialList_
end

function var_0_0.GetThreeStar(arg_12_0)
	if arg_12_0.cfg.three_star_need == "" then
		return {}
	end

	return arg_12_0.cfg.three_star_need
end

return var_0_0
