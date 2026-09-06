-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/frameworkext/ai/workflow/flow/FlowParallelOr.lua

module("frameworkext.ai.workflow.flow.FlowParallelOr", package.seeall)

local FlowParallelOr = class("FlowParallelOr", FlowBase)

function FlowParallelOr:ctor()
	FlowParallelOr.super.ctor(self)

	self._children = {}
	self._doneCount = 0
end

function FlowParallelOr:addChild(work)
	table.insert(self._children, work)

	work.parent = self
end

function FlowParallelOr:onStart(context)
	FlowParallelOr.super.onStart(self, context)

	self._doneCount = 0

	local len = #self._children

	for i = 1, len do
		self._children[i]:onStart(context)
	end
end

function FlowParallelOr:onChildDone(child)
	self._doneCount = self._doneCount + 1

	if child.result == WorkResult.Succeed then
		local len = #self._children

		for i = 1, len do
			if self._children[i].status == WorkStatus.Running then
				self._children[i]:onInterrupt()
			end
		end

		self:onDone(WorkResult.Succeed)
	elseif self._doneCount == #self._children then
		FlowParallelOr.super.onDone(WorkResult.Fail)
	end
end

function FlowParallelOr:onInterrupt()
	FlowParallelOr.super.onInterrupt(self)

	local len = #self._children

	for i = 1, len do
		if self._children[i].status == WorkStatus.Running then
			self._children[i]:onInterrupt()
		end
	end
end

function FlowParallelOr:getChildren()
	return self._children
end

function FlowParallelOr:onDestroy()
	FlowParallelOr.super.onDestroy(self)

	local len = #self._children

	for i = 1, len do
		self._children[i]:onDestroy()
	end

	self._children = nil
end

return FlowParallelOr
