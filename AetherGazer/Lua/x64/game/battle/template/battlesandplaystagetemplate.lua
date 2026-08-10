local var_0_0 = class("BattleSandPlayStageTemplate", BattleBaseStageTemplate)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.id_ = arg_1_1
	arg_1_0.stageID_ = arg_1_1
	arg_1_0.cfg_ = BattleSandPlayStageCfg[arg_1_0.stageID_]
	arg_1_0.destID_ = arg_1_1
	arg_1_0.activityId_ = 323841

	arg_1_0:InitHeroList()
end

function var_0_0.InitHeroList(arg_2_0)
	arg_2_0.heroList_ = {}
	arg_2_0.heroTrialList_ = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_0.cfg_.hero_list) do
		table.insert(arg_2_0.heroList_, iter_2_1[1])
		table.insert(arg_2_0.heroTrialList_, iter_2_1[2])
	end
end

function var_0_0.GetDest(arg_3_0)
	return arg_3_0.stageID_
end

function var_0_0.GetComboSkillID(arg_4_0)
	return 67
end

function var_0_0.GetStageId(arg_5_0)
	return arg_5_0.stageID_
end

function var_0_0.GetType(arg_6_0)
	return BattleConst.STAGE_TYPE_NEW.SAND_PLAY
end

function var_0_0.GetMap(arg_7_0)
	return arg_7_0.cfg_.map, false
end

function var_0_0.GetEnemyLevel(arg_8_0)
	return arg_8_0.cfg_.monster_level
end

function var_0_0.GetAILevel(arg_9_0)
	return arg_9_0.cfg_.ai_level
end

function var_0_0.GetHeroTeam(arg_10_0)
	return arg_10_0.heroList_, arg_10_0.heroTrialList_
end

function var_0_0.GetActivityID(arg_11_0)
	return arg_11_0.activityId_
end

return var_0_0
