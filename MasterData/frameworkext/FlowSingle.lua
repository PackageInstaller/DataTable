-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/frameworkext/ai/workflow/flow/FlowSingle.lua

module("frameworkext.ai.workflow.flow.FlowSingle", package.seeall)

local FlowSingle = class("FlowSingle", FlowBase)

function FlowSingle:ctor()
	FlowSingle.super.ctor(self)

	self._child = nil
	self._children = nil
end

function FlowSingle:addChild(work)
	self._child = work
	self._child.parent = self
	self._children = {
		self._child
	}
end

function FlowSingle:onStart(context)
	FlowSingle.super.onStart(self, context)
	self._child:onStart(context)
end

function FlowSingle:onInterrupt()
	FlowSingle.super.onInterrupt(self)

	if self._child.status == WorkStatus.Running then
		self._child:onInterrupt()
	end
end

function FlowSingle:onChildDone(child)
	self:onDone(child.result)
end

function FlowSingle:getChildren()
	return self._children
end

function FlowSingle:onDestroy()
	FlowSingle.super.onDestroy(self)
	self._child:onDestroy()

	self._child = nil
	self._children = nil
end

return FlowSingle
