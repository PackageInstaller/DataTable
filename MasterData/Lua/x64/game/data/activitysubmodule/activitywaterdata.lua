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

function var_0_0:ParseHistoryScheduleData(arg_3_1)
	local var_3_0 = {
		schedule_id = arg_3_1.schedule_id,
		competition_list = {},
		selected_contestant_id = arg_3_1.selected_contestant_id,
		is_success = arg_3_1.is_success,
		got_process_reward_id_list = {},
		is_got_success_reward = arg_3_1.is_got_success_reward
	}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.competition_list) do
		table.insert(var_3_0.competition_list, (self:ParseCompetitionData(iter_3_1)))
	end

	table.insertto(var_3_0.got_process_reward_id_list, arg_3_1.got_process_reward_id_list, 1)

	return var_3_0
end

function var_0_0:ParseCurrentScheduleData(arg_4_1)
	local var_4_0 = {
		schedule_id = arg_4_1.schedule_id,
		competition_list = {},
		is_click = arg_4_1.is_click,
		selected_contestant_id = arg_4_1.selected_contestant_id,
		got_process_reward_id_list = {}
	}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1.competition_list) do
		table.insert(var_4_0.competition_list, (self:ParseCompetitionData(iter_4_1)))
	end

	table.insertto(var_4_0.got_process_reward_id_list, arg_4_1.got_process_reward_id_list, 1)

	return var_4_0
end

function var_0_0:InitFromServerData(arg_5_1)
	var_0_1[arg_5_1.activity_id] = {
		activity_id = arg_5_1.activity_id,
		contribution_value = arg_5_1.contribution_value,
		got_contribution_reward_id_list = {},
		current_schedule = self:ParseCurrentScheduleData(arg_5_1.current_schedule),
		history_schedule_list = {},
		history_schedule_dic = {},
		open_stage_id = arg_5_1.open_stage_id,
		open_online_stage_id = arg_5_1.open_online_stage_id
	}

	for iter_5_0, iter_5_1 in ipairs(arg_5_1.history_schedule_list) do
		local var_5_0 = self:ParseHistoryScheduleData(iter_5_1)

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
	if not var_0_1[ActivityCfg.get_id_list_by_sub_activity_list[ActivityWaterCfg[arg_7_1].activity_id][1]] then
		return nil
	end

	return var_0_1[ActivityCfg.get_id_list_by_sub_activity_list[ActivityWaterCfg[arg_7_1].activity_id][1]].history_schedule_dic[arg_7_1]
end

function var_0_0.GetCurrentSchedule(arg_8_0, arg_8_1)
	if not var_0_1[arg_8_1] then
		return nil
	end

	return var_0_1[arg_8_1].current_schedule
end

function var_0_0.GetCurrentScheduleActivityId(arg_9_0, arg_9_1)
	if not var_0_1[arg_9_1] then
		return nil
	end

	return ActivityWaterCfg[var_0_1[arg_9_1].current_schedule.schedule_id].activity_id
end

function var_0_0.OnChallengeSuccess(arg_10_0, arg_10_1, arg_10_2)
	var_0_3[arg_10_1] = var_0_3[arg_10_1] or {}

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
	var_0_1[ActivityCfg.get_id_list_by_sub_activity_list[ActivityWaterCfg[arg_15_1].activity_id][1]].current_schedule.selected_contestant_id = arg_15_2

	manager.notify:Invoke(ACTIVITY_WATER_COMPETITION_UPDATE, arg_15_2)
end

function var_0_0.OnGetSelfAssistantReward(arg_16_0, arg_16_1, arg_16_2)
	table.insertto(var_0_1[arg_16_1].got_contribution_reward_id_list, arg_16_2)
	manager.notify:Invoke(ACTIVITY_WATER_SELF_ASSISTANT_REWARD_UPDATE, {})
end

