local IslandTaskAgency = class("IslandTaskAgency", import(".IslandBaseAgency"))

IslandTaskAgency.TASK_ADDED = "IslandTaskAgency.TASK_ADDED"
IslandTaskAgency.TASK_UPDATED = "IslandTaskAgency.TASK_UPDATED"
IslandTaskAgency.TASK_REMOVED = "IslandTaskAgency.TASK_REMOVED"
IslandTaskAgency.FUTURE_TASK_REMOVED = "IslandTaskAgency.FUTURE_TASK_REMOVED"
IslandTaskAgency.TASK_FINISH = "IslandTaskAgency.TASK_FINISH"

function IslandTaskAgency:OnInit(arg_1_1)
	local var_1_0 = arg_1_1.task_info or {}

	self.finishedDailyCntInWeek = var_1_0.week_daily_task_num or 0
	self.traceId = var_1_0.focus_id or 0
	self.finishedIds = var_1_0.task_id_list_finish or {}
	self.tasks = {}

	for iter_1_0, iter_1_1 in ipairs(var_1_0.task_list or {}) do
		local var_1_1 = IslandTask.New(iter_1_1)

		self.tasks[var_1_1.id] = var_1_1
	end

	self:InitFutureTasks(var_1_0.task_list_random or {})
	self:SetMainTraceId(self:GetPriorityMainTraceTaskId())

	self.acceptCheckTimestampTags = {}

	if self.traceId ~= 0 then
		if self.tasks[self.traceId] and self.tasks[self.traceId]:GetType() == IslandTaskType.MAIN or not self:IsShowInTaskUI(self.tasks[self.traceId]) then
			self.traceId = 0
		end
	end

	return
end

function IslandTaskAgency:InitFutureTasks(arg_2_1)
	self.mutexIds = Clone(self.finishedIds)

	for iter_2_0, iter_2_1 in pairs(self.tasks) do
		table.insert(self.mutexIds, iter_2_1.id)
	end

	self.futureTasks = {}
	self.randomTaskTimes = {}

	for iter_2_2, iter_2_3 in ipairs(arg_2_1) do
		self.randomTaskTimes[iter_2_3.task_id] = iter_2_3.timestamp

		if not self:CheckMutex(iter_2_3.task_id) then
			local var_2_0 = IslandFutureTask.New(iter_2_3)

			self.futureTasks[var_2_0.id] = var_2_0
		end
	end

	for iter_2_4, iter_2_5 in ipairs(IslandTaskType.GetPermanentTypes()) do
		underscore.each(underscore.select(pg.island_task.get_id_list_by_type[iter_2_5] or {}, function(arg_3_0)
			return pg.island_task[arg_3_0].unlock_time ~= "stop" and not IslandTaskAgency.IsServerAcceptType(arg_3_0) and not self:CheckMutex(arg_3_0)
		end), function(arg_4_0)
			local var_4_0 = IslandFutureTask.New({
				task_id = arg_4_0
			})

			self.futureTasks[var_4_0.id] = var_4_0

			return
		end)
	end

	self:BuildObjectTaskHudData()

	return
end

function IslandTaskAgency:BuildObjectTaskHudData()
	IslandObjectTaskHudHelper.BuildData((table.mergeArray(underscore.keys(self.tasks), underscore.keys(self.futureTasks))))

	return
end

function IslandTaskAgency:CheckMutex(arg_6_1)
	if self:IsPassId(arg_6_1) then
		return true
	end

	local var_6_0 = pg.island_task[arg_6_1].unlock_condition

	if pg.island_task[arg_6_1].unlock_condition == "" or #var_6_0 == 0 then
		return false
	end

	return underscore.any(var_6_0, function(arg_7_0)
		return arg_7_0[1] == IslandTaskConditionType.MUTEX_TASK and table.contains(self.mutexIds, arg_7_0[2])
	end)
end

function IslandTaskAgency:GetFinishedIds()
	return self.finishedIds
end

function IslandTaskAgency:IsFinishTask(arg_9_1)
	return table.contains(self.finishedIds, arg_9_1)
end

