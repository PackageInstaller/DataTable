local var_0_0 = singletonClass("TaskData2")

function var_0_0.Init(arg_1_0)
	arg_1_0.data = {
		plotPhase_ = 1,
		newbieTaskPhase_ = 1,
		taskList = {},
		activityList = {},
		typeList = {},
		typedSortedList = {},
		activitySortedList = {},
		phaseSortedList = {}
	}
end

function var_0_0.TaskInit(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.data.plotPhase_ = arg_2_2 or arg_2_0.data.plotPhase_
	arg_2_0.data.newbieTaskPhase_ = arg_2_3 or arg_2_0.data.newbieTaskPhase_

	arg_2_0:TaskModify(arg_2_1)
end

function var_0_0.TaskUpdate(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0.data.plotPhase_ = arg_3_2 or arg_3_0.data.plotPhase_
	arg_3_0.data.newbieTaskPhase_ = arg_3_3 or arg_3_0.data.newbieTaskPhase_

	arg_3_0:TaskModify(arg_3_1)
end

function var_0_0.TaskModify(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		if AssignmentCfg[iter_4_1.id] == nil then
			Debug.LogError("TaskCfg没有对应ID:" .. iter_4_1.id)
		else
			arg_4_0:UpdateData(iter_4_1)
			arg_4_0:TaskUpdatePlotPhase(iter_4_1)
		end
	end
end

function var_0_0.UpdateData(arg_5_0, arg_5_1)
	arg_5_1 = arg_5_0:ParserData(arg_5_1)

	local var_5_0 = AssignmentCfg[arg_5_1.id]

	arg_5_0.data.taskList[arg_5_1.id] = arg_5_1

	arg_5_0:BuildTypedMap(arg_5_1)
	arg_5_0:BuildActivityMap(arg_5_1)
	arg_5_0:MarkSortDirty(arg_5_1)
end

function var_0_0.TaskUpdatePlotPhase(arg_6_0, arg_6_1)
	local var_6_0 = AssignmentCfg[arg_6_1.id]

	if var_6_0.type == TaskConst.TASK_TYPE.PLOT and var_6_0.phase > arg_6_0.data.plotPhase_ then
		arg_6_0.data.plotPhase_ = var_6_0.phase
	end
end

function var_0_0.TaskDelete(arg_7_0, arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		local var_7_0 = {
			id = iter_7_1
		}
		local var_7_1 = AssignmentCfg[var_7_0.id]

		arg_7_0.data.taskList[var_7_0.id] = nil
		arg_7_0.data.typeList[var_7_1.type][var_7_0.id] = nil

		if var_7_1.activity_id and var_7_1.activity_id ~= 0 then
			arg_7_0.data.activityList[var_7_1.activity_id][var_7_0.id] = nil
		end

		arg_7_0:MarkSortDirty(var_7_0)
	end
end

function var_0_0.MarkSortDirty(arg_8_0, arg_8_1)
	local var_8_0 = AssignmentCfg[arg_8_1.id]

	arg_8_0.data.typedSortedList[var_8_0.type] = false

	if var_8_0.activity_id and var_8_0.activity_id ~= 0 then
		arg_8_0.data.activitySortedList[var_8_0.activity_id] = false
	end

	if var_8_0.phase and var_8_0.phase ~= 0 then
		arg_8_0.data.phaseSortedList[var_8_0.type] = arg_8_0.data.phaseSortedList[var_8_0.type] or {}
		arg_8_0.data.phaseSortedList[var_8_0.type][var_8_0.phase] = false
	end
end

function var_0_0.SortTask(arg_9_0, arg_9_1)
	if arg_9_1 == nil then
		return {}
	end

	local var_9_0 = {}
	local var_9_1 = {}
	local var_9_2 = {}
	local var_9_3 = {}

	for iter_9_0, iter_9_1 in pairs(arg_9_1) do
		if iter_9_1 then
			local var_9_4 = arg_9_0:GetTask(iter_9_0)

			if var_9_4 then
				if var_9_4.complete_flag == 0 then
					local var_9_5 = AssignmentCfg[iter_9_0]

					if var_9_4.progress < var_9_5.need then
						local var_9_6 = var_9_5.activity_id

						if var_9_6 ~= 0 then
							local var_9_7 = ActivityData:GetActivityData(var_9_6)

							if manager.time:GetServerTime() < var_9_7.startTime then
								table.insert(var_9_0, var_9_4)
							else
								table.insert(var_9_1, var_9_4)
							end
						else
							table.insert(var_9_1, var_9_4)
						end
					else
						table.insert(var_9_2, var_9_4)
					end
				elseif var_9_4.complete_flag > 0 then
					table.insert(var_9_3, var_9_4)
				end
			end
		end
	end

	table.sort(var_9_2, function(arg_10_0, arg_10_1)
		local var_10_0 = AssignmentCfg[arg_10_0.id] and AssignmentCfg[arg_10_0.id].type or -1
		local var_10_1 = AssignmentCfg[arg_10_1.id] and AssignmentCfg[arg_10_1.id].type or -1

		if var_10_0 ~= var_10_1 then
			return var_10_0 < var_10_1
		else
			return arg_10_0.id < arg_10_1.id
		end
	end)
	table.sort(var_9_1, function(arg_11_0, arg_11_1)
		local var_11_0 = AssignmentCfg[arg_11_0.id] and AssignmentCfg[arg_11_0.id].type or -1
		local var_11_1 = AssignmentCfg[arg_11_1.id] and AssignmentCfg[arg_11_1.id].type or -1

		if var_11_0 ~= var_11_1 then
			return var_11_0 < var_11_1
		else
			return arg_11_0.id < arg_11_1.id
		end
	end)
	table.sort(var_9_3, function(arg_12_0, arg_12_1)
		local var_12_0 = AssignmentCfg[arg_12_0.id] and AssignmentCfg[arg_12_0.id].type or -1
		local var_12_1 = AssignmentCfg[arg_12_1.id] and AssignmentCfg[arg_12_1.id].type or -1

		if var_12_0 ~= var_12_1 then
			return var_12_0 < var_12_1
		else
			return arg_12_0.id < arg_12_1.id
		end
	end)
	table.sort(var_9_0, function(arg_13_0, arg_13_1)
		local var_13_0 = AssignmentCfg[arg_13_0.id] and AssignmentCfg[arg_13_0.id].type or -1
		local var_13_1 = AssignmentCfg[arg_13_1.id] and AssignmentCfg[arg_13_1.id].type or -1

		if var_13_0 ~= var_13_1 then
			return var_13_0 < var_13_1
		else
			return arg_13_0.id < arg_13_1.id
		end
	end)
	table.insertto(var_9_2, var_9_1)
	table.insertto(var_9_2, var_9_0)
	table.insertto(var_9_2, var_9_3)

	return var_9_2
end

function var_0_0.AddTaskToList(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_2 == nil then
		return
	end

	for iter_14_0, iter_14_1 in pairs(arg_14_2) do
		if iter_14_1 then
			local var_14_0 = arg_14_0:GetTask(iter_14_0)

			if var_14_0 then
				table.insert(arg_14_1, var_14_0)
			end
		end
	end
end

function var_0_0.AddActivityTaskToList(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0:AddTaskToList(arg_15_1, arg_15_0:GetTaskIDListByActivity(arg_15_2))
end

function var_0_0.SortTaskInfo(arg_16_0, arg_16_1)
	CommonTools.UniversalSortEx(arg_16_1, {
		map = function(arg_17_0)
			if arg_17_0.complete_flag then
				return 0
			else
				local var_17_0 = arg_17_0.id
				local var_17_1 = AssignmentCfg[var_17_0]

				if arg_17_0.progress >= var_17_1.need then
					return 1
				else
					return 2
				end
			end
		end
	}, {
		ascend = true,
		map = function(arg_18_0)
			return arg_18_0.id
		end
	})
end

function var_0_0.ParserData(arg_19_0, arg_19_1)
	return {
		id = arg_19_1.id,
		progress = arg_19_1.progress,
		complete_flag = arg_19_1.complete_flag,
		expired_timestamp = arg_19_1.expired_timestamp
	}
end

function var_0_0.BuildTypedMap(arg_20_0, arg_20_1)
	local var_20_0 = AssignmentCfg[arg_20_1.id]

	if not arg_20_0.data.typeList[var_20_0.type] then
		arg_20_0.data.typeList[var_20_0.type] = {}
	end

	arg_20_0.data.typeList[var_20_0.type][arg_20_1.id] = true
end

function var_0_0.BuildActivityMap(arg_21_0, arg_21_1)
	local var_21_0 = AssignmentCfg[arg_21_1.id]

	if var_21_0.activity_id or var_21_0.activity_id ~= 0 then
		if not arg_21_0.data.activityList[var_21_0.activity_id] then
			arg_21_0.data.activityList[var_21_0.activity_id] = {}
		end

		arg_21_0.data.activityList[var_21_0.activity_id][arg_21_1.id] = true
	end
end

function var_0_0.GetTaskIDListByType(arg_22_0, arg_22_1)
	return arg_22_0.data.typeList[arg_22_1] or {}
end

function var_0_0.GetTaskIDListByActivity(arg_23_0, arg_23_1)
	return arg_23_0.data.activityList[arg_23_1] or {}
end

function var_0_0.GetTask(arg_24_0, arg_24_1)
	return arg_24_0.data.taskList[arg_24_1]
end

function var_0_0.GetTaskComplete(arg_25_0, arg_25_1)
	if arg_25_0.data.taskList[arg_25_1] then
		return arg_25_0.data.taskList[arg_25_1].complete_flag >= 1
	end

	return false
end

function var_0_0.GetActivityTaskSortList(arg_26_0, arg_26_1)
	if not arg_26_0.data.activitySortedList[arg_26_1] then
		arg_26_0.data.activitySortedList[arg_26_1] = arg_26_0:SortTask(arg_26_0.data.activityList[arg_26_1])
	end

	return arg_26_0.data.activitySortedList[arg_26_1] or {}
end

function var_0_0.GetTypedTaskSortList(arg_27_0, arg_27_1, arg_27_2)
	if not arg_27_0.data.typedSortedList[arg_27_1] then
		arg_27_0.data.typedSortedList[arg_27_1] = arg_27_0:SortTask(arg_27_0.data.typeList[arg_27_1])
	end

	local var_27_0 = arg_27_0.data.typedSortedList[arg_27_1] or {}

	if arg_27_2 then
		local var_27_1 = {}

		for iter_27_0, iter_27_1 in ipairs(var_27_0) do
			if arg_27_2(iter_27_1) then
				table.insert(var_27_1, iter_27_1)
			end
		end

		return var_27_1
	else
		return var_27_0
	end
end

function var_0_0.GetTypedTaskSortListCommonFilter(arg_28_0, arg_28_1)
	return arg_28_0:GetTypedTaskSortList(arg_28_1, arg_28_0.CommonTaskFilterRole)
end

function var_0_0.GetTaskProgress(arg_29_0, arg_29_1)
	if arg_29_0.data.taskList[arg_29_1] then
		return arg_29_0.data.taskList[arg_29_1].progress
	end

	return 0
end

function var_0_0.GetAssignmentPhase(arg_30_0)
	return arg_30_0.data.newbieTaskPhase_ or 1
end

function var_0_0.GetPlotPhase(arg_31_0)
	return arg_31_0.data.plotPhase_
end

function var_0_0.GetSortedPhaseTaskList(arg_32_0, arg_32_1, arg_32_2)
	if not arg_32_1 or not arg_32_2 then
		return {}
	end

	if not arg_32_0.data.phaseSortedList[arg_32_1] or not arg_32_0.data.phaseSortedList[arg_32_1][arg_32_2] then
		local var_32_0 = {}
		local var_32_1 = arg_32_0:GetTaskIDListByType(arg_32_1)

		for iter_32_0, iter_32_1 in pairs(var_32_1) do
			local var_32_2 = arg_32_0:GetTask(iter_32_0)

			if iter_32_1 and var_32_2 and not arg_32_0:CheckFilterPhaseTask(var_32_2) and AssignmentCfg[iter_32_0].phase == arg_32_2 then
				var_32_0[iter_32_0] = true
			end
		end

		arg_32_0.data.phaseSortedList[arg_32_1] = arg_32_0.data.phaseSortedList[arg_32_1] or {}
		arg_32_0.data.phaseSortedList[arg_32_1][arg_32_2] = arg_32_0:SortTask(var_32_0)
	end

	return arg_32_0.data.phaseSortedList[arg_32_1][arg_32_2]
end

function var_0_0.SubmitTask(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_0:GetTask(arg_33_1)

	if var_33_0 then
		var_33_0.complete_flag = 1

		arg_33_0:MarkSortDirty(var_33_0)
	end
end

function var_0_0.SubmitTaskList(arg_34_0, arg_34_1)
	for iter_34_0, iter_34_1 in ipairs(arg_34_1) do
		arg_34_0:SubmitTask(iter_34_1)
	end
end

function var_0_0.UpdateTaskCompleteFlag(arg_35_0, arg_35_1)
	for iter_35_0, iter_35_1 in ipairs(arg_35_1) do
		local var_35_0 = arg_35_0:GetTask(iter_35_1.id)

		if var_35_0 then
			var_35_0.complete_flag = var_35_0.complete_flag + iter_35_1.vary
		end
	end
end

function var_0_0.CommonTaskFilterRole(arg_36_0)
	if arg_36_0 then
		local var_36_0 = AssignmentCfg[arg_36_0.id]

		if arg_36_0.complete_flag >= 1 and var_36_0.type == TaskConst.TASK_TYPE.PLOT and TaskData2:GetPlotPhase() > var_36_0.phase then
			return false
		else
			if var_36_0.condition == GameSetting.task_top_type.value[1] and var_36_0.type == TaskConst.TASK_TYPE.PLOT then
				return false
			end

			return true
		end
	end

	return false
end

function var_0_0.CheckFilterPhaseTask(arg_37_0, arg_37_1)
	if not arg_37_1 then
		return false
	end

	local var_37_0 = AssignmentCfg[arg_37_1.id]

	if not var_37_0 then
		return false
	end

	if var_37_0.condition == TaskConst.STAGE_TASK_ID and var_37_0.additional_parameter[1] == TaskConst.TASK_TYPE.ALPHA then
		return true
	end

	return false
end

return var_0_0
