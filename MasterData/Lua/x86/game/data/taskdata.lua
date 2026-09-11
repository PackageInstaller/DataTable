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

function var_0_0:TaskInit(arg_2_1, arg_2_2)
	self.taskList_ = {}

	self:TaskModify(arg_2_1)

	self.newbieTaskPhase_ = arg_2_2
	self.isLogin_ = 1

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		if self.taskIsPass[iter_2_1.id] and self.taskIsPass[iter_2_1.id] == 0 then
			self.taskIsPass[iter_2_1.id] = 1
		end
	end
end

function var_0_0:TaskUpdate(arg_3_1, arg_3_2)
	self:TaskModify(arg_3_1)
end

function var_0_0:TaskModify(arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		if AssignmentCfg[iter_4_1.id] == nil then
			print("TaskCfg没有对应ID:" .. iter_4_1.id)

			break
		end

		if AssignmentCfg[iter_4_1.id].type == TaskConst.TASK_TYPE.ALPHA then
			self:UpdateNewbieTask(iter_4_1)
		elseif AssignmentCfg[iter_4_1.id].type == TaskConst.TASK_TYPE.NOOB then
			self:UpdateNoobTask(iter_4_1)
		elseif AssignmentCfg[iter_4_1.id].type == TaskConst.TASK_TYPE.NOOB_ADVANCE then
			self:UpdateNoobAdvanceTask(iter_4_1)
		elseif AssignmentCfg[iter_4_1.id].type == TaskConst.TASK_TYPE.DAILY_OFFER then
			self:UpdateNewbieDailyTask(iter_4_1)
		elseif AssignmentCfg[iter_4_1.id].type == TaskConst.TASK_TYPE.PASSPORT_CHALLENGE then
			self.taskList_[iter_4_1.id] = self:ParseTaskData(iter_4_1)

			self:UpdatePloatPhase(iter_4_1)
		elseif AssignmentCfg[iter_4_1.id].type == TaskConst.TASK_TYPE.REGRESSION_CHALLENGE then
			self.taskList_[iter_4_1.id] = self:ParseTaskData(iter_4_1)
		elseif AssignmentCfg[iter_4_1.id].activity_id ~= 0 then
			self:UpdateActivityTask(iter_4_1)
		else
			self.taskList_[iter_4_1.id] = self:ParseTaskData(iter_4_1)

			self:UpdatePloatPhase(iter_4_1)
		end
	end
end

function var_0_0:TaskDelete(arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		if AssignmentCfg[iter_5_1].type == TaskConst.TASK_TYPE.REGRESSION_CHALLENGE then
			self.taskList_[iter_5_1] = nil
		elseif AssignmentCfg[iter_5_1].activity_id ~= 0 then
			self.activityTask_[AssignmentCfg[iter_5_1].activity_id][iter_5_1] = nil

			self:UpdateActivityTaskRedTip(AssignmentCfg[iter_5_1].activity_id)

			self.needSortActivity_[AssignmentCfg[iter_5_1].activity_id] = true
		else
			self.taskList_[iter_5_1] = nil
		end
	end
end

function var_0_0:TaskSubmit(arg_6_1)
	for iter_6_0, iter_6_1 in pairs(arg_6_1) do
		if self.taskList_[iter_6_1.id] then
			self.taskList_[iter_6_1.id].complete_flag = self.taskList_[iter_6_1.id].complete_flag + iter_6_1.vary
		end
	end
end

function var_0_0:UpdatePloatPhase(arg_7_1)
	if AssignmentCfg[arg_7_1.id].type == TaskConst.TASK_TYPE.PLOT and AssignmentCfg[arg_7_1.id].phase > self.plotPhase_ then
		self.plotPhase_ = AssignmentCfg[arg_7_1.id].phase
	elseif AssignmentCfg[arg_7_1.id].type == TaskConst.TASK_TYPE.PASSPORT_CHALLENGE then
		self.activityTask_[AssignmentCfg[arg_7_1.id].activity_id] = self.activityTask_[AssignmentCfg[arg_7_1.id].activity_id] or {}
		self.activityTask_[AssignmentCfg[arg_7_1.id].activity_id][arg_7_1.id] = self:ParseTaskData(arg_7_1)
	end
end

function var_0_0:GetTaskList()
	return self.taskList_ or {}
end

function var_0_0:GetTaskIDListByType(arg_9_1)
	return (TaskTools.GetTaskList(self.taskList_, arg_9_1))
end

function var_0_0:GetSortTaskIDList(arg_10_1)
	local var_10_0 = {}
	local var_10_1 = {}
	local var_10_2 = {}
	local var_10_3 = {}

	for iter_10_0, iter_10_1 in pairs((TaskTools.GetTaskList(self.taskList_, arg_10_1))) do
		if self.taskList_[iter_10_1].complete_flag >= 1 then
			if AssignmentCfg[iter_10_1].type == TaskConst.TASK_TYPE.PLOT then
				if self.plotPhase_ <= AssignmentCfg[iter_10_1].phase then
					table.insert(var_10_3, iter_10_1)
				end
			else
				table.insert(var_10_3, iter_10_1)
			end
		elseif AssignmentCfg[iter_10_1].condition == GameSetting.task_top_type.value[1] and AssignmentCfg[iter_10_1].type == TaskConst.TASK_TYPE.PLOT then
			-- block empty
		elseif self.taskList_[iter_10_1].progress >= AssignmentCfg[iter_10_1].need then
			table.insert(var_10_1, iter_10_1)
		else
			table.insert(var_10_2, iter_10_1)
		end
	end

	table.insertto(var_10_0, var_10_1)
	table.insertto(var_10_0, var_10_2)
	table.insertto(var_10_0, var_10_3)

	return var_10_0
end

function var_0_0:GetPlotPhaseID()
	for iter_11_0, iter_11_1 in pairs((TaskTools.GetTaskList(self.taskList_, TaskConst.TASK_TYPE.PLOT))) do
		if AssignmentCfg[iter_11_1].condition == GameSetting.task_top_type.value[1] and AssignmentCfg[iter_11_1].type == TaskConst.TASK_TYPE.PLOT and self.plotPhase_ <= AssignmentCfg[iter_11_1].phase then
			return iter_11_1
		end
	end

	print("剧情任务没有阶段任务")
end

function var_0_0:GetFinishTaskIds(arg_12_1)
	local var_12_0 = manager.time:GetServerTime()
	local var_12_1 = {}

	for iter_12_0, iter_12_1 in pairs((TaskTools.GetTaskList(self.taskList_, arg_12_1))) do
		if self.taskList_[iter_12_1].progress >= AssignmentCfg[iter_12_1].need and self.taskList_[iter_12_1].complete_flag == 0 and (self.taskList_[iter_12_1].expired_timestamp == 0 or var_12_0 <= self.taskList_[iter_12_1].expired_timestamp) then
			table.insert(var_12_1, iter_12_1)
		end
	end

	return var_12_1
end

function var_0_0:GetIsAllFinish(arg_13_1)
	for iter_13_0, iter_13_1 in pairs((TaskTools.GetTaskList(self.taskList_, arg_13_1))) do
		if self.taskList_[iter_13_1].complete_flag < 1 then
			return false
		end
	end

	return true
end

function var_0_0:GetTask(arg_14_1)
	return self.taskList_[arg_14_1]
end

function var_0_0:GetTaskProgress(arg_15_1)
	if self.taskList_[arg_15_1] then
		return self.taskList_[arg_15_1].progress
	end

	return 0
end

function var_0_0:GetTaskComplete(arg_16_1)
	if self.taskList_[arg_16_1] then
		return self.taskList_[arg_16_1].complete_flag >= 1
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
			if iter_18_1.progress < AssignmentCfg[iter_18_1.id].need then
				if AssignmentCfg[iter_18_1.id].activity_id ~= 0 then
					if manager.time:GetServerTime() < ActivityData:GetActivityData(AssignmentCfg[iter_18_1.id].activity_id).startTime then
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

function var_0_0:GetAssignmentPhase()
	return self.newbieTaskPhase_ or 1
end

function var_0_0:GetNewbieTaskSortList(arg_24_1)
	if self.newbieTaskNeedSort_[arg_24_1] ~= false then
		self.newbieTaskNeedSort_[arg_24_1] = false
		self.newbieTaskSortList_[arg_24_1] = self:SortTask(self.newbieTask_[arg_24_1])
	end

	return self.newbieTaskSortList_[arg_24_1]
end

function var_0_0:GetNewbieTask(arg_25_1)
	return self.newbieTask_[AssignmentCfg[arg_25_1].phase][arg_25_1]
end

function var_0_0:GetNewbiePhaseTask()
	return self.newbiePhaseTask_
end

function var_0_0:UpdateNewbieTask(arg_27_1)
	local var_27_0 = AssignmentCfg[arg_27_1.id].phase

	if AssignmentCfg[arg_27_1.id].condition == TaskConst.STAGE_TASK_ID and AssignmentCfg[arg_27_1.id].additional_parameter[1] == TaskConst.TASK_TYPE.ALPHA then
		self.newbiePhaseTask_[var_27_0] = self:ParseTaskData(arg_27_1)
	else
		self.newbieTask_[var_27_0] = self.newbieTask_[var_27_0] or {}
		self.newbieTask_[var_27_0][arg_27_1.id] = self:ParseTaskData(arg_27_1)
	end

	self.newbieTaskNeedSort_[var_27_0] = true

	self:UpdateNewbieTaskRedPoint()
end

function var_0_0:NewbieTaskSubmit(arg_28_1)
	local var_28_0 = AssignmentCfg[arg_28_1].phase

	if AssignmentCfg[arg_28_1].condition == TaskConst.STAGE_TASK_ID and AssignmentCfg[arg_28_1].additional_parameter[1] == TaskConst.TASK_TYPE.ALPHA then
		self.newbiePhaseTask_[var_28_0].complete_flag = 1
	else
		self.newbieTask_[var_28_0][arg_28_1].complete_flag = 1
	end

	self.newbieTaskNeedSort_[var_28_0] = true

	self:UpdateNewbieTaskRedPoint()
end

function var_0_0:UpdateNewbieTaskRedPoint()
	local var_29_0 = self:GetAssignmentPhase()

	for iter_29_0, iter_29_1 in pairs(self:GetNewbieTaskSortList(var_29_0) or {}) do
		if iter_29_1.progress >= AssignmentCfg[iter_29_1.id].need and iter_29_1.complete_flag < 1 then
			manager.redPoint:setTip(RedPointConst.NEWBIE_TASK, 1)

			return
		end
	end

	local var_29_1 = self:GetNewbiePhaseTask()[var_29_0]

	if var_29_1 and var_29_1.progress >= AssignmentCfg[var_29_1.id].need and var_29_1.complete_flag < 1 then
		manager.redPoint:setTip(RedPointConst.NEWBIE_TASK, 1)

		return
	end

	manager.redPoint:setTip(RedPointConst.NEWBIE_TASK, 0)
end

function var_0_0:UpdateNewbieDailyTask(arg_30_1)
	local var_30_0

	if self.newbieDailyTask_[arg_30_1.id] == nil then
		var_30_0 = true
	end

	self.newbieDailyTask_[arg_30_1.id] = self:ParseTaskData(arg_30_1)

	if self.newbieDailyTask_[arg_30_1.id].complete_flag == 1 and not table.keyof(self.newbieDailyTaskFinish_, arg_30_1.id) then
		table.insert(self.newbieDailyTaskFinish_, arg_30_1.id)
	end

	self:UpdateNewbieDailyTaskRedTip()

	if var_30_0 then
		manager.notify:Invoke(NEWBIE_DAILY_UPDATE)
	end
end

function var_0_0:GetNewbieDailyTask()
	return self.newbieDailyTask_
end

function var_0_0:NewbieDailyTaskSubmit(arg_32_1)
	self.newbieDailyTask_[arg_32_1].complete_flag = 1

	table.insert(self.newbieDailyTaskFinish_, arg_32_1)
	self:UpdateNewbieDailyTaskRedTip()
	manager.notify:Invoke(NEWBIE_DAILY_SUBMIT)
end

function var_0_0:GetNewbieDailyTaskFinishCnt()
	return #self.newbieDailyTaskFinish_
end

function var_0_0:UpdateNewbieDailyTaskRedTip()
	for iter_34_0, iter_34_1 in pairs(self:GetNewbieDailyTask() or {}) do
		if iter_34_1.progress >= AssignmentCfg[iter_34_1.id].need and iter_34_1.complete_flag < 1 then
			manager.redPoint:setTip(RedPointConst.NEWBIE_DAILY_TASK, 1)

			return
		end
	end

	manager.redPoint:setTip(RedPointConst.NEWBIE_DAILY_TASK, 0)
end

function var_0_0:UpdateActivityTask(arg_35_1)
	self:InitAnniversaryFirstTask(AssignmentCfg[arg_35_1.id].activity_id)

	self.activityTask_[AssignmentCfg[arg_35_1.id].activity_id] = self.activityTask_[AssignmentCfg[arg_35_1.id].activity_id] or {}
	self.activityTask_[AssignmentCfg[arg_35_1.id].activity_id][arg_35_1.id] = self:ParseTaskData(arg_35_1)

	self:UpdateActivityTaskRedTip(AssignmentCfg[arg_35_1.id].activity_id)

	self.needSortActivity_[AssignmentCfg[arg_35_1.id].activity_id] = true
end

function var_0_0:GetActivityTaskList(arg_36_1)
	return self.activityTask_[arg_36_1]
end

function var_0_0:GetCanGetActivityTaskList(arg_37_1)
	local var_37_0 = {}

	for iter_37_0, iter_37_1 in pairs(self:GetActivityTaskList(arg_37_1) or {}) do
		if not self:GetActivityTaskComplete(arg_37_1, iter_37_1.id) and self:GetActivityTask(arg_37_1, iter_37_1.id).progress >= AssignmentCfg[iter_37_1.id].need then
			table.insert(var_37_0, iter_37_1)
		end
	end

	return var_37_0
end

function var_0_0:GetActivityTask(arg_38_1, arg_38_2)
	local var_38_0 = self:GetActivityTaskList(arg_38_1)

	if var_38_0 == nil then
		return nil
	end

	return var_38_0[arg_38_2]
end

function var_0_0:GetActivityTaskComplete(arg_39_1, arg_39_2)
	local var_39_0 = self:GetActivityTaskList(arg_39_1)

	if var_39_0 == nil then
		-- block empty
	end

	return var_39_0[arg_39_2].complete_flag >= 1
end

function var_0_0:OsirisTaskSubmit(arg_40_1)
	self.activityTask_[AssignmentCfg[arg_40_1].activity_id][arg_40_1].complete_flag = 1

	self:UpdateActivityTaskRedTip(AssignmentCfg[arg_40_1].activity_id)

	self.needSortActivity_[AssignmentCfg[arg_40_1].activity_id] = true
end

function var_0_0:GetActivityTaskSortList(arg_41_1)
	if self.needSortActivity_[arg_41_1] == true then
		self.activitySortTaskList_[arg_41_1] = self:SortTask(self.activityTask_[arg_41_1])
		self.needSortActivity_[arg_41_1] = false
	end

	return self.activitySortTaskList_[arg_41_1] or {}
end

function var_0_0:UpdateActivityTaskRedTip(arg_42_1)
	local var_42_0 = self:GetActivityTaskList(arg_42_1) or {}
	local var_42_1 = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, arg_42_1)

	for iter_42_0, iter_42_1 in pairs(var_42_0) do
		if iter_42_1.progress >= AssignmentCfg[iter_42_1.id].need and iter_42_1.complete_flag < 1 then
			manager.redPoint:setTip(var_42_1, 1)

			return
		end
	end

	manager.redPoint:setTip(var_42_1, 0)
end

function var_0_0:InitAnniversaryFirstTask(arg_43_1)
	if arg_43_1 ~= ActivityConst.ACTIVITY_2_0_ANNIVERSARY_NORMAL_TASK then
		return
	end

	if self.activityTask_[arg_43_1] ~= nil then
		return
	end

	self.activityTask_[arg_43_1] = {}

	for iter_43_0, iter_43_1 in ipairs(AssignmentCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_2_0_ANNIVERSARY_NORMAL_TASK]) do
		self.activityTask_[arg_43_1][iter_43_1] = self:ParseTaskData({
			complete_flag = 0,
			progress = 0,
			id = iter_43_1
		})
	end
