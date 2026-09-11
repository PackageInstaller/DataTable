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

function var_0_0:TaskInit(arg_2_1, arg_2_2, arg_2_3)
	self.data.plotPhase_ = arg_2_2 or self.data.plotPhase_
	self.data.newbieTaskPhase_ = arg_2_3 or self.data.newbieTaskPhase_

	self:TaskModify(arg_2_1)
end

function var_0_0:TaskUpdate(arg_3_1, arg_3_2, arg_3_3)
	self.data.plotPhase_ = arg_3_2 or self.data.plotPhase_
	self.data.newbieTaskPhase_ = arg_3_3 or self.data.newbieTaskPhase_

	self:TaskModify(arg_3_1)
end

function var_0_0:TaskModify(arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		if AssignmentCfg[iter_4_1.id] == nil then
			Debug.LogError("TaskCfg没有对应ID:" .. iter_4_1.id)
		else
			self:UpdateData(iter_4_1)
			self:TaskUpdatePlotPhase(iter_4_1)
		end
	end
end

function var_0_0:UpdateData(arg_5_1)
	arg_5_1 = self:ParserData(arg_5_1)
	self.data.taskList[arg_5_1.id] = arg_5_1

	self:BuildTypedMap(arg_5_1)
	self:BuildActivityMap(arg_5_1)
	self:MarkSortDirty(arg_5_1)
end

function var_0_0:TaskUpdatePlotPhase(arg_6_1)
	if AssignmentCfg[arg_6_1.id].type == TaskConst.TASK_TYPE.PLOT and AssignmentCfg[arg_6_1.id].phase > self.data.plotPhase_ then
		self.data.plotPhase_ = AssignmentCfg[arg_6_1.id].phase
	end
end

function var_0_0:TaskDelete(arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		local var_7_0 = {
			id = iter_7_1
		}

		self.data.taskList[var_7_0.id] = nil
		self.data.typeList[AssignmentCfg[var_7_0.id].type][var_7_0.id] = nil

		if AssignmentCfg[var_7_0.id].activity_id and AssignmentCfg[var_7_0.id].activity_id ~= 0 then
			self.data.activityList[AssignmentCfg[var_7_0.id].activity_id][var_7_0.id] = nil
		end

		self:MarkSortDirty(var_7_0)
	end
end

function var_0_0:MarkSortDirty(arg_8_1)
	self.data.typedSortedList[AssignmentCfg[arg_8_1.id].type] = false

	if AssignmentCfg[arg_8_1.id].activity_id and AssignmentCfg[arg_8_1.id].activity_id ~= 0 then
		self.data.activitySortedList[AssignmentCfg[arg_8_1.id].activity_id] = false
	end

	if AssignmentCfg[arg_8_1.id].phase and AssignmentCfg[arg_8_1.id].phase ~= 0 then
		self.data.phaseSortedList[AssignmentCfg[arg_8_1.id].type] = self.data.phaseSortedList[AssignmentCfg[arg_8_1.id].type] or {}
		self.data.phaseSortedList[AssignmentCfg[arg_8_1.id].type][AssignmentCfg[arg_8_1.id].phase] = false
	end
end

function var_0_0:SortTask(arg_9_1)
	if arg_9_1 == nil then
		return {}
	end

	local var_9_0 = {}
	local var_9_1 = {}
	local var_9_2 = {}
	local var_9_3 = {}

	for iter_9_0, iter_9_1 in pairs(arg_9_1) do
		if iter_9_1 then
			local var_9_4 = self:GetTask(iter_9_0)

			if var_9_4 then
				if var_9_4.complete_flag == 0 then
					if var_9_4.progress < AssignmentCfg[iter_9_0].need then
						if AssignmentCfg[iter_9_0].activity_id ~= 0 then
							if manager.time:GetServerTime() < ActivityData:GetActivityData(AssignmentCfg[iter_9_0].activity_id).startTime then
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
		if AssignmentCfg[arg_10_0.id] then
			local var_10_0 = AssignmentCfg[arg_10_0.id].type or -1

			if AssignmentCfg[arg_10_1.id] then
				local var_10_1 = AssignmentCfg[arg_10_1.id].type or -1

				if var_10_0 ~= var_10_1 then
					do return var_10_0 < var_10_1 end

					goto label_10_0
				end
			end
		end

		do return arg_10_0.id < arg_10_1.id end

		::label_10_0::
	end)
	table.sort(var_9_1, function(arg_11_0, arg_11_1)
		if AssignmentCfg[arg_11_0.id] then
			local var_11_0 = AssignmentCfg[arg_11_0.id].type or -1

			if AssignmentCfg[arg_11_1.id] then
				local var_11_1 = AssignmentCfg[arg_11_1.id].type or -1

				if var_11_0 ~= var_11_1 then
					do return var_11_0 < var_11_1 end

					goto label_11_0
				end
			end
		end

		do return arg_11_0.id < arg_11_1.id end

		::label_11_0::
	end)
	table.sort(var_9_3, function(arg_12_0, arg_12_1)
		if AssignmentCfg[arg_12_0.id] then
			local var_12_0 = AssignmentCfg[arg_12_0.id].type or -1

			if AssignmentCfg[arg_12_1.id] then
				local var_12_1 = AssignmentCfg[arg_12_1.id].type or -1

				if var_12_0 ~= var_12_1 then
					do return var_12_0 < var_12_1 end

					goto label_12_0
				end
			end
		end

		do return arg_12_0.id < arg_12_1.id end

		::label_12_0::
	end)
	table.sort(var_9_0, function(arg_13_0, arg_13_1)
		if AssignmentCfg[arg_13_0.id] then
			local var_13_0 = AssignmentCfg[arg_13_0.id].type or -1

			if AssignmentCfg[arg_13_1.id] then
				local var_13_1 = AssignmentCfg[arg_13_1.id].type or -1

				if var_13_0 ~= var_13_1 then
					do return var_13_0 < var_13_1 end

					goto label_13_0
				end
			end
		end

		do return arg_13_0.id < arg_13_1.id end

		::label_13_0::
	end)
	table.insertto(var_9_2, var_9_1)
	table.insertto(var_9_2, var_9_0)
	table.insertto(var_9_2, var_9_3)

	return var_9_2
end

function var_0_0:AddTaskToList(arg_14_1, arg_14_2)
	if arg_14_2 == nil then
		return
	end

	for iter_14_0, iter_14_1 in pairs(arg_14_2) do
		if iter_14_1 then
			local var_14_0 = self:GetTask(iter_14_0)

			if var_14_0 then
				table.insert(arg_14_1, var_14_0)
			end
		end
	end
end

function var_0_0:AddActivityTaskToList(arg_15_1, arg_15_2)
	self:AddTaskToList(arg_15_1, self:GetTaskIDListByActivity(arg_15_2))
end

function var_0_0.SortTaskInfo(arg_16_0, arg_16_1)
	CommonTools.UniversalSortEx(arg_16_1, {
		map = function(self)
			if self.complete_flag then
				return 0
			elseif self.progress >= AssignmentCfg[self.id].need then
				return 1
			else
				return 2
			end
		end
	}, {
		ascend = true,
		map = function(self)
			return self.id
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

function var_0_0:BuildTypedMap(arg_20_1)
	self.data.typeList[AssignmentCfg[arg_20_1.id].type] = self.data.typeList[AssignmentCfg[arg_20_1.id].type] or {}
	self.data.typeList[AssignmentCfg[arg_20_1.id].type][arg_20_1.id] = true
end

function var_0_0:BuildActivityMap(arg_21_1)
	if AssignmentCfg[arg_21_1.id].activity_id or AssignmentCfg[arg_21_1.id].activity_id ~= 0 then
		self.data.activityList[AssignmentCfg[arg_21_1.id].activity_id] = self.data.activityList[AssignmentCfg[arg_21_1.id].activity_id] or {}
		self.data.activityList[AssignmentCfg[arg_21_1.id].activity_id][arg_21_1.id] = true
	end
end

function var_0_0:GetTaskIDListByType(arg_22_1)
	return self.data.typeList[arg_22_1] or {}
end

function var_0_0:GetTaskIDListByActivity(arg_23_1)
	return self.data.activityList[arg_23_1] or {}
end

function var_0_0:GetTask(arg_24_1)
	return self.data.taskList[arg_24_1]
end

function var_0_0:GetTaskComplete(arg_25_1)
	if self.data.taskList[arg_25_1] then
		return self.data.taskList[arg_25_1].complete_flag >= 1
	end

	return false
end

function var_0_0:GetActivityTaskSortList(arg_26_1)
	self.data.activitySortedList[arg_26_1] = self.data.activitySortedList[arg_26_1] or self:SortTask(self.data.activityList[arg_26_1])

	return self.data.activitySortedList[arg_26_1] or {}
end

function var_0_0:GetTypedTaskSortList(arg_27_1, arg_27_2)
	self.data.typedSortedList[arg_27_1] = self.data.typedSortedList[arg_27_1] or self:SortTask(self.data.typeList[arg_27_1])

	local var_27_0 = self.data.typedSortedList[arg_27_1] or {}

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

function var_0_0:GetTypedTaskSortListCommonFilter(arg_28_1)
	return self:GetTypedTaskSortList(arg_28_1, self.CommonTaskFilterRole)
end

function var_0_0:GetTaskProgress(arg_29_1)
	if self.data.taskList[arg_29_1] then
		return self.data.taskList[arg_29_1].progress
	end

	return 0
end

function var_0_0:GetAssignmentPhase()
	return self.data.newbieTaskPhase_ or 1
end

function var_0_0:GetPlotPhase()
	return self.data.plotPhase_
end

function var_0_0:GetSortedPhaseTaskList(arg_32_1, arg_32_2)
	if not arg_32_1 or not arg_32_2 then
		return {}
	end

	if not self.data.phaseSortedList[arg_32_1] or not self.data.phaseSortedList[arg_32_1][arg_32_2] then
		local var_32_0 = {}

		for iter_32_0, iter_32_1 in pairs((self:GetTaskIDListByType(arg_32_1))) do
			local var_32_1 = self:GetTask(iter_32_0)

			if iter_32_1 and var_32_1 and not self:CheckFilterPhaseTask(var_32_1) and AssignmentCfg[iter_32_0].phase == arg_32_2 then
				var_32_0[iter_32_0] = true
			end
		end

		self.data.phaseSortedList[arg_32_1] = self.data.phaseSortedList[arg_32_1] or {}
		self.data.phaseSortedList[arg_32_1][arg_32_2] = self:SortTask(var_32_0)
	end

	return self.data.phaseSortedList[arg_32_1][arg_32_2]
end

function var_0_0:SubmitTask(arg_33_1)
	local var_33_0 = self:GetTask(arg_33_1)

	if var_33_0 then
		var_33_0.complete_flag = 1

		self:MarkSortDirty(var_33_0)
	end
end

function var_0_0:SubmitTaskList(arg_34_1)
	for iter_34_0, iter_34_1 in ipairs(arg_34_1) do
		self:SubmitTask(iter_34_1)
	end
end

function var_0_0:UpdateTaskCompleteFlag(arg_35_1)
	for iter_35_0, iter_35_1 in ipairs(arg_35_1) do
		local var_35_0 = self:GetTask(iter_35_1.id)

		if var_35_0 then
			var_35_0.complete_flag = var_35_0.complete_flag + iter_35_1.vary
		end
	end
end

function var_0_0:CommonTaskFilterRole()
	if self then
		if self.complete_flag >= 1 and AssignmentCfg[self.id].type == TaskConst.TASK_TYPE.PLOT and TaskData2:GetPlotPhase() > AssignmentCfg[self.id].phase then
			return false
		else
			if AssignmentCfg[self.id].condition == GameSetting.task_top_type.value[1] and AssignmentCfg[self.id].type == TaskConst.TASK_TYPE.PLOT then
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

	if not AssignmentCfg[arg_37_1.id] then
		return false
	end

	if var_37_0.condition == TaskConst.STAGE_TASK_ID and var_37_0.additional_parameter[1] == TaskConst.TASK_TYPE.ALPHA then
		return true
	end

	return false
end

return var_0_0
