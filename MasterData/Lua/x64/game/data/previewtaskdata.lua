local var_0_0 = singletonClass("PreviewTaskData")

function var_0_0.Init(arg_1_0)
	arg_1_0.taskList_ = {}
	arg_1_0.activityIDList_ = {}
end

function var_0_0:TaskModify(arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		if AssignmentCfg[iter_2_1.id] == nil then
			print("TaskCfg没有对应ID:" .. iter_2_1.id)

			break
		end

		if AssignmentCfg[iter_2_1.id].activity_id ~= 0 then
			self.curActivityID_ = AssignmentCfg[iter_2_1.id].activity_id
			self.activityIDList_[self.curActivityID_] = true
			self.taskList_[iter_2_1.id] = self:ParseTaskData(iter_2_1)
		end
	end
end

function var_0_0:TaskDelete(arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		self.taskList_[iter_3_1] = nil
	end
end

function var_0_0:TaskSubmit(arg_4_1)
	for iter_4_0, iter_4_1 in pairs(arg_4_1) do
		if self.taskList_[iter_4_1.id] then
			self.taskList_[iter_4_1.id].complete_flag = self.taskList_[iter_4_1.id].complete_flag + iter_4_1.vary
		end
	end
end

function var_0_0:GetTaskList()
	return self.taskList_ or {}
end

function var_0_0:GetSortTaskIDList()
	local var_6_0 = {}
	local var_6_1 = {}
	local var_6_2 = {}
	local var_6_3 = {}

	for iter_6_0, iter_6_1 in pairs(self.taskList_) do
		if AssignmentCfg[iter_6_0].activity_id == self.curActivityID_ and ActivityData:GetActivityIsOpen(AssignmentCfg[iter_6_0].activity_id) then
			if self.taskList_[iter_6_0].complete_flag >= 1 then
				table.insert(var_6_3, iter_6_0)
			elseif self.taskList_[iter_6_0].progress >= AssignmentCfg[iter_6_0].need then
				table.insert(var_6_1, iter_6_0)
			else
				table.insert(var_6_2, iter_6_0)
			end
		end
	end

	local var_6_4 = handler(self, self.Compare)

	table.sort(var_6_1, var_6_4)
	table.sort(var_6_2, var_6_4)
	table.sort(var_6_3, var_6_4)
	table.insertto(var_6_0, var_6_1)
	table.insertto(var_6_0, var_6_2)
	table.insertto(var_6_0, var_6_3)

	return var_6_0
end

function var_0_0.Compare(arg_7_0, arg_7_1, arg_7_2)
	return AssignmentCfg[arg_7_1].type < AssignmentCfg[arg_7_2].type and true or AssignmentCfg[arg_7_1].id < AssignmentCfg[arg_7_2].id
end

function var_0_0:GetTask(arg_8_1)
	return self.taskList_[arg_8_1]
end

function var_0_0:GetTaskProgress(arg_9_1)
	if self.taskList_[arg_9_1] then
		return self.taskList_[arg_9_1].progress
	end

	return 0
end

function var_0_0:GetTaskComplete(arg_10_1)
	if self.taskList_[arg_10_1] then
		return self.taskList_[arg_10_1].complete_flag >= 1
	end

	return false
end

function var_0_0:GetCurActivityID()
	return self.curActivityID_ or 0
end

function var_0_0:GetActivityIDList()
	return self.activityIDList_
end

function var_0_0.ParseTaskData(arg_13_0, arg_13_1)
	return {
		id = arg_13_1.id,
		progress = arg_13_1.progress,
		complete_flag = arg_13_1.complete_flag,
		expired_timestamp = arg_13_1.expired_timestamp
	}
end

return var_0_0
