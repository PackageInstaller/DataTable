local var_0_0 = singletonClass("CultivateHeroData")

function var_0_0.Init(arg_1_0)
	arg_1_0.dailyTaskStatus_ = {}
	arg_1_0.heroTaskInfoList_ = {}
	arg_1_0.accumulateTaskInfoList_ = {}
	arg_1_0.accumulateTaskAllReceivedList_ = {}
end

function var_0_0.SetData(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.activity_id

	arg_2_0.heroTaskInfoList_[var_2_0] = {}
	arg_2_0.accumulateTaskInfoList_[var_2_0] = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.task_info_list) do
		arg_2_0.heroTaskInfoList_[var_2_0][iter_2_1.id] = {
			progress = iter_2_1.progress
		}

		if CultivateHeroTaskCfg[iter_2_1.id].condition <= iter_2_1.progress then
			arg_2_0.heroTaskInfoList_[var_2_0][iter_2_1.id].isCompleted = true
		end
	end

	for iter_2_2, iter_2_3 in ipairs(arg_2_1.got_reward_task_id_list) do
		arg_2_0.heroTaskInfoList_[var_2_0][iter_2_3] = arg_2_0.heroTaskInfoList_[var_2_0][iter_2_3] or {}
		arg_2_0.heroTaskInfoList_[var_2_0][iter_2_3].isCompleted = true
		arg_2_0.heroTaskInfoList_[var_2_0][iter_2_3].isReceived = true
	end

	if arg_2_1.daily_pt_task_got_flag == true then
		arg_2_0.dailyTaskStatus_[var_2_0] = true
	else
		arg_2_0.dailyTaskStatus_[var_2_0] = nil
	end

	for iter_2_4, iter_2_5 in ipairs(arg_2_1.got_point_id_list) do
		arg_2_0.accumulateTaskInfoList_[var_2_0][iter_2_5] = {
			isReceived = true
		}
	end

	arg_2_0.accumulateTaskAllReceivedList_[var_2_0] = nil

	arg_2_0:RefreshDailyRedPoint(var_2_0)
	arg_2_0:RefreshAccumulateRedPoint(var_2_0)
	arg_2_0:RefreshHeroTaskRedPoint(var_2_0)
	arg_2_0:RefreshSelectRedPoint(var_2_0)
end

function var_0_0.UpdateDailyTask(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1.activity_id

	if arg_3_1.daily_pt_task_got_flag == true then
		arg_3_0.dailyTaskStatus_[var_3_0] = true
	else
		arg_3_0.dailyTaskStatus_[var_3_0] = nil
	end

	arg_3_0:RefreshDailyRedPoint(var_3_0)
end

function var_0_0.UpdateHeroTask(arg_4_0, arg_4_1)
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1.task_info_list) do
		local var_4_1 = CultivateHeroTaskCfg[iter_4_1.id].activity_id

		var_4_0[var_4_1] = true
		arg_4_0.heroTaskInfoList_[var_4_1][iter_4_1.id] = {
			progress = iter_4_1.progress
		}

		if CultivateHeroTaskCfg[iter_4_1.id].condition <= iter_4_1.progress then
			arg_4_0.heroTaskInfoList_[var_4_1][iter_4_1.id].isCompleted = true
		end
	end

	for iter_4_2, iter_4_3 in pairs(var_4_0) do
		arg_4_0:RefreshHeroTaskRedPoint(iter_4_2)
	end
end

