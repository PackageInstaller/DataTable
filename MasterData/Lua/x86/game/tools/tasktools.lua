local var_0_0 = {
	GetTaskList = function(arg_1_0, arg_1_1, arg_1_2)
		local var_1_0 = {}

		for iter_1_0, iter_1_1 in pairs(arg_1_0) do
			if AssignmentCfg[iter_1_1.id] == nil then
				print("没有对应的任务ID:", iter_1_1.id)
			elseif AssignmentCfg[iter_1_1.id].type == arg_1_1 then
				if arg_1_2 then
					if AssignmentCfg[iter_1_1.id].phase == arg_1_2 then
						table.insert(var_1_0, iter_1_1.id)
					end
				else
					table.insert(var_1_0, iter_1_1.id)
				end
			end
		end

		table.sort(var_1_0)

		return var_1_0
	end,
	ActivityPtCanReceive = function(arg_2_0, arg_2_1)
		return ActivityPtCfg[arg_2_0].target[arg_2_1] <= ActivityPtData:GetCurrentActivityPt(arg_2_0)
	end,
	ActivityPtIsReceived = function(arg_3_0, arg_3_1)
		if ActivityPtData:GetDailyGetRewardList()[arg_3_0][ActivityPtCfg[arg_3_0].target[arg_3_1]] then
			return true
		end

		return false
	end
}

