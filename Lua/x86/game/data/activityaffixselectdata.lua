local var_0_0 = singletonClass("ActivityAffixSelectData")
local var_0_1 = {}
local var_0_2 = {}
local var_0_3 = {}

function var_0_0.Init(arg_1_0)
	var_0_1 = {}
	var_0_2 = {}
	var_0_3 = {}
end

function var_0_0.OnPushMainActivityData(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.activity_id
	local var_2_1 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.got_reward_list) do
		table.insert(var_2_1, iter_2_1)
	end

	var_0_1[var_2_0] = {
		got_reward_list = var_2_1
	}

	manager.notify:Invoke(AFFIX_SELECT_MAIN_ACTIVITY_UPDATE, {})
end

function var_0_0.OnPushSubActivityData(arg_3_0, arg_3_1)
	local var_3_0 = {
		activityId = arg_3_1.activity_id,
		clearState = arg_3_1.first_clear_reward_apply_state,
		clickState = arg_3_1.first_clear_reward_apply_state == 1 and 1 or 0,
		affixList = {},
		point = arg_3_1.point
	}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.custom_affix_list) do
		table.insert(var_3_0.affixList, iter_3_1)
	end

	var_0_2[arg_3_1.activity_id] = var_3_0

	manager.notify:Invoke(AFFIX_SELECT_SUB_ACTIVITY_UPDATE, {})
end

function var_0_0.GetClearState(arg_4_0, arg_4_1)
	local var_4_0 = var_0_2[arg_4_1]

	if not var_4_0 then
		error("找不到对应的活动，未开启")

		return 0
	end

	return var_4_0.clearState
end

function var_0_0.HaveGotScoreReward(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = var_0_1[arg_5_1] and var_0_1[arg_5_1].got_reward_list or {}

	if not table.indexof(var_5_0, arg_5_2) then
		return false
	end

	return true
end

function var_0_0.OnGetFirstBonus(arg_6_0, arg_6_1)
	local var_6_0 = var_0_2[arg_6_1]

	if not var_6_0 then
		error("找不到对应的活动，未开启")
	end

	var_6_0.clearState = 3

	manager.notify:Invoke(AFFIX_SELECT_FIRST_BONUS_UPDATE, arg_6_1)
end

function var_0_0.OnSetAffix(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = var_0_2[arg_7_1]

	if not var_7_0 then
		error("找不到对应的活动，未开启")
	end

	var_7_0.affixList = arg_7_2

	manager.notify:Invoke(AFFIX_SELECT_CUSTOM_AFFIX_UPDATE, arg_7_1)
end

function var_0_0.GetSubActivityData(arg_8_0, arg_8_1)
	return var_0_2[arg_8_1]
end

function var_0_0.GetAllFirstRewards(arg_9_0)
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in pairs(var_0_2) do
		if iter_9_1.clearState == 2 then
			table.insert(var_9_0, iter_9_0)
		end
	end

	return var_9_0
end

function var_0_0.GetOpenedSubActivityDatas(arg_10_0, arg_10_1)
	local var_10_0 = {}
	local var_10_1 = ActivityCfg[arg_10_1]

	for iter_10_0, iter_10_1 in ipairs(var_10_1.sub_activity_list) do
		table.insert(var_10_0, var_0_2[iter_10_1])
	end

	return var_10_0
end

function var_0_0.GetGodRewardList(arg_11_0, arg_11_1)
	return var_0_1[arg_11_1] and var_0_1[arg_11_1].got_reward_list or {}
end

function var_0_0.GetCurrentActivityReward(arg_12_0, arg_12_1)
	local var_12_0 = ActivityPointRewardCfg.get_id_list_by_activity_id[arg_12_1]

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		local var_12_1 = arg_12_0:GetRewardStatus(arg_12_1, iter_12_1)

		if var_12_1 == 1 or var_12_1 == 2 then
			return iter_12_1
		end
	end

	return var_12_0[#var_12_0]
end

function var_0_0.ScoreRewardGetCount(arg_13_0, arg_13_1)
	return #(var_0_1[arg_13_1] and var_0_1[arg_13_1].got_reward_list or {})
end

function var_0_0.GetTotalScore(arg_14_0, arg_14_1)
	local var_14_0 = 0
	local var_14_1 = ActivityCfg[arg_14_1]

	for iter_14_0, iter_14_1 in ipairs(var_14_1.sub_activity_list) do
		if var_0_2[iter_14_1] then
			var_14_0 = var_14_0 + var_0_2[iter_14_1].point
		end
	end

	return var_14_0
end

function var_0_0.GetLevelScore(arg_15_0, arg_15_1)
	local var_15_0 = ActivityAffixSelectCfg[arg_15_1].base_point
	local var_15_1 = var_0_2[arg_15_1]

	for iter_15_0, iter_15_1 in ipairs(var_15_1.affixList) do
		var_15_0 = var_15_0 + ActivityAffixPoolCfg[iter_15_1].point
	end

	return var_15_0
end

function var_0_0.GetRewardStatus(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = false
	local var_16_1 = var_0_1[arg_16_1] and var_0_1[arg_16_1].got_reward_list or {}

	if table.indexof(var_16_1, arg_16_2) then
		var_16_0 = true
	end

	if var_16_0 then
		return 3
	end

	local var_16_2 = ActivityPointRewardCfg[arg_16_2]

	if arg_16_0:GetTotalScore(arg_16_1) >= var_16_2.need then
		return 2
	end

	return 1
end

function var_0_0.OnScoreRewardGet(arg_17_0, arg_17_1)
	for iter_17_0, iter_17_1 in ipairs(arg_17_1) do
		local var_17_0 = ActivityPointRewardCfg[iter_17_1].activity_id

		if var_0_1[var_17_0] and not table.indexof(var_0_1[var_17_0].got_reward_list, iter_17_1) then
			table.insert(var_0_1[var_17_0].got_reward_list, iter_17_1)
		end
	end
end

function var_0_0.GetAffix(arg_18_0, arg_18_1)
	local var_18_0 = ActivityAffixSelectCfg[arg_18_1].boss_affix
	local var_18_1 = {}

	table.insert(var_18_1, var_18_0)

	local var_18_2 = var_0_2[arg_18_1]

	if var_18_2 then
		local var_18_3 = var_18_2.affixList

		for iter_18_0, iter_18_1 in ipairs(var_18_3) do
			local var_18_4 = ActivityAffixPoolCfg[iter_18_1]

			table.insert(var_18_1, var_18_4.affix)
		end
	end

	return var_18_1
end

function var_0_0.ReadInnerRedPoint(arg_19_0, arg_19_1)
	var_0_3[arg_19_1] = true
end

function var_0_0.HaveReadInnerPoint(arg_20_0, arg_20_1)
	return var_0_3[arg_20_1] ~= nil
end

function var_0_0.SetClickState(arg_21_0, arg_21_1)
	local var_21_0 = var_0_2[arg_21_1]

	if not var_21_0 then
		error("找不到对应的活动，未开启")
	end

	var_21_0.clickState = 0
end

return var_0_0
