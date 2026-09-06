-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/frameworkext/ai/workflow/flow/FlowCondition.lua

module("frameworkext.ai.workflow.flow.FlowCondition", package.seeall)

local FlowCondition = class("FlowCondition", FlowBase)

function FlowCondition:ctor()
	FlowCondition.super.ctor(self)

	self._condition = nil
	self._conditionResult = false
	self._trueWork = nil
	self._falseWork = nil
	self._children = nil
end

function FlowCondition:addCondition(condition, trueWork, falseWork)
	self._condition = condition
	self._trueWork = trueWork
	self._falseWork = falseWork
	self._trueWork.parent = self
	self._falseWork.parent = self
	self._children = {
		self._trueWork,
		self._falseWork
	}
end

function FlowCondition:onStart(context)
	FlowCondition.super.onStart(self, context)

	self._conditionResult = self._condition.isMeetCondition()

	if self._conditionResult then
		if self._trueWork then
			self._trueWork:onStart(context)
		else
			self:onChildDone(nil)
		end
	elseif self._falseWork then
		self._falseWork:onStart(context)
	else
		self:onChildDone(nil)
	end
end

function FlowCondition:onChildDone(child)
	if child then
		FlowCondition.super.onDone(self, child.result)
	else
		FlowCondition.super.onDone(self, WorkResult.Succeed)
	end
end

function FlowCondition:onInterrupt()
	FlowCondition.super.onInterrupt(self)

	if self._conditionResult then
		if self._trueWork and self._trueWork.status == WorkStatus.Running then
			self._trueWork:onInterrupt()
		end
	elseif self._falseWork and self._falseWork.status == WorkStatus.Running then
		self._falseWork:onInterrupt()
	end
end

function FlowCondition:getChildren()
	return self._children
end

function FlowCondition:onDestroy()
	FlowCondition.super.onDestroy(self)

	if self._trueWork then
		self._trueWork:onDestroy()
	end

	if self._falseWork then
		self._falseWork:onDestroy()
	end

	self._condition = nil
	self._trueWork = nil
	self._falseWork = nil
	self._children = nil
end

return FlowCondition
