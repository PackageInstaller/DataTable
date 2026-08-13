class = var_0_10000

local var_0_0 = "WorldTaskProxy"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("....BaseEntity"))

var_0_1.Fields = {
	itemListenerList = "table",
	dailyTaskIds = "table",
	list = "table",
	dailyTimeStemp = "number",
	dailyTimer = "table",
	taskFinishCount = "number",
	mapList = "table",
	mapListenerList = "table",
	recycle = "table"
}
var_0_1.EventUpdateTask = "WorldTaskProxy.EventUpdateTask"
var_0_1.EventUpdateDailyTaskIds = "WorldTaskProxy.EventUpdateDailyTaskIds"

function var_0_1.Build(arg_1_0)
	arg_1_0.list = {}
	arg_1_0.recycle = {}
	arg_1_0.itemListenerList = {}
	arg_1_0.mapListenerList = {}

	return
end

function var_0_1.Setup(arg_2_0, arg_2_1)
	ipairs = var_1_10002

	for iter_2_0, iter_2_1 in var_1_10002(arg_2_1) do
		WorldTask = var_1_10007

		local var_2_0 = var_1_10007.New(iter_2_1)
		local var_2_1 = var_1_10007.getState(var_2_0)

		WorldTask = var_2_0

		if var_2_1 == var_2_0.STATE_RECEIVED then
			arg_2_0.recycle[var_1_10007.id] = var_1_10007
		else
			arg_2_0:addTask(var_1_10007)
		end
	end

	return
end

function var_0_1.Dispose(arg_3_0)
	arg_3_0:Clear()

	return
end

function var_0_1.getTaskById(arg_4_0, arg_4_1)
	assert = var_1_10002

	var_1_10002(arg_4_1, "taskId can not be nil")

	return arg_4_0.list[arg_4_1]
end

