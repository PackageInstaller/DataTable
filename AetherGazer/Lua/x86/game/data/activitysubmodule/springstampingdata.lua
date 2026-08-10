local var_0_0 = singletonClass("SpringStampingData")

function var_0_0.InitData(arg_1_0, arg_1_1)
	arg_1_0.activityId_ = arg_1_1.activity_id
	arg_1_0.taskList_ = {}

	for iter_1_0, iter_1_1 in ipairs(AssignmentCfg.get_id_list_by_activity_id[arg_1_0.activityId_]) do
		arg_1_0.taskList_[iter_1_0] = clone(AssignmentCfg[iter_1_1])
	end
end

function var_0_0.GetChapterIsOpen(arg_2_0, arg_2_1)
	return ActivityData:GetActivityIsOpen(ActivityCfg[arg_2_0.activityId_].sub_activity_list[arg_2_1])
end

function var_0_0.CheckTaskList(arg_3_0)
	local var_3_0 = {}
	local var_3_1 = 0

	for iter_3_0, iter_3_1 in ipairs(arg_3_0.taskList_) do
		iter_3_1.process = TaskData2:GetTaskProgress(iter_3_1.id)
		iter_3_1.isComplete = iter_3_1.process >= iter_3_1.need
		iter_3_1.isRewarded = TaskData2:GetTaskComplete(iter_3_1.id)
		iter_3_1.isOpen = IsConditionAchieved(iter_3_1.phase)

		if iter_3_1.isComplete and not iter_3_1.isRewarded then
			var_3_0[iter_3_1.id] = true
			var_3_1 = 1
		end
	end

	manager.redPoint:setTip(RedPointConst.ACTIVITY_SPRING_STAMPING, var_3_1)

	return arg_3_0.taskList_, var_3_0
end

return var_0_0
