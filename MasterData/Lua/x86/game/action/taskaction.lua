local var_0_0 = {
	TaskNetHandler = {
		SCCancelTask = 28005,
		CSRequestTaskOnceRequire = 28014,
		SCResponseSubmitTask = 28011,
		SCTaskList = 28001,
		SCResponseTaskOnceRequire = 28015,
		CSRequestSubmitTask = 28010,
		SCTaskProgressUpdate = 28007
	},
	Init = function(self)
		self:Add_SC_Listener(self.TaskNetHandler.SCTaskList, handler(self, self.OnSCTaskList))
		self:Add_SC_Listener(self.TaskNetHandler.SCCancelTask, handler(self, self.OnSCCancelTask))
		self:Add_SC_Listener(self.TaskNetHandler.SCTaskProgressUpdate, handler(self, self.OnSCTaskProgressUpdate))
	end,
	Add_SC_Listener = function(arg_2_0, arg_2_1, arg_2_2)
		manager.net:Bind(arg_2_1, function(arg_3_0)
			if arg_2_2 then
				arg_2_2(arg_3_0)
			end
		end)
	end,
	OnSCTaskList = function(arg_4_0, arg_4_1)
		if arg_4_1.send_type == 0 then
			TaskData2:TaskInit(arg_4_1.assignment_list, arg_4_1.newbie_phase, arg_4_1.assignment_phase)
		elseif arg_4_1.send_type then
			TaskData2:TaskUpdate(arg_4_1.assignment_list, arg_4_1.newbie_phase, arg_4_1.assignment_phase)
		end

		TaskAction:OnTaskChange(arg_4_1.assignment_list)
	end,
	OnSCCancelTask = function(arg_5_0, arg_5_1)
		TaskData2:TaskDelete(arg_5_1.id_list)
		TaskAction:OnTaskChange(TaskAction:PackTaskIdListToTaskList(arg_5_1.id_list))
	end,
	OnSCTaskProgressUpdate = function(arg_6_0, arg_6_1)
		TaskData2:TaskModify(arg_6_1.progress_list)
		TaskAction:OnTaskChange(arg_6_1.progress_list)
	end,
	SubmitTask = function(self, arg_7_1, arg_7_2)
		if TaskTools.CheckTaskSuspendedByActivity(arg_7_1) then
			return
		end

		manager.net:SendWithLoadingNew(self.TaskNetHandler.CSRequestSubmitTask, {
			id = arg_7_1
		}, self.TaskNetHandler.SCResponseSubmitTask, function(arg_8_0)
			if isSuccess(arg_8_0.result) then
				self:OnSubmitTask(arg_8_0, arg_7_1, arg_7_2)
				manager.notify:Invoke(ON_TASK_SUBMIT_RESPONSE)
			else
				ShowTips(arg_8_0.result)
			end
		end)
	end,
	OnSubmitTask = function(self, arg_9_1, arg_9_2, arg_9_3)
		if isSuccess(arg_9_1.result) then
			TaskData2:SubmitTask(arg_9_2)

			local var_9_0 = mergeReward2(arg_9_1.reward_list or {})

			if #var_9_0 > 0 then
				getReward2(var_9_0, nil, arg_9_3)
			end

			local var_9_3, var_9_4, var_9_5 = self:FilterPassportWeeklyBonus(AssignmentCfg[arg_9_2].type, var_9_0)

			if var_9_4 > 0 then
				PassportData:AddWeeklyExp(var_9_4)
			end

			self:AddTaskPoint(var_9_5)
			TaskAction:OnTaskChange(TaskAction:PackTaskIdListToTaskList({
				arg_9_2
			}))
		else
			ShowTips(arg_9_1.result)
		end
	end,
	SubmitTaskList = function(self, arg_10_1, arg_10_2, arg_10_3)
		if TaskTools.CheckAnyTaskSuspendedByActivity(arg_10_1) then
			return
		end

		local var_10_0 = {
			id_list = arg_10_1,
			type = arg_10_2 or 0
		}

		manager.net:SendWithLoadingNew(self.TaskNetHandler.CSRequestTaskOnceRequire, var_10_0, self.TaskNetHandler.SCResponseTaskOnceRequire, function(arg_11_0)
			if isSuccess(arg_11_0.result) then
				self:OnSubmitTaskList(arg_11_0, var_10_0)
				self:OnTaskChange(self:PackTaskIdListToTaskList(var_10_0.id_list))

				if arg_10_3 then
					arg_10_3()
				else
					manager.notify:Invoke(ON_TASK_SUBMIT_LIST_RESPONSE)
				end
			else
				ShowTips(arg_11_0.result)
			end
		end)
	end,
	OnSubmitTaskList = function(self, arg_12_1, arg_12_2)
		if not isSuccess(arg_12_1.result) then
			ShowTips(arg_12_1.result)

			return
		end

		local var_12_0 = mergeReward2(arg_12_1.reward_list or {})

		if #var_12_0 > 0 then
			getReward2(var_12_0)
		end

		local var_12_2 = 0

		for iter_12_0, iter_12_1 in ipairs(arg_12_2.id_list) do
			TaskData2:SubmitTask(iter_12_1)
		end

		if arg_12_2.type == TaskConst.TASK_TYPE.DAILY then
			self:PostSubmitTaskList_DAILY(arg_12_2, var_12_0)
		elseif arg_12_2.type == TaskConst.TASK_TYPE.WEEK then
			self:PostSubmitTaskList_WEEK(arg_12_2, var_12_0)
		elseif arg_12_2.type == TaskConst.TASK_TYPE.PASSPORT_MULTIPLE_TASK_TYPE then
			local var_12_3 = {}

			for iter_12_2, iter_12_3 in ipairs(self.passportDailyIdList_) do
				table.insertto(var_12_3, AssignmentCfg[iter_12_3].reward or {})
			end

			for iter_12_4, iter_12_5 in ipairs(self.passportWeeklyIdList_) do
				table.insertto(var_12_3, AssignmentCfg[iter_12_5].reward or {})
			end

			local var_12_7, var_12_8, var_12_9 = self:FilterPassportWeeklyBonus(TaskConst.TASK_TYPE.PASSPORT_DAILY, (deepClone((mergeReward((formatRewardCfgList(var_12_3)))))))

			for iter_12_6, iter_12_7 in ipairs(self.passportChallengeIdList_) do
				table.insertto(var_12_9, AssignmentCfg[iter_12_7].reward or {})
			end

			local var_12_13, var_12_14, var_12_15 = self:FilterPassportWeeklyBonus(0, (mergeReward((formatRewardCfgList(var_12_9)))))

			var_12_2 = var_12_14 + nil
			var_12_0 = var_12_15
		else
			local var_12_17

			var_12_17, var_12_2, var_12_0 = self:FilterPassportWeeklyBonus(arg_12_2.type, var_12_0)
		end

		if var_12_2 > 0 then
			PassportData:AddWeeklyExp(var_12_2)
		end

		self:AddTaskPoint(var_12_0)
	end,
	PostSubmitTaskList_DAILY = function(arg_13_0, arg_13_1, arg_13_2)
		for iter_13_0, iter_13_1 in ipairs(ActivityPtCfg[ActivityPtConst.TASK_DAILY_ACTIVITY_PT].target) do
			if not TaskTools.ActivityPtIsReceived(ActivityPtConst.TASK_DAILY_ACTIVITY_PT, iter_13_0) and TaskTools.ActivityPtCanReceive(ActivityPtConst.TASK_DAILY_ACTIVITY_PT, iter_13_0) then
				ActivityPtData:TaskDailySubmit({
					activityID = ActivityPtConst.TASK_DAILY_ACTIVITY_PT,
					activityPt = ActivityPtData:GetGiftPt(ActivityPtConst.TASK_DAILY_ACTIVITY_PT, iter_13_0)
				})
				table.insertto(arg_13_2, ActivityPtCfg[ActivityPtConst.TASK_DAILY_ACTIVITY_PT].reward[iter_13_0])
			end
		end

		ActivityPtAction:UpdateActivityPt()
	end,
	PostSubmitTaskList_WEEK = function(arg_14_0, arg_14_1, arg_14_2)
		for iter_14_0, iter_14_1 in ipairs(ActivityPtCfg[ActivityPtConst.TASK_WEEK_ACTIVITY_PT].target) do
			if not TaskTools.ActivityPtIsReceived(ActivityPtConst.TASK_WEEK_ACTIVITY_PT, iter_14_0) and TaskTools.ActivityPtCanReceive(ActivityPtConst.TASK_WEEK_ACTIVITY_PT, iter_14_0) then
				ActivityPtData:TaskDailySubmit({
					activityID = ActivityPtConst.TASK_WEEK_ACTIVITY_PT,
					activityPt = ActivityPtData:GetGiftPt(ActivityPtConst.TASK_WEEK_ACTIVITY_PT, iter_14_0)
				})
				table.insertto(arg_14_2, ActivityPtCfg[ActivityPtConst.TASK_WEEK_ACTIVITY_PT].reward[iter_14_0])
			end
		end

		ActivityPtAction:UpdateActivityPt()
	end
}