end

function var_0_0:GetNoobPhaseTask()
	return self.noobTask_
end

function var_0_0:GetNoobTaskSortList(arg_45_1)
	if self.noobTaskNeedSort_[arg_45_1] ~= false then
		self.noobTaskNeedSort_[arg_45_1] = false
		self.noobTaskSortList_[arg_45_1] = self:SortTask(self.noobTask_[arg_45_1])
	end

	return self.noobTaskSortList_[arg_45_1]
end

function var_0_0:GetNoobTaskByPhase(arg_46_1)
	return self.noobTask_[arg_46_1]
end

function var_0_0:GetNoobTask(arg_47_1)
	return self.noobTask_[AssignmentCfg[arg_47_1].phase][arg_47_1]
end

function var_0_0:UpdateNoobTask(arg_48_1)
	self.noobTask_[AssignmentCfg[arg_48_1.id].phase] = self.noobTask_[AssignmentCfg[arg_48_1.id].phase] or {}
	self.noobTask_[AssignmentCfg[arg_48_1.id].phase][arg_48_1.id] = self:ParseTaskData(arg_48_1)
	self.noobTaskNeedSort_[AssignmentCfg[arg_48_1.id].phase] = true

	local var_48_0 = 0

	for iter_48_0, iter_48_1 in pairs(self.noobTask_[AssignmentCfg[arg_48_1.id].phase]) do
		if iter_48_1.complete_flag >= 1 then
			var_48_0 = var_48_0 + 1
		end
	end

	self.noobCompletedNumList_[AssignmentCfg[arg_48_1.id].phase] = var_48_0

	self:UpdateNoobTaskRedPoint(AssignmentCfg[arg_48_1.id].phase)
	self:UpdateNoobReadyList(AssignmentCfg[arg_48_1.id].phase)

	if self.isLogin_ > 0 and self.taskIsPass[arg_48_1.id] and self.taskIsPass[arg_48_1.id] == 0 and self:ParseTaskData(arg_48_1).progress >= AssignmentCfg[arg_48_1.id].need then
		self.taskIsPass[arg_48_1.id] = 1
	end
