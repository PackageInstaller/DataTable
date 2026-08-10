local var_0_0 = singletonClass("CoreVerificationData")
local var_0_1 = {}
local var_0_2 = {}
local var_0_3 = 0
local var_0_4 = 0
local var_0_5 = 0
local var_0_6 = {}
local var_0_7 = {}
local var_0_8 = {}
local var_0_9 = {}
local var_0_10 = {}
local var_0_11 = 0
local var_0_12 = {}
local var_0_13 = {}
local var_0_14 = {}
local var_0_15 = 8

function var_0_0.Init(arg_1_0)
	var_0_1 = {}
	var_0_9 = {}
	var_0_2 = {}
	var_0_6 = {}
	var_0_7 = {}
	var_0_8 = {}
	var_0_10 = {}
	var_0_13 = {}
	var_0_14 = {}
	var_0_3 = 1
	var_0_4 = 2
	var_0_12 = {}

	for iter_1_0, iter_1_1 in pairs(CoreVerificationInfoCfg.get_id_list_by_cycle) do
		var_0_1[iter_1_0] = {}
		var_0_1[iter_1_0][1] = {}
		var_0_1[iter_1_0][2] = {}

		for iter_1_2, iter_1_3 in ipairs(iter_1_1) do
			local var_1_0 = CoreVerificationInfoCfg[iter_1_3]

			var_0_1[iter_1_0][var_1_0.boss_type][var_1_0.difficult] = iter_1_3

			if arg_1_0:IsChallengeType(iter_1_3) then
				var_0_15 = var_1_0.difficult
			end
		end
	end

	var_0_2[1] = {}
	var_0_2[2] = {}
	var_0_2[3] = {}
	var_0_2[4] = {}
	var_0_2[5] = {}

	for iter_1_4, iter_1_5 in pairs(CoreVerificationRewardCfg.all) do
		local var_1_1 = CoreVerificationRewardCfg[iter_1_5]

		if var_1_1.reward_type == 1 or var_1_1.reward_type == 2 then
			if not var_0_2[var_1_1.reward_type][var_1_1.cycle] then
				var_0_2[var_1_1.reward_type][var_1_1.cycle] = {}
			end

			table.insert(var_0_2[var_1_1.reward_type][var_1_1.cycle], iter_1_5)
		else
			table.insert(var_0_2[var_1_1.reward_type], iter_1_5)
		end
	end

	arg_1_0:SetUpdateCycleCallBack()
end

function var_0_0.ResetStage(arg_2_0)
	var_0_7[1] = {}
	var_0_7[2] = {}

	for iter_2_0, iter_2_1 in ipairs(var_0_8) do
		if CoreVerificationRewardCfg[iter_2_1] and CoreVerificationRewardCfg[iter_2_1].reward_type ~= 4 then
			CoreVerificationRewardCfg[iter_2_1] = false
		end
	end

	for iter_2_2, iter_2_3 in pairs(var_0_6) do
		iter_2_3.passState = false
	end

	var_0_9 = {
		0,
		0
	}
end

function var_0_0.ResetHeroInfo(arg_3_0)
	var_0_7[1] = {}
	var_0_7[2] = {}

	for iter_3_0, iter_3_1 in ipairs(var_0_8) do
		if CoreVerificationRewardCfg[iter_3_1] and CoreVerificationRewardCfg[iter_3_1].reward_type ~= 4 then
			CoreVerificationRewardCfg[iter_3_1] = false
		end
	end

	var_0_9 = {
		var_0_15 - 1,
		var_0_15 - 1
	}

	for iter_3_2, iter_3_3 in pairs(var_0_6) do
		if CoreVerificationData:IsChallengeType(iter_3_2) then
			var_0_6[iter_3_2] = {}
		end
	end
end

