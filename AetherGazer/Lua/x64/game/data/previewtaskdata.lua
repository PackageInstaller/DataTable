local var_0_0 = singletonClass("PreviewTaskData")

function var_0_0.Init(arg_1_0)
	arg_1_0.taskList_ = {}
	arg_1_0.activityIDList_ = {}
end

function var_0_0.TaskModify(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		local var_2_0 = AssignmentCfg[iter_2_1.id]

		if var_2_0 == nil then
			print("TaskCfg没有对应ID:" .. iter_2_1.id)

			break
		end

		if var_2_0.activity_id ~= 0 then
			arg_2_0.curActivityID_ = var_2_0.activity_id
			arg_2_0.activityIDList_[arg_2_0.curActivityID_] = true
			arg_2_0.taskList_[iter_2_1.id] = arg_2_0:ParseTaskData(iter_2_1)
		end
	end
end

function var_0_0.TaskDelete(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		local var_3_0 = AssignmentCfg[iter_3_1]

		arg_3_0.taskList_[iter_3_1] = nil
	end
end

function var_0_0.TaskSubmit(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in pairs(arg_4_1) do
		if arg_4_0.taskList_[iter_4_1.id] then
			arg_4_0.taskList_[iter_4_1.id].complete_flag = arg_4_0.taskList_[iter_4_1.id].complete_flag + iter_4_1.vary
		end
	end
end

function var_0_0.GetTaskList(arg_5_0)
	return arg_5_0.taskList_ or {}
end

function var_0_0.GetSortTaskIDList(arg_6_0)
	local var_6_0 = {}
	local var_6_1 = {}
	local var_6_2 = {}
	local var_6_3 = {}

	for iter_6_0, iter_6_1 in pairs(arg_6_0.taskList_) do
		local var_6_4 = AssignmentCfg[iter_6_0]

		if var_6_4.activity_id == arg_6_0.curActivityID_ and ActivityData:GetActivityIsOpen(var_6_4.activity_id) then
			if arg_6_0.taskList_[iter_6_0].complete_flag >= 1 then
				table.insert(var_6_3, iter_6_0)
			elseif arg_6_0.taskList_[iter_6_0].progress >= AssignmentCfg[iter_6_0].need then
				table.insert(var_6_1, iter_6_0)
			else
				table.insert(var_6_2, iter_6_0)
			end
		end
	end

	local var_6_5 = handler(arg_6_0, arg_6_0.Compare)

	table.sort(var_6_1, var_6_5)
	table.sort(var_6_2, var_6_5)
	table.sort(var_6_3, var_6_5)
	table.insertto(var_6_0, var_6_1)
	table.insertto(var_6_0, var_6_2)
	table.insertto(var_6_0, var_6_3)

	return var_6_0
end

function var_0_0.Compare(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = AssignmentCfg[arg_7_1]
	local var_7_1 = AssignmentCfg[arg_7_2]

	return var_7_0.type < var_7_1.type and true or var_7_0.id < var_7_1.id
end

function var_0_0.GetTask(arg_8_0, arg_8_1)
	return arg_8_0.taskList_[arg_8_1]
end

function var_0_0.GetTaskProgress(arg_9_0, arg_9_1)
	if arg_9_0.taskList_[arg_9_1] then
		return arg_9_0.taskList_[arg_9_1].progress
	end

	return 0
end

function var_0_0.GetTaskComplete(arg_10_0, arg_10_1)
	if arg_10_0.taskList_[arg_10_1] then
		return arg_10_0.taskList_[arg_10_1].complete_flag >= 1
	end

	return false
end

function var_0_0.GetCurActivityID(arg_11_0)
	return arg_11_0.curActivityID_ or 0
end

function var_0_0.GetActivityIDList(arg_12_0)
	return arg_12_0.activityIDList_
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
