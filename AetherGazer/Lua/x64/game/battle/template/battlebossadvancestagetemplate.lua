local var_0_0 = class("BattleBossAdvanceStageTemplate", BattleBaseStageTemplate)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.id = arg_1_1
	arg_1_0.cfg = BattleBossStageCfg[arg_1_0.id]
	arg_1_0.bossIndex_ = arg_1_2
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
	return BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE_ADVANCE
end

function var_0_0.GetMap(arg_6_0)
	return arg_6_0.cfg.map, false
end

function var_0_0.GetAILevel(arg_7_0)
	return arg_7_0.cfg.ai_level
end

function var_0_0.GetEnemyLevel(arg_8_0)
	return BossChallengeAdvanceCfg[BattleBossChallengeAdvanceData:GetChooseModeID()].monster_level
end

function var_0_0.GetHeroTeam(arg_9_0)
	return arg_9_0.heroList_, arg_9_0.heroTrialList_
end

function var_0_0.GetStageAffix(arg_10_0)
	local var_10_0 = {}
	local var_10_1 = {}
	local var_10_2 = {}
	local var_10_3 = BattleBossChallengeAdvanceData:GetBossAffixList(arg_10_0.bossIndex_, BossConst.TYPE_AFFIX)

	for iter_10_0, iter_10_1 in pairs(var_10_3) do
		local var_10_4 = ActivityAffixPoolCfg[iter_10_1].affix

		table.insert(var_10_0, var_10_4[1])
		table.insert(var_10_1, var_10_4[2])
		table.insert(var_10_2, var_10_4[3])
	end

	local var_10_5 = BossTools.GetBossID(arg_10_0:GetType(), arg_10_0.bossIndex_)
	local var_10_6 = BossChallengeUICfg[var_10_5]

	table.insert(var_10_0, var_10_6.custom_affix[1])
	table.insert(var_10_1, var_10_6.custom_affix[2])
	table.insert(var_10_2, var_10_6.custom_affix[3])

	return var_10_0, var_10_1, var_10_2
end

function var_0_0.GetAttributeFactor(arg_11_0)
	local var_11_0 = BattleBossChallengeAdvanceData:GetChooseModeID()
	local var_11_1 = BattleBossChallengeAdvanceData:GetBossList()[arg_11_0.bossIndex_].multipleIndex
	local var_11_2 = BossChallengeAdvanceCfg[var_11_0].monster_value[var_11_1]
	local var_11_3 = var_11_2[1] / 1000
	local var_11_4 = var_11_2[2] / 1000
	local var_11_5 = var_11_2[3] / 1000

	return Vector3.New(var_11_3, var_11_4, var_11_5)
end

function var_0_0.GetServerExtant(arg_12_0)
	return BattleBossChallengeAdvanceData:GetBossList()[arg_12_0.bossIndex_].id
end

function var_0_0.GetBossIndex(arg_13_0)
	return arg_13_0.bossIndex_
end

return var_0_0
