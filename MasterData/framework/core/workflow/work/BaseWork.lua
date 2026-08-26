-- chunkname: @framework/core/workflow/work/BaseWork.lua

module("framework.core.workflow.work.BaseWork", package.seeall)

local BaseWork = class("BaseWork")
local DoneEvent = "done"

function BaseWork:initInternal()
	self.context = nil
	self.root = nil
	self.parent = nil
	self.isSuccess = false
	self.status = WorkStatus.Init
	self.flowName = nil
end

function BaseWork:setRootInternal(root)
	self.root = root
end

function BaseWork:setParentInternal(parent)
	self.parent = parent
end

function BaseWork:onStartInternal(context)
	self.context = context
	self.status = WorkStatus.Running

	return self:onStart(context)
end

function BaseWork:onStopInternal()
	self.status = WorkStatus.Stopped

	self:onStop()
end

function BaseWork:onResumeInternal()
	self.status = WorkStatus.Running

	self:onResume()
end

function BaseWork:onResetInternal()
	self.status = WorkStatus.Init

	self:onReset()
end

function BaseWork:onDestroyInternal()
	self:onDestroy()

	self.context = nil
	self.parent = nil
end

function BaseWork:onDone(isSuccess)
	self.isSuccess = isSuccess
	self.status = WorkStatus.Done

	if self.beforeClearWork then
		self:beforeClearWork()
	end

	self:clearWork()

	if self.parent then
		if self._dispatcher then
			self.parent:onWorkDone(self)
		else
			return self.parent:onWorkDone(self)
		end
	end

	if self._dispatcher then
		self._dispatcher:dispatchEvent(DoneEvent, isSuccess)
	end
end

function BaseWork:registerDoneListener(handler, handlerTarget)
	if not self._dispatcher then
		self._dispatcher = {}

		LuaEventSystem.addEventMechanism(self._dispatcher)
	end

	self._dispatcher:registerCallback(DoneEvent, handler, handlerTarget)
end

function BaseWork:unregisterDoneListener(handler, handlerTarget)
	if self._dispatcher then
		self._dispatcher:unregisterCallback(DoneEvent, handler, handlerTarget)
	end
end

function BaseWork:ctor()
	return
end

function BaseWork:onStart(context)
	return
end

function BaseWork:onStop()
	if self.beforeClearWork then
		self:beforeClearWork()
	end

	self:clearWork()
end

function BaseWork:onResume()
	return
end

function BaseWork:onReset()
	if self.beforeClearWork then
		self:beforeClearWork()
	end

	self:clearWork()
end

function BaseWork:onDestroy()
	if self.beforeClearWork then
		self:beforeClearWork()
	end

	self:clearWork()
end

function BaseWork:clearWork()
	return
end

return BaseWork