function var_0_0.OnGetTotalAssistantReward(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	table.insertto(var_0_1[ActivityCfg.get_id_list_by_sub_activity_list[ActivityWaterCfg[arg_17_1].activity_id][1]].current_schedule.got_process_reward_id_list, arg_17_3)
	manager.notify:Invoke(ACTIVITY_WATER_TOTAL_ASSISTANT_REWARD_UPDATE, {})
end

function var_0_0:OnGetWinReward(arg_18_1)
	local var_18_0 = self:GetHistoryData(arg_18_1)

	if not var_18_0 then
		return
	end

	var_18_0.is_got_success_reward = true

	manager.notify:Invoke(ACTIVITY_WATER_WIN_REWARD_UPDATE, {})
end

function var_0_0:HaveGotHistoryReward(arg_19_1)
	local var_19_0 = self:GetHistoryData(arg_19_1)

	if not var_19_0 then
		return false
	end

	return var_19_0.is_got_success_reward
end

function var_0_0.GetContributionValue(arg_20_0, arg_20_1)
	if not var_0_1[arg_20_1] then
		return 0
	end

	return var_0_1[arg_20_1].contribution_value
end

function var_0_0.GetCurrentContributeIndex(arg_21_0, arg_21_1)
	if not var_0_1[arg_21_1] then
		return 1, false
	end

	local var_21_0 = var_0_1[arg_21_1].got_contribution_reward_id_list

	for iter_21_0, iter_21_1 in ipairs(ActivityPointRewardCfg.get_id_list_by_activity_id[arg_21_1]) do
		if table.indexof(var_21_0, iter_21_1) then
			-- block empty
		else
			return iter_21_0, false
		end
	end

	return #ActivityPointRewardCfg.get_id_list_by_activity_id[arg_21_1], true
end

function var_0_0:GetCurrentContributeCfg(arg_22_1)
	local var_22_0, var_22_1 = self:GetCurrentContributeIndex(arg_22_1)

	return ActivityPointRewardCfg.get_id_list_by_activity_id[arg_22_1][var_22_0], var_22_1
end

function var_0_0.GetCurrentCompetition(arg_23_0, arg_23_1, arg_23_2)
	if not var_0_1[arg_23_1] then
		return 0
	end

	return var_0_1[arg_23_1].current_schedule.competition_list[arg_23_2]
end

function var_0_0:HaveSelectAssistantRole(arg_24_1)
	return self:GetCurrentAssistantRole(arg_24_1) > 0
end

function var_0_0.GetCurrentAssistantRole(arg_25_0, arg_25_1)
	if not var_0_1[arg_25_1] then
		return 0
	end

	return var_0_1[arg_25_1].current_schedule.selected_contestant_id
end

function var_0_0:GetCurrentAssistantRoleProcess(arg_26_1)
	if not var_0_1[arg_26_1] then
		return 0
	end

	local var_26_0 = self:GetCurrentAssistantRole(arg_26_1)

	for iter_26_0, iter_26_1 in ipairs(var_0_1[arg_26_1].current_schedule.competition_list) do
		if iter_26_1.competition_id == var_26_0 then
			return iter_26_1.assistance_process
		end
	end

	return 0
end

function var_0_0:GetCurrentAssistantIndex(arg_27_1)
	if not var_0_1[arg_27_1] then
		return 0
	end

	local var_27_0 = self:GetCurrentAssistantRole(arg_27_1)

	for iter_27_0, iter_27_1 in ipairs(var_0_1[arg_27_1].current_schedule.competition_list) do
		if iter_27_1.competition_id == var_27_0 then
			return iter_27_0
		end
	end

	return 0
end

function var_0_0.GetCurrentAssistantRoleStageId(arg_28_0, arg_28_1)
	if not var_0_1[arg_28_1] then
		return 0
	end

	return var_0_1[arg_28_1].open_stage_id
end

function var_0_0.GetOnlineStageId(arg_29_0, arg_29_1)
	if not var_0_1[arg_29_1] then
		return 0
	end

	return var_0_1[arg_29_1].open_online_stage_id
end

function var_0_0:GetTrialHeroList(arg_30_1)
	return var_0_2[self:GetCurrentAssistantRole(arg_30_1)] or {
		0,
		0,
		0
	}
end

function var_0_0.SetHeroTeam(arg_31_0, arg_31_1, arg_31_2)
	var_0_2[arg_31_1] = arg_31_2
end

function var_0_0:IsOppositeRole(arg_32_1, arg_32_2)
	local var_32_0 = self:GetOppositeHeroId(arg_32_1, arg_32_2)

	return arg_32_2 == var_32_0, var_32_0
end

function var_0_0:GetOppositeHeroId(arg_33_1)
	if not var_0_1[arg_33_1] then
		return 0
	end

	return ActivityWaterCompetitionCfg[var_0_1[arg_33_1].current_schedule.competition_list[3 - self:GetCurrentAssistantIndex(arg_33_1)].competition_id].hero_id
end

function var_0_0:GetCanUseTrialList(arg_34_1)
	return ActivityWaterCfg[self:GetCurrentSchedule(arg_34_1).schedule_id].activity_id, ActivityWaterCompetitionCfg[self:GetCurrentAssistantRole(arg_34_1)].camp_hero_id_list
end

function var_0_0.HaveGetTotalProgressReward(arg_35_0, arg_35_1, arg_35_2)
	if not var_0_1[arg_35_1] then
		return false
	end

	if table.indexof(var_0_1[arg_35_1].current_schedule.got_process_reward_id_list, arg_35_2) then
		return true
	end

	return false
end

function var_0_0.HaveGetSelfProgressReward(arg_36_0, arg_36_1, arg_36_2)
	if not var_0_1[arg_36_1] then
		return false
	end

	if table.indexof(var_0_1[arg_36_1].got_contribution_reward_id_list, arg_36_2) then
		return true
	end

	return false
end

function var_0_0.GetCompetitionImage(arg_37_0, arg_37_1)
	return getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. HeroStandardSystemCfg[ActivityWaterCompetitionCfg[arg_37_1].hero_id].hero_id)
