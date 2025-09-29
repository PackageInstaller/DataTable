-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ai/impl/action/AIRandomWalk.lua

module("logic.extensions.ai.impl.action.AIRandomWalk", package.seeall)

local M = class("AIRandomWalk", AINode)

function M:ctor(context)
	M.super.ctor(self, context)

	self._waitForComplete = true
	self._moveFrameCount = 0
end

function M:initFromConfig(aiConfigData)
	M.super.initFromConfig(self, aiConfigData)
end

function M:onStart()
	M.super.onStart(self)

	local unit = self:getContext():getUnit()

	unit.navMesh:setNavMeshAgentStatus(true)

	if unit.navMesh:movetoRandomPosInTargetZone() then
		unit.navMesh:resumeNavMesh()

		self._moveFrameCount = 0

		if self._waitForComplete then
			return self
		end

		return self:onEnd(AIConst.AIStatus.SUCCESS)
	end

	return self:onEnd(AIConst.AIStatus.FAILD)
end

function M:onUpdate()
	local unit = self:getContext():getUnit()

	if self._waitForComplete and unit.navMeshMover:isArrivedDestination() then
		return self:onEnd(AIConst.AIStatus.SUCCESS)
	end

	return self
end

function M:handleEnd()
	return
end

function M:onReset()
	M.super.onReset(self)

	self._moveFrameCount = 0
end

function M:onReuse(context)
	M.super.onReuse(self, context)
end

function M:onRecycle()
	M.super.onRecycle(self)

	self._moveFrameCount = 0
end

function M:onDestroy()
	M.super.onDestroy(self)

	self._moveFrameCount = 0
end

return M
