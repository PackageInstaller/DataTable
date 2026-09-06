-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/frameworkext/ai/workflow/flow/FlowSequence.lua

module("frameworkext.ai.workflow.flow.FlowSequence", package.seeall)

local FlowSequence = class("FlowSequence", FlowBase)

function FlowSequence:ctor()
	FlowSequence.super.ctor(self)

	self._children = {}
	self._curIndex = 0
end

function FlowSequence:addChild(work)
	table.insert(self._children, work)

	work.parent = self
end

function FlowSequence:onStart(context)
	FlowSequence.super.onStart(self, context)

	self._curIndex = 0

	self:next()
end

function FlowSequence:next()
	self._curIndex = self._curIndex + 1

	local len = #self._children

	if len >= self._curIndex then
		self._children[self._curIndex]:onStart(self.context)
	end
end

function FlowSequence:onChildDone(child)
	if child.result == WorkResult.Succeed then
		if self._curIndex == #self._children then
			self:onDone(WorkResult.Succeed)
		else
			self:next()
		end
	else
		self:onDone(WorkResult.Fail)
	end
end

function FlowSequence:onInterrupt()
	FlowSequence.super.onInterrupt(self)

	if self._children[self._curIndex].status == WorkStatus.Running then
		self._children[self._curIndex]:onInterrupt()
	end
end

function FlowSequence:getChildren()
	return self._children
end

function FlowSequence:onDestroy()
	FlowSequence.super.onDestroy(self)

	local len = #self._children

	for i = 1, len do
		self._children[i]:onDestroy()
	end

	self._children = nil
end

return FlowSequence
