local var_0_0 = class("BattleSoloChallengeStageTemplate", BattleBaseStageTemplate)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.id = arg_1_1
	arg_1_0.activityID_ = arg_1_2
	arg_1_0.cfg = BattleSoloChallengeStageCfg[arg_1_1]
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitHeroList()
	arg_2_0:InitComboSkillID()
end

function var_0_0.GetDest(arg_3_0)
	local var_3_0 = SoloChallengeData:GetSelectedDifficultyIndex(arg_3_0.activityID_)
	local var_3_1 = ActivitySoloChallengeCfg[arg_3_0.activityID_].stage_id[var_3_0][2]

	return table.keyof(var_3_1, arg_3_0.id)
end

function var_0_0.GetStageId(arg_4_0)
	return arg_4_0.id
end

function var_0_0.GetType(arg_5_0)
	return BattleConst.STAGE_TYPE_NEW.SOLO_CHALLENGE
end

function var_0_0.GetMap(arg_6_0)
	return arg_6_0.cfg.map, false
end

function var_0_0.GetAILevel(arg_7_0)
	return arg_7_0.cfg.ai_level or 0
end

function var_0_0.GetEnemyLevel(arg_8_0)
	return arg_8_0.cfg.monster_level or 0
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
	local var_13_0
	local var_13_1 = {}
	local var_13_2 = {}
	local var_13_3 = {}
	local var_13_4 = ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.SOLO_CHALLENGE):GetContDataTemplateById(arg_13_0:GetContID()):GetAffixList(arg_13_0:GetTeamIndex())

	for iter_13_0, iter_13_1 in pairs(var_13_4) do
		if iter_13_1 ~= 0 then
			local var_13_5 = ActivityAffixPoolCfg[iter_13_1].affix

			table.insert(var_13_1, var_13_5[1])
			table.insert(var_13_2, var_13_5[2])
			table.insert(var_13_3, var_13_5[3])
		end
	end

	return var_13_1, var_13_2, var_13_3
end

function var_0_0.GetChipList(arg_14_0)
	return {}
end

return var_0_0