function IslandTaskAgency:GetFinishCntByType(arg_10_1, arg_10_2)
	return underscore.reduce(self.finishedIds, 0, function(arg_11_0, arg_11_1)
		local var_11_0 = pg.island_task[arg_11_1]

		return arg_11_0 + ((not arg_10_2 or var_11_0.count_offset == 1) and var_11_0.type == arg_10_1 and 1 or 0)
	end)
end

function IslandTaskAgency:GetFinishedDailyCntInWeek()
	return self.finishedDailyCntInWeek
end

function IslandTaskAgency:IsPassId(arg_13_1)
	return table.contains(self.mutexIds, arg_13_1)
end

function IslandTaskAgency:GetTasks()
	return self.tasks
end

function IslandTaskAgency:GetShowTasks()
	local var_15_0 = {}

	for iter_15_0, iter_15_1 in pairs(self.tasks) do
		if self:IsShowInTaskUI(iter_15_1) then
			table.insert(var_15_0, iter_15_1)
		end
	end

	return var_15_0
end

function IslandTaskAgency:IsShowInTaskUI(arg_16_1)
	if not arg_16_1 then
		return false
	end

	local var_16_0 = arg_16_1:getConfig("type")

	if var_16_0 == IslandTaskType.SEASON then
		return false
	end

	local var_16_1 = arg_16_1:getConfig("link_task")
	local var_16_2 = underscore.all(var_16_1, function(arg_17_0)
		return self:IsFinishTask(arg_17_0)
	end)

	if var_16_0 == IslandTaskType.HIDE then
		if #var_16_1 > 0 and var_16_2 then
			return true
		end
	elseif var_16_2 then
		return true
	end

	return false
end

function IslandTaskAgency:GetTask(arg_18_1)
	return self.tasks[arg_18_1]
end

function IslandTaskAgency:GetFutureTask(arg_19_1)
	return self.futureTasks[arg_19_1]
end

function IslandTaskAgency:SetTraceId(arg_20_1)
	self.traceId = arg_20_1

	return
end

function IslandTaskAgency:GetTraceId()
	return self.traceId
end

function IslandTaskAgency:GetTraceTask()
	if self.traceId == 0 then
		return nil
	end

	return self.tasks[self.traceId]
end

function IslandTaskAgency:SetMainTraceId(arg_23_1)
	self.mainTraceId = arg_23_1

	return
end

function IslandTaskAgency:GetMainTraceId()
	return self.mainTraceId
end

function IslandTaskAgency:GetMainTraceTask()
	if self.mainTraceId == 0 then
		return nil
	end

	return self.tasks[self.mainTraceId]
end

function IslandTaskAgency:GetPriorityTraceTaskId()
	local var_26_0 = {}

	for iter_26_0, iter_26_1 in pairs(self.tasks) do
		if not table.contains(IslandTaskType.EXCLUED_TRACK_TYPES, iter_26_1:GetType()) and self:IsShowInTaskUI(iter_26_1) then
			table.insert(var_26_0, iter_26_1)
		end
	end

	table.sort(var_26_0, CompareFuncs({
		function(arg_27_0)
			return -arg_27_0:GetAcceptTime()
		end,
		function(arg_28_0)
			return IslandTaskType.GetTrackPriority(arg_28_0:GetType())
		end,
		function(arg_29_0)
			return arg_29_0.id
		end
	}))

	return (var_26_0[1] or nil) and (var_26_0[1].id or 0)
end

function IslandTaskAgency:GetPriorityMainTraceTaskId()
	for iter_30_0, iter_30_1 in pairs(self.tasks) do
		if iter_30_1:GetType() == IslandTaskType.MAIN then
			return iter_30_1.id
		end
	end

	return 0
end

function IslandTaskAgency:AddTask(arg_31_1)
	self.tasks[arg_31_1.id] = arg_31_1

	if self.randomTaskTimes[arg_31_1.id] then
		self.tasks[arg_31_1.id]:SetEndTime(self.randomTaskTimes[arg_31_1.id])
	end

	self.futureTasks[arg_31_1.id] = nil

	table.insert(self.mutexIds, arg_31_1.id)

	for iter_31_0, iter_31_1 in pairs(self.futureTasks) do
		if self:CheckMutex(iter_31_1.id) then
			self:RemoveFutureTask(iter_31_1.id)
		end
	end

	self:DispatchEvent(IslandTaskAgency.TASK_ADDED, arg_31_1)

	return
