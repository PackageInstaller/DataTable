-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/frameworkext/ai/workflow/flow/FlowRepeatForever.lua

module("frameworkext.ai.workflow.flow.FlowRepeatForever", package.seeall)

local FlowRepeatForever = class("FlowRepeatForever", FlowBase)

function FlowRepeatForever:ctor()
	FlowRepeatForever.super.ctor(self)

	self._child = nil
	self._children = nil
end

function FlowRepeatForever:addChild(work)
	self._child = work
	self._child.parent = self
	self._children = {
		self._children
	}
end

function FlowRepeatForever:onStart(context)
	FlowRepeatForever.super.onStart(self, context)
	self._child:onStart(context)
end

function FlowRepeatForever:onChildDone(child)
	self:onDone(child.result)
end

function FlowRepeatForever:onInterrupt()
	FlowRepeatForever.super.onInterrupt(self)

	if self._child.status == WorkStatus.Running then
		self._child:onInterrupt()
	end
end

function FlowRepeatForever:getChildren()
	return self._children
end

function FlowRepeatForever:onDestroy()
	FlowRepeatForever.super.onDestroy(self)
	self._child:onDestroy()

	self._child = nil
	self._children = nil
end

return FlowRepeatForever