end

function var_0_0:NoobTaskSubmit(arg_49_1)
	self.noobTask_[AssignmentCfg[arg_49_1].phase][arg_49_1].complete_flag = 1
	self.noobTaskNeedSort_[AssignmentCfg[arg_49_1].phase] = true

	local var_49_0 = 0

	for iter_49_0, iter_49_1 in pairs(self.noobTask_[AssignmentCfg[arg_49_1].phase]) do
		if iter_49_1.complete_flag >= 1 then
			var_49_0 = var_49_0 + 1
		end
	end

	self.noobCompletedNumList_[AssignmentCfg[arg_49_1].phase] = var_49_0

	self:UpdateNoobTaskRedPoint(AssignmentCfg[arg_49_1].phase)
	self:UpdateNoobReadyList(AssignmentCfg[arg_49_1].phase)
end

function var_0_0:UpdateNoobReadyList(arg_50_1)
	self.noobTaskReadyList_ = {}

	for iter_50_0, iter_50_1 in pairs(self:GetNoobTaskByPhase(arg_50_1) or {}) do
		if ActivityNoobData:GetUnlockPhase() >= AssignmentCfg[iter_50_1.id].phase and iter_50_1.progress >= AssignmentCfg[iter_50_1.id].need and iter_50_1.complete_flag < 1 then
			table.insert(self.noobTaskReadyList_, iter_50_1.id)
		end
	end