function var_0_0.UpdateCycleInfo(arg_4_0, arg_4_1)
	var_0_3 = arg_4_1.now_cycle
	var_0_4 = arg_4_1.next_cycle
	var_0_5 = arg_4_1.refresh_timestamp

	for iter_4_0, iter_4_1 in ipairs(arg_4_1.stage_info) do
		var_0_6[iter_4_1.id] = {}
		var_0_6[iter_4_1.id].passState = iter_4_1.sign == 1
		var_0_6[iter_4_1.id].passTime = iter_4_1.sign == 1 and iter_4_1.min_time / 1000 or 3600
	end

	var_0_8 = {}

	for iter_4_2, iter_4_3 in ipairs(arg_4_1.reward_list) do
		var_0_8[iter_4_3] = true
	end

	var_0_7[1] = {}
	var_0_7[2] = {}
	var_0_10 = {}
	var_0_14 = {}
	var_0_12 = {}

	for iter_4_4, iter_4_5 in ipairs(arg_4_1.lock_list) do
		for iter_4_6, iter_4_7 in ipairs(iter_4_5.hero_list) do
			table.insert(var_0_7[iter_4_5.boss_type], iter_4_7)
		end
	end

	var_0_9 = {
		0,
		0
	}

	local var_4_0 = var_0_1[var_0_3][1]
	local var_4_1 = var_0_1[var_0_3][2]

	for iter_4_8, iter_4_9 in ipairs(var_4_0) do
		if var_0_6[iter_4_9] and var_0_6[iter_4_9].passState then
			var_0_9[1] = iter_4_8
		end
	end

	for iter_4_10, iter_4_11 in ipairs(var_4_1) do
		if var_0_6[iter_4_11] and var_0_6[iter_4_11].passState then
			var_0_9[2] = iter_4_10
		end
	end

	for iter_4_12, iter_4_13 in ipairs(arg_4_1.affix_list or {}) do
		if iter_4_13.id and not var_0_10[iter_4_13.id] then
			var_0_10[iter_4_13.id] = {}
		end

		var_0_10[iter_4_13.id] = iter_4_13.affix_list
	end

	for iter_4_14, iter_4_15 in ipairs(arg_4_1.affix_list or {}) do
		if iter_4_15.id and not var_0_10[iter_4_15.id] then
			var_0_10[iter_4_15.id] = {}
		end

		var_0_10[iter_4_15.id] = iter_4_15.affix_list
	end

	local var_4_2 = arg_4_1.max_score_info
	local var_4_3 = 0
	local var_4_4 = var_4_2 and var_4_2.lock_list or {}

	for iter_4_16, iter_4_17 in ipairs(var_4_4) do
		if iter_4_17.boss_type and not var_0_12[iter_4_17.boss_type] then
			var_0_12[iter_4_17.boss_type] = {}
		end

		var_0_12[iter_4_17.boss_type] = iter_4_17
		var_4_3 = var_4_3 + (iter_4_17.score or 0)
	end

	var_0_11 = var_4_3
end

