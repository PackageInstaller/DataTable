-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ai/core/compose/AISequence.lua

module("logic.extensions.ai.core.compose.AISequence", package.seeall)

local AISequence = class("AISequence", AIParentNode)

function AISequence:ctor(context)
	AISequence.super.ctor(self, context)

	self._currentChildIndex = 0
end

function AISequence:onStart()
	AISequence.super.onStart(self)

	self._currentChildIndex = 1

	return self:getChildAt(self._currentChildIndex):onStart()
end

function AISequence:onChildEnd(child)
	if child:getStatus() == AIConst.AIStatus.SUCCESS then
		self._currentChildIndex = self._currentChildIndex + 1

		local nextChild = self:getChildAt(self._currentChildIndex)

		if nextChild then
			return nextChild:onStart()
		else
			return self:onEnd(AIConst.AIStatus.SUCCESS)
		end
	else
		return self:onEnd(AIConst.AIStatus.FAILD)
	end
end

function AISequence:onReset()
	AISequence.super.onReset(self)

	self._currentChildIndex = 0
end

function AISequence:onReuse(context)
	AISequence.super.onReuse(self, context)
end

function AISequence:onRecycle()
	AISequence.super.onRecycle(self)

	self._currentChildIndex = 0
end

function AISequence:onDestroy()
	AISequence.super.onDestroy(self)

	self._currentChildIndex = nil
end

return AISequence
