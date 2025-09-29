-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/handler/TimelineTask.lua

module("logic.common.handler.TimelineTask", package.seeall)

local TimelineTask = class("TimelineTask")
local kTaskUnitPool = {}
local kPoolCapacity = 50

local function getOrCreateTaskUnit()
	local taskUnit = table.remove(kTaskUnitPool)

	if taskUnit then
		return taskUnit
	end

	return TimelineTask.TaskUnit.New()
end

local function returnTaskUnit(taskUnit)
	if #kTaskUnitPool >= kPoolCapacity then
		taskUnit:destroy()
	else
		taskUnit:reset()
		table.insert(kTaskUnitPool, taskUnit)
	end
end

function TimelineTask:ctor()
	self._passTime = 0
	self._timeScale = 1
	self._taskUnitList = {}
	self._context = false
	self._curTaskUnit = false
	self._callbackFinish = false
	self._callbackFinishSelf = false
end

function TimelineTask:addFinishListener(callback, callbackSelf)
	self._callbackFinish = callback
	self._callbackFinishSelf = callbackSelf
end

function TimelineTask:removeFinishListener()
	self._callbackFinish = false
	self._callbackFinishSelf = false
end

function TimelineTask:addTask(duration, callback, callbackSelf)
	local taskUnit = getOrCreateTaskUnit()

	taskUnit:setDuration(duration)
	taskUnit:setListener(callback, callbackSelf)
	table.insert(self._taskUnitList, taskUnit)
end

function TimelineTask:setTimeScale(timeScale)
	self._timeScale = timeScale
end

function TimelineTask:start(context)
	self._context = context
	self._passTime = 0
	self._curTaskUnit = table.remove(self._taskUnitList, 1)

	if self._curTaskUnit then
		FrameUpdate:addListener(self)
	end
end

function TimelineTask:stop()
	self._timeScale = 1

	self:_clearCurrentTask()
	self:_clearTaskUnitList()
	self:removeFinishListener()
	FrameUpdate:removeListener(self)
end

function TimelineTask:clear()
	self:stop()
end

function TimelineTask:luaUpdate(deltaTime)
	self._passTime = self._passTime + deltaTime * self._timeScale

	if self._curTaskUnit and self._passTime >= self._curTaskUnit.duration then
		self:_onFinishCurTask()
	end
end

function TimelineTask:_clearCurrentTask()
	if self._curTaskUnit then
		returnTaskUnit(self._curTaskUnit)

		self._curTaskUnit = false
	end
end

function TimelineTask:_onFinishCurTask()
	self._passTime = 0

	self._curTaskUnit:finish(self._context)

	if self._curTaskUnit then
		returnTaskUnit(self._curTaskUnit)
	end

	self._curTaskUnit = table.remove(self._taskUnitList, 1)

	if not self._curTaskUnit then
		self:_onFinishAllTask()
	end
end

function TimelineTask:_onFinishAllTask()
	local callback = self._callbackFinish
	local callbackSelf = self._callbackFinishSelf
	local context = self._context

	self:stop()

	if callback then
		if callbackSelf then
			callback(callbackSelf, context)
		else
			callback(context)
		end
	end
end

function TimelineTask:_clearTaskUnitList()
	for _, taskUnit in pairs(self._taskUnitList) do
		returnTaskUnit(taskUnit)
	end

	table.clear(self._taskUnitList)
end

TimelineTask.TaskUnit = class("TimelineTask.TaskUnit")

function TimelineTask.TaskUnit:ctor(duration, callback, callbackSelf)
	self.duration = 0
	self.handler = Handler.New()
end

function TimelineTask.TaskUnit:setDuration(duration)
	self.duration = duration
end

function TimelineTask.TaskUnit:setListener(callback, callbackSelf)
	self.handler:setListener(callback, callbackSelf)
end

function TimelineTask.TaskUnit:finish(context)
	self.handler:call(context)
end

function TimelineTask.TaskUnit:reset()
	self.duration = 0

	self.handler:clear()
end

function TimelineTask.TaskUnit:destroy()
	self.duration = 0

	self.handler:clear()

	self.handler = nil
end

return TimelineTask
