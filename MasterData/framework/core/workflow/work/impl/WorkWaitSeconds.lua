-- chunkname: @framework/core/workflow/work/impl/WorkWaitSeconds.lua

module("framework.core.workflow.work.impl.WorkWaitSeconds", package.seeall)

local WorkWaitSeconds = class("WorkWaitSeconds", BaseWork)

function WorkWaitSeconds:ctor(waitSeconds)
	self._waitSeconds = waitSeconds or 0.01
end

function WorkWaitSeconds:onStart()
	self._startTime = Time.realtimeSinceStartup

	TaskDispatcher.runDelay(self._onTimeEnd, self, self._waitSeconds)
end

function WorkWaitSeconds:onStop()
	self._waitSeconds = Time.realtimeSinceStartup - self._startTime

	TaskDispatcher.cancelTask(self._onTimeEnd, self)
end

function WorkWaitSeconds:onResume()
	if self._waitSeconds > 0 then
		TaskDispatcher.runDelay(self._onTimeEnd, self, self._waitSeconds)
	else
		self:onDone(true)
	end
end

function WorkWaitSeconds:onReset()
	TaskDispatcher.cancelTask(self._onTimeEnd, self)
end

function WorkWaitSeconds:onDestroy()
	TaskDispatcher.cancelTask(self._onTimeEnd, self)
end

function WorkWaitSeconds:_onTimeEnd()
	self:onDone(true)
end

return WorkWaitSeconds
