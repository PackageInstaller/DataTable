-- chunkname: @framework/core/taskdispatcher/TaskDispatcher.lua

module("framework.core.taskdispatcher.TaskDispatcher", package.seeall)

local TaskDispatcher = {}

TaskDispatcher.Idle = 1
TaskDispatcher.Active = 2
TaskDispatcher.ToInsert = 3
TaskDispatcher.ToDelete = 4

function TaskDispatcher.init()
	UpdateBeat:Add(TaskDispatcher._onUnityUpdate, TaskDispatcher)

	TaskDispatcher._taskPool = TaskItem.createPool()
	TaskDispatcher._allTasks = {}
	TaskDispatcher._onceIdxList = {}
	TaskDispatcher._deltaTasks = {}
	TaskDispatcher._isDispatching = false
end

function TaskDispatcher.runDelay(callback, cbObj, delay)
	if not callback or not delay then
		logError("TaskDispatcher.runDelay, callback or delay should not be null!")

		return
	end

	TaskDispatcher._addNewTask(callback, cbObj, delay, 1, false)
end

function TaskDispatcher.runRepeat(callback, cbObj, interval, repeatCount)
	if not callback or not interval then
		logError("TaskDispatcher.runRepeat, callback or interval should not be null!")

		return
	end

	TaskDispatcher._addNewTask(callback, cbObj, interval, repeatCount or -1, true)
end

function TaskDispatcher.cancelTask(callback, cbObj)
	if TaskDispatcher._isDispatching then
		local alreadyTask = TaskDispatcher._getTaskWhichCbInDispatch(callback, cbObj)

		if alreadyTask then
			alreadyTask.status = TaskDispatcher.ToDelete
		end

		TaskDispatcher._removeFromDeltaQueue(callback, cbObj)

		local deleteTask = TaskDispatcher._taskPool:getObject()

		deleteTask.status = TaskDispatcher.ToDelete

		deleteTask:setCb(callback, cbObj)
		table.insert(TaskDispatcher._deltaTasks, deleteTask)
	else
		TaskDispatcher._directDelete(callback, cbObj)
	end
end

function TaskDispatcher._addNewTask(callback, cbObj, interval, repeatCount, isLoop)
	local toDelete = false

	if TaskDispatcher._isDispatching then
		local deltaTask = TaskDispatcher._getTaskInDeltaQueue(callback, cbObj)

		if deltaTask then
			if TaskDispatcher.ToInsert == deltaTask.status then
				return
			elseif TaskDispatcher.ToDelete == deltaTask.status then
				toDelete = true
			end
		end
	end

	local alreadyTask = TaskDispatcher._getTaskWhichCbInDispatch(callback, cbObj)

	if alreadyTask ~= nil and alreadyTask.isLoop and alreadyTask.status ~= TaskDispatcher.ToDelete and not toDelete then
		return
	end

	if TaskDispatcher._isDispatching then
		TaskDispatcher._removeFromDeltaQueue(callback, cbObj)
	end

	local newTask = TaskDispatcher._taskPool:getObject()

	newTask:setCb(callback, cbObj)

	newTask.interval = interval
	newTask.isLoop = isLoop
	newTask.repeatCount = repeatCount
	newTask.addFrame = TaskItem.frameCount
	newTask.status = TaskDispatcher.Active

	if TaskDispatcher._isDispatching then
		newTask.status = TaskDispatcher.ToInsert

		table.insert(TaskDispatcher._deltaTasks, newTask)
	else
		TaskDispatcher._directAdd(newTask)
	end
end

function TaskDispatcher._onUnityUpdate()
	TaskDispatcher._isDispatching = true

	TaskDispatcher._taskTick(Time.deltaTime)

	TaskDispatcher._isDispatching = false

	TaskDispatcher._doAddOrRemove()

	TaskItem.frameCount = TaskItem.frameCount + 1
end

function TaskDispatcher._doAddOrRemove()
	local count = #TaskDispatcher._deltaTasks
	local tmpTask

	for idx = 1, count do
		if TaskDispatcher.ToDelete == TaskDispatcher._deltaTasks[idx].status then
			TaskDispatcher._directDelete(TaskDispatcher._deltaTasks[idx].callback, TaskDispatcher._deltaTasks[idx].cbObj)
			TaskDispatcher._taskPool:putObject(TaskDispatcher._deltaTasks[idx])
		elseif TaskDispatcher.ToInsert == TaskDispatcher._deltaTasks[idx].status then
			TaskDispatcher._directAdd(TaskDispatcher._deltaTasks[idx])
		else
			TaskDispatcher._taskPool:putObject(TaskDispatcher._deltaTasks[idx])
		end

		TaskDispatcher._deltaTasks[idx] = nil
	end
