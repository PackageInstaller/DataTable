-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/frameworkext/ai/workflow/work/WorkBase.lua

module("frameworkext.ai.workflow.work.WorkBase", package.seeall)

local WorkBase = class("WorkBase")

function WorkBase:ctor()
	self.context = nil
	self.parent = nil
	self.status = WorkStatus.Init
	self.result = WorkResult.Unknown
	self.id = nil
	self.workflow = nil
end

function WorkBase:onStart(context)
	self.workflow:enterWork(self)

	self.context = context
	self.status = WorkStatus.Running
end

function WorkBase:onDone(result)
	self.result = result == WorkResult.Succeed and WorkResult.Succeed or WorkResult.Fail

	self:onStop()

	if self._dispatcher then
		self._dispatcher:dispatch(1, self.result)
	end

	if self.parent then
		self.parent:onChildDone(self)
	end
end

function WorkBase:onStop()
	self.context = nil
	self.status = WorkStatus.Stopped
end

function WorkBase:onInterrupt()
	self.context = nil
	self.status = WorkStatus.Stopped
	self.result = WorkResult.Interrupt
end

function WorkBase:serialize()
	local data = {}

	data.id = self.id
	data.status = self.status
	data.result = self.result

	return data
end

function WorkBase:deserialize(sourceData)
	self.status = sourceData.status
	self.result = sourceData.result
end

function WorkBase:getChildren()
	return nil
end

function WorkBase:onDestroy()
	self.parent = nil
	self._dispatcher = nil
	self.id = nil
	self.workflow = nil
end

function WorkBase:addDoneListener(handler, handlerObj)
	if not self._dispatcher then
		self._dispatcher = {}

		NotifyDispatcher.extend(self._dispatcher)
	end

	self._dispatcher:addListener(1, handler, handlerObj)
end

function WorkBase:removeDoneListener(handler, handlerObj)
	if not self._dispatcher then
		return
	end

	self._dispatcher:removeListener(1, handler, handlerObj)
end

return WorkBase
