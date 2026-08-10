local var_0_0 = singletonClass("ActivityWaterData")
local var_0_1 = {}
local var_0_2 = {}
local var_0_3 = {}

function var_0_0.Init(arg_1_0)
	var_0_1 = {}
end

function var_0_0.ParseCompetitionData(arg_2_0, arg_2_1)
	return {
		competition_id = arg_2_1.competition_id,
		assistance_process = arg_2_1.assistance_process
	}
end

function var_0_0.ParseHistoryScheduleData(arg_3_0, arg_3_1)
	local var_3_0 = {
		schedule_id = arg_3_1.schedule_id,
		competition_list = {},
		selected_contestant_id = arg_3_1.selected_contestant_id,
		is_success = arg_3_1.is_success,
		got_process_reward_id_list = {},
		is_got_success_reward = arg_3_1.is_got_success_reward
	}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.competition_list) do
		local var_3_1 = arg_3_0:ParseCompetitionData(iter_3_1)

		table.insert(var_3_0.competition_list, var_3_1)
	end

	table.insertto(var_3_0.got_process_reward_id_list, arg_3_1.got_process_reward_id_list, 1)

	return var_3_0
end

function var_0_0.ParseCurrentScheduleData(arg_4_0, arg_4_1)
	local var_4_0 = {
		schedule_id = arg_4_1.schedule_id,
		competition_list = {},
		is_click = arg_4_1.is_click,
		selected_contestant_id = arg_4_1.selected_contestant_id,
		got_process_reward_id_list = {}
	}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1.competition_list) do
		local var_4_1 = arg_4_0:ParseCompetitionData(iter_4_1)

		table.insert(var_4_0.competition_list, var_4_1)
	end

	table.insertto(var_4_0.got_process_reward_id_list, arg_4_1.got_process_reward_id_list, 1)

	return var_4_0
end

function var_0_0.InitFromServerData(arg_5_0, arg_5_1)
	var_0_1[arg_5_1.activity_id] = {
		activity_id = arg_5_1.activity_id,
		contribution_value = arg_5_1.contribution_value,
		got_contribution_reward_id_list = {},
		current_schedule = arg_5_0:ParseCurrentScheduleData(arg_5_1.current_schedule),
		history_schedule_list = {},
		history_schedule_dic = {},
		open_stage_id = arg_5_1.open_stage_id,
		open_online_stage_id = arg_5_1.open_online_stage_id
	}

	for iter_5_0, iter_5_1 in ipairs(arg_5_1.history_schedule_list) do
		local var_5_0 = arg_5_0:ParseHistoryScheduleData(iter_5_1)

		table.insert(var_0_1[arg_5_1.activity_id].history_schedule_list, var_5_0)

		var_0_1[arg_5_1.activity_id].history_schedule_dic[iter_5_1.schedule_id] = var_5_0
	end

	table.insertto(var_0_1[arg_5_1.activity_id].got_contribution_reward_id_list, arg_5_1.got_contribution_reward_id_list)
end

function var_0_0.GetHistoryList(arg_6_0, arg_6_1, arg_6_2)
	if not var_0_1[arg_6_1] then
		return {}
	end

	local var_6_0 = clone(var_0_1[arg_6_1].history_schedule_list)

	if arg_6_2 and var_0_1[arg_6_1].current_schedule ~= nil and var_0_1[arg_6_1].current_schedule.schedule_id ~= 0 then
		table.insert(var_6_0, var_0_1[arg_6_1].current_schedule)
	end

	return var_6_0
end

function var_0_0.GetHistoryData(arg_7_0, arg_7_1)
	local var_7_0 = ActivityWaterCfg[arg_7_1].activity_id
	local var_7_1 = ActivityCfg.get_id_list_by_sub_activity_list[var_7_0][1]

	if not var_0_1[var_7_1] then
		return nil
	end

	return var_0_1[var_7_1].history_schedule_dic[arg_7_1]
end

function var_0_0.GetCurrentSchedule(arg_8_0, arg_8_1)
	local var_8_0 = var_0_1[arg_8_1]

	if not var_8_0 then
		return nil
	end

	return var_8_0.current_schedule
