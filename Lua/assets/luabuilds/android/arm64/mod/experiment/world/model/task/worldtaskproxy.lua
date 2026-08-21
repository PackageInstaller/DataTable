local var_0_0 = class("WorldTaskProxy", import("....BaseEntity"))

var_0_0.Fields = {
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
var_0_0.EventUpdateTask = "WorldTaskProxy.EventUpdateTask"
var_0_0.EventUpdateDailyTaskIds = "WorldTaskProxy.EventUpdateDailyTaskIds"

function var_0_0.Build(arg_1_0)
	arg_1_0.list = {}
	arg_1_0.recycle = {}
	arg_1_0.itemListenerList = {}
	arg_1_0.mapListenerList = {}

	return
end

function var_0_0.Setup(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		local var_2_0 = WorldTask.New(iter_2_1)

		if var_2_0:getState() == WorldTask.STATE_RECEIVED then
			arg_2_0.recycle[var_2_0.id] = var_2_0
		else
			arg_2_0:addTask(var_2_0)
		end
	end

	return
end

function var_0_0.Dispose(arg_3_0)
	arg_3_0:Clear()

	return
end

function var_0_0.getTaskById(arg_4_0, arg_4_1)
	assert(arg_4_1, "taskId can not be nil")

	return arg_4_0.list[arg_4_1]
end

function var_0_0.addTaskListener(arg_5_0, arg_5_1)
	if arg_5_1.config.complete_condition == WorldConst.TaskTypeSubmitItem then
		arg_5_0.itemListenerList[arg_5_1.config.complete_parameter[1]] = arg_5_0.itemListenerList[arg_5_1.config.complete_parameter[1]] or {}

		table.insert(arg_5_0.itemListenerList[arg_5_1.config.complete_parameter[1]], arg_5_1.id)
	elseif arg_5_1.config.complete_condition == WorldConst.TaskTypePressingMap then
		for iter_5_0, iter_5_1 in ipairs(arg_5_1.config.complete_parameter) do
			arg_5_0.mapListenerList[iter_5_1] = arg_5_0.mapListenerList[iter_5_1] or {}

			table.insert(arg_5_0.mapListenerList[iter_5_1], arg_5_1.id)
		end
	end

	return
end

function var_0_0.removeTaskListener(arg_6_0, arg_6_1)
	if arg_6_1.config.complete_condition == WorldConst.TaskTypeSubmitItem then
		table.removebyvalue(arg_6_0.itemListenerList[arg_6_1.config.complete_parameter[1]], arg_6_1.id)
	elseif arg_6_1.config.complete_condition == WorldConst.TaskTypePressingMap then
		for iter_6_0, iter_6_1 in ipairs(arg_6_1.config.complete_parameter) do
			table.removebyvalue(arg_6_0.mapListenerList[iter_6_1], arg_6_1.id)
		end
	end

	return
end

function var_0_0.doUpdateTaskByItem(arg_7_0, arg_7_1)
	if not arg_7_0.itemListenerList[arg_7_1.id] then
		return
	end

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.itemListenerList[arg_7_1.id]) do
		local var_7_0 = arg_7_0:getTaskById(iter_7_1)

		var_7_0:updateProgress(arg_7_1.count)
		arg_7_0:updateTask(var_7_0)
	end

	return
end

function var_0_0.doUpdateTaskByMap(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_0.mapListenerList[arg_8_1] then
		return
	end

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.mapListenerList[arg_8_1]) do
		local var_8_0 = arg_8_0:getTaskById(iter_8_1)

		var_8_0:updateProgress(var_8_0:getProgress() + (arg_8_2 and 1 or -1))
		arg_8_0:updateTask(var_8_0)
	end

	return
end

function var_0_0.addTask(arg_9_0, arg_9_1)
	arg_9_0.recycle[arg_9_1.id] = nil
	arg_9_0.list[arg_9_1.id] = arg_9_1

	arg_9_0:addTaskListener(arg_9_1)
	arg_9_0:DispatchEvent(var_0_0.EventUpdateTask, arg_9_1)

	return
end

function var_0_0.deleteTask(arg_10_0, arg_10_1)
	if not arg_10_0.list[arg_10_1] then
		return
	end

	arg_10_0.recycle[arg_10_1] = arg_10_0.list[arg_10_1]
	arg_10_0.list[arg_10_1] = nil

	arg_10_0:removeTaskListener(arg_10_0.recycle[arg_10_1])
	arg_10_0:DispatchEvent(var_0_0.EventUpdateTask, arg_10_0.recycle[arg_10_1])

	return
end

function var_0_0.updateTask(arg_11_0, arg_11_1)
	arg_11_0.list[arg_11_1.id] = arg_11_1

	if arg_11_1:getState() == WorldTask.STATE_RECEIVED then
		arg_11_0:deleteTask(arg_11_1.id)
	else
		arg_11_0:DispatchEvent(var_0_0.EventUpdateTask, arg_11_1)
	end

	return
end

function var_0_0.getTasks(arg_12_0)
	return arg_12_0.list
end

function var_0_0.getTaskVOs(arg_13_0)
	return underscore.values(arg_13_0.list)
end

function var_0_0.getDoingTaskVOs(arg_14_0)
	for iter_14_0, iter_14_1 in pairs(arg_14_0:getTasks()) do
		if iter_14_1:isAlive() then
			table.insert({}, iter_14_1)
		end
	end

	return {}
end

function var_0_0.getAutoSubmitTaskVO(arg_15_0)
	for iter_15_0, iter_15_1 in pairs(arg_15_0:getTasks()) do
		if iter_15_1:IsAutoSubmit() and iter_15_1:getState() == WorldTask.STATE_FINISHED then
			return iter_15_1
		end
	end

	return nil
end

function var_0_0.riseTaskFinishCount(arg_16_0)
	arg_16_0.taskFinishCount = arg_16_0.taskFinishCount + 1

	return
end

function var_0_0.getDailyTaskIds(arg_17_0)
	return underscore.rest(arg_17_0.dailyTaskIds, 1)
end

function var_0_0.UpdateDailyTaskIds(arg_18_0, arg_18_1)
	if arg_18_0.dailyTaskIds ~= arg_18_1 then
		arg_18_0.dailyTaskIds = arg_18_1

		arg_18_0:DispatchEvent(var_0_0.EventUpdateDailyTaskIds)
	end

	return
end

function var_0_0.checkDailyTask(arg_19_0, arg_19_1)
	if arg_19_0.dailyTimeStemp then
		if arg_19_0.dailyTimeStemp < pg.TimeMgr.GetInstance():GetServerTime() then
			table.insert({}, function(arg_20_0)
				pg.ConnectionMgr.GetInstance():Send(5, {
					type = 0
				}, 6, function(arg_21_0)
					if arg_21_0.result == 0 then
						arg_19_0.dailyTimeStemp = arg_21_0.next_refresh_time

						assert(arg_19_0.dailyTimeStemp > 0, "refresh time:" .. arg_19_0.dailyTimeStemp)

						if arg_19_0.dailyTimer then
							arg_19_0.dailyTimer:Stop()
						end

						local var_21_0 = arg_19_0

						var_21_0.dailyTimer = Timer.New(function()
							arg_19_0:checkDailyTask()

							return
						end, arg_19_0.dailyTimeStemp - pg.TimeMgr.GetInstance():GetServerTime() + 1)

						arg_19_0:UpdateDailyTaskIds(underscore.rest(arg_21_0.task_list, 1))
					else
						pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_21_0.result))
					end

					arg_20_0()

					return
				end)

				return
			end)
		end

		seriesAsync({}, arg_19_1)

		return
	end
end

function var_0_0.canAcceptDailyTask(arg_23_0)
	return arg_23_0.dailyTaskIds and #arg_23_0.dailyTaskIds > 0 and pg.gameset.world_port_taskmax.key_value > #arg_23_0:getDoingTaskVOs()
end

function var_0_0.hasDoingCollectionTask(arg_24_0)
	return underscore.any(arg_24_0:getDoingTaskVOs(), function(arg_25_0)
		return arg_25_0:IsTypeCollection()
	end)
end

function var_0_0.getRecycleTask(arg_26_0, arg_26_1)
	return arg_26_0.list[arg_26_1] or arg_26_0.recycle[arg_26_1]
end

return var_0_0