end

function IslandTaskAgency:UpdateTask(arg_32_1)
	self.tasks[arg_32_1.id] = arg_32_1

	if self.randomTaskTimes[arg_32_1.id] then
		self.tasks[arg_32_1.id]:SetEndTime(self.randomTaskTimes[arg_32_1.id])
	end

	self:DispatchEvent(IslandTaskAgency.TASK_UPDATED, arg_32_1)

	if arg_32_1:IsFinish() and arg_32_1:IsSubmitImmediately() then
		pg.m02:sendNotification(GAME.ISLAND_SUBMIT_TASK, {
			taskId = arg_32_1.id
		})
	end

	return
end

function IslandTaskAgency:GetDiffTargetIdsByTypeAndParam(arg_33_1, arg_33_2)
	local var_33_0 = {}

	for iter_33_0, iter_33_1 in pairs(self.tasks) do
		var_33_0 = table.mergeArray(var_33_0, iter_33_1:GetTargetIdByTypeAndParam(arg_33_1, arg_33_2), true)
	end

	return var_33_0
end

function IslandTaskAgency:GetTasksByTypeAndParam(arg_34_1, arg_34_2)
	local var_34_0 = {}

	for iter_34_0, iter_34_1 in pairs(self.tasks) do
		if iter_34_1:ExistTargetType(arg_34_1, arg_34_2) then
			table.insert(var_34_0, iter_34_1)
		end
	end

	return task
end

function IslandTaskAgency:ExistDailyTask()
	for iter_35_0, iter_35_1 in pairs(self.tasks) do
		if iter_35_1:GetShowType() == IslandTaskType.DAILY then
			return true
		end
	end

	return false
end

function IslandTaskAgency:AddFinishId(arg_36_1)
	table.insert(self.finishedIds, arg_36_1)

	if pg.island_task[arg_36_1].type == IslandTaskType.DAILY and pg.island_task[arg_36_1].count_offset == 1 then
		self.finishedDailyCntInWeek = self.finishedDailyCntInWeek + 1
	end

	self:DispatchEvent(IslandTaskAgency.TASK_FINISH, arg_36_1)

	return
end

function IslandTaskAgency:RemoveTask(arg_37_1)
	self.tasks[arg_37_1] = nil

	self:DispatchEvent(IslandTaskAgency.TASK_REMOVED, self.tasks[arg_37_1])

	return
end

function IslandTaskAgency:RemoveFutureTask(arg_38_1)
	self.futureTasks[arg_38_1] = nil

	self:DispatchEvent(IslandTaskAgency.FUTURE_TASK_REMOVED, self.futureTasks[arg_38_1])

	return
end

function IslandTaskAgency:UpdatePerDay()
	if pg.TimeMgr.GetInstance():GetServerWeek() == 1 then
		self.finishedDailyCntInWeek = 0
	end

	pg.m02:sendNotification(GAME.ISLAND_GET_RANDOM_REFRESH_TASK)

	return
end

function IslandTaskAgency:UpdateRandomRefreshTask(arg_40_1)
	for iter_40_0, iter_40_1 in ipairs(arg_40_1.remove_task_list or {}) do
		self.tasks[iter_40_1] = nil
	end

	for iter_40_2, iter_40_3 in ipairs(arg_40_1.remove_task_finish or {}) do
		table.removebyvalue(self.finishedIds, iter_40_3)
	end

	self:InitFutureTasks(arg_40_1.task_list_random or {})

	for iter_40_4, iter_40_5 in ipairs(arg_40_1.task_list or {}) do
		self:AddTask((IslandTask.New(iter_40_5)))
	end

	if arg_40_1.task_list and #arg_40_1.task_list > 0 then
		self:TryAutoTrackTask()
	end

	return
end

