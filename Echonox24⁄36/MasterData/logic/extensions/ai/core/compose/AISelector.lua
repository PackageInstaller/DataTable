-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ai/core/compose/AISelector.lua

module("logic.extensions.ai.core.compose.AISelector", package.seeall)

local AISelector = class("AISelector", AIParentNode)

function AISelector:ctor(context)
	AISelector.super.ctor(self, context)

	self._currentChildIndex = 0
end

function AISelector:onStart()
	AISelector.super.onStart(self)

	self._currentChildIndex = 1

	return self:getChildAt(self._currentChildIndex):onStart()
end

function AISelector:onChildEnd(child)
	if child:getStatus() == AIConst.AIStatus.FAILD then
		self._currentChildIndex = self._currentChildIndex + 1

		local nextChild = self:getChildAt(self._currentChildIndex)

		if nextChild then
			return nextChild:onStart()
		else
			return self:onEnd(AIConst.AIStatus.FAILD)
		end
	else
		return self:onEnd(AIConst.AIStatus.SUCCESS)
	end
end

function AISelector:onReset()
	AISelector.super.onReset(self)

	self._currentChildIndex = 0
end

function AISelector:onReuse(context)
	AISelector.super.onReuse(self, context)
end

function AISelector:onRecycle()
	AISelector.super.onRecycle(self)

	self._currentChildIndex = 0
end

function AISelector:onDestroy()
	AISelector.super.onDestroy(self)

	self._currentChildIndex = nil
end

return AISelector
