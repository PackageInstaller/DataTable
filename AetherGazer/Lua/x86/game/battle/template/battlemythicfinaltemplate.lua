local var_0_0 = class("BattleMythicFinalTemplate", BattleBaseStageTemplate)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.id = arg_1_1
	arg_1_0.activityID_ = arg_1_2
	arg_1_0.cfg = BattleMythicFinalCfg[arg_1_1]
	arg_1_0.levelcfg = MythicFinalCfg[MythicData:GetCurHotLevelId()]
	arg_1_0.nextBattleStage_ = nil
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitHeroList()
	arg_2_0:InitComboSkillID()
	arg_2_0:InitChipData()
end

function var_0_0.GetDest(arg_3_0)
	return arg_3_0:GetTeamIndex()
end

function var_0_0.GetStageId(arg_4_0)
	return arg_4_0.id
end

function var_0_0.GetType(arg_5_0)
	return BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL
end

function var_0_0.GetMap(arg_6_0)
	return arg_6_0.cfg.map, false
end

function var_0_0.GetAILevel(arg_7_0)
	return arg_7_0.cfg.ai_level
end

function var_0_0.GetAttributeFactor(arg_8_0)
	local var_8_0 = MythicFinalCfg[MythicData:GetCurHotLevelId()]

	if var_8_0.attribute_factor and var_8_0.attribute_factor[3] then
		local var_8_1 = var_8_0.attribute_factor[1] / 1000
		local var_8_2 = var_8_0.attribute_factor[2] / 1000
		local var_8_3 = var_8_0.attribute_factor[3] / 1000

		return Vector3.New(var_8_1, var_8_2, var_8_3)
	end

	return Vector3.New(1, 1, 1)
end

function var_0_0.GetStageAffix(arg_9_0)
	local var_9_0 = {}
	local var_9_1 = {}
	local var_9_2 = {}
	local var_9_3 = MythicData:GetFinalMonsterAffix()

	for iter_9_0, iter_9_1 in pairs(var_9_3 or {}) do
		table.insert(var_9_0, iter_9_1[1])
		table.insert(var_9_1, iter_9_1[2])
		table.insert(var_9_2, iter_9_1[3])
	end

	return var_9_0, var_9_1, var_9_2
end

function var_0_0.GetHeroTeam(arg_10_0)
	return arg_10_0.heroList_, arg_10_0.heroTrialList_
end

function var_0_0.GetEnemyLevel(arg_11_0)
	return arg_11_0.levelcfg.monster_level
end

function var_0_0.GetNextStage(arg_12_0)
	return arg_12_0.nextBattleStage_
end

function var_0_0.SetNextStage(arg_13_0, arg_13_1)
	arg_13_0.nextBattleStage_ = arg_13_1
end

function var_0_0.GetBattleTime(arg_14_0)
	return MythicData:GetBattleRemainTime(arg_14_0:GetDest())
end

return var_0_0
