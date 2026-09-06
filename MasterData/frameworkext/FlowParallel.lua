-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/frameworkext/ai/workflow/flow/FlowParallel.lua

module("frameworkext.ai.workflow.flow.FlowParallel", package.seeall)

local FlowParallel = class("FlowParallel", FlowBase)

function FlowParallel:ctor()
	FlowParallel.super.ctor(self)

	self._children = {}
	self._doneCount = 0
	self._succeedCount = 0
end

function FlowParallel:addChild(work)
	table.insert(self._children, work)

	work.parent = self
end

function FlowParallel:onStart(context)
	FlowParallel.super.onStart(self, context)

	self._doneCount = 0
	self._succeedCount = 0

	local len = #self._children

	for i = 1, len do
		self._children[i]:onStart(context)
	end
end

function FlowParallel:onChildDone(child)
	self._doneCount = self._doneCount + 1

	if child.result == WorkResult.Succeed then
		self._succeedCount = self._succeedCount + 1
	end

	if self._doneCount == #self._children then
		if self._succeedCount == self._doneCount then
			self.super.onDone(WorkResult.Succeed)
		else
			self.super.onDone(WorkResult.Fail)
		end
	end
end

function FlowParallel:onInterrupt()
	FlowParallel.super.onInterrupt(self)

	local len = #self._children

	for i = 1, len do
		if self._children[i].status == WorkStatus.Running then
			self._children[i]:onInterrupt()
		end
	end
end

function FlowParallel:getChildren()
	return self._children
end

function FlowParallel:onDestroy()
	FlowParallel.super.onDestroy(self)

	local len = #self._children

	for i = 1, len do
		self._children[i]:onDestroy()
	end

	self._children = nil
end

return FlowParallel
