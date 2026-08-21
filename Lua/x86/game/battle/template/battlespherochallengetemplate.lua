local var_0_0 = class("BattleSPHeroChallengeTemplate", BattleBaseStageTemplate)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.id = arg_1_1
	arg_1_0.activityID_ = arg_1_2
	arg_1_0.cfg = BattleVerthandiExclusiveCfg[arg_1_1]
end

function var_0_0.Init(arg_2_0)
	arg_2_0.heroList_ = arg_2_0.cfg.hero_list
	arg_2_0.systemHeroList = {}

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
	return BattleConst.STAGE_TYPE_NEW.SP_HERO_CHALLENGE_BATTLE_3_1
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

function var_0_0.GetAttributeFactor(arg_13_0)
	local var_13_0 = arg_13_0.cfg

	if var_13_0.attribute_factor and var_13_0.attribute_factor[3] then
		local var_13_1 = var_13_0.attribute_factor[1] / 1000
		local var_13_2 = var_13_0.attribute_factor[2] / 1000
		local var_13_3 = var_13_0.attribute_factor[3] / 1000

		return Vector3.New(var_13_1, var_13_2, var_13_3)
	end

	return Vector3.New(1, 1, 1)
end

function var_0_0.GetStageAffix(arg_14_0)
	local var_14_0 = {}
	local var_14_1 = {}
	local var_14_2 = {}
	local var_14_3 = {}
	local var_14_4 = SPHeroChallengeData:GetCurActivityInfo()
	local var_14_5 = SPHeroChallengeData:GetActivityID()
	local var_14_6 = SPHeroChallengeTools:GetUnlockChapterAffix()

	for iter_14_0, iter_14_1 in pairs(var_14_6 or {}) do
		table.insert(var_14_1, iter_14_1[1])
		table.insert(var_14_2, iter_14_1[2])
		table.insert(var_14_3, iter_14_1[3])
	end

	local var_14_7 = SPHeroChallengeTools:GetUnlockAffix()

	for iter_14_2, iter_14_3 in pairs(var_14_7 or {}) do
		local var_14_8 = ActivityAffixPoolCfg[iter_14_3]

		if var_14_8 then
			table.insert(var_14_1, var_14_8.affix[1])
			table.insert(var_14_2, var_14_8.affix[2])
			table.insert(var_14_3, var_14_8.affix[3])
		end
	end

	if arg_14_0.cfg.sub_type == SpHeroChallengeConst.BattleSubType.boss and var_14_4 then
		local var_14_9 = var_14_4:GetBossErosiveness()
		local var_14_10 = ActivityHeroChallengeCfg[var_14_5].affix_defense

		if var_14_10 then
			table.insert(var_14_1, var_14_10[1])
			table.insert(var_14_2, var_14_9 + 1)
			table.insert(var_14_3, var_14_10[3])
		end
	end

	return var_14_1, var_14_2, var_14_3
end

return var_0_0
