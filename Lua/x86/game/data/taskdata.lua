local var_0_0 = singletonClass("TaskData")

function var_0_0.Init(arg_1_0)
	arg_1_0.taskList_ = {}
	arg_1_0.newbieTask_ = {}
	arg_1_0.newbiePhaseTask_ = {}
	arg_1_0.newbieTaskNeedSort_ = {}
	arg_1_0.newbieTaskSortList_ = {}
	arg_1_0.newbieTaskPhase_ = 1
	arg_1_0.newbieDailyTask_ = {}
	arg_1_0.newbieDailyTaskFinish_ = {}
	arg_1_0.plotPhase_ = 1
	arg_1_0.activityTask_ = {}
	arg_1_0.activitySortTaskList_ = {}
	arg_1_0.needSortActivity_ = {}
	arg_1_0.noobTask_ = {}
	arg_1_0.noobTaskNeedSort_ = {}
	arg_1_0.noobTaskSortList_ = {}
	arg_1_0.noobCompletedNumList_ = {}
	arg_1_0.noobTaskReadyList_ = {}
	arg_1_0.noobAdvanceTask_ = {}
	arg_1_0.noobAdvanceTaskNeedSort_ = {}
	arg_1_0.noobAdvanceTaskSortList_ = {}
	arg_1_0.isCompletedAllNoobAdvanceTask_ = false
	arg_1_0.isLogin_ = 0
	arg_1_0.taskIsPass = {
		[160011] = 0
	}
end

