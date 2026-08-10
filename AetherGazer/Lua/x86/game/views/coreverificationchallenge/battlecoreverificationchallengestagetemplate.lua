BattleBaseStageTemplate = import("game.battle.template.BattleBaseStageTemplate")

local var_0_0 = class("BattleCoreVerificationChallengeStageTemplate", BattleBaseStageTemplate)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.id = arg_1_1
	arg_1_0.activityID_ = arg_1_2

	local var_1_0 = CoreVerificationChallengeTools.GetBattleClCfg(arg_1_2)

	arg_1_0.cfg = nullable(var_1_0, arg_1_0.id)
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
	return CoreVerificationChallengeTools.GetBattleStageType(arg_5_0.activityID_)
end

function var_0_0.GetMap(arg_6_0)
	return arg_6_0.cfg.map, false
end

function var_0_0.GetAILevel(arg_7_0)
	return arg_7_0.cfg.ai_level
end

function var_0_0.GetEnemyLevel(arg_8_0)
	return arg_8_0.cfg.monster_level
end

function var_0_0.GetHeroTeam(arg_9_0)
	return arg_9_0.heroList_, arg_9_0.heroTrialList_
end

function var_0_0.GetStageAffix(arg_10_0)
	local var_10_0 = {}
	local var_10_1 = {}
	local var_10_2 = {}
	local var_10_3 = {}
	local var_10_4 = CoreVerificationChallengeTools.GetModeCfg()
	local var_10_5 = var_10_4[arg_10_0.id].stage_type
	local var_10_6 = CoreVerificationChallengeTools.GetModeIndex()
	local var_10_7 = var_10_4[arg_10_0.id].stage_com_affix

	for iter_10_0, iter_10_1 in pairs(var_10_7 or {}) do
		local var_10_8 = ActivityAffixPoolCfg[iter_10_1].affix

		table.insert(var_10_3, var_10_8)
	end

	local var_10_9 = var_10_4[arg_10_0.id].stage_affix

	for iter_10_2, iter_10_3 in pairs(var_10_9 or {}) do
		local var_10_10 = ActivityAffixPoolCfg[iter_10_3].affix

		table.insert(var_10_3, var_10_10)
	end

	if var_10_6 == 1 then
		if var_10_5 == 1 then
			local var_10_11 = var_10_4[arg_10_0.id].stage_buff

			for iter_10_4, iter_10_5 in pairs(var_10_11 or {}) do
				local var_10_12 = ActivityAffixPoolCfg[iter_10_5[1]].affix

				var_10_12[2] = CoreVerificationChallengeData:GetBuffLevelById(affixId)

				table.insert(var_10_3, var_10_12)
			end

			local var_10_13 = var_10_4[arg_10_0.id].stage_debuff

			for iter_10_6, iter_10_7 in pairs(var_10_13 or {}) do
				local var_10_14 = ActivityAffixPoolCfg[iter_10_7[1]].affix

				var_10_14[2] = var_10_14[2] == 50 and 1 or var_10_14[2]

				table.insert(var_10_3, var_10_14)
			end
		else
			local var_10_15 = CoreVerificationChallengeData:GetSelectAffixs()

			for iter_10_8, iter_10_9 in pairs(var_10_15 or {}) do
				local var_10_16 = ActivityAffixPoolCfg[iter_10_9.buff_id].affix

				var_10_16[2] = CoreVerificationChallengeData:GetBuffLevelById(iter_10_9.buff_id)

				table.insert(var_10_3, var_10_16)
			end
		end
	elseif var_10_6 == 2 then
		if var_10_5 == 1 then
			local var_10_17 = var_10_4[arg_10_0.id].stage_buff

			for iter_10_10, iter_10_11 in pairs(var_10_17 or {}) do
				local var_10_18 = ActivityAffixPoolCfg[iter_10_11].affix

				table.insert(var_10_3, var_10_18)
			end
		else
			local var_10_19 = CoreVerificationChallengeMode2Data:GetSelectAffixs()

			for iter_10_12, iter_10_13 in pairs(var_10_19 or {}) do
				local var_10_20 = ActivityAffixPoolCfg[iter_10_13.buff_id].affix

				table.insert(var_10_3, var_10_20)
			end
		end
	else
		local var_10_21 = var_10_4[arg_10_0.id].type_affix

		for iter_10_14, iter_10_15 in pairs(var_10_21 or {}) do
			local var_10_22 = ActivityAffixPoolCfg[iter_10_15].affix

			table.insert(var_10_3, var_10_22)
		end
	end

	for iter_10_16, iter_10_17 in pairs(var_10_3 or {}) do
		table.insert(var_10_0, iter_10_17[1])
		table.insert(var_10_1, iter_10_17[2] == 50 and 1 or iter_10_17[2])
		table.insert(var_10_2, iter_10_17[3])
	end

	return var_10_0, var_10_1, var_10_2
end

function var_0_0.GetOpts(arg_11_0)
	local var_11_0 = {}
	local var_11_1 = CoreVerificationChallengeTools.GetModeIndex()
	local var_11_2 = {}

	if var_11_1 == 1 then
		var_11_2 = CoreVerificationChallengeData:GetSelectAffixs()
	elseif var_11_1 == 2 then
		var_11_2 = CoreVerificationChallengeMode2Data:GetSelectAffixs()
	end

	local var_11_3 = {}

	for iter_11_0, iter_11_1 in ipairs(var_11_2 or {}) do
		table.insert(var_11_3, iter_11_1.buff_id)
	end

	local var_11_4 = {
		key = 1,
		value = var_11_3
	}
	local var_11_5 = {
		key = 2,
		value = {
			arg_11_0:GetTeamIndex()
		}
	}

	table.insert(var_11_0, var_11_4)
	table.insert(var_11_0, var_11_5)

	return var_11_0
end

return var_0_0
