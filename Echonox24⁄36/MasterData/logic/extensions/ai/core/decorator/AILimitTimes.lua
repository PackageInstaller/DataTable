-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ai/core/decorator/AILimitTimes.lua

module("logic.extensions.ai.core.decorator.AILimitTimes", package.seeall)

local AILimitTimes = class("AILimitTimes", AIParentNode)

function AILimitTimes:ctor(context)
	AILimitTimes.super.ctor(self, context)

	self._totalTimes = 0
	self._passTimes = 0
end

function AILimitTimes:initFromConfig(aiConfigData)
	AILimitTimes.super.initFromConfig(self, aiConfigData)

	self._totalTimes = aiConfigData.totalTimes
end

function AILimitTimes:onStart()
	AILimitTimes.super.onStart(self)

	if self._passTimes >= self._totalTimes then
		return self:onEnd(AIConst.AIStatus.FAILD)
	else
		self._passTimes = self._passTimes + 1

		return self:getFirstChild():onStart()
	end
end

function AILimitTimes:onChildEnd(child)
	if child:getStatus() == AIConst.AIStatus.FAILD then
		return self:onEnd(AIConst.AIStatus.FAILD)
	else
		return self:onEnd(AIConst.AIStatus.SUCCESS)
	end
end

function AILimitTimes:onReset()
	AILimitTimes.super.onReset(self)
end

function AILimitTimes:onReuse(context)
	AILimitTimes.super.onReuse(self, context)
end

function AILimitTimes:onRecycle()
	AILimitTimes.super.onRecycle(self)

	self._passTimes = 0
	self._totalTimes = 0
end

function AILimitTimes:onDestroy()
	AILimitTimes.super.onDestroy(self)

	self._passTimes = nil
	self._totalTimes = nil
end

return AILimitTimes