function var_0_0.TaskInit(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.taskList_ = {}

	arg_2_0:TaskModify(arg_2_1)

	arg_2_0.newbieTaskPhase_ = arg_2_2
	arg_2_0.isLogin_ = 1

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		if arg_2_0.taskIsPass[iter_2_1.id] and arg_2_0.taskIsPass[iter_2_1.id] == 0 then
			arg_2_0.taskIsPass[iter_2_1.id] = 1
		end
	end
end

function var_0_0.TaskUpdate(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0:TaskModify(arg_3_1)
end

function var_0_0.TaskModify(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		local var_4_0 = AssignmentCfg[iter_4_1.id]

		if var_4_0 == nil then
			print("TaskCfg没有对应ID:" .. iter_4_1.id)

			break
		end

		if var_4_0.type == TaskConst.TASK_TYPE.ALPHA then
			arg_4_0:UpdateNewbieTask(iter_4_1)
		elseif var_4_0.type == TaskConst.TASK_TYPE.NOOB then
			arg_4_0:UpdateNoobTask(iter_4_1)
		elseif var_4_0.type == TaskConst.TASK_TYPE.NOOB_ADVANCE then
			arg_4_0:UpdateNoobAdvanceTask(iter_4_1)
		elseif var_4_0.type == TaskConst.TASK_TYPE.DAILY_OFFER then
			arg_4_0:UpdateNewbieDailyTask(iter_4_1)
		elseif var_4_0.type == TaskConst.TASK_TYPE.PASSPORT_CHALLENGE then
			arg_4_0.taskList_[iter_4_1.id] = arg_4_0:ParseTaskData(iter_4_1)

			arg_4_0:UpdatePloatPhase(iter_4_1)
		elseif var_4_0.type == TaskConst.TASK_TYPE.REGRESSION_CHALLENGE then
			arg_4_0.taskList_[iter_4_1.id] = arg_4_0:ParseTaskData(iter_4_1)
		elseif var_4_0.activity_id ~= 0 then
			arg_4_0:UpdateActivityTask(iter_4_1)
		else
			arg_4_0.taskList_[iter_4_1.id] = arg_4_0:ParseTaskData(iter_4_1)

			arg_4_0:UpdatePloatPhase(iter_4_1)
		end
	end
end

function var_0_0.TaskDelete(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		local var_5_0 = AssignmentCfg[iter_5_1]

		if var_5_0.type == TaskConst.TASK_TYPE.REGRESSION_CHALLENGE then
			arg_5_0.taskList_[iter_5_1] = nil
		elseif var_5_0.activity_id ~= 0 then
			arg_5_0.activityTask_[var_5_0.activity_id][iter_5_1] = nil

			arg_5_0:UpdateActivityTaskRedTip(var_5_0.activity_id)

			arg_5_0.needSortActivity_[var_5_0.activity_id] = true
		else
			arg_5_0.taskList_[iter_5_1] = nil
		end
	end
end

function var_0_0.TaskSubmit(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in pairs(arg_6_1) do
		if arg_6_0.taskList_[iter_6_1.id] then
			arg_6_0.taskList_[iter_6_1.id].complete_flag = arg_6_0.taskList_[iter_6_1.id].complete_flag + iter_6_1.vary
		end
	end
end

function var_0_0.UpdatePloatPhase(arg_7_0, arg_7_1)
	local var_7_0 = AssignmentCfg[arg_7_1.id]

	if var_7_0.type == TaskConst.TASK_TYPE.PLOT and var_7_0.phase > arg_7_0.plotPhase_ then
		arg_7_0.plotPhase_ = var_7_0.phase
	elseif var_7_0.type == TaskConst.TASK_TYPE.PASSPORT_CHALLENGE then
		arg_7_0.activityTask_[var_7_0.activity_id] = arg_7_0.activityTask_[var_7_0.activity_id] or {}
		arg_7_0.activityTask_[var_7_0.activity_id][arg_7_1.id] = arg_7_0:ParseTaskData(arg_7_1)
	end
end

function var_0_0.GetTaskList(arg_8_0)
	return arg_8_0.taskList_ or {}
end

function var_0_0.GetTaskIDListByType(arg_9_0, arg_9_1)
	return (TaskTools.GetTaskList(arg_9_0.taskList_, arg_9_1))
end

function var_0_0.GetSortTaskIDList(arg_10_0, arg_10_1)
	local var_10_0 = TaskTools.GetTaskList(arg_10_0.taskList_, arg_10_1)
	local var_10_1 = {}
	local var_10_2 = {}
	local var_10_3 = {}
	local var_10_4 = {}

	for iter_10_0, iter_10_1 in pairs(var_10_0) do
		local var_10_5 = AssignmentCfg[iter_10_1]

		if arg_10_0.taskList_[iter_10_1].complete_flag >= 1 then
			if var_10_5.type == TaskConst.TASK_TYPE.PLOT then
				if arg_10_0.plotPhase_ <= var_10_5.phase then
					table.insert(var_10_4, iter_10_1)
				end
			else
				table.insert(var_10_4, iter_10_1)
			end
		elseif var_10_5.condition == GameSetting.task_top_type.value[1] and var_10_5.type == TaskConst.TASK_TYPE.PLOT then
			-- block empty
		elseif arg_10_0.taskList_[iter_10_1].progress >= AssignmentCfg[iter_10_1].need then
			table.insert(var_10_2, iter_10_1)
		else
			table.insert(var_10_3, iter_10_1)
		end
	end

	table.insertto(var_10_1, var_10_2)
	table.insertto(var_10_1, var_10_3)
	table.insertto(var_10_1, var_10_4)

	return var_10_1
end

function var_0_0.GetPlotPhaseID(arg_11_0)
	local var_11_0 = TaskTools.GetTaskList(arg_11_0.taskList_, TaskConst.TASK_TYPE.PLOT)

	for iter_11_0, iter_11_1 in pairs(var_11_0) do
		local var_11_1 = AssignmentCfg[iter_11_1]

		if var_11_1.condition == GameSetting.task_top_type.value[1] and var_11_1.type == TaskConst.TASK_TYPE.PLOT and arg_11_0.plotPhase_ <= var_11_1.phase then
			return iter_11_1
		end
	end

	print("剧情任务没有阶段任务")
end

function var_0_0.GetFinishTaskIds(arg_12_0, arg_12_1)
	local var_12_0 = manager.time:GetServerTime()
	local var_12_1 = TaskTools.GetTaskList(arg_12_0.taskList_, arg_12_1)
	local var_12_2 = {}

	for iter_12_0, iter_12_1 in pairs(var_12_1) do
		if arg_12_0.taskList_[iter_12_1].progress >= AssignmentCfg[iter_12_1].need and arg_12_0.taskList_[iter_12_1].complete_flag == 0 and (arg_12_0.taskList_[iter_12_1].expired_timestamp == 0 or var_12_0 <= arg_12_0.taskList_[iter_12_1].expired_timestamp) then
			table.insert(var_12_2, iter_12_1)
		end
	end

	return var_12_2
end

function var_0_0.GetIsAllFinish(arg_13_0, arg_13_1)
	local var_13_0 = TaskTools.GetTaskList(arg_13_0.taskList_, arg_13_1)

	for iter_13_0, iter_13_1 in pairs(var_13_0) do
		if arg_13_0.taskList_[iter_13_1].complete_flag < 1 then
			return false
		end
	end

	return true
end

function var_0_0.GetTask(arg_14_0, arg_14_1)
	return arg_14_0.taskList_[arg_14_1]
end

function var_0_0.GetTaskProgress(arg_15_0, arg_15_1)
	if arg_15_0.taskList_[arg_15_1] then
		return arg_15_0.taskList_[arg_15_1].progress
	end

	return 0
end

function var_0_0.GetTaskComplete(arg_16_0, arg_16_1)
	if arg_16_0.taskList_[arg_16_1] then
		return arg_16_0.taskList_[arg_16_1].complete_flag >= 1
	end

	return false
end

function var_0_0.ParseTaskData(arg_17_0, arg_17_1)
	return {
		id = arg_17_1.id,
		progress = arg_17_1.progress,
		complete_flag = arg_17_1.complete_flag,
		expired_timestamp = arg_17_1.expired_timestamp
	}
end

function var_0_0.SortTask(arg_18_0, arg_18_1)
	if arg_18_1 == nil then
		return {}
	end

	local var_18_0 = {}
	local var_18_1 = {}
	local var_18_2 = {}
	local var_18_3 = {}

	for iter_18_0, iter_18_1 in pairs(arg_18_1) do
		if iter_18_1.complete_flag == 0 then
			local var_18_4 = AssignmentCfg[iter_18_1.id]

			if iter_18_1.progress < var_18_4.need then
				local var_18_5 = var_18_4.activity_id

				if var_18_5 ~= 0 then
					local var_18_6 = ActivityData:GetActivityData(var_18_5)

					if manager.time:GetServerTime() < var_18_6.startTime then
						table.insert(var_18_0, iter_18_1)
					else
						table.insert(var_18_1, iter_18_1)
					end
				else
					table.insert(var_18_1, iter_18_1)
				end
			else
				table.insert(var_18_2, iter_18_1)
			end
		elseif iter_18_1.complete_flag >= 1 then
			table.insert(var_18_3, iter_18_1)
		end
	end

	table.sort(var_18_2, function(arg_19_0, arg_19_1)
		return AssignmentCfg[arg_19_0.id].type < AssignmentCfg[arg_19_1.id].type and true or arg_19_0.id < arg_19_1.id
	end)
	table.sort(var_18_1, function(arg_20_0, arg_20_1)
		return AssignmentCfg[arg_20_0.id].type < AssignmentCfg[arg_20_1.id].type and true or arg_20_0.id < arg_20_1.id
	end)
	table.sort(var_18_3, function(arg_21_0, arg_21_1)
		return AssignmentCfg[arg_21_0.id].type < AssignmentCfg[arg_21_1.id].type and true or arg_21_0.id < arg_21_1.id
	end)
	table.sort(var_18_0, function(arg_22_0, arg_22_1)
		return AssignmentCfg[arg_22_0.id].type < AssignmentCfg[arg_22_1.id].type and true or arg_22_0.id < arg_22_1.id
	end)
	table.insertto(var_18_2, var_18_1)
	table.insertto(var_18_2, var_18_0)
	table.insertto(var_18_2, var_18_3)

	return var_18_2
end

function var_0_0.GetAssignmentPhase(arg_23_0)
	return arg_23_0.newbieTaskPhase_ or 1
end

function var_0_0.GetNewbieTaskSortList(arg_24_0, arg_24_1)
	if arg_24_0.newbieTaskNeedSort_[arg_24_1] ~= false then
		arg_24_0.newbieTaskNeedSort_[arg_24_1] = false
		arg_24_0.newbieTaskSortList_[arg_24_1] = arg_24_0:SortTask(arg_24_0.newbieTask_[arg_24_1])
	end

	return arg_24_0.newbieTaskSortList_[arg_24_1]
end

function var_0_0.GetNewbieTask(arg_25_0, arg_25_1)
	local var_25_0 = AssignmentCfg[arg_25_1].phase

	return arg_25_0.newbieTask_[var_25_0][arg_25_1]
end

function var_0_0.GetNewbiePhaseTask(arg_26_0)
	return arg_26_0.newbiePhaseTask_
end

function var_0_0.UpdateNewbieTask(arg_27_0, arg_27_1)
	local var_27_0 = AssignmentCfg[arg_27_1.id]
	local var_27_1 = var_27_0.phase

	if var_27_0.condition == TaskConst.STAGE_TASK_ID and var_27_0.additional_parameter[1] == TaskConst.TASK_TYPE.ALPHA then
		arg_27_0.newbiePhaseTask_[var_27_1] = arg_27_0:ParseTaskData(arg_27_1)
	else
		arg_27_0.newbieTask_[var_27_1] = arg_27_0.newbieTask_[var_27_1] or {}
		arg_27_0.newbieTask_[var_27_1][arg_27_1.id] = arg_27_0:ParseTaskData(arg_27_1)
	end

	arg_27_0.newbieTaskNeedSort_[var_27_1] = true

	arg_27_0:UpdateNewbieTaskRedPoint()
end

function var_0_0.NewbieTaskSubmit(arg_28_0, arg_28_1)
	local var_28_0 = AssignmentCfg[arg_28_1]
	local var_28_1 = var_28_0.phase

	if var_28_0.condition == TaskConst.STAGE_TASK_ID and var_28_0.additional_parameter[1] == TaskConst.TASK_TYPE.ALPHA then
		arg_28_0.newbiePhaseTask_[var_28_1].complete_flag = 1
	else
		arg_28_0.newbieTask_[var_28_1][arg_28_1].complete_flag = 1
	end

	arg_28_0.newbieTaskNeedSort_[var_28_1] = true

	arg_28_0:UpdateNewbieTaskRedPoint()
end

function var_0_0.UpdateNewbieTaskRedPoint(arg_29_0)
	local var_29_0 = arg_29_0:GetAssignmentPhase()
	local var_29_1 = arg_29_0:GetNewbieTaskSortList(var_29_0) or {}

	for iter_29_0, iter_29_1 in pairs(var_29_1) do
		if iter_29_1.progress >= AssignmentCfg[iter_29_1.id].need and iter_29_1.complete_flag < 1 then
			manager.redPoint:setTip(RedPointConst.NEWBIE_TASK, 1)

			return
		end
	end

	local var_29_2 = arg_29_0:GetNewbiePhaseTask()[var_29_0]

	if var_29_2 and var_29_2.progress >= AssignmentCfg[var_29_2.id].need and var_29_2.complete_flag < 1 then
		manager.redPoint:setTip(RedPointConst.NEWBIE_TASK, 1)

		return
	end

	manager.redPoint:setTip(RedPointConst.NEWBIE_TASK, 0)
end

function var_0_0.UpdateNewbieDailyTask(arg_30_0, arg_30_1)
	local var_30_0

	if arg_30_0.newbieDailyTask_[arg_30_1.id] == nil then
		var_30_0 = true
	end

	arg_30_0.newbieDailyTask_[arg_30_1.id] = arg_30_0:ParseTaskData(arg_30_1)

	if arg_30_0.newbieDailyTask_[arg_30_1.id].complete_flag == 1 and not table.keyof(arg_30_0.newbieDailyTaskFinish_, arg_30_1.id) then
		table.insert(arg_30_0.newbieDailyTaskFinish_, arg_30_1.id)
	end

	arg_30_0:UpdateNewbieDailyTaskRedTip()

	if var_30_0 then
		manager.notify:Invoke(NEWBIE_DAILY_UPDATE)
	end
end

function var_0_0.GetNewbieDailyTask(arg_31_0)
	return arg_31_0.newbieDailyTask_
end

function var_0_0.NewbieDailyTaskSubmit(arg_32_0, arg_32_1)
	arg_32_0.newbieDailyTask_[arg_32_1].complete_flag = 1

	table.insert(arg_32_0.newbieDailyTaskFinish_, arg_32_1)
	arg_32_0:UpdateNewbieDailyTaskRedTip()
	manager.notify:Invoke(NEWBIE_DAILY_SUBMIT)
end

function var_0_0.GetNewbieDailyTaskFinishCnt(arg_33_0)
	return #arg_33_0.newbieDailyTaskFinish_
end

function var_0_0.UpdateNewbieDailyTaskRedTip(arg_34_0)
	local var_34_0 = arg_34_0:GetNewbieDailyTask() or {}

	for iter_34_0, iter_34_1 in pairs(var_34_0) do
		if iter_34_1.progress >= AssignmentCfg[iter_34_1.id].need and iter_34_1.complete_flag < 1 then
			manager.redPoint:setTip(RedPointConst.NEWBIE_DAILY_TASK, 1)

			return
		end
	end

	manager.redPoint:setTip(RedPointConst.NEWBIE_DAILY_TASK, 0)
end

function var_0_0.UpdateActivityTask(arg_35_0, arg_35_1)
	local var_35_0 = AssignmentCfg[arg_35_1.id]

	arg_35_0:InitAnniversaryFirstTask(var_35_0.activity_id)

	arg_35_0.activityTask_[var_35_0.activity_id] = arg_35_0.activityTask_[var_35_0.activity_id] or {}
	arg_35_0.activityTask_[var_35_0.activity_id][arg_35_1.id] = arg_35_0:ParseTaskData(arg_35_1)

	arg_35_0:UpdateActivityTaskRedTip(var_35_0.activity_id)

	arg_35_0.needSortActivity_[var_35_0.activity_id] = true
end

function var_0_0.GetActivityTaskList(arg_36_0, arg_36_1)
	return arg_36_0.activityTask_[arg_36_1]
end

function var_0_0.GetCanGetActivityTaskList(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_0:GetActivityTaskList(arg_37_1) or {}
	local var_37_1 = {}

	for iter_37_0, iter_37_1 in pairs(var_37_0) do
		local var_37_2 = AssignmentCfg[iter_37_1.id]
		local var_37_3 = arg_37_0:GetActivityTask(arg_37_1, iter_37_1.id).progress

		if not arg_37_0:GetActivityTaskComplete(arg_37_1, iter_37_1.id) and var_37_3 >= var_37_2.need then
			table.insert(var_37_1, iter_37_1)
		end
	end

	return var_37_1
end

function var_0_0.GetActivityTask(arg_38_0, arg_38_1, arg_38_2)
	local var_38_0 = arg_38_0:GetActivityTaskList(arg_38_1)

	if var_38_0 == nil then
		return nil
	end

	return var_38_0[arg_38_2]
end

function var_0_0.GetActivityTaskComplete(arg_39_0, arg_39_1, arg_39_2)
	local var_39_0 = arg_39_0:GetActivityTaskList(arg_39_1)

	if var_39_0 == nil then
		-- block empty
	end

	return var_39_0[arg_39_2].complete_flag >= 1
end

function var_0_0.OsirisTaskSubmit(arg_40_0, arg_40_1)
	local var_40_0 = AssignmentCfg[arg_40_1].activity_id

	arg_40_0.activityTask_[var_40_0][arg_40_1].complete_flag = 1

	arg_40_0:UpdateActivityTaskRedTip(var_40_0)

	arg_40_0.needSortActivity_[var_40_0] = true
end

function var_0_0.GetActivityTaskSortList(arg_41_0, arg_41_1)
	if arg_41_0.needSortActivity_[arg_41_1] == true then
		arg_41_0.activitySortTaskList_[arg_41_1] = arg_41_0:SortTask(arg_41_0.activityTask_[arg_41_1])
		arg_41_0.needSortActivity_[arg_41_1] = false
	end

	return arg_41_0.activitySortTaskList_[arg_41_1] or {}
end

function var_0_0.UpdateActivityTaskRedTip(arg_42_0, arg_42_1)
	local var_42_0 = arg_42_0:GetActivityTaskList(arg_42_1) or {}
	local var_42_1 = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, arg_42_1)

	for iter_42_0, iter_42_1 in pairs(var_42_0) do
		if iter_42_1.progress >= AssignmentCfg[iter_42_1.id].need and iter_42_1.complete_flag < 1 then
			manager.redPoint:setTip(var_42_1, 1)

			return
		end
	end

	manager.redPoint:setTip(var_42_1, 0)
end

function var_0_0.InitAnniversaryFirstTask(arg_43_0, arg_43_1)
	if arg_43_1 ~= ActivityConst.ACTIVITY_2_0_ANNIVERSARY_NORMAL_TASK then
		return
	end

	if arg_43_0.activityTask_[arg_43_1] ~= nil then
		return
	end

	arg_43_0.activityTask_[arg_43_1] = {}

	for iter_43_0, iter_43_1 in ipairs(AssignmentCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_2_0_ANNIVERSARY_NORMAL_TASK]) do
		arg_43_0.activityTask_[arg_43_1][iter_43_1] = arg_43_0:ParseTaskData({
			complete_flag = 0,
			progress = 0,
			id = iter_43_1
		})
	end
end

function var_0_0.GetNoobPhaseTask(arg_44_0)
	return arg_44_0.noobTask_
end

function var_0_0.GetNoobTaskSortList(arg_45_0, arg_45_1)
	if arg_45_0.noobTaskNeedSort_[arg_45_1] ~= false then
		arg_45_0.noobTaskNeedSort_[arg_45_1] = false
		arg_45_0.noobTaskSortList_[arg_45_1] = arg_45_0:SortTask(arg_45_0.noobTask_[arg_45_1])
	end

	return arg_45_0.noobTaskSortList_[arg_45_1]
end

function var_0_0.GetNoobTaskByPhase(arg_46_0, arg_46_1)
	return arg_46_0.noobTask_[arg_46_1]
end

function var_0_0.GetNoobTask(arg_47_0, arg_47_1)
	local var_47_0 = AssignmentCfg[arg_47_1].phase

	return arg_47_0.noobTask_[var_47_0][arg_47_1]
end

function var_0_0.UpdateNoobTask(arg_48_0, arg_48_1)
	local var_48_0 = AssignmentCfg[arg_48_1.id]
	local var_48_1 = var_48_0.phase

	arg_48_0.noobTask_[var_48_1] = arg_48_0.noobTask_[var_48_1] or {}
	arg_48_0.noobTask_[var_48_1][arg_48_1.id] = arg_48_0:ParseTaskData(arg_48_1)
	arg_48_0.noobTaskNeedSort_[var_48_1] = true

	local var_48_2 = 0

	for iter_48_0, iter_48_1 in pairs(arg_48_0.noobTask_[var_48_1]) do
		if iter_48_1.complete_flag >= 1 then
			var_48_2 = var_48_2 + 1
		end
	end

	arg_48_0.noobCompletedNumList_[var_48_1] = var_48_2

	arg_48_0:UpdateNoobTaskRedPoint(var_48_1)
	arg_48_0:UpdateNoobReadyList(var_48_1)

	if arg_48_0.isLogin_ > 0 and arg_48_0.taskIsPass[arg_48_1.id] and arg_48_0.taskIsPass[arg_48_1.id] == 0 and arg_48_0:ParseTaskData(arg_48_1).progress >= var_48_0.need then
		arg_48_0.taskIsPass[arg_48_1.id] = 1
	end
end

function var_0_0.NoobTaskSubmit(arg_49_0, arg_49_1)
	local var_49_0 = AssignmentCfg[arg_49_1].phase

	arg_49_0.noobTask_[var_49_0][arg_49_1].complete_flag = 1
	arg_49_0.noobTaskNeedSort_[var_49_0] = true

	local var_49_1 = 0

	for iter_49_0, iter_49_1 in pairs(arg_49_0.noobTask_[var_49_0]) do
		if iter_49_1.complete_flag >= 1 then
			var_49_1 = var_49_1 + 1
		end
	end

	arg_49_0.noobCompletedNumList_[var_49_0] = var_49_1

	arg_49_0:UpdateNoobTaskRedPoint(var_49_0)
	arg_49_0:UpdateNoobReadyList(var_49_0)
end

function var_0_0.UpdateNoobReadyList(arg_50_0, arg_50_1)
	arg_50_0.noobTaskReadyList_ = {}

	local var_50_0 = arg_50_0:GetNoobTaskByPhase(arg_50_1) or {}

	for iter_50_0, iter_50_1 in pairs(var_50_0) do
		local var_50_1 = AssignmentCfg[iter_50_1.id]

		if ActivityNoobData:GetUnlockPhase() >= var_50_1.phase and iter_50_1.progress >= var_50_1.need and iter_50_1.complete_flag < 1 then
			table.insert(arg_50_0.noobTaskReadyList_, iter_50_1.id)
		end
	end
end

function var_0_0.GetNoobReadyList(arg_51_0, arg_51_1)
	arg_51_0:UpdateNoobReadyList(arg_51_1)

	return arg_51_0.noobTaskReadyList_
end

function var_0_0.GetNoobCompletedList(arg_52_0)
	return arg_52_0.noobCompletedNumList_
end

function var_0_0.UpdateNoobTaskRedPoint(arg_53_0, arg_53_1)
	local var_53_0 = ActivityNoobData:GetUnlockPhase()
	local var_53_1 = arg_53_0:GetNoobTaskByPhase(arg_53_1) or {}

	for iter_53_0, iter_53_1 in pairs(var_53_1) do
		if var_53_0 >= AssignmentCfg[iter_53_1.id].phase and iter_53_1.progress >= AssignmentCfg[iter_53_1.id].need and iter_53_1.complete_flag < 1 then
			manager.redPoint:setTip(string.format("%s_%d", RedPointConst.NEWBIE_TASK, arg_53_1), 1)

			return
		end
	end

	manager.redPoint:setTip(string.format("%s_%d", RedPointConst.NEWBIE_TASK, arg_53_1), 0)
end

function var_0_0.GetNoobAdvanceTaskSortList(arg_54_0, arg_54_1)
	if arg_54_0.noobAdvanceTaskNeedSort_[arg_54_1] ~= false then
		arg_54_0.noobAdvanceTaskNeedSort_[arg_54_1] = false
		arg_54_0.noobAdvanceTaskSortList_[arg_54_1] = arg_54_0:SortTask(arg_54_0.noobAdvanceTask_[arg_54_1])
	end

	return arg_54_0.noobAdvanceTaskSortList_[arg_54_1]
end

function var_0_0.GetNoobAdvanceTaskByPhase(arg_55_0, arg_55_1)
	return arg_55_0.noobAdvanceTask_[arg_55_1]
end

function var_0_0.GetNoobAdvanceTask(arg_56_0, arg_56_1)
	local var_56_0 = AssignmentCfg[arg_56_1].phase

	return arg_56_0.noobAdvanceTask_[var_56_0][arg_56_1]
end

function var_0_0.UpdateNoobAdvanceTask(arg_57_0, arg_57_1)
	local var_57_0 = AssignmentCfg[arg_57_1.id].phase

	arg_57_0.noobAdvanceTask_[var_57_0] = arg_57_0.noobAdvanceTask_[var_57_0] or {}
	arg_57_0.noobAdvanceTask_[var_57_0][arg_57_1.id] = arg_57_0:ParseTaskData(arg_57_1)
	arg_57_0.noobAdvanceTaskNeedSort_[var_57_0] = true

	arg_57_0:UpdateNoobAdvanceTaskRedPoint(var_57_0)
end

function var_0_0.NoobAdvanceTaskSubmit(arg_58_0, arg_58_1)
	local var_58_0 = {}

	for iter_58_0, iter_58_1 in ipairs(arg_58_1) do
		local var_58_1 = AssignmentCfg[iter_58_1].phase

		arg_58_0.noobAdvanceTask_[var_58_1][iter_58_1].complete_flag = 1
		arg_58_0.noobAdvanceTaskNeedSort_[var_58_1] = true
		var_58_0[var_58_1] = true
	end

	for iter_58_2, iter_58_3 in pairs(var_58_0) do
		arg_58_0:UpdateNoobAdvanceTaskRedPoint(iter_58_2)
	end
end

function var_0_0.UpdateNoobAdvanceTaskRedPoint(arg_59_0, arg_59_1)
	local var_59_0 = GameSetting.advanced_task_tad.value

	for iter_59_0, iter_59_1 in ipairs(var_59_0) do
		for iter_59_2, iter_59_3 in ipairs(iter_59_1[2]) do
			if iter_59_3[1] == arg_59_1 then
				local var_59_1 = iter_59_0
				local var_59_2 = arg_59_0:GetNoobAdvanceTaskByPhase(arg_59_1)

				for iter_59_4, iter_59_5 in pairs(var_59_2) do
					if AssignmentCfg[iter_59_5.id].need <= iter_59_5.progress and iter_59_5.complete_flag == 0 then
						manager.redPoint:setTip(string.format("%s_%d_%d", RedPointConst.NOOB_ADVANCE, var_59_1, arg_59_1), 1)

						return
					end
				end

				manager.redPoint:setTip(string.format("%s_%d_%d", RedPointConst.NOOB_ADVANCE, var_59_1, arg_59_1), 0)

				return
			end
		end
	end
end

function var_0_0.IsCompletedAllNoobAdvanceTask(arg_60_0)
	if arg_60_0.isCompletedAllNoobAdvanceTask_ == true then
		return true
	end

	for iter_60_0, iter_60_1 in pairs(arg_60_0.noobAdvanceTask_) do
		for iter_60_2, iter_60_3 in pairs(iter_60_1) do
			if AssignmentCfg[iter_60_3.id].need > iter_60_3.progress or iter_60_3.complete_flag == 0 then
				arg_60_0.isCompletedAllNoobAdvanceTask_ = false

				return false
			end
		end
	end

	arg_60_0.isCompletedAllNoobAdvanceTask_ = true

	return true
end

return var_0_0