end

function var_0_0.GetMaxSelfProgress(arg_38_0)
	return GameSetting.activity_water_upper_limit.value[1]
end

function var_0_0:GetCurrentSelfProgress(arg_39_1)
	local var_39_0 = self:GetCurrentSchedule(arg_39_1)

	if not var_39_0 or var_39_0.schedule_id == 0 then
		return 0
	end

	return (ItemTools.getItemNum(ActivityWaterCfg[var_39_0.schedule_id].assistance_coin_id))
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

	local var_41_0 = {}

	var_41_0[1] = var_0_1[arg_41_1].current_schedule.competition_list[1].assistance_process or 0
	var_41_0[2] = var_0_1[arg_41_1].current_schedule.competition_list[2].assistance_process or 0

	return var_41_0
end

function var_0_0:IsAllScheduleOver(arg_42_1)
	if not var_0_1[arg_42_1] then
		return true
	end

	for iter_42_0, iter_42_1 in ipairs((self:GetScheduleActivities(arg_42_1))) do
		if ActivityData:GetActivityIsOpen(iter_42_1) then
			return false
		end
	end

	return true
end

function var_0_0.OnVoteUpdate(arg_43_0, arg_43_1)
	local var_43_0 = ActivityCfg.get_id_list_by_sub_activity_list[ActivityWaterCfg[arg_43_1.schedule_id].activity_id][1]

	if not var_0_1[ActivityCfg.get_id_list_by_sub_activity_list[ActivityWaterCfg[arg_43_1.schedule_id].activity_id][1]] then
		return
	end

	local var_43_1 = var_0_1[var_43_0].current_schedule.competition_list

	if var_0_1[var_43_0].current_schedule.competition_list[1].competition_id == arg_43_1.competition_list[1].competition_id then
		var_43_1[1].assistance_process = arg_43_1.competition_list[1].assistance_process
		var_43_1[2].assistance_process = arg_43_1.competition_list[2].assistance_process
	else
		var_43_1[1].assistance_process = arg_43_1.competition_list[2].assistance_process
		var_43_1[2].assistance_process = arg_43_1.competition_list[1].assistance_process
	end

	manager.notify:Invoke(ACTIVITY_WATER_CLIENT_PROGRESS_UPDATE, var_43_0)
end

return var_0_0
