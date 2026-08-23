local OutpostBaseState = class("OutpostBaseState", require("app.core.fsm.KSComState"))

function OutpostBaseState:ctor()
	OutpostBaseState.super.ctor(self)

	self._task = nil
	self._curFsm = nil
end

function OutpostBaseState:onCleanupState()
	self:stopTask()
	self:cleanFsm()
end

function OutpostBaseState:stopTask()
	if self._task then
		g.core.common.CoroutineManager:stop(self._task)
	end

	self._task = nil
end

function OutpostBaseState:startTask(arg_4_1)
	self:stopTask()

	self._task = g.core.common.CoroutineManager:start(arg_4_1)
end

function OutpostBaseState:cleanFsm()
	if self._curFsm then
		self._curFsm:cleanupFSM()

		self._curFsm = nil
	end
end

return OutpostBaseState
