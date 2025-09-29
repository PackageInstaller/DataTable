-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ai/core/base/AIParentNode.lua

module("logic.extensions.ai.core.base.AIParentNode", package.seeall)

local AIParentNode = class("AIParentNode", AINode)

function AIParentNode:ctor(context)
	AIParentNode.super.ctor(self, context)

	self._children = false
end

function AIParentNode:onStart()
	local node = AIParentNode.super.onStart(self)

	self:getContext():sink()

	return node
end

function AIParentNode:addChild(child)
	if not self._children then
		self._children = {}
	end

	table.insert(self._children, child)
	child:setParent(self)

	child._childrenIndex = #self._children
end

function AIParentNode:removeChild(child)
	if not self._children then
		return
	end

	child:setParent(nil)
	table.removebyvalue(self._children, child)
end

function AIParentNode:removeChildAt(index)
	if not self._children then
		return
	end

	local child = self:getChildAt(index)

	if child then
		child:setParent(nil)
		table.remove(self._children, index)
	end
end

function AIParentNode:removeAllChild()
	if not self._children then
		return
	end

	for _, child in ipairs(self._children) do
		child:setParent(nil)
	end

	table.clear(self._children)
end

function AIParentNode:getChildren()
	return self._children
end

function AIParentNode:getChildrenCount()
	if self._children then
		return #self._children
	end

	return 0
end

function AIParentNode:getFirstChild()
	return self:getChildAt(1)
end

function AIParentNode:getChildAt(index)
	return self._children[index]
end

function AIParentNode:onChildEnd(child)
	printError(string.format("no implement exception in class [%s]", tostring(self.class)))
end

function AIParentNode:canInterrupt()
	local canInterrupt = true

	for _, child in ipairs(self._children) do
		if child:getStatus() == AIConst.AIStatus.RUNNING and not child:canInterrupt() then
			canInterrupt = false

			break
		end
	end

	return canInterrupt
end

function AIParentNode:onInterrupt(status)
	for _, child in ipairs(self._children) do
		if child:getStatus() == AIConst.AIStatus.RUNNING then
			child:onInterruptWithoutReport()
		end
	end

	self:getContext():float()

	return AIParentNode.super.onInterrupt(self, status)
end

function AIParentNode:onInterruptWithoutReport()
	for _, child in ipairs(self._children) do
		if child:getStatus() == AIConst.AIStatus.RUNNING then
			child:onInterruptWithoutReport()
		end
	end

	self:getContext():float()
	AIParentNode.super.onInterruptWithoutReport(self)
end

function AIParentNode:onEnd(status)
	self:getContext():float()

	return AIParentNode.super.onEnd(self, status)
end

function AIParentNode:onReset()
	if self:getStatus() == AIConst.AIStatus.RUNNING then
		self:getContext():float()
	end

	if self._children then
		for _, child in ipairs(self._children) do
			child:onReset()
		end
	end

	AIParentNode.super.onReset(self)
end

function AIParentNode:onReuse(context)
	AIParentNode.super.onReuse(self, context)
end

function AIParentNode:onRecycle()
	if self._children then
		for _, child in ipairs(self._children) do
			child:returnSelf()
		end

		table.clear(self._children)
	end

	AIParentNode.super.onRecycle(self)
end

function AIParentNode:onDestroy()
	AIParentNode.super.onDestroy(self)

	self._children = false
end

return AIParentNode