function var_0_0:TryToSubmitPassportTaskList(arg_15_1, arg_15_2, arg_15_3)
	var_0_0.passportDailyIdList_ = arg_15_1
	var_0_0.passportWeeklyIdList_ = arg_15_2
	var_0_0.passportChallengeIdList_ = arg_15_3

	local var_15_0 = {}

	table.insertto(var_15_0, arg_15_1)
	table.insertto(var_15_0, arg_15_2)
	table.insertto(var_15_0, arg_15_3)
	self:SubmitTaskList(var_15_0, TaskConst.TASK_TYPE.PASSPORT_MULTIPLE_TASK_TYPE)
end

function var_0_0.FilterPassportWeeklyBonus(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = 0
	local var_16_1 = 0

	for iter_16_0, iter_16_1 in pairs(arg_16_2) do
		if arg_16_1 == TaskConst.TASK_TYPE.PASSPORT_WEEKLY or arg_16_1 == TaskConst.TASK_TYPE.PASSPORT_DAILY then
			if iter_16_1.id == CurrencyConst.CURRENCY_TYPE_BATTLEPASS_EXP then
				iter_16_1.num = math.min(GameSetting.battlepass_exp_limit_weekly.value[1] - PassportData:GetExpWeekly(), iter_16_1.num)
				var_16_1 = iter_16_1.num
			end

			if iter_16_1.num == 0 then
				table.remove(arg_16_2, iter_16_0)
			else
				var_16_0 = var_16_0 + 1
			end
		else
			var_16_0 = var_16_0 + 1
		end
	end

	return var_16_0, var_16_1, arg_16_2
end

function var_0_0.AddTaskPoint(arg_17_0, arg_17_1)
	for iter_17_0, iter_17_1 in ipairs(arg_17_1) do
		if ItemCfg[iter_17_1.id] and ItemCfg[iter_17_1.id].type == ItemConst.ITEM_TYPE.CURRENCY and ItemCfg[iter_17_1.id].activity_id then
			ActivityPtData:ActivityPtModify(ItemCfg[iter_17_1.id].activity_id, iter_17_1.num)
		end
	end

	ActivityPtAction:UpdateActivityPt()
end

function var_0_0.OnTaskChange(arg_18_0, arg_18_1)
	manager.notify:CallUpdateFunc(TASK_LIST_CHANGE)
	manager.notify:Invoke(OSIRIS_TASK_UPDATE)
	TaskRedPoint:StartUpdateRedPointPhase(arg_18_1)
	manager.notify:Invoke(TASK_LIST_CHANGE_NOTIFY, arg_18_1)
end

function var_0_0.PackTaskIdListToTaskList(arg_19_0, arg_19_1)
	local var_19_0 = {}

	for iter_19_0, iter_19_1 in ipairs(arg_19_1) do
		table.insert(var_19_0, {
			id = iter_19_1
		})
	end

	return var_19_0
end

var_0_0:Init()

return var_0_0
