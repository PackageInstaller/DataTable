local var_0_0 = class("ActivityRhythmGameTemplate", BattleBaseStageTemplate)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.stageID_ = arg_1_1
	arg_1_0.activityID_ = arg_1_2.activityID
	arg_1_0.notActivity_ = arg_1_2.notActivity
	arg_1_0.battleCfg_ = BattleRhythmGameStageCfg[arg_1_1]

	if arg_1_2.cfgID ~= arg_1_1 then
		arg_1_0.cfgID_ = arg_1_2.cfgID
		arg_1_0.activityCfg_ = ActivityRhythmGameCfg[arg_1_0.cfgID_]

		if arg_1_0.activityCfg_ then
			arg_1_0.stars = arg_1_0.activityCfg_.three_star_need
		else
			arg_1_0.stars = {}
		end
	end
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitHeroList()
end

function var_0_0.InitHeroList(arg_3_0)
	arg_3_0.heroList_ = {}

	for iter_3_0 = 1, 3 do
		if arg_3_0.battleCfg_.hero_list[iter_3_0][1] ~= 0 then
			table.insert(arg_3_0.heroList_, arg_3_0.battleCfg_.hero_list[iter_3_0][2])
		else
			table.insert(arg_3_0.heroList_, 0)
		end
	end

	arg_3_0.heroTrialList_ = {}
end

function var_0_0.GetDest(arg_4_0)
	if arg_4_0.notActivity_ then
		return 0
	else
		return arg_4_0.stageID_
	end
end

function var_0_0.GetStageId(arg_5_0)
	return arg_5_0.stageID_
end

function var_0_0.GetType(arg_6_0)
	return BattleConst.STAGE_TYPE_NEW.ACTIVITY_RHYTHM_GAME
end

function var_0_0.GetMap(arg_7_0)
	return arg_7_0.battleCfg_.map, false
end

function var_0_0.GetAILevel(arg_8_0)
	return arg_8_0.battleCfg_.ai_level
end

function var_0_0.GetEnemyLevel(arg_9_0)
	return arg_9_0.battleCfg_.monster_level
end

function var_0_0.GetHeroTeam(arg_10_0)
	return arg_10_0.heroList_, arg_10_0.heroTrialList_
end

function var_0_0.GetSystemHeroTeam(arg_11_0)
	return arg_11_0.heroList_
end

function var_0_0.GetAddUserExp(arg_12_0)
	return arg_12_0.battleCfg_.user_exp or 0
end

function var_0_0.GetAddHeroExp(arg_13_0)
	return arg_13_0.battleCfg_.hero_exp or 0
end

function var_0_0.GetCost(arg_14_0)
	return arg_14_0.battleCfg_.cost or 0
end

function var_0_0.GetThreeStar(arg_15_0)
	if arg_15_0.stars == "" or arg_15_0.stars == nil then
		return {}
	end

	return arg_15_0.stars
end

function var_0_0.GetStageAffix(arg_16_0)
	local var_16_0 = {}
	local var_16_1 = {}
	local var_16_2 = {}
	local var_16_3 = ActivityRhythmGameData:GetCommandListByStageID(arg_16_0.stageID_)

	for iter_16_0, iter_16_1 in pairs(var_16_3) do
		table.insert(var_16_0, TalentTreeCfg[iter_16_1].affix_id)
		table.insert(var_16_1, 1)
		table.insert(var_16_2, TalentTreeCfg[iter_16_1].affix_user)
	end

	return var_16_0, var_16_1, var_16_2
end

return var_0_0