end

function var_0_0:GetNoobReadyList(arg_51_1)
	self:UpdateNoobReadyList(arg_51_1)

	return self.noobTaskReadyList_
end

function var_0_0:GetNoobCompletedList()
	return self.noobCompletedNumList_
end

function var_0_0:UpdateNoobTaskRedPoint(arg_53_1)
	local var_53_0 = ActivityNoobData:GetUnlockPhase()

	for iter_53_0, iter_53_1 in pairs(self:GetNoobTaskByPhase(arg_53_1) or {}) do
		if var_53_0 >= AssignmentCfg[iter_53_1.id].phase and iter_53_1.progress >= AssignmentCfg[iter_53_1.id].need and iter_53_1.complete_flag < 1 then
			manager.redPoint:setTip(string.format("%s_%d", RedPointConst.NEWBIE_TASK, arg_53_1), 1)

			return
		end
	end

	manager.redPoint:setTip(string.format("%s_%d", RedPointConst.NEWBIE_TASK, arg_53_1), 0)
end

function var_0_0:GetNoobAdvanceTaskSortList(arg_54_1)
	if self.noobAdvanceTaskNeedSort_[arg_54_1] ~= false then
		self.noobAdvanceTaskNeedSort_[arg_54_1] = false
		self.noobAdvanceTaskSortList_[arg_54_1] = self:SortTask(self.noobAdvanceTask_[arg_54_1])
	end

	return self.noobAdvanceTaskSortList_[arg_54_1]