end

function var_0_0.GetCurrentScheduleActivityId(arg_9_0, arg_9_1)
	local var_9_0 = var_0_1[arg_9_1]

	if not var_9_0 then
		return nil
	end

	return ActivityWaterCfg[var_9_0.current_schedule.schedule_id].activity_id
end

function var_0_0.OnChallengeSuccess(arg_10_0, arg_10_1, arg_10_2)
	if not var_0_3[arg_10_1] then
		var_0_3[arg_10_1] = {}
	end

	for iter_10_0, iter_10_1 in ipairs(arg_10_2) do
		local var_10_0 = {
			uid = iter_10_1.uid,
			dataDic = {}
		}

		for iter_10_2, iter_10_3 in ipairs(iter_10_1.data_list) do
			var_10_0.dataDic[iter_10_3.key] = iter_10_3.value
		end

		var_0_3[arg_10_1][tostring(iter_10_1.uid)] = var_10_0
	end
end

function var_0_0.GetSettlePlayer(arg_11_0, arg_11_1, arg_11_2)
	if not var_0_1[arg_11_1] then
		return nil
	end

	return var_0_3[arg_11_1][tostring(arg_11_2)]
end

function var_0_0.IsFirstEnter(arg_12_0, arg_12_1)
	if not var_0_1[arg_12_1] then
		return false
	end

	if var_0_1[arg_12_1].current_schedule.schedule_id == 0 then
		return false
	end

	return not var_0_1[arg_12_1].current_schedule.is_click
end

function var_0_0.OnClickEnd(arg_13_0, arg_13_1)
	var_0_1[arg_13_1].current_schedule.is_click = true
end

