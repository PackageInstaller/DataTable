-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ai/impl/condition/AISelectedByWorkType.lua

module("logic.extensions.ai.impl.condition.AISelectedByWorkType", package.seeall)

local M = class("AISelectedByWorkType", AINode)

function M:ctor(context)
	M.super.ctor(self, context)

	self._workType = 0
end

function M:initFromConfig(aiConfigData)
	M.super.initFromConfig(self, aiConfigData)

	self._workType = aiConfigData.workType
end

function M:onStart()
	M.super.onStart(self)

	local unit = self:getContext():getUnit()

	if unit.scheduleModel:getWorkType() == self._workType then
		return self:onEnd(AIConst.AIStatus.SUCCESS)
	end

	return self:onEnd(AIConst.AIStatus.FAILD)
end

function M:handleEnd()
	return
end

function M:onReset()
	M.super.onReset(self)
end

function M:onReuse(context)
	M.super.onReuse(self, context)
end

function M:onRecycle()
	M.super.onRecycle(self)

	self._workType = 0
end

function M:onDestroy()
	M.super.onDestroy(self)

	self._workType = 0
end

return M
