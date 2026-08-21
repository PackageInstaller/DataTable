local var_0_0 = class("IslandTaskAgency", import(".IslandBaseAgency"))

var_0_0.TASK_ADDED = "IslandTaskAgency.TASK_ADDED"
var_0_0.TASK_UPDATED = "IslandTaskAgency.TASK_UPDATED"
var_0_0.TASK_REMOVED = "IslandTaskAgency.TASK_REMOVED"
var_0_0.FUTURE_TASK_REMOVED = "IslandTaskAgency.FUTURE_TASK_REMOVED"
var_0_0.TASK_FINISH = "IslandTaskAgency.TASK_FINISH"

function var_0_0.OnInit(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1.task_info or {}

	arg_1_0.finishedDailyCntInWeek = var_1_0.week_daily_task_num or 0
	arg_1_0.traceId = var_1_0.focus_id or 0
	arg_1_0.finishedIds = var_1_0.task_id_list_finish or {}
	arg_1_0.tasks = {}

	local var_1_1 = var_1_0.task_list or {}

	for iter_1_0, iter_1_1 in ipairs(var_1_1) do
		local var_1_2 = IslandTask.New(iter_1_1)

		arg_1_0.tasks[var_1_2.id] = var_1_2
	end

	local var_1_3 = var_1_0.task_list_random or {}

	arg_1_0:InitFutureTasks(var_1_3)
	arg_1_0:SetMainTraceId(arg_1_0:GetPriorityMainTraceTaskId())

	arg_1_0.acceptCheckTimestampTags = {}

	if arg_1_0.traceId ~= 0 then
		if arg_1_0.tasks[arg_1_0.traceId] and arg_1_0.tasks[arg_1_0.traceId]:GetType() == IslandTaskType.MAIN or not arg_1_0:IsShowInTaskUI(arg_1_0.tasks[arg_1_0.traceId]) then
			arg_1_0.traceId = 0
		end
	end

	return
end

function var_0_0.InitFutureTasks(arg_2_0, arg_2_1)
	arg_2_0.mutexIds = Clone(arg_2_0.finishedIds)

	for iter_2_0, iter_2_1 in pairs(arg_2_0.tasks) do
		table.insert(arg_2_0.mutexIds, iter_2_1.id)
	end

	arg_2_0.futureTasks = {}
	arg_2_0.randomTaskTimes = {}

	for iter_2_2, iter_2_3 in ipairs(arg_2_1) do
		arg_2_0.randomTaskTimes[iter_2_3.task_id] = iter_2_3.timestamp

		if not arg_2_0:CheckMutex(iter_2_3.task_id) then
			local var_2_0 = IslandFutureTask.New(iter_2_3)

			arg_2_0.futureTasks[var_2_0.id] = var_2_0
		end
	end

	for iter_2_4, iter_2_5 in ipairs(IslandTaskType.GetPermanentTypes()) do
		local var_2_1 = pg.island_task.get_id_list_by_type[iter_2_5] or {}

		underscore.each(underscore.select(var_2_1, function(arg_3_0)
			return pg.island_task[arg_3_0].unlock_time ~= "stop" and not var_0_0.IsServerAcceptType(arg_3_0) and not arg_2_0:CheckMutex(arg_3_0)
		end), function(arg_4_0)
			local var_4_0 = IslandFutureTask.New({
				task_id = arg_4_0
			})

			arg_2_0.futureTasks[var_4_0.id] = var_4_0

			return
		end)
	end

	arg_2_0:BuildObjectTaskHudData()

	return
end

function var_0_0.BuildObjectTaskHudData(arg_5_0)
	IslandObjectTaskHudHelper.BuildData((table.mergeArray(underscore.keys(arg_5_0.tasks), underscore.keys(arg_5_0.futureTasks))))

	return
end

function var_0_0.CheckMutex(arg_6_0, arg_6_1)
	if arg_6_0:IsPassId(arg_6_1) then
		return true
	end

	local var_6_0 = pg.island_task[arg_6_1].unlock_condition

	if pg.island_task[arg_6_1].unlock_condition == "" or #var_6_0 == 0 then
		return false
	end

	return underscore.any(var_6_0, function(arg_7_0)
		return arg_7_0[1] == IslandTaskConditionType.MUTEX_TASK and table.contains(arg_6_0.mutexIds, arg_7_0[2])
	end)
end

function var_0_0.GetFinishedIds(arg_8_0)
	return arg_8_0.finishedIds
end

function var_0_0.IsFinishTask(arg_9_0, arg_9_1)
	return table.contains(arg_9_0.finishedIds, arg_9_1)
end

function var_0_0.GetFinishCntByType(arg_10_0, arg_10_1, arg_10_2)
	return underscore.reduce(arg_10_0.finishedIds, 0, function(arg_11_0, arg_11_1)
		local var_11_0 = pg.island_task[arg_11_1]

		return arg_11_0 + ((not arg_10_2 or var_11_0.count_offset == 1) and var_11_0.type == arg_10_1 and 1 or 0)
	end)
end

function var_0_0.GetFinishedDailyCntInWeek(arg_12_0)
	return arg_12_0.finishedDailyCntInWeek
end

function var_0_0.IsPassId(arg_13_0, arg_13_1)
	return table.contains(arg_13_0.mutexIds, arg_13_1)
end

function var_0_0.GetTasks(arg_14_0)
	return arg_14_0.tasks
end

function var_0_0.GetShowTasks(arg_15_0)
	for iter_15_0, iter_15_1 in pairs(arg_15_0.tasks) do
		if arg_15_0:IsShowInTaskUI(iter_15_1) then
			table.insert({}, iter_15_1)
		end
	end

	return {}
end

function var_0_0.IsShowInTaskUI(arg_16_0, arg_16_1)
	if not arg_16_1 then
		return false
	end

	local var_16_0 = arg_16_1:getConfig("type")

	if var_16_0 == IslandTaskType.SEASON then
		return false
	end

	local var_16_1 = arg_16_1:getConfig("link_task")
	local var_16_2 = underscore.all(var_16_1, function(arg_17_0)
		return arg_16_0:IsFinishTask(arg_17_0)
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

function var_0_0.GetTask(arg_18_0, arg_18_1)
	return arg_18_0.tasks[arg_18_1]
end

function var_0_0.GetFutureTask(arg_19_0, arg_19_1)
	return arg_19_0.futureTasks[arg_19_1]
end

function var_0_0.SetTraceId(arg_20_0, arg_20_1)
	arg_20_0.traceId = arg_20_1

	return
end

function var_0_0.GetTraceId(arg_21_0)
	return arg_21_0.traceId
end

function var_0_0.GetTraceTask(arg_22_0)
	if arg_22_0.traceId == 0 then
		return nil
	end

	return arg_22_0.tasks[arg_22_0.traceId]
end

function var_0_0.SetMainTraceId(arg_23_0, arg_23_1)
	arg_23_0.mainTraceId = arg_23_1

	return
end

function var_0_0.GetMainTraceId(arg_24_0)
	return arg_24_0.mainTraceId
end

function var_0_0.GetMainTraceTask(arg_25_0)
	if arg_25_0.mainTraceId == 0 then
		return nil
	end

	return arg_25_0.tasks[arg_25_0.mainTraceId]
end

function var_0_0.GetPriorityTraceTaskId(arg_26_0)
	for iter_26_0, iter_26_1 in pairs(arg_26_0.tasks) do
		if not table.contains(IslandTaskType.EXCLUED_TRACK_TYPES, iter_26_1:GetType()) and arg_26_0:IsShowInTaskUI(iter_26_1) then
			table.insert({}, iter_26_1)
		end
	end

	table.sort({}, CompareFuncs({
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

	if ({})[1] then
		local var_26_0 = ({})[1].id

		if not ({})[1].id then
			var_26_0 = 0
		end

		return var_26_0
	end
end

function var_0_0.GetPriorityMainTraceTaskId(arg_30_0)
	for iter_30_0, iter_30_1 in pairs(arg_30_0.tasks) do
		if iter_30_1:GetType() == IslandTaskType.MAIN then
			return iter_30_1.id
		end
	end

	return 0
end

function var_0_0.AddTask(arg_31_0, arg_31_1)
	arg_31_0.tasks[arg_31_1.id] = arg_31_1

	if arg_31_0.randomTaskTimes[arg_31_1.id] then
		arg_31_0.tasks[arg_31_1.id]:SetEndTime(arg_31_0.randomTaskTimes[arg_31_1.id])
	end

	arg_31_0.futureTasks[arg_31_1.id] = nil

	table.insert(arg_31_0.mutexIds, arg_31_1.id)

	for iter_31_0, iter_31_1 in pairs(arg_31_0.futureTasks) do
		if arg_31_0:CheckMutex(iter_31_1.id) then
			arg_31_0:RemoveFutureTask(iter_31_1.id)
		end
	end

	arg_31_0:DispatchEvent(var_0_0.TASK_ADDED, arg_31_1)

	return
end

function var_0_0.UpdateTask(arg_32_0, arg_32_1)
	arg_32_0.tasks[arg_32_1.id] = arg_32_1

	if arg_32_0.randomTaskTimes[arg_32_1.id] then
		arg_32_0.tasks[arg_32_1.id]:SetEndTime(arg_32_0.randomTaskTimes[arg_32_1.id])
	end

	arg_32_0:DispatchEvent(var_0_0.TASK_UPDATED, arg_32_1)

	if arg_32_1:IsFinish() and arg_32_1:IsSubmitImmediately() then
		pg.m02:sendNotification(GAME.ISLAND_SUBMIT_TASK, {
			taskId = arg_32_1.id
		})
	end

	return
end

function var_0_0.GetDiffTargetIdsByTypeAndParam(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = {}

	for iter_33_0, iter_33_1 in pairs(arg_33_0.tasks) do
		var_33_0 = table.mergeArray(var_33_0, iter_33_1:GetTargetIdByTypeAndParam(arg_33_1, arg_33_2), true)
	end

	return var_33_0
end

function var_0_0.GetTasksByTypeAndParam(arg_34_0, arg_34_1, arg_34_2)
	for iter_34_0, iter_34_1 in pairs(arg_34_0.tasks) do
		if iter_34_1:ExistTargetType(arg_34_1, arg_34_2) then
			table.insert({}, iter_34_1)
		end
	end

	return task
end

function var_0_0.ExistDailyTask(arg_35_0)
	for iter_35_0, iter_35_1 in pairs(arg_35_0.tasks) do
		if iter_35_1:GetShowType() == IslandTaskType.DAILY then
			return true
		end
	end

	return false
end

function var_0_0.AddFinishId(arg_36_0, arg_36_1)
	table.insert(arg_36_0.finishedIds, arg_36_1)

	if pg.island_task[arg_36_1].type == IslandTaskType.DAILY and pg.island_task[arg_36_1].count_offset == 1 then
		arg_36_0.finishedDailyCntInWeek = arg_36_0.finishedDailyCntInWeek + 1
	end

	arg_36_0:DispatchEvent(var_0_0.TASK_FINISH, arg_36_1)

	return
end

function var_0_0.RemoveTask(arg_37_0, arg_37_1)
	arg_37_0.tasks[arg_37_1] = nil

	arg_37_0:DispatchEvent(var_0_0.TASK_REMOVED, arg_37_0.tasks[arg_37_1])

	return
end

function var_0_0.RemoveFutureTask(arg_38_0, arg_38_1)
	arg_38_0.futureTasks[arg_38_1] = nil

	arg_38_0:DispatchEvent(var_0_0.FUTURE_TASK_REMOVED, arg_38_0.futureTasks[arg_38_1])

	return
end

function var_0_0.UpdatePerDay(arg_39_0)
	if pg.TimeMgr.GetInstance():GetServerWeek() == 1 then
		arg_39_0.finishedDailyCntInWeek = 0
	end

	pg.m02:sendNotification(GAME.ISLAND_GET_RANDOM_REFRESH_TASK)

	return
end

function var_0_0.UpdateRandomRefreshTask(arg_40_0, arg_40_1)
	local var_40_0 = arg_40_1.remove_task_list or {}

	for iter_40_0, iter_40_1 in ipairs(var_40_0) do
		arg_40_0.tasks[iter_40_1] = nil
	end

	local var_40_1 = arg_40_1.remove_task_finish or {}

	for iter_40_2, iter_40_3 in ipairs(var_40_1) do
		table.removebyvalue(arg_40_0.finishedIds, iter_40_3)
	end

	local var_40_2 = arg_40_1.task_list_random or {}

	arg_40_0:InitFutureTasks(var_40_2)

	local var_40_3 = arg_40_1.task_list or {}

	for iter_40_4, iter_40_5 in ipairs(var_40_3) do
		arg_40_0:AddTask((IslandTask.New(iter_40_5)))
	end

	if arg_40_1.task_list and #arg_40_1.task_list > 0 then
		arg_40_0:TryAutoTrackTask()
	end

	return
end

function var_0_0.UpdatePerSecond(arg_41_0)
	for iter_41_0, iter_41_1 in pairs(arg_41_0.tasks) do
		if not iter_41_1:InTime() then
			arg_41_0:RemoveTask(iter_41_1.id)
		end
	end

	for iter_41_2, iter_41_3 in pairs(arg_41_0.futureTasks) do
		if not iter_41_3:InTime() then
			arg_41_0:RemoveFutureTask(iter_41_3.id)
		end
	end

	local var_41_1 = pg.TimeMgr.GetInstance():GetServerTime()

	if arg_41_0.acceptCheckTimestampTags[var_41_1] then
		arg_41_0.acceptCheckTimestampTags[var_41_1] = nil

		arg_41_0:TryAcceptAutoTasks()
	end

	return
end

function var_0_0.TryAcceptAutoTasks(arg_42_0, arg_42_1)
	arg_42_0.acceptCheckTimestampTags = {}

	for iter_42_0, iter_42_1 in pairs(arg_42_0.futureTasks) do
		if iter_42_1:IsAcceptImmediately() and iter_42_1:IsUnlock() then
			table.insert({}, iter_42_1.id)
		elseif iter_42_1:IsUnlockWaitTime() then
			arg_42_0.acceptCheckTimestampTags[iter_42_1:GetUnlockTime()] = true
		end
	end

	if #{} > 0 then
		pg.m02:sendNotification(GAME.ISLAND_ACCEPT_TASK, {
			taskIds = {},
			callback = arg_42_1
		})
	else
		existCall(arg_42_1)
	end

	return
end

function var_0_0.TrySubmitAutoTasks(arg_43_0, arg_43_1)
	for iter_43_0, iter_43_1 in pairs(arg_43_0.tasks) do
		if iter_43_1:IsFinish() and iter_43_1:IsSubmitImmediately() then
			table.insert({}, function(arg_44_0)
				pg.m02:sendNotification(GAME.ISLAND_SUBMIT_TASK, {
					taskId = iter_43_1.id,
					callback = arg_44_0
				})

				return
			end)
		end
	end

	seriesAsync({}, function()
		existCall(arg_43_1)

		return
	end)

	return
end

function var_0_0.TryAutoTrackTask(arg_46_0)
	local var_46_0 = arg_46_0:GetPriorityTraceTaskId()

	if var_46_0 then
		pg.m02:sendNotification(GAME.ISLAND_SET_TRACE_TASK, {
			traceId = var_46_0,
			type = IslandTaskTrackCard.TYPES.OTHER
		})
	end

	local var_46_1 = arg_46_0:GetPriorityMainTraceTaskId()

	if var_46_1 then
		pg.m02:sendNotification(GAME.ISLAND_SET_TRACE_TASK, {
			traceId = var_46_1,
			type = IslandTaskTrackCard.TYPES.MAIN
		})
	end

	return
end

function var_0_0.GetCanAcceptTasks(arg_47_0)
	for iter_47_0, iter_47_1 in pairs(arg_47_0.futureTasks) do
		if iter_47_1:IsUnlock() then
			table.insert({}, iter_47_1)
		end
	end

	return {}
end

function var_0_0.GetCanSubmitTasks(arg_48_0)
	for iter_48_0, iter_48_1 in pairs(arg_48_0.tasks) do
		if iter_48_1:IsFinish() then
			table.insert({}, iter_48_1)
		end
	end

	return {}
end

function var_0_0.GetCanAcceptTasksByMapId(arg_49_0, arg_49_1)
	for iter_49_0, iter_49_1 in pairs(arg_49_0.futureTasks) do
		if iter_49_1:getConfig("map_trigger_tips") == arg_49_1 and iter_49_1:IsUnlock() then
			table.insert({}, iter_49_1)
		end
	end

	return {}
end

function var_0_0.GetCanSubmitTasksByMapId(arg_50_0, arg_50_1)
	for iter_50_0, iter_50_1 in pairs(arg_50_0.tasks) do
		if iter_50_1:getConfig("map_complete_tips") == arg_50_1 and iter_50_1:IsFinish() then
			table.insert({}, iter_50_1)
		end
	end

	return {}
end

function var_0_0.IsServerAcceptType(arg_51_0)
	return pg.island_task[arg_51_0].trigger_type == 3
end

return var_0_0