function var_0_0.BattleStageData(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = CoreVerificationInfoCfg[arg_5_1]
	local var_5_1 = var_5_0.boss_type
	local var_5_2 = var_5_0.difficult

	if var_5_2 > var_0_9[var_5_1] then
		var_0_9[var_5_1] = var_5_2
	end

	for iter_5_0, iter_5_1 in ipairs(arg_5_2) do
		if not table.keyof(var_0_7[var_5_1], iter_5_1) then
			table.insert(var_0_7[var_5_1], iter_5_1)
		end
	end

	if var_0_6[var_5_0.id] then
		var_0_6[var_5_0.id].passState = true

		if arg_5_3 < var_0_6[var_5_0.id].passTime then
			var_0_6[var_5_0.id].passTime = arg_5_3
		end
	else
		var_0_6[var_5_0.id] = {}
		var_0_6[var_5_0.id].passState = true
		var_0_6[var_5_0.id].passTime = arg_5_3
	end

	CoreVerificationAction.UpdateRewardRedPoints()
end

function var_0_0.UpdateRewardData(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(arg_6_1.reward_list) do
		var_0_8[iter_6_1] = true
	end
end

function var_0_0.GetBossUICfgByBossType(arg_7_0, arg_7_1)
	local var_7_0 = var_0_1[var_0_3][arg_7_1][1]
	local var_7_1 = CoreVerificationInfoCfg[var_7_0].stage_id

	return BossChallengeUICfg[var_7_1] or BossChallengeUICfg[3090009]
end

function var_0_0.GetRecommendByBossType(arg_8_0, arg_8_1)
	local var_8_0 = var_0_1[var_0_3][arg_8_1][1]

	return CoreVerificationInfoCfg[var_8_0].recommend
end

function var_0_0.GetLockHeroByBossType(arg_9_0, arg_9_1)
	return var_0_7[arg_9_1]
end

function var_0_0.GetDiffListByBossType(arg_10_0, arg_10_1)
	return var_0_1[var_0_3][arg_10_1]
end

function var_0_0.GetLockHeroByInfoID(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = CoreVerificationInfoCfg[arg_11_1].boss_type

	if arg_11_2 then
		return var_0_7[var_11_0]
	elseif var_11_0 == 1 then
		return var_0_7[2]
	elseif var_11_0 == 2 then
		return var_0_7[1]
	end

	return var_0_7[1]
end

function var_0_0.GetMaxPassByBossType(arg_12_0, arg_12_1)
	local var_12_0 = var_0_9[arg_12_1] > 0
	local var_12_1 = var_0_9[arg_12_1] > 0 and var_0_9[arg_12_1] or 1
	local var_12_2 = var_0_1[var_0_3][arg_12_1][var_12_1]
	local var_12_3 = var_12_0 and var_0_6[var_12_2].passTime or 0

	return var_12_0, var_12_1, var_12_3
end

function var_0_0.GetMaxUnlockByBossType(arg_13_0, arg_13_1)
	local var_13_0 = 1
	local var_13_1 = PlayerData:GetPlayerInfo().userLevel

	for iter_13_0, iter_13_1 in ipairs(var_0_1[var_0_3][arg_13_1]) do
		if var_0_6[iter_13_1 - 1] and var_13_1 >= CoreVerificationInfoCfg[iter_13_1].unlock_level then
			if arg_13_0:IsChallengeType(iter_13_1) then
				if arg_13_0:IsOpenChallge() then
					var_13_0 = iter_13_0
				end
			else
				var_13_0 = iter_13_0
			end
		end
	end

	return var_13_0
end

function var_0_0.GetStageInfoByTypeAndDiff(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = var_0_1[var_0_3][arg_14_1][arg_14_2]

	return var_0_6[var_14_0]
end

function var_0_0.GetInfoCfgByTypeAndDiff(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = var_0_1[var_0_3][arg_15_1][arg_15_2]

	return CoreVerificationInfoCfg[var_15_0]
end

function var_0_0.GetAffixByTypeAndDiff(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = var_0_1[var_0_3][arg_16_1][arg_16_2]

	return CoreVerificationInfoCfg[var_16_0].affix_type
end

function var_0_0.GetRewardListByType(arg_17_0, arg_17_1)
	if arg_17_1 == 1 or arg_17_1 == 2 then
		return var_0_2[arg_17_1][var_0_3]
	else
		return var_0_2[arg_17_1]
	end
end

function var_0_0.CheckFirstReward(arg_18_0)
	local var_18_0 = var_0_2[4]

	for iter_18_0, iter_18_1 in ipairs(var_18_0) do
		if not var_0_8[iter_18_1] then
			return "true"
		end
	end

	return "false"
end

function var_0_0.GetCanReset(arg_19_0)
	for iter_19_0, iter_19_1 in pairs(var_0_8) do
		if CoreVerificationRewardCfg[iter_19_0].reward_type ~= 4 and iter_19_1 then
			return false
		end
	end

	return true
end

function var_0_0.CheckCycleReward(arg_20_0)
	for iter_20_0, iter_20_1 in pairs(var_0_2) do
		for iter_20_2, iter_20_3 in pairs(iter_20_1) do
			if type(iter_20_3) == "table" and iter_20_2 == var_0_3 then
				for iter_20_4, iter_20_5 in pairs(iter_20_3) do
					if not var_0_8[iter_20_5] then
						return true
					end
				end
			elseif type(iter_20_3) == "number" and not var_0_8[iter_20_3] then
				return true
			end
		end
	end

	return false
end

function var_0_0.GetCurCycleInfo(arg_21_0)
	return var_0_1[var_0_3]
end

function var_0_0.GetPreviewInfo(arg_22_0)
	return var_0_1[var_0_4]
end

function var_0_0.GetRefreshTime(arg_23_0)
	return var_0_5
end

function var_0_0.GetTaskProcess(arg_24_0, arg_24_1)
	local var_24_0 = CoreVerificationRewardCfg[arg_24_1].condition
	local var_24_1 = ConditionCfg[var_24_0]
	local var_24_2 = 0

	if var_24_1.type == 11300 then
		local var_24_3 = var_24_1.params[1]

		var_24_2 = var_24_1.params[2] <= var_0_9[var_24_3] and 1 or 0
	elseif var_24_1.type == 11302 then
		local var_24_4 = var_24_1.params[1]

		var_24_2 = var_24_4 <= var_0_9[1] and var_24_4 <= var_0_9[2] and 1 or 0
	elseif var_24_1.type == 11301 then
		local var_24_5 = var_24_1.params[1]
		local var_24_6 = var_0_1[var_0_3][1][var_24_5]
		local var_24_7 = var_0_1[var_0_3][2][var_24_5]

		var_24_2 = var_0_6[var_24_6] and var_0_6[var_24_7] and 1 or 0
	elseif var_24_1.type == 11303 then
		local var_24_8 = var_24_1.params[1]
		local var_24_9 = var_24_1.params[2]
		local var_24_10 = var_0_1[var_0_3][var_24_8][var_24_9]

		var_24_2 = var_0_6[var_24_10] and 1 or 0
	end

	return var_24_2, var_24_1.progress_show, var_24_2 == 1, var_0_8[arg_24_1] or false
end

function var_0_0.IsStageProcess(arg_25_0)
	return var_0_9[1] > 0 or var_0_9[2] > 0
end

local var_0_16

function var_0_0.SetUpdateCycleCallBack(arg_26_0)
	function var_0_16()
		ShowTips("STAGE_REFRESH_DATA")
		JumpTools.GoToSystem("/coreVerificationMain", nil, ViewConst.SYSTEM_ID.CORE_VERIFICATION)
	end
end

function var_0_0.InvokeUpdateCycleCallBack(arg_28_0)
	if var_0_16 then
		var_0_16()

		var_0_16 = nil
	end
end

function var_0_0.IsChallengeType(arg_29_0, arg_29_1)
	return CoreVerificationInfoCfg[arg_29_1] and CoreVerificationInfoCfg[arg_29_1].stage_type == 1 or false
end

function var_0_0.GetStageIdByTypeAndDiff(arg_30_0, arg_30_1, arg_30_2)
	return var_0_1[var_0_3][arg_30_1][arg_30_2] or 0
end

function var_0_0.GetSuffixList(arg_31_0, arg_31_1)
	if CoreVerificationInfoCfg[arg_31_1] and CoreVerificationInfoCfg[arg_31_1].affix_pool ~= "" then
		return CoreVerificationInfoCfg[arg_31_1].affix_pool
	end

	return {}
end

function var_0_0.GetRecordSuffixList(arg_32_0, arg_32_1)
	return var_0_10[arg_32_1] or {}
end

function var_0_0.GetRecordSuffixIndexList(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_0:GetRecordSuffixList(arg_33_1)
	local var_33_1 = arg_33_0:GetSuffixList(arg_33_1)
	local var_33_2 = {}

	for iter_33_0, iter_33_1 in ipairs(var_33_1) do
		var_33_2[iter_33_0] = 0

		if #iter_33_1 ~= 1 then
			for iter_33_2, iter_33_3 in ipairs(iter_33_1) do
				if table.indexof(var_33_0, iter_33_3) then
					var_33_2[iter_33_0] = iter_33_2
				end
			end
		end
	end

	return var_33_2
end

function var_0_0.GetMaxScore(arg_34_0)
	return var_0_11
end

function var_0_0.GetMaxScoreHeroInfo(arg_35_0, arg_35_1)
	return var_0_12[arg_35_1] or {}
end

function var_0_0.UpdateSuperScore(arg_36_0, arg_36_1)
	var_0_13[tonumber(arg_36_1.id)] = arg_36_1.score
end

function var_0_0.GetSuperScore(arg_37_0, arg_37_1)
	return var_0_13[arg_37_1] or 0
end

function var_0_0.IsOpenChallge(arg_38_0)
	local var_38_0 = arg_38_0:GetStageInfoByTypeAndDiff(1, var_0_15 - 1)
	local var_38_1 = arg_38_0:GetStageInfoByTypeAndDiff(2, var_0_15 - 1)

	return var_38_0 and var_38_1 and var_38_0.passState and var_38_1.passState
end

function var_0_0.IsPassChallengeChallge(arg_39_0, arg_39_1)
	local var_39_0 = arg_39_0:GetStageInfoByTypeAndDiff(arg_39_1, var_0_15)
	local var_39_1 = var_0_1[var_0_3][arg_39_1][var_0_15] or 0

	return var_39_0 and var_39_0.passState and arg_39_0:IsChallengeType(var_39_1)
end

function var_0_0.IsOpenChallgeByType(arg_40_0, arg_40_1)
	local var_40_0 = arg_40_0:GetStageInfoByTypeAndDiff(arg_40_1, var_0_15 - 1)

	return var_40_0 and var_40_0.passState
end

function var_0_0.OnSaveSuffix(arg_41_0, arg_41_1)
	var_0_14 = {}
	var_0_14 = arg_41_1.affix_info and arg_41_1.affix_info.affix_list
end

function var_0_0.GetSelectSuffix(arg_42_0)
	return var_0_14 or {}
end

return var_0_0
