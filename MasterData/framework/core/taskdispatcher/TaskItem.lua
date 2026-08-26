-- chunkname: @framework/core/taskdispatcher/TaskItem.lua

module("framework.core.taskdispatcher.TaskItem", package.seeall)

local TaskItem = class("TaskItem")

TaskItem.IsIOSPlayer = SLFramework.FrameworkSettings.CurPlatform == SLFramework.FrameworkSettings.IOSPlayer
TaskItem.frameCount = 0
TaskItem._itemPool = nil

local TRACKBACK = __G__TRACKBACK__
local _xpcall = xpcall

function TaskItem.createPool()
	TaskItem._itemPool = LuaObjPool.New(32, TaskItem._poolNew, TaskItem._poolRelease, TaskItem._poolReset)

	return TaskItem._itemPool
end

function TaskItem._poolNew()
	return TaskItem.New()
end

function TaskItem._poolRelease(luaObj)
	luaObj:release()
end

function TaskItem._poolReset(luaObj)
	luaObj:reset()
end

function TaskItem:reset()
	self.interval = 0
	self.addFrame = 0
	self.timeCount = 0

	self:setCb(nil, nil)

	self.repeatCount = 0
	self.isLoop = false
	self.hasInvoked = false
	self.status = TaskDispatcher.Idle
end

function TaskItem:ctor()
	self:reset()
end

function TaskItem:release()
	self:reset()
end

function TaskItem:setCb(callback, cbObj)
	self.callback = callback
	self.cbObj = cbObj
end

function TaskItem:update(deltaTime)
	if self.status == TaskDispatcher.ToDelete then
		self.repeatCount = 0

		return false
	end

	self.hasInvoked = false

	if self.addFrame >= TaskItem.frameCount then
		return self.hasInvoked
	end

	self.timeCount = self.timeCount + deltaTime

	if self.timeCount < self.interval then
		return self.hasInvoked
	end

	self.hasInvoked = true
	self.timeCount = self.timeCount - self.interval

	if self.cbObj then
		_xpcall(self.callback, TRACKBACK, self.cbObj)
	else
		_xpcall(self.callback, TRACKBACK)
	end

	self.repeatCount = self.repeatCount - 1

	return self.hasInvoked
end

function TaskItem:logStr()
	return "callback = " .. tostring(self.callback) .. " cbObj = " .. tostring(self.cbObj) .. " interval = " .. self.interval .. " addFrame = " .. self.addFrame .. " timeCount = " .. self.timeCount .. " repeatCount = " .. self.repeatCount .. " isLoop = " .. tostring(self.isLoop) .. " hasInvoked = " .. tostring(self.hasInvoked) .. " status = " .. self.status
end

return TaskItem