function var_0_0.OnStageRefresh(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	var_0_1[arg_14_1].open_stage_id = arg_14_2
	var_0_1[arg_14_1].open_online_stage_id = arg_14_3
end

function var_0_0.OnSelectAssistantRole(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = ActivityWaterCfg[arg_15_1].activity_id
	local var_15_1 = ActivityCfg.get_id_list_by_sub_activity_list[var_15_0][1]

	var_0_1[var_15_1].current_schedule.selected_contestant_id = arg_15_2

	manager.notify:Invoke(ACTIVITY_WATER_COMPETITION_UPDATE, arg_15_2)
end

function var_0_0.OnGetSelfAssistantReward(arg_16_0, arg_16_1, arg_16_2)
	table.insertto(var_0_1[arg_16_1].got_contribution_reward_id_list, arg_16_2)
	manager.notify:Invoke(ACTIVITY_WATER_SELF_ASSISTANT_REWARD_UPDATE, {})
end

function var_0_0.OnGetTotalAssistantReward(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = ActivityWaterCfg[arg_17_1].activity_id
	local var_17_1 = ActivityCfg.get_id_list_by_sub_activity_list[var_17_0][1]

	table.insertto(var_0_1[var_17_1].current_schedule.got_process_reward_id_list, arg_17_3)
	manager.notify:Invoke(ACTIVITY_WATER_TOTAL_ASSISTANT_REWARD_UPDATE, {})
end

function var_0_0.OnGetWinReward(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0:GetHistoryData(arg_18_1)

	if not var_18_0 then
		return
	end

	var_18_0.is_got_success_reward = true

	manager.notify:Invoke(ACTIVITY_WATER_WIN_REWARD_UPDATE, {})
end

function var_0_0.HaveGotHistoryReward(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0:GetHistoryData(arg_19_1)

	if not var_19_0 then
		return false
	end

	return var_19_0.is_got_success_reward
end

function var_0_0.GetContributionValue(arg_20_0, arg_20_1)
	local var_20_0 = var_0_1[arg_20_1]

	if not var_20_0 then
		return 0
	end

	return var_20_0.contribution_value
end

function var_0_0.GetCurrentContributeIndex(arg_21_0, arg_21_1)
	local var_21_0 = var_0_1[arg_21_1]

	if not var_21_0 then
		return 1, false
	end

	local var_21_1 = var_21_0.got_contribution_reward_id_list
	local var_21_2 = ActivityPointRewardCfg.get_id_list_by_activity_id[arg_21_1]

	for iter_21_0, iter_21_1 in ipairs(var_21_2) do
		if table.indexof(var_21_1, iter_21_1) then
			-- block empty
		else
			return iter_21_0, false
		end
	end

	return #var_21_2, true
end

function var_0_0.GetCurrentContributeCfg(arg_22_0, arg_22_1)
	local var_22_0, var_22_1 = arg_22_0:GetCurrentContributeIndex(arg_22_1)

	return ActivityPointRewardCfg.get_id_list_by_activity_id[arg_22_1][var_22_0], var_22_1
end

function var_0_0.GetCurrentCompetition(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = var_0_1[arg_23_1]

	if not var_23_0 then
		return 0
	end

	return var_23_0.current_schedule.competition_list[arg_23_2]
end

function var_0_0.HaveSelectAssistantRole(arg_24_0, arg_24_1)
	return arg_24_0:GetCurrentAssistantRole(arg_24_1) > 0
end

function var_0_0.GetCurrentAssistantRole(arg_25_0, arg_25_1)
	local var_25_0 = var_0_1[arg_25_1]

	if not var_25_0 then
		return 0
	end

	return var_25_0.current_schedule.selected_contestant_id
end

function var_0_0.GetCurrentAssistantRoleProcess(arg_26_0, arg_26_1)
	local var_26_0 = var_0_1[arg_26_1]

	if not var_26_0 then
		return 0
	end

	local var_26_1 = arg_26_0:GetCurrentAssistantRole(arg_26_1)

	for iter_26_0, iter_26_1 in ipairs(var_26_0.current_schedule.competition_list) do
		if iter_26_1.competition_id == var_26_1 then
			return iter_26_1.assistance_process
		end
	end

	return 0
end

function var_0_0.GetCurrentAssistantIndex(arg_27_0, arg_27_1)
	local var_27_0 = var_0_1[arg_27_1]

	if not var_27_0 then
		return 0
	end

	local var_27_1 = arg_27_0:GetCurrentAssistantRole(arg_27_1)

	for iter_27_0, iter_27_1 in ipairs(var_27_0.current_schedule.competition_list) do
		if iter_27_1.competition_id == var_27_1 then
			return iter_27_0
		end
	end

	return 0
end

function var_0_0.GetCurrentAssistantRoleStageId(arg_28_0, arg_28_1)
	local var_28_0 = var_0_1[arg_28_1]

	if not var_28_0 then
		return 0
	end

	return var_28_0.open_stage_id
end

function var_0_0.GetOnlineStageId(arg_29_0, arg_29_1)
	local var_29_0 = var_0_1[arg_29_1]

	if not var_29_0 then
		return 0
	end

	return var_29_0.open_online_stage_id
end

function var_0_0.GetTrialHeroList(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_0:GetCurrentAssistantRole(arg_30_1)

	return var_0_2[var_30_0] or {
		0,
		0,
		0
	}
end

function var_0_0.SetHeroTeam(arg_31_0, arg_31_1, arg_31_2)
	var_0_2[arg_31_1] = arg_31_2
end

function var_0_0.IsOppositeRole(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = arg_32_0:GetOppositeHeroId(arg_32_1, arg_32_2)

	return arg_32_2 == var_32_0, var_32_0
end

function var_0_0.GetOppositeHeroId(arg_33_0, arg_33_1)
	local var_33_0 = var_0_1[arg_33_1]

	if not var_33_0 then
		return 0
	end

	local var_33_1 = 3 - arg_33_0:GetCurrentAssistantIndex(arg_33_1)
	local var_33_2 = var_33_0.current_schedule.competition_list[var_33_1].competition_id

	return ActivityWaterCompetitionCfg[var_33_2].hero_id
end

function var_0_0.GetCanUseTrialList(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_0:GetCurrentSchedule(arg_34_1).schedule_id
	local var_34_1 = ActivityWaterCfg[var_34_0]
	local var_34_2 = arg_34_0:GetCurrentAssistantRole(arg_34_1)
	local var_34_3 = ActivityWaterCompetitionCfg[var_34_2]

	return var_34_1.activity_id, var_34_3.camp_hero_id_list
end

function var_0_0.HaveGetTotalProgressReward(arg_35_0, arg_35_1, arg_35_2)
	local var_35_0 = var_0_1[arg_35_1]

	if not var_35_0 then
		return false
	end

	if table.indexof(var_35_0.current_schedule.got_process_reward_id_list, arg_35_2) then
		return true
	end

	return false
end

function var_0_0.HaveGetSelfProgressReward(arg_36_0, arg_36_1, arg_36_2)
	local var_36_0 = var_0_1[arg_36_1]

	if not var_36_0 then
		return false
	end

	if table.indexof(var_36_0.got_contribution_reward_id_list, arg_36_2) then
		return true
	end

	return false
end

function var_0_0.GetCompetitionImage(arg_37_0, arg_37_1)
	local var_37_0 = ActivityWaterCompetitionCfg[arg_37_1]
	local var_37_1 = HeroStandardSystemCfg[var_37_0.hero_id]

	return getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. var_37_1.hero_id)
end

function var_0_0.GetMaxSelfProgress(arg_38_0)
	return GameSetting.activity_water_upper_limit.value[1]
end

function var_0_0.GetCurrentSelfProgress(arg_39_0, arg_39_1)
	local var_39_0 = arg_39_0:GetCurrentSchedule(arg_39_1)

	if not var_39_0 or var_39_0.schedule_id == 0 then
		return 0
	end

	local var_39_1 = var_39_0.schedule_id
	local var_39_2 = ActivityWaterCfg[var_39_1].assistance_coin_id

	return (ItemTools.getItemNum(var_39_2))
end

function var_0_0.GetScheduleActivities(arg_40_0, arg_40_1)
	local var_40_0 = {}

	for iter_40_0, iter_40_1 in ipairs(ActivityCfg[arg_40_1].sub_activity_list) do
		if ActivityCfg[iter_40_1].activity_template == ActivityTemplateConst.ACTIVITY_2_2_WATER_SCHEDULE then
			table.insert(var_40_0, iter_40_1)
		end
	end

	return var_40_0
end

function var_0_0.GetClientProgress(arg_41_0, arg_41_1)
	if not var_0_1[arg_41_1] then
		return {
			0,
			0
		}
	end

	local var_41_0 = var_0_1[arg_41_1].current_schedule.competition_list

	return {
		var_41_0[1].assistance_process or 0,
		var_41_0[2].assistance_process or 0
	}
end

function var_0_0.IsAllScheduleOver(arg_42_0, arg_42_1)
	if not var_0_1[arg_42_1] then
		return true
	end

	local var_42_0 = arg_42_0:GetScheduleActivities(arg_42_1)

	for iter_42_0, iter_42_1 in ipairs(var_42_0) do
		if ActivityData:GetActivityIsOpen(iter_42_1) then
			return false
		end
	end

	return true
end

function var_0_0.OnVoteUpdate(arg_43_0, arg_43_1)
	local var_43_0 = ActivityWaterCfg[arg_43_1.schedule_id]
	local var_43_1 = ActivityCfg.get_id_list_by_sub_activity_list[var_43_0.activity_id][1]

	if not var_0_1[var_43_1] then
		return
	end

	local var_43_2 = var_0_1[var_43_1].current_schedule.competition_list

	if var_43_2[1].competition_id == arg_43_1.competition_list[1].competition_id then
		var_43_2[1].assistance_process = arg_43_1.competition_list[1].assistance_process
		var_43_2[2].assistance_process = arg_43_1.competition_list[2].assistance_process
	else
		var_43_2[1].assistance_process = arg_43_1.competition_list[2].assistance_process
		var_43_2[2].assistance_process = arg_43_1.competition_list[1].assistance_process
	end

	manager.notify:Invoke(ACTIVITY_WATER_CLIENT_PROGRESS_UPDATE, var_43_1)
end

return var_0_0
