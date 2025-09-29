-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ai/core/compose/AIRepeatCondition.lua

module("logic.extensions.ai.core.compose.AIRepeatCondition", package.seeall)

local AIRepeatCondition = class("AIRepeatCondition", AIParentNode)

function AIRepeatCondition:ctor(context)
	AIRepeatCondition.super.ctor(self, context)

	self._curSelectIndex = 0
	self._currentNode = false
	self._conditionCurrentNode = false
end

function AIRepeatCondition:onStart()
	AIRepeatCondition.super.onStart(self)

	local conditionNode = self:getChildAt(1)
	local node = conditionNode:onStart()

	if self:getStatus() ~= AIConst.AIStatus.RUNNING then
		return node
	else
		if conditionNode:getStatus() == AIConst.AIStatus.RUNNING then
			self._conditionCurrentNode = node
		end

		return self
	end
end

function AIRepeatCondition:onUpdate()
	local conditionNode = self:getChildAt(1)
	local node = false

	if conditionNode:getStatus() ~= AIConst.AIStatus.RUNNING then
		node = conditionNode:onStart()
	elseif self._conditionCurrentNode then
		node = self._conditionCurrentNode:onUpdate()
	end

	if conditionNode:getStatus() == AIConst.AIStatus.RUNNING then
		self._conditionCurrentNode = node
	end

	if self:getStatus() ~= AIConst.AIStatus.RUNNING then
		return node
	end

	if self._currentNode then
		node = self._currentNode:onUpdate()

		if self:getStatus() ~= AIConst.AIStatus.RUNNING then
			return node
		else
			self._currentNode = node
		end
	end

	return self
end

function AIRepeatCondition:onChildEnd(child)
	if child:getChildrenIndex() == 1 then
		local oldIndex = self._curSelectIndex

		if child:getStatus() == AIConst.AIStatus.FAILD then
			self._curSelectIndex = 3
		elseif child:getStatus() == AIConst.AIStatus.SUCCESS then
			self._curSelectIndex = 2
		end

		if oldIndex ~= self._curSelectIndex then
			local oldNode = self:getChildAt(oldIndex)
			local isChange = true

			if oldNode then
				isChange = oldNode:interruptWithoutReport()
			end

			if isChange then
				local node = self:getChildAt(self._curSelectIndex):onStart()

				if self:getStatus() ~= AIConst.AIStatus.RUNNING then
					return node
				else
					self._currentNode = node
				end
			end
		end

		return self
	else
		return self:onEnd(child:getStatus())
	end
end

function AIRepeatCondition:handleEnd()
	self._curSelectIndex = 0
	self._currentNode = false
end

function AIRepeatCondition:onReset()
	AIRepeatCondition.super.onReset(self)

	self._curSelectIndex = 0
end

function AIRepeatCondition:onReuse(context)
	AIRepeatCondition.super.onReuse(self, context)
end

function AIRepeatCondition:onRecycle()
	AIRepeatCondition.super.onRecycle(self)

	self._curSelectIndex = 0
end

function AIRepeatCondition:onDestroy()
	AIRepeatCondition.super.onDestroy(self)

	self._curSelectIndex = nil
end

return AIRepeatCondition