function var_0_0.GetSortHeroTaskList(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = CultivateHeroTaskCfg.get_id_list_by_group_id[arg_5_1]
	local var_5_1 = {}
	local var_5_2 = {}
	local var_5_3 = {}
	local var_5_4 = {}

	for iter_5_0, iter_5_1 in pairs(var_5_0) do
		if arg_5_0.heroTaskInfoList_[arg_5_2][iter_5_1].isReceived == true then
			table.insert(var_5_4, iter_5_1)
		elseif arg_5_0.heroTaskInfoList_[arg_5_2][iter_5_1].isCompleted == true then
			table.insert(var_5_2, iter_5_1)
		else
			table.insert(var_5_3, iter_5_1)
		end
	end

	local var_5_5 = handler(arg_5_0, arg_5_0.Compare)

	table.sort(var_5_2, var_5_5)
	table.sort(var_5_3, var_5_5)
	table.sort(var_5_4, var_5_5)
	table.insertto(var_5_1, var_5_2)
	table.insertto(var_5_1, var_5_3)
	table.insertto(var_5_1, var_5_4)

	local var_5_6 = #var_5_2 > 0

	return var_5_1, var_5_6
end

function var_0_0.Compare(arg_6_0, arg_6_1, arg_6_2)
	return CultivateHeroTaskCfg[arg_6_1].id < CultivateHeroTaskCfg[arg_6_2].id
end

function var_0_0.IsHeroTaskCompleted(arg_7_0, arg_7_1, arg_7_2)
	return CultivateHeroData:GetHeroTaskInfoList(arg_7_1)[arg_7_2].isCompleted
end

function var_0_0.IsHeroTaskReceived(arg_8_0, arg_8_1, arg_8_2)
	return CultivateHeroData:GetHeroTaskInfoList(arg_8_1)[arg_8_2].isReceived
end

function var_0_0.GetDailyTaskStatus(arg_9_0)
	return arg_9_0.dailyTaskStatus_
end

function var_0_0.GetCompletedTaskList(arg_10_0)
	return arg_10_0.completedTaskList_ or {}
end

function var_0_0.GetReceivedTaskList(arg_11_0)
	return arg_11_0.receivedTaskList_ or {}
end

function var_0_0.GetHeroTaskInfoList(arg_12_0, arg_12_1)
	if arg_12_1 ~= nil then
		return arg_12_0.heroTaskInfoList_[arg_12_1] or {}
	end

	return arg_12_0.heroTaskInfoList_
end

function var_0_0.GetAccumulateTaskInfoList(arg_13_0, arg_13_1)
	if arg_13_1 ~= nil then
		return arg_13_0.accumulateTaskInfoList_[arg_13_1] or {}
	end

	return arg_13_0.accumulateTaskInfoList_
end

function var_0_0.SetReceivedHeroTaskList(arg_14_0, arg_14_1, arg_14_2)
	for iter_14_0, iter_14_1 in ipairs(arg_14_1) do
		arg_14_0.heroTaskInfoList_[arg_14_2][iter_14_1].isReceived = true
	end

	arg_14_0:RefreshAccumulateRedPoint(arg_14_2)
	arg_14_0:RefreshHeroTaskRedPoint(arg_14_2)
end

function var_0_0.SetReceivedAccumulateTask(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0.accumulateTaskInfoList_[arg_15_2][arg_15_1] = arg_15_0.accumulateTaskInfoList_[arg_15_2][arg_15_1] or {}
	arg_15_0.accumulateTaskInfoList_[arg_15_2][arg_15_1].isReceived = true

	arg_15_0:RefreshAccumulateRedPoint(arg_15_2)
end

function var_0_0.SetReceivedDailyTask(arg_16_0, arg_16_1)
	arg_16_0.dailyTaskStatus_[arg_16_1] = true

	arg_16_0:RefreshDailyRedPoint(arg_16_1)
	arg_16_0:RefreshAccumulateRedPoint(arg_16_1)
end

function var_0_0.GetSelectHeroID(arg_17_0, arg_17_1)
	return getData(string.format("CultivateHero_%d", arg_17_1), "selectHeroID")
end

function var_0_0.SetSelectHeroID(arg_18_0, arg_18_1, arg_18_2)
	saveData(string.format("CultivateHero_%d", arg_18_1), "selectHeroID", arg_18_2)
	manager.redPoint:setTip(string.format("%s_%s_Select", RedPointConst.CULTIVATE_HERO, arg_18_1), 0)
end

function var_0_0.RefreshSelectRedPoint(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0:GetSelectHeroID(arg_19_1) == nil and 1 or 0

	manager.redPoint:setTip(string.format("%s_%s_Select", RedPointConst.CULTIVATE_HERO, arg_19_1), var_19_0)
end

function var_0_0.RefreshDailyRedPoint(arg_20_0, arg_20_1)
	if arg_20_0:IsAllReceived(arg_20_1) == true then
		return
	end

	local var_20_0 = 100
	local var_20_1 = ActivityPtData:GetCurrentActivityPt(ActivityPtConst.TASK_DAILY_ACTIVITY_PT)
	local var_20_2 = CultivateHeroData:GetDailyTaskStatus()[arg_20_1]
	local var_20_3 = 0

	if var_20_0 <= var_20_1 and var_20_2 ~= true then
		var_20_3 = 1
	end

	manager.redPoint:setTip(string.format("%s_%s_Daily_Reward", RedPointConst.CULTIVATE_HERO, arg_20_1), var_20_3)
end

function var_0_0.RefreshAccumulateRedPoint(arg_21_0, arg_21_1)
	if arg_21_0:IsAllReceived(arg_21_1) == true then
		return
	end

	local var_21_0 = ItemTools.getItemNum(ActivityCultivateHeroCfg[arg_21_1].coin_id)
	local var_21_1 = ActivityPointRewardCfg.get_id_list_by_activity_id[arg_21_1]
	local var_21_2 = 0

	for iter_21_0, iter_21_1 in ipairs(var_21_1) do
		local var_21_3 = ActivityPointRewardCfg[iter_21_1]
		local var_21_4 = arg_21_0.accumulateTaskInfoList_[arg_21_1][iter_21_1] and arg_21_0.accumulateTaskInfoList_[arg_21_1][iter_21_1].isReceived

		if var_21_0 >= var_21_3.need and var_21_4 ~= true then
			var_21_2 = 1

			break
		end
	end

	manager.redPoint:setTip(string.format("%s_%s_Accumulate_Reward", RedPointConst.CULTIVATE_HERO, arg_21_1), var_21_2)
end

function var_0_0.RefreshHeroTaskRedPoint(arg_22_0, arg_22_1)
	if arg_22_0:IsAllReceived(arg_22_1) == true then
		return
	end

	local var_22_0 = ActivityCultivateHeroCfg[arg_22_1].group

	for iter_22_0, iter_22_1 in ipairs(var_22_0) do
		local var_22_1 = CultivateHeroTaskCfg.get_id_list_by_group_id[iter_22_1]
		local var_22_2 = 0

		for iter_22_2, iter_22_3 in ipairs(var_22_1) do
			local var_22_3 = arg_22_0.heroTaskInfoList_[arg_22_1][iter_22_3].isCompleted
			local var_22_4 = arg_22_0.heroTaskInfoList_[arg_22_1][iter_22_3].isReceived

			if var_22_3 == true and not var_22_4 then
				var_22_2 = 1

				break
			end
		end

		manager.redPoint:setTip(string.format("%s_%s_%s_Task_Reward", RedPointConst.CULTIVATE_HERO, arg_22_1, iter_22_1), var_22_2)
	end
end

function var_0_0.IsAllReceived(arg_23_0, arg_23_1)
	if arg_23_0.accumulateTaskAllReceivedList_[arg_23_1] == true or arg_23_0.accumulateTaskInfoList_[arg_23_1] == nil then
		return true
	end

	local var_23_0 = ActivityPointRewardCfg.get_id_list_by_activity_id[arg_23_1]
	local var_23_1 = true

	for iter_23_0, iter_23_1 in ipairs(var_23_0) do
		if not (arg_23_0.accumulateTaskInfoList_[arg_23_1][iter_23_1] and arg_23_0.accumulateTaskInfoList_[arg_23_1][iter_23_1].isReceived) then
			var_23_1 = false

			break
		end
	end

	arg_23_0.accumulateTaskAllReceivedList_[arg_23_1] = var_23_1

	if var_23_1 == true then
		manager.redPoint:setTip(string.format("%s_%s_Daily_Reward", RedPointConst.CULTIVATE_HERO, arg_23_1), 0)
		manager.redPoint:setTip(string.format("%s_%s_Accumulate_Reward", RedPointConst.CULTIVATE_HERO, arg_23_1), 0)

		local var_23_2 = ActivityCultivateHeroCfg[arg_23_1].group

		for iter_23_2, iter_23_3 in ipairs(var_23_2) do
			manager.redPoint:setTip(string.format("%s_%s_%s_Task_Reward", RedPointConst.CULTIVATE_HERO, arg_23_1, iter_23_3), 0)
		end
	end

	return var_23_1
end

return var_0_0
