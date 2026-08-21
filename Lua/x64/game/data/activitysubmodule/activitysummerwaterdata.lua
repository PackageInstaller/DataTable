local var_0_0 = singletonClass("ActivitySummerWaterData")
local var_0_1 = {}
local var_0_2 = 0
local var_0_3 = {}
local var_0_4 = {}

function var_0_0.InitFromServerData(arg_1_0, arg_1_1)
	var_0_2 = arg_1_1.activity_id
	var_0_1[arg_1_1.activity_id] = {
		schedule_id = arg_1_1.schedule_id,
		open_stage_id = arg_1_1.open_stage_id,
		open_online_stage_id = arg_1_1.open_online_stage_id,
		gain_num = arg_1_1.gain_num,
		online_gain_num = arg_1_1.online_gain_num
	}
end

function var_0_0.GetMainActivityID(arg_2_0)
	return var_0_2
end

function var_0_0.GetActivityID(arg_3_0)
	if not var_0_1[var_0_2] or not ActivityWaterCfg[var_0_1[var_0_2].schedule_id] then
		return
	end

	return ActivityWaterCfg[var_0_1[var_0_2].schedule_id].activity_id
end

function var_0_0.GetVoteActivityID(arg_4_0)
	return ActivityWaterCfg[var_0_1[var_0_2].schedule_id].voting_activity_id
end

function var_0_0.GetCurrentScheduleCfg(arg_5_0)
	return ActivityWaterCfg[var_0_1[var_0_2].schedule_id]
end

function var_0_0.GetCurrentScheduleData(arg_6_0)
	return var_0_1[var_0_2]
end

function var_0_0.GetChallengeTaskID(arg_7_0)
	local var_7_0 = ActivityCfg[var_0_2].sub_activity_list

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		if ActivityCfg[iter_7_1].activity_template == 4 then
			return iter_7_1
		end
	end

	return 0
end

function var_0_0.HaveSelectAssistantRole(arg_8_0, arg_8_1)
	return arg_8_0:GetCurrentAssistantRole(arg_8_1) > 0
end

function var_0_0.GetTotalGainCurrenyNum(arg_9_0)
	return var_0_1[var_0_2].gain_num + var_0_1[var_0_2].online_gain_num
end

function var_0_0.GetCurrentAssistantRole(arg_10_0, arg_10_1)
	local var_10_0 = var_0_1[arg_10_1]

	if not var_10_0 then
		return 0
	end

	return var_10_0.current_schedule.selected_contestant_id
end

function var_0_0.GetCanUseTrialList(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0:GetCurrentSchedule(arg_11_1).schedule_id
	local var_11_1 = ActivityWaterCfg[var_11_0]
	local var_11_2 = arg_11_0:GetCurrentAssistantRole(arg_11_1)
	local var_11_3 = ActivityWaterCompetitionCfg[var_11_2]

	return var_11_1.activity_id, var_11_3.camp_hero_id_list
end

function var_0_0.OnChallengeSuccess(arg_12_0, arg_12_1, arg_12_2)
	if not var_0_3[arg_12_1] then
		var_0_3[arg_12_1] = {}
	end

	if not var_0_4[arg_12_1] then
		var_0_4[arg_12_1] = {}
	end

	for iter_12_0, iter_12_1 in ipairs(arg_12_2) do
		local var_12_0 = {
			uid = iter_12_1.uid,
			dataDic = {}
		}

		for iter_12_2, iter_12_3 in ipairs(iter_12_1.data_list) do
			if not var_0_4[arg_12_1][iter_12_3.key] then
				var_0_4[arg_12_1][iter_12_3.key] = 0
			end

			if var_0_4[arg_12_1][iter_12_3.key] < iter_12_3.value then
				var_0_4[arg_12_1][iter_12_3.key] = iter_12_3.value
			end

			var_12_0.dataDic[iter_12_3.key] = iter_12_3.value
		end

		var_0_3[arg_12_1][tostring(iter_12_1.uid)] = var_12_0
	end
end

function var_0_0.GetSettlePlayer(arg_13_0, arg_13_1, arg_13_2)
	if not var_0_1[arg_13_1] then
		return nil
	end

	return var_0_3[arg_13_1][tostring(arg_13_2)]
end

function var_0_0.GetSettleMaxData(arg_14_0, arg_14_1)
	if not var_0_1[arg_14_1] then
		return nil
	end

	return var_0_4[arg_14_1]
end

function var_0_0.OnStageRefresh(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5)
	var_0_1[arg_15_1].open_stage_id = arg_15_2
	var_0_1[arg_15_1].open_online_stage_id = arg_15_3
	var_0_1[arg_15_1].gain_num = arg_15_4
	var_0_1[arg_15_1].online_gain_num = arg_15_5
end

return var_0_0