end

function var_0_0:GetNoobAdvanceTaskByPhase(arg_55_1)
	return self.noobAdvanceTask_[arg_55_1]
end

function var_0_0:GetNoobAdvanceTask(arg_56_1)
	return self.noobAdvanceTask_[AssignmentCfg[arg_56_1].phase][arg_56_1]
end

function var_0_0:UpdateNoobAdvanceTask(arg_57_1)
	self.noobAdvanceTask_[AssignmentCfg[arg_57_1.id].phase] = self.noobAdvanceTask_[AssignmentCfg[arg_57_1.id].phase] or {}
	self.noobAdvanceTask_[AssignmentCfg[arg_57_1.id].phase][arg_57_1.id] = self:ParseTaskData(arg_57_1)
	self.noobAdvanceTaskNeedSort_[AssignmentCfg[arg_57_1.id].phase] = true

	self:UpdateNoobAdvanceTaskRedPoint(AssignmentCfg[arg_57_1.id].phase)
end

function var_0_0:NoobAdvanceTaskSubmit(arg_58_1)
	local var_58_0 = {}

	for iter_58_0, iter_58_1 in ipairs(arg_58_1) do
		self.noobAdvanceTask_[AssignmentCfg[iter_58_1].phase][iter_58_1].complete_flag = 1
		self.noobAdvanceTaskNeedSort_[AssignmentCfg[iter_58_1].phase] = true
		var_58_0[AssignmentCfg[iter_58_1].phase] = true
	end

	for iter_58_2, iter_58_3 in pairs(var_58_0) do
		self:UpdateNoobAdvanceTaskRedPoint(iter_58_2)
	end
