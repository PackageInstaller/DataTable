class = var_0_10000

local var_0_0 = "IslandTaskAgency"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandBaseAgency"))

var_0_1.TASK_ADDED = "IslandTaskAgency.TASK_ADDED"
var_0_1.TASK_UPDATED = "IslandTaskAgency.TASK_UPDATED"
var_0_1.TASK_REMOVED = "IslandTaskAgency.TASK_REMOVED"
var_0_1.FUTURE_TASK_REMOVED = "IslandTaskAgency.FUTURE_TASK_REMOVED"
var_0_1.TASK_FINISH = "IslandTaskAgency.TASK_FINISH"

function var_0_1.OnInit(arg_1_0, arg_1_1)
	local var_1_0

	if not arg_1_1.task_info then
		var_1_0 = {}
	end

	local var_1_1

	if not var_1_0.week_daily_task_num then
		var_1_1 = 0
	end

	arg_1_0.finishedDailyCntInWeek = var_1_1

	local var_1_2

	if not var_1_0.focus_id then
		var_1_2 = 0
	end

	arg_1_0.traceId = var_1_2

	local var_1_3

	if not var_1_0.task_id_list_finish then
		var_1_3 = {}
	end

	arg_1_0.finishedIds = var_1_3
	arg_1_0.tasks = {}
	ipairs = var_3

	local var_1_4

	if not var_1_0.task_list then
		var_1_4 = {}
	end

	for iter_1_0, iter_1_1 in var_3(var_1_4) do
		IslandTask = var_1_10008
		var_1_10008 = var_1_10008.New(iter_1_1)
		arg_1_0.tasks[var_1_10008.id] = var_1_10008
	end

	local var_1_5 = arg_1_0
	local var_1_6 = arg_1_0.InitFutureTasks
	local var_1_7

	if not var_1_0.task_list_random then
		var_1_7 = {}
	end

	var_1_6(var_1_5, var_1_7)
	arg_1_0:SetMainTraceId(arg_1_0:GetPriorityMainTraceTaskId())

	arg_1_0.acceptCheckTimestampTags = {}

	if arg_1_0.traceId ~= 0 then
		if arg_1_0.tasks[arg_1_0.traceId] then
			local var_1_8 = var_3
			local var_1_9 = var_3.GetType(var_1_8)

			IslandTaskType = var_1_8

			if var_1_9 ~= var_1_8.MAIN then
				if not arg_1_0:IsShowInTaskUI(var_3) then
					arg_1_0.traceId = 0
				end

				return
			end
		end
	end
end

function var_0_1.InitFutureTasks(arg_2_0, arg_2_1)
	Clone = var_1_10002
	arg_2_0.mutexIds = var_1_10002(arg_2_0.finishedIds)
	pairs = var_2

	for iter_2_0, iter_2_1 in var_2(arg_2_0.tasks) do
		table = var_1_10007

		var_1_10007.insert(arg_2_0.mutexIds, iter_2_1.id)
	end

	arg_2_0.futureTasks = {}
	arg_2_0.randomTaskTimes = {}
	ipairs = var_2

	for iter_2_2, iter_2_3 in var_2(arg_2_1) do
		var_1_10007 = arg_2_0.randomTaskTimes
		var_1_10007[iter_2_3.task_id] = iter_2_3.timestamp
		var_1_10008 = arg_2_0

		if not arg_2_0.CheckMutex(var_1_10008, iter_2_3.task_id) then
			IslandFutureTask = var_1_10007
			var_1_10007 = var_1_10007.New(iter_2_3)
			var_1_10008 = arg_2_0.futureTasks
			var_1_10008[var_1_10007.id] = var_1_10007
		end
	end

	ipairs = var_2
	IslandTaskType = var_3

	for iter_2_4, iter_2_5 in var_2(var_3.GetPermanentTypes()) do
		pg = var_1_10007

		if not var_1_10007.island_task.get_id_list_by_type[iter_2_5] then
			var_1_10007 = {}
		end

		underscore = var_1_10008
		var_1_10008 = var_1_10008.select(var_1_10007, function(arg_3_0)
			pg = var_2_10001

			local var_3_1

			if var_2_10001.island_task[arg_3_0].unlock_time ~= "stop" and not var_0_1.IsServerAcceptType(arg_3_0) then
				local var_3_0 = arg_2_0

				var_3_1 = not var_1.CheckMutex(var_3_0, arg_3_0)
			else
				var_3_1 = false
			end

			if false then
				var_3_1 = true
			end

			return var_3_1
		end)
		underscore = var_9

		var_9.each(var_1_10008, function(arg_4_0)
			IslandFutureTask = var_2_10001

			local var_4_0 = var_2_10001.New({
				task_id = arg_4_0
			})

			arg_2_0.futureTasks[var_4_0.id] = var_4_0

			return
		end)
	end

	arg_2_0:BuildObjectTaskHudData()

	return