function var_0_1.addTaskListener(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1.config.complete_condition

	WorldConst = var_1_10003

	local var_5_2

	if var_5_0 == var_1_10003.TaskTypeSubmitItem then
		local var_5_1 = arg_5_1.config.complete_parameter[1]

		var_5_2 = arg_5_0.itemListenerList

		local var_5_3

		if not arg_5_0.itemListenerList[var_5_1] then
			var_5_3 = {}
		end

		var_5_2[var_5_1] = var_5_3
		table = var_5_2

		var_5_2.insert(arg_5_0.itemListenerList[var_5_1], arg_5_1.id)
	else
		local var_5_4 = arg_5_1.config.complete_condition

		WorldConst = var_5_2

		if var_5_4 == var_5_2.TaskTypePressingMap then
			ipairs = var_5_4

			for iter_5_0, iter_5_1 in var_5_4(arg_5_1.config.complete_parameter) do
				local var_5_5 = arg_5_0.mapListenerList
				local var_5_6

				if not arg_5_0.mapListenerList[iter_5_1] then
					var_5_6 = {}
				end

				var_5_5[iter_5_1] = var_5_6
				table = var_5_5

				var_5_5.insert(arg_5_0.mapListenerList[iter_5_1], arg_5_1.id)
			end
		end
	end

	return
end

function var_0_1.removeTaskListener(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1.config.complete_condition

	WorldConst = var_1_10003

	if var_6_0 == var_1_10003.TaskTypeSubmitItem then
		local var_6_1 = arg_6_1.config.complete_parameter[1]

		table = var_3

		var_3.removebyvalue(arg_6_0.itemListenerList[var_6_1], arg_6_1.id)
	else
		local var_6_2 = arg_6_1.config.complete_condition

		WorldConst = var_3

		if var_6_2 == var_3.TaskTypePressingMap then
			ipairs = var_6_2

			for iter_6_0, iter_6_1 in var_6_2(arg_6_1.config.complete_parameter) do
				table = var_1_10007

				var_1_10007.removebyvalue(arg_6_0.mapListenerList[iter_6_1], arg_6_1.id)
			end
		end
	end

	return
end

function var_0_1.doUpdateTaskByItem(arg_7_0, arg_7_1)
	if not arg_7_0.itemListenerList[arg_7_1.id] then
		return
	end

	ipairs = var_2

	for iter_7_0, iter_7_1 in var_2(arg_7_0.itemListenerList[arg_7_1.id]) do
		local var_7_0 = arg_7_0:getTaskById(iter_7_1)

		var_7.updateProgress(var_7_0, arg_7_1.count)
		arg_7_0:updateTask(var_7)
	end

	return
end

function var_0_1.doUpdateTaskByMap(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_0.mapListenerList[arg_8_1] then
		return
	end

	ipairs = var_3

	for iter_8_0, iter_8_1 in var_3(arg_8_0.mapListenerList[arg_8_1]) do
		local var_8_0 = arg_8_0:getTaskById(iter_8_1)

		var_8.updateProgress(var_8_0, var_8:getProgress() + (arg_8_2 and 1 or -1))
		arg_8_0:updateTask(var_8)
	end

	return
end

function var_0_1.addTask(arg_9_0, arg_9_1)
	arg_9_0.recycle[arg_9_1.id] = nil
	arg_9_0.list[arg_9_1.id] = arg_9_1

	arg_9_0:addTaskListener(arg_9_1)
	arg_9_0:DispatchEvent(var_0_1.EventUpdateTask, arg_9_1)

	return
end

function var_0_1.deleteTask(arg_10_0, arg_10_1)
	if not arg_10_0.list[arg_10_1] then
		return
	end

	arg_10_0.recycle[arg_10_1] = arg_10_0.list[arg_10_1]
	arg_10_0.list[arg_10_1] = nil

	arg_10_0:removeTaskListener(arg_10_0.recycle[arg_10_1])
	arg_10_0:DispatchEvent(var_0_1.EventUpdateTask, arg_10_0.recycle[arg_10_1])

	return
end

function var_0_1.updateTask(arg_11_0, arg_11_1)
	arg_11_0.list[arg_11_1.id] = arg_11_1

	local var_11_0 = arg_11_1
	local var_11_1 = arg_11_1.getState(var_11_0)

	WorldTask = var_11_0

	if var_11_1 == var_11_0.STATE_RECEIVED then
		arg_11_0:deleteTask(arg_11_1.id)
	else
		arg_11_0:DispatchEvent(var_0_1.EventUpdateTask, arg_11_1)
	end

	return
end

function var_0_1.getTasks(arg_12_0)
	return arg_12_0.list
end

function var_0_1.getTaskVOs(arg_13_0)
	underscore = var_1_10001

	return var_1_10001.values(arg_13_0.list)
end

function var_0_1.getDoingTaskVOs(arg_14_0)
	local var_14_0 = {}

	pairs = var_1_10002

	for iter_14_0, iter_14_1 in var_1_10002(arg_14_0:getTasks()) do
		if iter_14_1:isAlive() then
			table = var_7

			var_7.insert(var_14_0, iter_14_1)
		end
	end

	return var_14_0
end

function var_0_1.getAutoSubmitTaskVO(arg_15_0)
	pairs = var_1_10001

	for iter_15_0, iter_15_1 in var_1_10001(arg_15_0:getTasks()) do
		if iter_15_1:IsAutoSubmit() then
			local var_15_0 = iter_15_1
			local var_15_1 = iter_15_1.getState(var_15_0)

			WorldTask = var_15_0

			if var_15_1 == var_15_0.STATE_FINISHED then
				return iter_15_1
			end
		end
	end

	return nil
end

function var_0_1.riseTaskFinishCount(arg_16_0)
	arg_16_0.taskFinishCount = arg_16_0.taskFinishCount + 1

	return
end

function var_0_1.getDailyTaskIds(arg_17_0)
	underscore = var_1_10001

	return var_1_10001.rest(arg_17_0.dailyTaskIds, 1)
end

function var_0_1.UpdateDailyTaskIds(arg_18_0, arg_18_1)
	if arg_18_0.dailyTaskIds ~= arg_18_1 then
		arg_18_0.dailyTaskIds = arg_18_1

		arg_18_0:DispatchEvent(var_0_1.EventUpdateDailyTaskIds)
	end

	return
end

function var_0_1.checkDailyTask(arg_19_0, arg_19_1)
	local var_19_0 = {}

	if arg_19_0.dailyTimeStemp then
		local var_19_1 = arg_19_0.dailyTimeStemp

		pg = var_1_10004

		local var_19_2 = var_1_10004.TimeMgr.GetInstance()

		if var_19_1 < var_4.GetServerTime(var_19_2) then
			table = var_19_1

			var_19_1.insert(var_19_0, function(arg_20_0)
				pg = var_2_10001

				local var_20_0 = var_2_10001.ConnectionMgr.GetInstance()

				var_1.Send(var_20_0, 5, {
					type = 0
				}, 6, function(arg_21_0)
					local var_21_0

					if arg_21_0.result == 0 then
						var_21_0 = arg_19_0
						var_21_0.dailyTimeStemp = arg_21_0.next_refresh_time
						assert = var_21_0

						local var_21_1 = arg_19_0.dailyTimeStemp

						var_21_0(0 < var_21_1, "refresh time:" .. arg_19_0.dailyTimeStemp)

						local var_21_2

						if arg_19_0.dailyTimer then
							var_21_2 = arg_19_0.dailyTimer

							var_21_0.Stop(var_21_2)
						end

						var_21_0 = arg_19_0
						Timer = var_21_2

						local var_21_3 = var_21_2.New

						function var_3_10003()
							local var_22_0 = arg_19_0

							var_0.checkDailyTask(var_22_0)

							return
						end

						local var_21_4 = arg_19_0.dailyTimeStemp

						pg = var_3_10005

						local var_21_5 = var_3_10005.TimeMgr.GetInstance()

						var_21_0.dailyTimer = var_21_3(var_3_10003, var_21_4 - var_5.GetServerTime(var_21_5) + 1)

						local var_21_6 = arg_19_0

						var_21_0 = var_21_0.UpdateDailyTaskIds
						underscore = var_3_10003

						var_21_0(var_21_6, var_3_10003.rest(arg_21_0.task_list, 1))
					else
						pg = var_21_0

						local var_21_7 = var_21_0.TipsMgr.GetInstance()
						local var_21_8 = var_1.ShowTips

						errorTip = var_3_10003

						var_21_8(var_21_7, var_3_10003("", arg_21_0.result))
					end

					arg_20_0()

					return
				end)

				return
			end)
		end

		seriesAsync = var_19_1

		var_19_1(var_19_0, arg_19_1)

		return
	end
end

function var_0_1.canAcceptDailyTask(arg_23_0)
	if arg_23_0.dailyTaskIds then
		if #arg_23_0.dailyTaskIds > 0 then
			pg = var_23_0

			local var_23_0

			if not (var_23_0.gameset.world_port_taskmax.key_value > #arg_23_0:getDoingTaskVOs()) then
				var_23_0 = false
			else
				var_23_0 = true
			end

			return var_23_0
		end
	end
end

function var_0_1.hasDoingCollectionTask(arg_24_0)
	underscore = var_1_10001

	return var_1_10001.any(arg_24_0:getDoingTaskVOs(), function(arg_25_0)
		return arg_25_0:IsTypeCollection()
	end)
end

function var_0_1.getRecycleTask(arg_26_0, arg_26_1)
	local var_26_0

	if not arg_26_0.list[arg_26_1] then
		var_26_0 = arg_26_0.recycle[arg_26_1]
	end

	return var_26_0
end

return var_0_1
