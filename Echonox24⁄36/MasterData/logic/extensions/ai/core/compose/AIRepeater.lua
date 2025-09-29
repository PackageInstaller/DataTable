-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ai/core/compose/AIRepeater.lua

module("logic.extensions.ai.core.compose.AIRepeater", package.seeall)

local AIRepeater = class("AIRepeater", AIParentNode)
local tAIStatus = AIConst.AIStatus

function AIRepeater:ctor(context)
	AIRepeater.super.ctor(self, context)

	self._count = 1
	self._repeatForever = false
	self._endOnFailure = false
	self._returnSuccess = false
	self._executeCount = 0
end

function AIRepeater:initFromConfig(aiConfigData)
	AIRepeater.super.initFromConfig(self, aiConfigData)

	self._count = aiConfigData.count
	self._repeatForever = aiConfigData.repeatForever
	self._endOnFailure = aiConfigData.endOnFailure
	self._returnSuccess = aiConfigData.returnSuccess
end

function AIRepeater:onStart()
	AIRepeater.super.onStart(self)

	self._executeCount = self._executeCount + 1

	return self:getFirstChild():onStart()
end

function AIRepeater:onUpdate()
	if self._status == tAIStatus.RUNNING then
		if self:getFirstChild():getStatus() == tAIStatus.RUNNING then
			self:getFirstChild():onUpdate()

			return self
		elseif self._repeatForever or self._count > self._executeCount then
			return self:onStart()
		end
	end

	return self
end

function AIRepeater:onChildEnd(child)
	if child:getStatus() == tAIStatus.FAILD and self._endOnFailure then
		if self._returnSuccess then
			return self:onEnd(tAIStatus.SUCCESS)
		end

		return self:onEnd(tAIStatus.FAILD)
	end

	if not self._repeatForever and self._count == self._executeCount then
		return self:onEnd(tAIStatus.SUCCESS)
	end

	return self
end

function AIRepeater:onReset()
	AIRepeater.super.onReset(self)

	self._executeCount = 0
end

function AIRepeater:onReuse(context)
	AIRepeater.super.onReuse(self, context)
end

function AIRepeater:onRecycle()
	AIRepeater.super.onRecycle(self)

	self._count = 1
	self._repeatForever = false
	self._endOnFailure = false
	self._returnSuccess = false
	self._executeCount = 0
end

function AIRepeater:onDestroy()
	AIRepeater.super.onDestroy(self)

	self._count = nil
	self._repeatForever = nil
	self._endOnFailure = nil
	self._returnSuccess = nil
	self._executeCount = nil
end

return AIRepeater