end

function var_0_0:UpdateNoobAdvanceTaskRedPoint(arg_59_1)
	for iter_59_0, iter_59_1 in ipairs(GameSetting.advanced_task_tad.value) do
		for iter_59_2, iter_59_3 in ipairs(iter_59_1[2]) do
			if iter_59_3[1] == arg_59_1 then
				for iter_59_4, iter_59_5 in pairs((self:GetNoobAdvanceTaskByPhase(arg_59_1))) do
					if AssignmentCfg[iter_59_5.id].need <= iter_59_5.progress and iter_59_5.complete_flag == 0 then
						manager.redPoint:setTip(string.format("%s_%d_%d", RedPointConst.NOOB_ADVANCE, iter_59_0, arg_59_1), 1)

						return
					end
				end

				manager.redPoint:setTip(string.format("%s_%d_%d", RedPointConst.NOOB_ADVANCE, iter_59_0, arg_59_1), 0)

				return
			end
		end
	end
end

function var_0_0:IsCompletedAllNoobAdvanceTask()
	if self.isCompletedAllNoobAdvanceTask_ == true then
		return true
	end

	for iter_60_0, iter_60_1 in pairs(self.noobAdvanceTask_) do
		for iter_60_2, iter_60_3 in pairs(iter_60_1) do
			if AssignmentCfg[iter_60_3.id].need > iter_60_3.progress or iter_60_3.complete_flag == 0 then
				self.isCompletedAllNoobAdvanceTask_ = false

				return false
			end
		end
	end

	self.isCompletedAllNoobAdvanceTask_ = true

	return true
end

return var_0_0
