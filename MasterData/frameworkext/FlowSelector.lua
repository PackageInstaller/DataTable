-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/frameworkext/ai/workflow/flow/FlowSelector.lua

module("frameworkext.ai.workflow.flow.FlowSelector", package.seeall)

local FlowSelector = class("FlowSelector", FlowBase)

function FlowSelector:ctor()
	FlowSelector.super.ctor(self)

	self._selectWork = nil
	self._succeedWork = nil
	self._failWork = nil
	self._children = nil
end

function FlowSelector:addConditionWork(selectWork, succeedWork, failWork)
	self._selectWork = selectWork
	self._succeedWork = succeedWork
	self._failWork = failWork
	self._selectWork.parent = self
	self._succeedWork.parent = self
	self._failWork.parent = self
	self._children = {
		self._selectWork,
		self._succeedWork,
		self._failWork
	}
end

function FlowSelector:onStart(context)
	FlowSelector.super.onStart(self, context)
	self._selectWork:onStart(context)
end

function FlowSelector:onChildDone(child)
	if child == self._selectWork then
		if child.result == WorkResult.Succeed then
			self._succeedWork:onStart(self.context)
		else
			self._failWork:onStart(self.context)
		end
	else
		self:onDone(child.result)
	end
end

function FlowSelector:onInterrupt()
	FlowSelector.super.onInterrupt(self)

	if self._selectWork.status == WorkStatus.Running then
		self._selectWork:onInterrupt()
	elseif self._selectWork.status == WorkStatus.Stopped then
		if self._succeedWork.status == WorkStatus.Running then
			self._succeedWork:onInterrupt()
		elseif self._failWork.status == WorkStatus.Running then
			self._failWork:onInterrupt()
		end
	end
end

function FlowSelector:getChildren()
	return self._children
end

function FlowSelector:onDestroy()
	FlowSelector.super.onDestroy(self)
	self._selectWork:onDestroy()
	self._succeedWork:onDestroy()
	self._failWork:onDestroy()

	self._selectWork = nil
	self._succeedWork = nil
	self._failWork = nil
	self._children = nil
end

return FlowSelector