end

function var_0_1.BuildObjectTaskHudData(arg_5_0)
	table = var_1_10001

	local var_5_0 = var_1_10001.mergeArray

	underscore = var_1_10002

	local var_5_1 = var_1_10002.keys(arg_5_0.tasks)

	underscore = var_3

	local var_5_2 = var_5_0(var_5_1, var_3.keys(arg_5_0.futureTasks))

	IslandObjectTaskHudHelper = var_5_1

	var_5_1.BuildData(var_5_2)

	return
end

function var_0_1.CheckMutex(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0

	if arg_6_0.IsPassId(var_6_0, arg_6_1) then
		return true
	end

	pg = var_2

	if var_2.island_task[arg_6_1].unlock_condition == "" or #var_2 == 0 then
		return false
	end

	underscore = var_6_0

	return var_6_0.any(var_2, function(arg_7_0)
		local var_7_0 = arg_7_0[1]

		IslandTaskConditionType = var_2_10002

		local var_7_1

		if var_7_0 == var_2_10002.MUTEX_TASK then
			table = var_7_0
			var_7_1 = var_7_0.contains(arg_6_0.mutexIds, arg_7_0[2])
		else
			var_7_1 = false
		end

		if false then
			var_7_1 = true
		end

		return var_7_1
	end)
end

function var_0_1.GetFinishedIds(arg_8_0)
	return arg_8_0.finishedIds
end

function var_0_1.IsFinishTask(arg_9_0, arg_9_1)
	table = var_1_10002

	return var_1_10002.contains(arg_9_0.finishedIds, arg_9_1)
end

function var_0_1.GetFinishCntByType(arg_10_0, arg_10_1, arg_10_2)
	underscore = var_1_10003

	return var_1_10003.reduce(arg_10_0.finishedIds, 0, function(arg_11_0, arg_11_1)
		pg = var_2_10002

		local var_11_0 = var_2_10002.island_task[arg_11_1]

		return arg_11_0 + ((not arg_10_2 or var_11_0.count_offset == 1) and var_11_0.type == arg_10_1 and 1 or 0)
	end)
end

function var_0_1.GetFinishedDailyCntInWeek(arg_12_0)
	return arg_12_0.finishedDailyCntInWeek
end

function var_0_1.IsPassId(arg_13_0, arg_13_1)
	table = var_1_10002

	return var_1_10002.contains(arg_13_0.mutexIds, arg_13_1)
end

function var_0_1.GetTasks(arg_14_0)
	return arg_14_0.tasks
end

function var_0_1.GetShowTasks(arg_15_0)
	local var_15_0 = {}

	pairs = var_1_10002

	for iter_15_0, iter_15_1 in var_1_10002(arg_15_0.tasks) do
		if arg_15_0:IsShowInTaskUI(iter_15_1) then
			table = var_7

			var_7.insert(var_15_0, iter_15_1)
		end
	end

	return var_15_0
end

function var_0_1.IsShowInTaskUI(arg_16_0, arg_16_1)
	if not arg_16_1 then
		return false
	end

	local var_16_0 = arg_16_1
	local var_16_1 = arg_16_1.getConfig(var_16_0, "type")

	IslandTaskType = var_16_0

	if var_16_1 == var_16_0.SEASON then
		return false
	end

	local var_16_2 = arg_16_1
	local var_16_3 = arg_16_1.getConfig(var_16_2, "link_task")

	underscore = var_16_2

	local var_16_4 = var_16_2.all(var_16_3, function(arg_17_0)
		local var_17_0 = arg_16_0

		return var_1.IsFinishTask(var_17_0, arg_17_0)
	end)

	IslandTaskType = var_5

	if var_16_1 == var_5.HIDE then
		if #var_16_3 > 0 and var_16_4 then
			return true
		end
	elseif var_16_4 then
		return true
	end

	return false
end

function var_0_1.GetTask(arg_18_0, arg_18_1)
	return arg_18_0.tasks[arg_18_1]
end

function var_0_1.GetFutureTask(arg_19_0, arg_19_1)
	return arg_19_0.futureTasks[arg_19_1]
end

function var_0_1.SetTraceId(arg_20_0, arg_20_1)
	arg_20_0.traceId = arg_20_1

	return
end

function var_0_1.GetTraceId(arg_21_0)
	return arg_21_0.traceId
end

function var_0_1.GetTraceTask(arg_22_0)
	if arg_22_0.traceId == 0 then
		return nil
	end

	return arg_22_0.tasks[arg_22_0.traceId]
end

function var_0_1.SetMainTraceId(arg_23_0, arg_23_1)
	arg_23_0.mainTraceId = arg_23_1

	return
end

function var_0_1.GetMainTraceId(arg_24_0)
	return arg_24_0.mainTraceId
end

function var_0_1.GetMainTraceTask(arg_25_0)
	if arg_25_0.mainTraceId == 0 then
		return nil
	end

	return arg_25_0.tasks[arg_25_0.mainTraceId]
end

function var_0_1.GetPriorityTraceTaskId(arg_26_0)
	local var_26_0 = {}

	pairs = var_1_10002

	for iter_26_0, iter_26_1 in var_1_10002(arg_26_0.tasks) do
		table = var_1_10007
		var_1_10007 = var_1_10007.contains
		IslandTaskType = var_1_10008

		if not var_1_10007(var_1_10008.EXCLUED_TRACK_TYPES, iter_26_1:GetType()) then
			var_1_10008 = arg_26_0

			if arg_26_0.IsShowInTaskUI(var_1_10008, iter_26_1) then
				table = var_1_10007

				var_1_10007.insert(var_26_0, iter_26_1)
			end
		end
	end

	table = var_2

	local var_26_1 = var_2.sort
	local var_26_2 = var_26_0

	CompareFuncs = var_4

	var_26_1(var_26_2, var_4({
		function(arg_27_0)
			return -arg_27_0:GetAcceptTime()
		end,
		function(arg_28_0)
			IslandTaskType = var_2_10001

			return var_2_10001.GetTrackPriority(arg_28_0:GetType())
		end,
		function(arg_29_0)
			return arg_29_0.id
		end
	}))

	local var_26_3

	if not var_26_0[1] or not var_26_0[1].id then
		var_26_3 = 0
	end

	return var_26_3
end

function var_0_1.GetPriorityMainTraceTaskId(arg_30_0)
	pairs = var_1_10001

	for iter_30_0, iter_30_1 in var_1_10001(arg_30_0.tasks) do
		local var_30_0 = iter_30_1
		local var_30_1 = iter_30_1.GetType(var_30_0)

		IslandTaskType = var_30_0

		if var_30_1 == var_30_0.MAIN then
			return iter_30_1.id
		end
	end

	return 0
end

function var_0_1.AddTask(arg_31_0, arg_31_1)
	arg_31_0.tasks[arg_31_1.id] = arg_31_1

	if arg_31_0.randomTaskTimes[arg_31_1.id] then
		local var_31_0 = arg_31_0.tasks[arg_31_1.id]

		var_2.SetEndTime(var_31_0, arg_31_0.randomTaskTimes[arg_31_1.id])
	end

	local var_31_1 = arg_31_0.futureTasks

	var_31_1[arg_31_1.id] = nil
	table = var_31_1

	var_31_1.insert(arg_31_0.mutexIds, arg_31_1.id)

	pairs = var_2

	for iter_31_0, iter_31_1 in var_2(arg_31_0.futureTasks) do
		if arg_31_0:CheckMutex(iter_31_1.id) then
			arg_31_0:RemoveFutureTask(iter_31_1.id)
		end
	end

	arg_31_0:DispatchEvent(var_0_1.TASK_ADDED, arg_31_1)

	return
end

function var_0_1.UpdateTask(arg_32_0, arg_32_1)
	arg_32_0.tasks[arg_32_1.id] = arg_32_1

	if arg_32_0.randomTaskTimes[arg_32_1.id] then
		local var_32_0 = arg_32_0.tasks[arg_32_1.id]

		var_2.SetEndTime(var_32_0, arg_32_0.randomTaskTimes[arg_32_1.id])
	end

	arg_32_0:DispatchEvent(var_0_1.TASK_UPDATED, arg_32_1)

	if arg_32_1:IsFinish() and arg_32_1:IsSubmitImmediately() then
		pg = var_2

		local var_32_1 = var_2.m02
		local var_32_2 = var_2.sendNotification

		GAME = var_4

		var_32_2(var_32_1, var_4.ISLAND_SUBMIT_TASK, {
			taskId = arg_32_1.id
		})
	end

	return
end

function var_0_1.GetDiffTargetIdsByTypeAndParam(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = {}

	pairs = var_1_10004

	for iter_33_0, iter_33_1 in var_1_10004(arg_33_0.tasks) do
		local var_33_1 = iter_33_1
		local var_33_2 = iter_33_1.GetTargetIdByTypeAndParam(var_33_1, arg_33_1, arg_33_2)

		table = var_33_1
		var_33_0 = var_33_1.mergeArray(var_33_0, var_33_2, true)
	end

	return var_33_0
end

function var_0_1.GetTasksByTypeAndParam(arg_34_0, arg_34_1, arg_34_2)
	local var_34_0 = {}

	pairs = var_1_10004

	for iter_34_0, iter_34_1 in var_1_10004(arg_34_0.tasks) do
		if iter_34_1:ExistTargetType(arg_34_1, arg_34_2) then
			table = var_9

			var_9.insert(var_34_0, iter_34_1)
		end
	end

	task = var_4

	return var_4
end

function var_0_1.ExistDailyTask(arg_35_0)
	pairs = var_1_10001

	for iter_35_0, iter_35_1 in var_1_10001(arg_35_0.tasks) do
		local var_35_0 = iter_35_1
		local var_35_1 = iter_35_1.GetShowType(var_35_0)

		IslandTaskType = var_35_0

		if var_35_1 == var_35_0.DAILY then
			return true
		end
	end

	return false
end

function var_0_1.AddFinishId(arg_36_0, arg_36_1)
	table = var_1_10002

	var_1_10002.insert(arg_36_0.finishedIds, arg_36_1)

	pg = var_2

	local var_36_0 = var_2.island_task[arg_36_1].type

	IslandTaskType = var_4

	if var_36_0 == var_4.DAILY and var_2.count_offset == 1 then
		arg_36_0.finishedDailyCntInWeek = arg_36_0.finishedDailyCntInWeek + 1
	end

	arg_36_0:DispatchEvent(var_0_1.TASK_FINISH, arg_36_1)

	return
end

function var_0_1.RemoveTask(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_0.tasks[arg_37_1]

	arg_37_0.tasks[arg_37_1] = nil

	arg_37_0:DispatchEvent(var_0_1.TASK_REMOVED, var_37_0)

	return
end

function var_0_1.RemoveFutureTask(arg_38_0, arg_38_1)
	local var_38_0 = arg_38_0.futureTasks[arg_38_1]

	arg_38_0.futureTasks[arg_38_1] = nil

	arg_38_0:DispatchEvent(var_0_1.FUTURE_TASK_REMOVED, var_38_0)

	return
end

function var_0_1.UpdatePerDay(arg_39_0)
	pg = var_1_10001

	local var_39_0 = var_1_10001.TimeMgr.GetInstance()

	if var_1.GetServerWeek(var_39_0) == 1 then
		arg_39_0.finishedDailyCntInWeek = 0
	end

	pg = var_1

	local var_39_1 = var_1.m02
	local var_39_2 = var_1.sendNotification

	GAME = var_1_10003

	var_39_2(var_39_1, var_1_10003.ISLAND_GET_RANDOM_REFRESH_TASK)

	return
end

function var_0_1.UpdateRandomRefreshTask(arg_40_0, arg_40_1)
	ipairs = var_1_10002

	local var_40_0

	if not arg_40_1.remove_task_list then
		var_40_0 = {}
	end

	for iter_40_0, iter_40_1 in var_1_10002(var_40_0) do
		var_1_10007 = arg_40_0.tasks
		var_1_10007[iter_40_1] = nil
	end

	ipairs = var_2

	local var_40_1

	if not arg_40_1.remove_task_finish then
		var_40_1 = {}
	end

	for iter_40_2, iter_40_3 in var_2(var_40_1) do
		table = var_1_10007

		var_1_10007.removebyvalue(arg_40_0.finishedIds, iter_40_3)
	end

	local var_40_2 = arg_40_0
	local var_40_3 = arg_40_0.InitFutureTasks
	local var_40_4

	if not arg_40_1.task_list_random then
		var_40_4 = {}
	end

	var_40_3(var_40_2, var_40_4)

	ipairs = var_40_3

	local var_40_5

	if not arg_40_1.task_list then
		var_40_5 = {}
	end

	for iter_40_4, iter_40_5 in var_40_3(var_40_5) do
		IslandTask = var_1_10007
		var_1_10007 = var_1_10007.New(iter_40_5)

		arg_40_0:AddTask(var_1_10007)
	end

	if arg_40_1.task_list and #arg_40_1.task_list > 0 then
		arg_40_0:TryAutoTrackTask()
	end

	return
end

function var_0_1.UpdatePerSecond(arg_41_0)
	pairs = var_1_10001

	for iter_41_0, iter_41_1 in var_1_10001(arg_41_0.tasks) do
		if not iter_41_1:InTime() then
			arg_41_0:RemoveTask(iter_41_1.id)
		end
	end

	local var_41_0 = {}

	pairs = var_2

	for iter_41_2, iter_41_3 in var_2(arg_41_0.futureTasks) do
		if not iter_41_3:InTime() then
			arg_41_0:RemoveFutureTask(iter_41_3.id)
		end
	end

	pg = var_2

	local var_41_1 = var_2.TimeMgr.GetInstance()
	local var_41_2 = var_2.GetServerTime(var_41_1)

	if arg_41_0.acceptCheckTimestampTags[var_41_2] then
		arg_41_0.acceptCheckTimestampTags[var_41_2] = nil

		arg_41_0:TryAcceptAutoTasks()
	end

	return
end

function var_0_1.TryAcceptAutoTasks(arg_42_0, arg_42_1)
	local var_42_0 = {}

	arg_42_0.acceptCheckTimestampTags = {}
	pairs = var_3

	for iter_42_0, iter_42_1 in var_3(arg_42_0.futureTasks) do
		if iter_42_1:IsAcceptImmediately() and iter_42_1:IsUnlock() then
			table = var_8

			var_8.insert(var_42_0, iter_42_1.id)
		elseif iter_42_1:IsUnlockWaitTime() then
			arg_42_0.acceptCheckTimestampTags[iter_42_1:GetUnlockTime()] = true
		end
	end

	local var_42_2

	if #var_42_0 > 0 then
		pg = var_42_2

		local var_42_1 = var_42_2.m02

		var_42_2 = var_42_2.sendNotification
		GAME = var_5

		var_42_2(var_42_1, var_5.ISLAND_ACCEPT_TASK, {
			taskIds = var_42_0,
			callback = arg_42_1
		})
	else
		existCall = var_42_2

		var_42_2(arg_42_1)
	end

	return
end

function var_0_1.TrySubmitAutoTasks(arg_43_0, arg_43_1)
	local var_43_0 = {}

	pairs = var_1_10003

	for iter_43_0, iter_43_1 in var_1_10003(arg_43_0.tasks) do
		if iter_43_1:IsFinish() and iter_43_1:IsSubmitImmediately() then
			table = var_8

			var_8.insert(var_43_0, function(arg_44_0)
				pg = var_2_10001

				local var_44_0 = var_2_10001.m02
				local var_44_1 = var_1.sendNotification

				GAME = var_2_10003

				var_44_1(var_44_0, var_2_10003.ISLAND_SUBMIT_TASK, {
					taskId = iter_43_1.id,
					callback = arg_44_0
				})

				return
			end)
		end
	end

	seriesAsync = var_3

	var_3(var_43_0, function()
		existCall = var_2_10000

		var_2_10000(arg_43_1)

		return
	end)

	return
end

function var_0_1.TryAutoTrackTask(arg_46_0)
	local var_46_0 = arg_46_0

	if arg_46_0.GetPriorityTraceTaskId(var_46_0) then
		pg = var_46_0

		local var_46_1 = var_46_0.m02
		local var_46_2 = var_2.sendNotification

		GAME = var_1_10004

		local var_46_3 = var_1_10004.ISLAND_SET_TRACE_TASK

		var_1_10005 = {
			traceId = var_1
		}
		IslandTaskTrackCard = var_1_10006
		var_1_10005.type = var_1_10006.TYPES.OTHER

		var_46_2(var_46_1, var_46_3, var_1_10005)
	end

	local var_46_4 = arg_46_0

	if arg_46_0.GetPriorityMainTraceTaskId(var_46_4) then
		pg = var_46_4

		local var_46_5 = var_46_4.m02
		local var_46_6 = var_3.sendNotification

		GAME = var_1_10005

		local var_46_7 = var_1_10005.ISLAND_SET_TRACE_TASK
		local var_46_8 = {
			traceId = var_2
		}

		IslandTaskTrackCard = var_1_10007
		var_46_8.type = var_1_10007.TYPES.MAIN

		var_46_6(var_46_5, var_46_7, var_46_8)
	end

	return
end

function var_0_1.GetCanAcceptTasks(arg_47_0)
	local var_47_0 = {}

	pairs = var_1_10002

	for iter_47_0, iter_47_1 in var_1_10002(arg_47_0.futureTasks) do
		if iter_47_1:IsUnlock() then
			table = var_7

			var_7.insert(var_47_0, iter_47_1)
		end
	end

	return var_47_0
end

function var_0_1.GetCanSubmitTasks(arg_48_0)
	local var_48_0 = {}

	pairs = var_1_10002

	for iter_48_0, iter_48_1 in var_1_10002(arg_48_0.tasks) do
		if iter_48_1:IsFinish() then
			table = var_7

			var_7.insert(var_48_0, iter_48_1)
		end
	end

	return var_48_0
end

function var_0_1.GetCanAcceptTasksByMapId(arg_49_0, arg_49_1)
	local var_49_0 = {}

	pairs = var_1_10003

	for iter_49_0, iter_49_1 in var_1_10003(arg_49_0.futureTasks) do
		if iter_49_1:getConfig("map_trigger_tips") == arg_49_1 and iter_49_1:IsUnlock() then
			table = var_8

			var_8.insert(var_49_0, iter_49_1)
		end
	end

	return var_49_0
end

function var_0_1.GetCanSubmitTasksByMapId(arg_50_0, arg_50_1)
	local var_50_0 = {}

	pairs = var_1_10003

	for iter_50_0, iter_50_1 in var_1_10003(arg_50_0.tasks) do
		if iter_50_1:getConfig("map_complete_tips") == arg_50_1 and iter_50_1:IsFinish() then
			table = var_8

			var_8.insert(var_50_0, iter_50_1)
		end
	end

	return var_50_0
end

function var_0_1.IsServerAcceptType(arg_51_0)
	pg = var_1_10001

	return var_1_10001.island_task[arg_51_0].trigger_type == 3
end

return var_0_1
