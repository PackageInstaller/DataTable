local var_0_0 = class("BattleActivityPtScrollTemplate", BattleBaseStageTemplate)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.id_ = arg_1_1
	arg_1_0.activityID_ = arg_1_2
	arg_1_0.stageID_ = arg_1_1
	arg_1_0.cfg = BattleStageTools.GetStageCfg(arg_1_0:GetType(), arg_1_1)
	arg_1_0.destID_ = 0

	local var_1_0 = {}
	local var_1_1 = ActivityPtRouletteStageCfg.get_id_list_by_activity_id[arg_1_0.activityID_]

	for iter_1_0, iter_1_1 in ipairs(var_1_1) do
		if ActivityPtRouletteStageCfg[iter_1_1].stage_id == arg_1_0.stageID_ then
			arg_1_0.destID_ = iter_1_1
		end
	end
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitHeroList()
	arg_2_0:InitComboSkillID()
	arg_2_0:InitChipData()
end

function var_0_0.GetDest(arg_3_0)
	return arg_3_0.destID_
end

function var_0_0.GetStageId(arg_4_0)
	return arg_4_0.stageID_
end

function var_0_0.GetType(arg_5_0)
	return BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT_SCROLL
end

function var_0_0.GetMap(arg_6_0)
	return arg_6_0.cfg.map, false
end

function var_0_0.GetHeroTeam(arg_7_0)
	return arg_7_0.heroList_, arg_7_0.heroTrialList_
end

function var_0_0.GetActivityID(arg_8_0)
	return arg_8_0.activityID_
end

function var_0_0.GetThreeStar(arg_9_0)
	return {}
end

function var_0_0.GetCost(arg_10_0)
	return ActivityPtRouletteStageCfg[arg_10_0:GetDest()].cost[2] or 0
end

function var_0_0.GetStageAffix(arg_11_0)
	local var_11_0 = {}
	local var_11_1 = {}
	local var_11_2 = {}
	local var_11_3 = ActivityPtRouletteStageCfg[arg_11_0:GetDest()]
	local var_11_4 = manager.time:GetGameServerWeek()
	local var_11_5 = var_11_3.roulette_id

	for iter_11_0, iter_11_1 in ipairs(var_11_5) do
		local var_11_6 = ActivityPtRouletteRandomCfg[iter_11_1]

		if var_11_6.time == var_11_4 then
			local var_11_7 = var_11_6.affix_list

			for iter_11_2, iter_11_3 in ipairs(var_11_7) do
				local var_11_8 = ActivityPtRouletteAffixCfg[iter_11_3].affix_list

				table.insert(var_11_0, var_11_8[1])
				table.insert(var_11_1, var_11_8[2])
				table.insert(var_11_2, var_11_8[3])
			end

			local var_11_9 = ActivityPtScrollData:GetChooseAffixID(arg_11_0.activityID_)
			local var_11_10 = ActivityPtScrollData:GetAffixInfo(arg_11_0.activityID_, var_11_9)

			if not table.indexof(var_11_0, var_11_10.affix) then
				table.insert(var_11_0, var_11_10.affix)
				table.insert(var_11_1, var_11_10.level)
				table.insert(var_11_2, var_11_10.target)
			end

			local var_11_11 = ActivityPtRouletteAffixCfg[var_11_9].affix_list2

			for iter_11_4, iter_11_5 in ipairs(var_11_11) do
				table.insert(var_11_0, iter_11_5[1])
				table.insert(var_11_1, iter_11_5[2])
				table.insert(var_11_2, iter_11_5[3])
			end

			break
		end
	end

	return var_11_0, var_11_1, var_11_2
end

function var_0_0.GetAddUserExp(arg_12_0)
	return arg_12_0.cfg.user_exp or 0
end

function var_0_0.GetAddHeroExp(arg_13_0)
	return arg_13_0.cfg.hero_exp or 0
end

function var_0_0.GetAILevel(arg_14_0)
	return arg_14_0.cfg.ai_level
end

function var_0_0.GetEnemyLevel(arg_15_0)
	return arg_15_0.cfg.monster_level
end

return var_0_0