function var_0_0.GetAllCanReciveTask(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = var_0_0:GetFinishTaskIDList(arg_4_1)

	if next(var_4_0) then
		TaskAction:SubmitTaskList(var_4_0)
	end

	if arg_4_2 then
		arg_4_2()
	end
end

function var_0_0.GetCanGetActivityTaskList(arg_5_0, arg_5_1)
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in pairs((TaskData2:GetTaskIDListByActivity(arg_5_1))) do
		if iter_5_0 then
			local var_5_1 = TaskData2:GetTask(iter_5_0)

			if var_5_1 then
				if not TaskData2:GetTaskComplete(iter_5_0) and var_5_1.progress >= AssignmentCfg[iter_5_0].need then
					table.insert(var_5_0, var_5_1)
				end
			end
		end
	end

	return var_5_0
end

function var_0_0.GetActivityTaskList(arg_6_0, arg_6_1)
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in pairs((TaskData2:GetActivityTaskSortList(arg_6_1))) do
		if iter_6_1 then
			var_6_0[iter_6_1.id] = iter_6_1
		end
	end

	return var_6_0
end

function var_0_0.GetAllCanReciveTaskByActivityID(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 then
		local var_7_0 = {}

		for iter_7_0, iter_7_1 in pairs((var_0_0:GetActivityTaskList(arg_7_1))) do
			if iter_7_1 then
				if TaskData2:GetTaskProgress(iter_7_0) >= AssignmentCfg[iter_7_0].need and not TaskData2:GetTaskComplete(iter_7_0) then
					table.insert(var_7_0, iter_7_0)
				end
			end
		end

		if next(var_7_0) then
			TaskAction:SubmitTaskList(var_7_0)
		end

		if arg_7_2 then
			arg_7_2()
		end
	end
end

function var_0_0:GetFinishTaskIds(arg_8_1, arg_8_2)
	local var_8_0 = manager.time:GetServerTime()

	return (self:GetTaskListByPredict(arg_8_1, arg_8_2, function(arg_9_0)
		local var_9_0 = TaskData2:GetTask(arg_9_0)

		if var_9_0.progress >= AssignmentCfg[arg_9_0].need and var_9_0.complete_flag == 0 and (var_9_0.expired_timestamp == 0 or var_9_0.expired_timestamp >= var_8_0) then
			return true
		end

		return false
	end))
end

function var_0_0.GetTaskListByPredict(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = {}

	if arg_10_1 then
		local var_10_1 = TaskData2:GetTaskIDListByType(arg_10_1)

		if var_10_1 then
			for iter_10_0, iter_10_1 in pairs(var_10_1) do
				if AssignmentCfg[iter_10_0] == nil then
					print("没有对应的任务ID:", iter_10_0)

					break
				end

				local var_10_2

				if arg_10_2 then
					if AssignmentCfg[iter_10_0].phase == arg_10_2 then
						var_10_2 = iter_10_0
					end
				else
					var_10_2 = iter_10_0
				end

				if var_10_2 then
					if arg_10_3 then
						if arg_10_3(var_10_2) then
							table.insert(var_10_0, var_10_2)
						end
					else
						table.insert(var_10_0, var_10_2)
					end
				end
			end
		end
	end

	return var_10_0
end

function var_0_0.GetTaskCountByType(arg_11_0, arg_11_1)
	local var_11_0 = 0

	for iter_11_0, iter_11_1 in pairs((TaskData2:GetTypedTaskSortList(arg_11_1))) do
		if iter_11_1 and TaskData2:GetTask(iter_11_1.id) then
			var_11_0 = var_11_0 + 1
		end
	end

	return var_11_0
end

function var_0_0:GetPlotPhaseID()
	self:GetTaskCountByType(TaskConst.TASK_TYPE.PLOT)

	for iter_12_0, iter_12_1 in pairs((TaskData2:GetTaskIDListByType(TaskConst.TASK_TYPE.PLOT))) do
		if iter_12_0 and TaskData2:GetTask(iter_12_0) then
			if AssignmentCfg[iter_12_0].condition == GameSetting.task_top_type.value[1] and AssignmentCfg[iter_12_0].type == TaskConst.TASK_TYPE.PLOT and TaskData2:GetPlotPhase() <= AssignmentCfg[iter_12_0].phase then
				return iter_12_0
			end
		end
	end
end

function var_0_0.GetNewbiePhaseTask(arg_13_0)
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in pairs((TaskData2:GetTaskIDListByType(TaskConst.TASK_TYPE.ALPHA))) do
		local var_13_1 = TaskData2:GetTask(iter_13_0)

		if iter_13_0 and var_13_1 then
			if AssignmentCfg[iter_13_0].condition == TaskConst.STAGE_TASK_ID and AssignmentCfg[iter_13_0].additional_parameter[1] == TaskConst.TASK_TYPE.ALPHA then
				var_13_0[AssignmentCfg[iter_13_0].phase] = var_13_1
			end
		end
	end

	return var_13_0
end

function var_0_0.GetNoobPhaseTask(arg_14_0, arg_14_1)
	local var_14_0 = {}

	for iter_14_0, iter_14_1 in pairs((TaskData2:GetTaskIDListByType(arg_14_1))) do
		local var_14_1 = TaskData2:GetTask(iter_14_0)

		if iter_14_1 and var_14_1 then
			var_14_0[AssignmentCfg[iter_14_0].phase] = var_14_0[AssignmentCfg[iter_14_0].phase] or {}
			var_14_0[AssignmentCfg[iter_14_0].phase][iter_14_0] = var_14_1
		end
	end

	return var_14_0
end

function var_0_0.GetNoobReadyList(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = {}

	for iter_15_0, iter_15_1 in pairs((TaskTools:GetNoobTaskSortList(arg_15_1, arg_15_2))) do
		if ActivityNoobData:GetUnlockPhase() >= AssignmentCfg[iter_15_1.id].phase and iter_15_1.progress >= AssignmentCfg[iter_15_1.id].need and iter_15_1.complete_flag < 1 then
			table.insert(var_15_0, iter_15_1.id)
		end
	end

	return var_15_0
end

function var_0_0.GetNoobCompletedList(arg_16_0, arg_16_1)
	local var_16_0 = {}

	for iter_16_0, iter_16_1 in pairs((TaskData2:GetTaskIDListByType(arg_16_1))) do
		local var_16_1 = TaskData2:GetTask(iter_16_0)

		if iter_16_1 and var_16_1 then
			if var_16_1.complete_flag >= 1 then
				var_16_0[AssignmentCfg[iter_16_0].phase] = (var_16_0[AssignmentCfg[iter_16_0].phase] or 0) + 1
			end
		end
	end

	return var_16_0
end

function var_0_0.IsCompletedAllNoobAdvanceTask(arg_17_0, arg_17_1)
	for iter_17_0, iter_17_1 in pairs((TaskData2:GetTaskIDListByType(arg_17_1))) do
		local var_17_0 = TaskData2:GetTask(iter_17_0)

		if iter_17_1 and var_17_0 and (AssignmentCfg[iter_17_0].need > var_17_0.progress or var_17_0.complete_flag == 0) then
			return false
		end
	end

	return true
end

function var_0_0.GetNewbieDailyTaskFinishCnt(arg_18_0)
	local var_18_0 = 0

	for iter_18_0, iter_18_1 in pairs((TaskData2:GetTaskIDListByType(TaskConst.TASK_TYPE.DAILY_OFFER))) do
		local var_18_1 = TaskData2:GetTask(iter_18_0)

		if iter_18_1 and var_18_1 and var_18_1.complete_flag == 1 then
			var_18_0 = var_18_0 + 1
		end
	end

	return var_18_0
end

function var_0_0.GetTaskIDList(arg_19_0, arg_19_1)
	local var_19_0 = {}

	for iter_19_0, iter_19_1 in pairs((TaskData2:GetTaskIDListByType(arg_19_1))) do
		if iter_19_1 and TaskData2:GetTask(iter_19_0) then
			table.insert(var_19_0, iter_19_0)
		end
	end

	return var_19_0
end

function var_0_0.GetNoobAdvanceTaskSortList(arg_20_0, arg_20_1, arg_20_2)
	return TaskData2:GetSortedPhaseTaskList(arg_20_1, arg_20_2)
end

function var_0_0.GetNoobTaskSortList(arg_21_0, arg_21_1, arg_21_2)
	return TaskData2:GetSortedPhaseTaskList(arg_21_1, arg_21_2)
end

function var_0_0.GetNewbieTaskSortList(arg_22_0, arg_22_1)
	return TaskData2:GetSortedPhaseTaskList(TaskConst.TASK_TYPE.ALPHA, arg_22_1)
end

function var_0_0.GetIdolTraineeTaskSortList(arg_23_0)
	local var_23_0 = {}

	for iter_23_0, iter_23_1 in pairs((TaskData2:GetTaskIDListByType(TaskConst.TASK_TYPE.IDOL_TRAINEE_DAILY))) do
		table.insert(var_23_0, iter_23_0)
	end

	for iter_23_2, iter_23_3 in pairs((TaskData2:GetTaskIDListByType(TaskConst.TASK_TYPE.IDOL_TRAINEE_WEEKLY))) do
		table.insert(var_23_0, iter_23_2)
	end

	table.sort(var_23_0, function(arg_24_0, arg_24_1)
		local var_24_0 = TaskData2:GetTaskComplete(arg_24_1)
		local var_24_1 = TaskData2:GetTaskProgress(arg_24_0) >= AssignmentCfg[arg_24_0].need
		local var_24_2 = TaskData2:GetTaskProgress(arg_24_1) >= AssignmentCfg[arg_24_1].need

		if TaskData2:GetTaskComplete(arg_24_0) ~= var_24_0 then
			return var_24_0
		end

		if var_24_1 ~= var_24_2 then
			return var_24_1
		end

		return arg_24_0 < arg_24_1
	end)

	return var_23_0
end

function var_0_0.ShowActivityTaskPop(arg_25_0, arg_25_1, arg_25_2)
	JumpTools.OpenPageByJump("commonTaskPop", {
		activityId = arg_25_1,
		prefab = arg_25_2
	})
end

function var_0_0.ShowTypeTaskPop(arg_26_0, arg_26_1, arg_26_2)
	JumpTools.OpenPageByJump("commonTaskPop", {
		taskType = arg_26_1,
		prefab = arg_26_2
	})
end

function var_0_0.SortTaskList(arg_27_0, arg_27_1)
	local var_27_0 = {}
	local var_27_1 = {}
	local var_27_2 = {}

	for iter_27_0, iter_27_1 in ipairs(arg_27_1) do
		local var_27_3 = TaskData2:GetTask(iter_27_1)

		if var_27_3 and var_27_3.complete_flag == 1 then
			table.insert(var_27_2, iter_27_1)
		else
			if var_27_3 then
				if AssignmentCfg[iter_27_1].need <= (var_27_3.progress or 0) then
					table.insert(var_27_1, iter_27_1)

					goto label_27_0
				end
			end

			table.insert(var_27_0, iter_27_1)
		end

		::label_27_0::
	end

	table.insertto(var_27_1, var_27_0)
	table.insertto(var_27_1, var_27_2)

	return var_27_1
end

function var_0_0.GetFinishTaskIDList(arg_28_0, arg_28_1)
	local var_28_0 = {}

	for iter_28_0, iter_28_1 in ipairs(arg_28_1) do
		local var_28_1 = TaskData2:GetTask(iter_28_1)

		if var_28_1 and var_28_1.complete_flag == 1 then
			-- block empty
		elseif var_28_1 then
			if AssignmentCfg[iter_28_1].need <= (var_28_1.progress or 0) then
				table.insert(var_28_0, iter_28_1)
			end
		end
	end

	return var_28_0
end

function var_0_0.GetFinishTaskNum(arg_29_0, arg_29_1)
	local var_29_0 = 0

	for iter_29_0, iter_29_1 in ipairs(arg_29_1) do
		if TaskData2:GetTaskComplete(iter_29_1) then
			var_29_0 = var_29_0 + 1
		end
	end

	return var_29_0
end

function var_0_0.IsHasReceiveTask(arg_30_0, arg_30_1)
	for iter_30_0, iter_30_1 in ipairs(arg_30_1) do
		if not TaskData2:GetTaskComplete(iter_30_1) and TaskData2:GetTaskProgress(iter_30_1) >= AssignmentCfg[iter_30_1].need then
			return true
		end
	end

	return false
end

function var_0_0.IsAnyTaskNotCompleted(arg_31_0)
	if AssignmentCfg.get_id_list_by_activity_id[arg_31_0] then
		for iter_31_0, iter_31_1 in ipairs(AssignmentCfg.get_id_list_by_activity_id[arg_31_0]) do
			local var_31_0 = TaskData2:GetTask(iter_31_1)

			if var_31_0 and var_31_0.complete_flag ~= 1 then
				return iter_31_1
			end
		end
	end
end

function var_0_0.GetTaskNumInfo(arg_32_0)
	local var_32_0 = AssignmentCfg.get_id_list_by_activity_id[arg_32_0] or {}
	local var_32_1 = 0

	for iter_32_0, iter_32_1 in ipairs(var_32_0) do
		local var_32_2 = TaskData2:GetTask(iter_32_1)

		if var_32_2 and var_32_2.complete_flag == 1 then
			var_32_1 = var_32_1 + 1
		elseif var_32_2 then
			if AssignmentCfg[iter_32_1].need <= (var_32_2.progress or 0) then
				var_32_1 = var_32_1 + 1
			end
		end
	end

	return var_32_1, #var_32_0
end

function var_0_0.GetCompleteTaskNumInfo(arg_33_0)
	local var_33_0 = AssignmentCfg.get_id_list_by_activity_id[arg_33_0] or {}
	local var_33_1 = 0

	for iter_33_0, iter_33_1 in ipairs(var_33_0) do
		local var_33_2 = TaskData2:GetTask(iter_33_1)

		if var_33_2 and var_33_2.complete_flag == 1 then
			var_33_1 = var_33_1 + 1
		end
	end

	return var_33_1, #var_33_0
end

function var_0_0.IsTaskSuspendedByActivity(arg_34_0)
	if AssignmentCfg[arg_34_0].activity_id ~= 0 then
		local var_34_0, var_34_1 = ActivityTools.GetActivityIsSuspended(AssignmentCfg[arg_34_0].activity_id)

		if var_34_0 then
			return true, var_34_1
		end
	end

	if AssignmentCfg[arg_34_0].type == 7 or AssignmentCfg[arg_34_0].type == 8 or AssignmentCfg[arg_34_0].type == 9 then
		return ActivityTools.GetActivityIsSuspended(ActivityConst.MONTH_CARD)
	end

	return false
end

function var_0_0.CheckTaskSuspendedByActivity(arg_35_0)
	local var_35_0, var_35_1 = var_0_0.IsTaskSuspendedByActivity(arg_35_0)

	if var_35_0 then
		ShowTips(var_35_1)

		return true
	end

	return false
end

function var_0_0.IsAnyTaskSuspendedByActivity(arg_36_0)
	for iter_36_0, iter_36_1 in ipairs(arg_36_0) do
		local var_36_0, var_36_1 = var_0_0.IsTaskSuspendedByActivity(iter_36_1)

		if var_36_0 then
			return true, var_36_1
		end
	end

	return false
end

function var_0_0.CheckAnyTaskSuspendedByActivity(arg_37_0)
	local var_37_0, var_37_1 = var_0_0.IsAnyTaskSuspendedByActivity(arg_37_0)

	if var_37_0 then
		ShowTips(var_37_1)

		return true
	end

	return false
end

function var_0_0.GetTargetTaskReward(arg_38_0, arg_38_1)
	local var_38_0 = 0

	for iter_38_0, iter_38_1 in ipairs(arg_38_0) do
		if not TaskData2:GetTaskComplete(iter_38_1) and TaskData2:GetTaskProgress(iter_38_1) >= AssignmentCfg[iter_38_1].need then
			for iter_38_2, iter_38_3 in ipairs(AssignmentCfg[iter_38_1].reward) do
				if iter_38_3[1] == arg_38_1 then
					var_38_0 = var_38_0 + iter_38_3[2]
				end
			end
		end
	end

	return var_38_0
end

return var_0_0
