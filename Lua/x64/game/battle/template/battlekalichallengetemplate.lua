local var_0_0 = class("BattleKaliChallengeTemplate", BattleBaseStageTemplate)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.id = arg_1_1
	arg_1_0.activityID_ = arg_1_2
	arg_1_0.cfg = BattleCoreKaliCfg[arg_1_1]
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitHeroList()
	arg_2_0:InitComboSkillID()
	arg_2_0:InitChipData()
end

function var_0_0.InitChipData(arg_3_0)
	arg_3_0.chipList_ = {}
end

function var_0_0.GetDest(arg_4_0)
	return arg_4_0.id
end

function var_0_0.GetStageId(arg_5_0)
	return arg_5_0.id
end

function var_0_0.GetType(arg_6_0)
	return BattleConst.STAGE_TYPE_NEW.ACTIVITY_SPKALI_CHALLENGE
end

function var_0_0.GetStageAffix(arg_7_0)
	local var_7_0 = ActivityTools.GetMainActivityId(arg_7_0.activityID_)
	local var_7_1 = SPKaliChallengeData:GetSPChallengeData(var_7_0)
	local var_7_2 = {}
	local var_7_3 = {}
	local var_7_4 = {}

	for iter_7_0, iter_7_1 in pairs(var_7_1 and var_7_1.showAffix or {}) do
		local var_7_5 = ActivityAffixPoolCfg[iter_7_1]

		if var_7_5 then
			local var_7_6 = table.indexof(var_7_2, var_7_5.affix[1])

			if not var_7_6 then
				table.insert(var_7_2, var_7_5.affix[1])
				table.insert(var_7_3, var_7_5.affix[2])
				table.insert(var_7_4, var_7_5.affix[3])
			else
				var_7_3[var_7_6] = var_7_3[var_7_6] + var_7_5.affix[2]
			end
		end
	end

	local var_7_7 = SPKaliChallengeData:GetNowAffixEffect(var_7_0)

	if var_7_7 then
		local var_7_8 = ActivitykaliaffixCfg[var_7_7] and ActivitykaliaffixCfg[var_7_7].affix_id or 0
		local var_7_9 = ActivityAffixPoolCfg[var_7_8]

		if var_7_9 then
			local var_7_10 = table.indexof(var_7_2, var_7_9.affix[1])

			if not var_7_10 then
				table.insert(var_7_2, var_7_9.affix[1])
				table.insert(var_7_3, var_7_9.affix[2])
				table.insert(var_7_4, var_7_9.affix[3])
			else
				var_7_3[var_7_10] = var_7_3[var_7_10] + var_7_9.affix[2]
			end
		end
	end

	return var_7_2, var_7_3, var_7_4
end

function var_0_0.GetMap(arg_8_0)
	return arg_8_0.cfg.map, false
end

function var_0_0.GetAILevel(arg_9_0)
	return arg_9_0.cfg.ai_level
end

function var_0_0.GetEnemyLevel(arg_10_0)
	return arg_10_0.cfg.monster_level
end

function var_0_0.GetHeroTeam(arg_11_0)
	return arg_11_0.heroList_, arg_11_0.heroTrialList_
end

function var_0_0.GetLevelID(arg_12_0)
	return arg_12_0.cfg.level
end

function var_0_0.GetMainActivityID(arg_13_0)
	return arg_13_0.activityID_
end

return var_0_0
