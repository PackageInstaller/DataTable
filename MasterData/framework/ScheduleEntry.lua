-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/framework/schedule/ScheduleEntry.lua

module("framework.schedule.ScheduleEntry", package.seeall)

local ScheduleEntry = class("ScheduleEntry")

setglobal("kScheduleStatusIdle", 1)
setglobal("kScheduleStatusActive", 2)
setglobal("kScheduleStatusToInsert", 3)
setglobal("kScheduleStatusToDelete", 4)

ScheduleEntry.curFrame = 0

function ScheduleEntry._poolCreateFunc()
	return ScheduleEntry.New()
end

function ScheduleEntry._poolDisposeFunc(entryObj)
	return
end

function ScheduleEntry._poolResetFunc(entryObj)
	entryObj:reset()
end

function ScheduleEntry.initPool()
	ScheduleEntry._pool = ObjectPool.New(30, ScheduleEntry._poolCreateFunc, ScheduleEntry._poolDisposeFunc, ScheduleEntry._poolResetFunc)
end

function ScheduleEntry.getPool()
	return ScheduleEntry._pool
end

function ScheduleEntry:ctor()
	self:reset()
end

function ScheduleEntry:reset()
	self.interval = 0
	self.regFrame = 0
	self.elapsed = 0
	self.handler = nil
	self.handlerObj = nil
	self.status = kScheduleStatusIdle
	self.isRepeat = true
	self.isExecuted = false
end

function ScheduleEntry:update(dt)
	self.isExecuted = false

	if self.regFrame < ScheduleEntry.curFrame then
		self.elapsed = self.elapsed + dt

		if self.elapsed >= self.interval then
			self.elapsed = self.elapsed - self.interval
			self.isExecuted = true

			trycall(self.handler, self.handlerObj)
		end
	end

	return self.isExecuted
end

return ScheduleEntry
