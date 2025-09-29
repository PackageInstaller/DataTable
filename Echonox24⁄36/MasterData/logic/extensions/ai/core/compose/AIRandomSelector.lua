-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ai/core/compose/AIRandomSelector.lua

module("logic.extensions.ai.core.compose.AIRandomSelector", package.seeall)

local AIRandomSelector = class("AIRandomSelector", AIParentNode)

function AIRandomSelector:ctor(context)
	AIRandomSelector.super.ctor(self, context)

	self._currentChildIndex = 0
	self._totalWeight = 0
	self._childWeights = nil
end

function AIRandomSelector:initFromConfig(aiConfigData)
	AIRandomSelector.super.initFromConfig(self, aiConfigData)

	self._childWeights = string.splitToNumber(aiConfigData.weights, ":")

	for i = 1, #self._childWeights do
		self._totalWeight = self._totalWeight + self._childWeights[i]
	end
end

function AIRandomSelector:onStart()
	AIRandomSelector.super.onStart(self)

	if #self._childWeights ~= self:getChildrenCount() then
		printError("the count of the weight values does not match the count of the ai child nodes")

		return self:onEnd(AIConst.AIStatus.FAILD)
	end

	if self._totalWeight <= 0 then
		printError("the totalWeight is LEqual than zero")

		return self:onEnd(AIConst.AIStatus.FAILD)
	end

	local weight = math.random(1, self._totalWeight)

	for i = 1, #self._childWeights do
		if weight <= self._childWeights[i] then
			self._currentChildIndex = i

			break
		else
			weight = weight - self._childWeights[i]
		end
	end

	if self._currentChildIndex < 1 or self._currentChildIndex > self:getChildrenCount() then
		return self:onEnd(AIConst.AIStatus.FAILD)
	end

	return self:getChildAt(self._currentChildIndex):onStart()
end

function AIRandomSelector:onChildEnd(child)
	if child:getStatus() == AIConst.AIStatus.FAILD then
		return self:onEnd(AIConst.AIStatus.FAILD)
	else
		return self:onEnd(AIConst.AIStatus.SUCCESS)
	end
end

function AIRandomSelector:onReset()
	AIRandomSelector.super.onReset(self)

	self._currentChildIndex = 0
end

function AIRandomSelector:onRecycle()
	AIRandomSelector.super.onRecycle(self)

	self._currentChildIndex = 0
	self._totalWeight = 0
	self._childWeights = nil
end

function AIRandomSelector:onDestroy()
	AIRandomSelector.super.onDestroy(self)

	self._currentChildIndex = 0
	self._totalWeight = 0
	self._childWeights = nil
end

return AIRandomSelector