function IslandTaskAgency:UpdatePerSecond()
	for iter_41_0, iter_41_1 in pairs(self.tasks) do
		if not iter_41_1:InTime() then
			self:RemoveTask(iter_41_1.id)
		end
	end

	for iter_41_2, iter_41_3 in pairs(self.futureTasks) do
		if not iter_41_3:InTime() then
			self:RemoveFutureTask(iter_41_3.id)
		end
	end

	local var_41_1 = pg.TimeMgr.GetInstance():GetServerTime()

	if self.acceptCheckTimestampTags[var_41_1] then
		self.acceptCheckTimestampTags[var_41_1] = nil

		self:TryAcceptAutoTasks()
	end

	return
end

function IslandTaskAgency:TryAcceptAutoTasks(arg_42_1)
	local var_42_0 = {}

	self.acceptCheckTimestampTags = {}

	for iter_42_0, iter_42_1 in pairs(self.futureTasks) do
		if iter_42_1:IsAcceptImmediately() and iter_42_1:IsUnlock() then
			table.insert(var_42_0, iter_42_1.id)
		elseif iter_42_1:IsUnlockWaitTime() then
			self.acceptCheckTimestampTags[iter_42_1:GetUnlockTime()] = true
		end
	end

	if #var_42_0 > 0 then
		pg.m02:sendNotification(GAME.ISLAND_ACCEPT_TASK, {
			taskIds = var_42_0,
			callback = arg_42_1
		})
	else
		existCall(arg_42_1)
	end

	return
end

function IslandTaskAgency:TrySubmitAutoTasks(arg_43_1)
	local var_43_0 = {}

	for iter_43_0, iter_43_1 in pairs(self.tasks) do
		if iter_43_1:IsFinish() and iter_43_1:IsSubmitImmediately() then
			table.insert(var_43_0, function(arg_44_0)
				pg.m02:sendNotification(GAME.ISLAND_SUBMIT_TASK, {
					taskId = iter_43_1.id,
					callback = arg_44_0
				})

				return
			end)
		end
	end

	seriesAsync(var_43_0, function()
		existCall(arg_43_1)

		return
	end)

	return
end

function IslandTaskAgency:TryAutoTrackTask()
	local var_46_0 = self:GetPriorityTraceTaskId()

	if var_46_0 then
		pg.m02:sendNotification(GAME.ISLAND_SET_TRACE_TASK, {
			traceId = var_46_0,
			type = IslandTaskTrackCard.TYPES.OTHER
		})
	end

	local var_46_1 = self:GetPriorityMainTraceTaskId()

	if var_46_1 then
		pg.m02:sendNotification(GAME.ISLAND_SET_TRACE_TASK, {
			traceId = var_46_1,
			type = IslandTaskTrackCard.TYPES.MAIN
		})
	end

	return
end

function IslandTaskAgency:GetCanAcceptTasks()
	local var_47_0 = {}

	for iter_47_0, iter_47_1 in pairs(self.futureTasks) do
		if iter_47_1:IsUnlock() then
			table.insert(var_47_0, iter_47_1)
		end
	end

	return var_47_0
end

function IslandTaskAgency:GetCanSubmitTasks()
	local var_48_0 = {}

	for iter_48_0, iter_48_1 in pairs(self.tasks) do
		if iter_48_1:IsFinish() then
			table.insert(var_48_0, iter_48_1)
		end
	end

	return var_48_0
end

function IslandTaskAgency:GetCanAcceptTasksByMapId(arg_49_1)
	local var_49_0 = {}

	for iter_49_0, iter_49_1 in pairs(self.futureTasks) do
		if iter_49_1:getConfig("map_trigger_tips") == arg_49_1 and iter_49_1:IsUnlock() then
			table.insert(var_49_0, iter_49_1)
		end
	end

	return var_49_0
end

function IslandTaskAgency:GetCanSubmitTasksByMapId(arg_50_1)
	local var_50_0 = {}

	for iter_50_0, iter_50_1 in pairs(self.tasks) do
		if iter_50_1:getConfig("map_complete_tips") == arg_50_1 and iter_50_1:IsFinish() then
			table.insert(var_50_0, iter_50_1)
		end
	end

	return var_50_0
end

function IslandTaskAgency:IsServerAcceptType()
	return pg.island_task[self].trigger_type == 3
end

return IslandTaskAgency
