local WorldTaskProxy = class("WorldTaskProxy", import("....BaseEntity"))

WorldTaskProxy.Fields = {
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
WorldTaskProxy.EventUpdateTask = "WorldTaskProxy.EventUpdateTask"
WorldTaskProxy.EventUpdateDailyTaskIds = "WorldTaskProxy.EventUpdateDailyTaskIds"

function WorldTaskProxy:Build()
	self.list = {}
	self.recycle = {}
	self.itemListenerList = {}
	self.mapListenerList = {}

	return
end

function WorldTaskProxy:Setup(arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		local var_2_0 = WorldTask.New(iter_2_1)

		if var_2_0:getState() == WorldTask.STATE_RECEIVED then
			self.recycle[var_2_0.id] = var_2_0
		else
			self:addTask(var_2_0)
		end
	end

	return
end

function WorldTaskProxy:Dispose()
	self:Clear()

	return
end

function WorldTaskProxy:getTaskById(arg_4_1)
	assert(arg_4_1, "taskId can not be nil")

	return self.list[arg_4_1]
end

function WorldTaskProxy:addTaskListener(arg_5_1)
	if arg_5_1.config.complete_condition == WorldConst.TaskTypeSubmitItem then
		self.itemListenerList[arg_5_1.config.complete_parameter[1]] = self.itemListenerList[arg_5_1.config.complete_parameter[1]] or {}

		table.insert(self.itemListenerList[arg_5_1.config.complete_parameter[1]], arg_5_1.id)
	elseif arg_5_1.config.complete_condition == WorldConst.TaskTypePressingMap then
		for iter_5_0, iter_5_1 in ipairs(arg_5_1.config.complete_parameter) do
			self.mapListenerList[iter_5_1] = self.mapListenerList[iter_5_1] or {}

			table.insert(self.mapListenerList[iter_5_1], arg_5_1.id)
		end
	end

	return
end

function WorldTaskProxy:removeTaskListener(arg_6_1)
	if arg_6_1.config.complete_condition == WorldConst.TaskTypeSubmitItem then
		table.removebyvalue(self.itemListenerList[arg_6_1.config.complete_parameter[1]], arg_6_1.id)
	elseif arg_6_1.config.complete_condition == WorldConst.TaskTypePressingMap then
		for iter_6_0, iter_6_1 in ipairs(arg_6_1.config.complete_parameter) do
			table.removebyvalue(self.mapListenerList[iter_6_1], arg_6_1.id)
		end
	end

	return
end

function WorldTaskProxy:doUpdateTaskByItem(arg_7_1)
	if not self.itemListenerList[arg_7_1.id] then
		return
	end

	for iter_7_0, iter_7_1 in ipairs(self.itemListenerList[arg_7_1.id]) do
		local var_7_0 = self:getTaskById(iter_7_1)

		var_7_0:updateProgress(arg_7_1.count)
		self:updateTask(var_7_0)
	end

	return
end

function WorldTaskProxy:doUpdateTaskByMap(arg_8_1, arg_8_2)
	if not self.mapListenerList[arg_8_1] then
		return
	end

	for iter_8_0, iter_8_1 in ipairs(self.mapListenerList[arg_8_1]) do
		local var_8_0 = self:getTaskById(iter_8_1)

		var_8_0:updateProgress(var_8_0:getProgress() + (arg_8_2 and 1 or -1))
		self:updateTask(var_8_0)
	end

	return
end

function WorldTaskProxy:addTask(arg_9_1)
	self.recycle[arg_9_1.id] = nil
	self.list[arg_9_1.id] = arg_9_1

	self:addTaskListener(arg_9_1)
	self:DispatchEvent(WorldTaskProxy.EventUpdateTask, arg_9_1)

	return
end

function WorldTaskProxy:deleteTask(arg_10_1)
	if not self.list[arg_10_1] then
		return
	end

	self.recycle[arg_10_1] = self.list[arg_10_1]
	self.list[arg_10_1] = nil

	self:removeTaskListener(self.recycle[arg_10_1])
	self:DispatchEvent(WorldTaskProxy.EventUpdateTask, self.recycle[arg_10_1])

	return
end

function WorldTaskProxy:updateTask(arg_11_1)
	self.list[arg_11_1.id] = arg_11_1

	if arg_11_1:getState() == WorldTask.STATE_RECEIVED then
		self:deleteTask(arg_11_1.id)
	else
		self:DispatchEvent(WorldTaskProxy.EventUpdateTask, arg_11_1)
	end

	return
end

function WorldTaskProxy:getTasks()
	return self.list
end

function WorldTaskProxy:getTaskVOs()
	return underscore.values(self.list)
end

function WorldTaskProxy:getDoingTaskVOs()
	local var_14_0 = {}

	for iter_14_0, iter_14_1 in pairs(self:getTasks()) do
		if iter_14_1:isAlive() then
			table.insert(var_14_0, iter_14_1)
		end
	end

	return var_14_0
end

function WorldTaskProxy:getAutoSubmitTaskVO()
	for iter_15_0, iter_15_1 in pairs(self:getTasks()) do
		if iter_15_1:IsAutoSubmit() and iter_15_1:getState() == WorldTask.STATE_FINISHED then
			return iter_15_1
		end
	end

	return nil
end

function WorldTaskProxy:riseTaskFinishCount()
	self.taskFinishCount = self.taskFinishCount + 1

	return
end

function WorldTaskProxy:getDailyTaskIds()
	return underscore.rest(self.dailyTaskIds, 1)
end

function WorldTaskProxy:UpdateDailyTaskIds(arg_18_1)
	if self.dailyTaskIds ~= arg_18_1 then
		self.dailyTaskIds = arg_18_1

		self:DispatchEvent(WorldTaskProxy.EventUpdateDailyTaskIds)
	end

	return
end

function WorldTaskProxy:checkDailyTask(arg_19_1)
	local var_19_0 = {}

	if self.dailyTimeStemp then
		if self.dailyTimeStemp < pg.TimeMgr.GetInstance():GetServerTime() then
			table.insert(var_19_0, function(arg_20_0)
				pg.ConnectionMgr.GetInstance():Send(5, {
					type = 0
				}, 6, function(arg_21_0)
					if arg_21_0.result == 0 then
						self.dailyTimeStemp = arg_21_0.next_refresh_time

						assert(self.dailyTimeStemp > 0, "refresh time:" .. self.dailyTimeStemp)

						if self.dailyTimer then
							self.dailyTimer:Stop()
						end

						self.dailyTimer = Timer.New(function()
							self:checkDailyTask()

							return
						end, self.dailyTimeStemp - pg.TimeMgr.GetInstance():GetServerTime() + 1)

						self:UpdateDailyTaskIds(underscore.rest(arg_21_0.task_list, 1))
					else
						pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_21_0.result))
					end

					arg_20_0()

					return
				end)

				return
			end)
		end
	end

	seriesAsync(var_19_0, arg_19_1)

	return
end

function WorldTaskProxy:canAcceptDailyTask()
	return self.dailyTaskIds and #self.dailyTaskIds > 0 and pg.gameset.world_port_taskmax.key_value > #self:getDoingTaskVOs()
end

function WorldTaskProxy:hasDoingCollectionTask()
	return underscore.any(self:getDoingTaskVOs(), function(arg_25_0)
		return arg_25_0:IsTypeCollection()
	end)
end

function WorldTaskProxy:getRecycleTask(arg_26_1)
	return self.list[arg_26_1] or self.recycle[arg_26_1]
end

return WorldTaskProxy