end

function TaskDispatcher._removeFromDeltaQueue(callback, cbObj)
	local count = #TaskDispatcher._deltaTasks
	local tmpTask

	for idx = count, 1, -1 do
		if TaskDispatcher._deltaTasks[idx].callback == callback and TaskDispatcher._deltaTasks[idx].cbObj == cbObj then
			TaskDispatcher._taskPool:putObject(TaskDispatcher._deltaTasks[idx])
			table.remove(TaskDispatcher._deltaTasks, idx)

			break
		end
	end
end

function TaskDispatcher._directAdd(taskItem)
	local alreadyTask, index = TaskDispatcher._getTaskWhichCbInDispatch(taskItem.callback, taskItem.cbObj)

	if alreadyTask and alreadyTask.status ~= TaskDispatcher.ToDelete then
		if isDebugBuild then
			logWarn("TaskDispatcher._directAdd, task already exists, add ignored! please call cancelTask first. callback = " .. tostring(taskItem.callback) .. " cbObj = " .. tostring(taskItem.cbObj))
		end

		TaskDispatcher._taskPool:putObject(taskItem)

		return
	end

	if alreadyTask then
		table.remove(TaskDispatcher._allTasks, index)
	end

	taskItem.status = TaskDispatcher.Active

	for i, v in ipairs(TaskDispatcher._allTasks) do
		if v.interval > taskItem.interval then
			table.insert(TaskDispatcher._allTasks, i, taskItem)

			return
		end
	end

	table.insert(TaskDispatcher._allTasks, taskItem)
end

function TaskDispatcher._directDelete(callback, cbObj)
	local count = #TaskDispatcher._allTasks
	local tmpTask

	for idx = count, 1, -1 do
		if TaskDispatcher._allTasks[idx].callback == callback and TaskDispatcher._allTasks[idx].cbObj == cbObj then
			TaskDispatcher._taskPool:putObject(TaskDispatcher._allTasks[idx])
			table.remove(TaskDispatcher._allTasks, idx)
		end
	end
end

function TaskDispatcher._getTaskWhichCbInDispatch(callback, cbObj)
	local count = #TaskDispatcher._allTasks
	local tmpTask

	for idx = count, 1, -1 do
		if TaskDispatcher._allTasks[idx].callback == callback and TaskDispatcher._allTasks[idx].cbObj == cbObj then
			return TaskDispatcher._allTasks[idx], idx
		end
	end

	return nil, 0
end

function TaskDispatcher._getTaskInDeltaQueue(callback, cbObj)
	local tmpTask
	local count = #TaskDispatcher._deltaTasks

	for idx = count, 1, -1 do
		if TaskDispatcher._deltaTasks[idx].callback == callback and TaskDispatcher._deltaTasks[idx].cbObj == cbObj then
			return TaskDispatcher._deltaTasks[idx]
		end
	end

	return nil
end

function TaskDispatcher._taskTick(deltaTime)
	local count = #TaskDispatcher._allTasks
	local tmpTask

	for idx = 1, count do
		if TaskDispatcher.ToDelete ~= TaskDispatcher._allTasks[idx].status and TaskDispatcher._allTasks[idx]:update(deltaTime) and TaskDispatcher._allTasks[idx].repeatCount == 0 then
			table.insert(TaskDispatcher._onceIdxList, idx)
		end
	end

	count = #TaskDispatcher._onceIdxList

	for idx = #TaskDispatcher._onceIdxList, 1, -1 do
		local removeIdx = TaskDispatcher._onceIdxList[idx]

		TaskDispatcher._taskPool:putObject(TaskDispatcher._allTasks[removeIdx])
		table.remove(TaskDispatcher._allTasks, removeIdx)
		table.remove(TaskDispatcher._onceIdxList, idx)
	end
end

function TaskDispatcher._logToBeDeleteItems()
	local log = "TaskDispatcher._logToBeDeleteItems: "

	for index, value in ipairs(TaskDispatcher._allTasks) do
		if value.status == TaskDispatcher.ToDelete then
			log = log .. index .. " = " .. value:logStr() .. "\n"
		end
	end

	logWarn(log)
end

function TaskDispatcher._logAllTasks()
	local log = "TaskDispatcher._logToBeDeleteItems: "

	for index, value in ipairs(TaskDispatcher._allTasks) do
		log = log .. index .. " = " .. value:logStr() .. "\n"
	end

	logWarn(log)
end

return TaskDispatcher
