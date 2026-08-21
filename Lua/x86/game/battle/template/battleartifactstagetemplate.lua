local var_0_0 = class("BattleArtifactStageTemplate", BattleBaseStageTemplate)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.id = arg_1_1
	arg_1_0.activityID_ = arg_1_2
	arg_1_0.cfg = BattleArtifactCfg[arg_1_1]
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitHeroList()
	arg_2_0:InitComboSkillID()
	arg_2_0:InitChipData()
end

function var_0_0.GetDest(arg_3_0)
	return ArtifactLevelData:GetLevelIdByStageId(arg_3_0.id)
end

function var_0_0.GetStageId(arg_4_0)
	return arg_4_0.id
end

function var_0_0.GetActivityID(arg_5_0)
	return arg_5_0.activityID_
end

function var_0_0.GetType(arg_6_0)
	return BattleConst.STAGE_TYPE_NEW.ARTIFACT
end

function var_0_0.GetMap(arg_7_0)
	return arg_7_0.cfg.map, false
end

function var_0_0.GetName(arg_8_0)
	return arg_8_0.cfg.name
end

function var_0_0.GetAILevel(arg_9_0)
	return arg_9_0.cfg.ai_level
end

function var_0_0.GetEnemyLevel(arg_10_0)
	return arg_10_0.cfg.monster_level
end

function var_0_0.GetStageAffix(arg_11_0)
	local var_11_0 = {}
	local var_11_1 = {}
	local var_11_2 = {}
	local var_11_3 = ActivityArtifactLevelCfg[ArtifactLevelData:GetLevelIdByStageId(arg_11_0.id)].affix_list

	for iter_11_0, iter_11_1 in ipairs(var_11_3) do
		table.insert(var_11_0, iter_11_1[1])
		table.insert(var_11_1, iter_11_1[2])
		table.insert(var_11_2, iter_11_1[3])
	end

	return var_11_0, var_11_1, var_11_2
end

function var_0_0.GetHeroTeam(arg_12_0)
	return arg_12_0.heroList_, arg_12_0.heroTrialList_
end

return var_0_0
