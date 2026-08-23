local LoopService = class("LoopService")

function LoopService:ctor()
	self._timerId = nil
	self._forbid = false
	self._redTotalSize = 0
	self._waitFunc = {}
end

function LoopService:reset()
	self._waitFunc = {}

	if self._timerId then
		g.core.common.Scheduler:cancelSchedule(self._timerId)

		self._timerId = nil
	end
end

function LoopService:forbidPushToWaitList()
	self._forbid = true
end

function LoopService:resumePushToWaitList()
	self._forbid = false
end

function LoopService:addToLoopFuncList(arg_5_1)
	if self._forbid then
		arg_5_1()

		return
	end

	self._waitFunc[#self._waitFunc + 1] = arg_5_1
	self._redTotalSize = #self._waitFunc
	self._timerId = self._timerId or g.core.common.Scheduler:newSchedule(handler(self, self._doCheckLoop), 0)
end

function LoopService:getLoopProgress()
	self._waitFunc = self._waitFunc or {}

	return self._redTotalSize, self._redTotalSize - #self._waitFunc
end

function LoopService:_doCheckLoop()
	if #self._waitFunc > 0 then
		table.remove(self._waitFunc, 1)()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_RED_INFO_GET_FLUSH)
	end
end

return LoopService
