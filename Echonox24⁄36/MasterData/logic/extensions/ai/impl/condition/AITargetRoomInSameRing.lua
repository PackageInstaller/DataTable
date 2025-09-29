-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ai/impl/condition/AITargetRoomInSameRing.lua

module("logic.extensions.ai.impl.condition.AITargetRoomInSameRing", package.seeall)

local M = class("AITargetRoomInSameRing", AINode)

function M:ctor(context)
	M.super.ctor(self, context)

	self._withPath = true
end

function M:initFromConfig(aiConfigData)
	M.super.initFromConfig(self, aiConfigData)

	self._withPath = aiConfigData.withPath
end

function M:onStart()
	M.super.onStart(self)

	local unit = self:getContext():getUnit()
	local curZoneId = unit.navMesh:getCurZoneId()
	local targetZoneId = self:getContext():getTargetRoomId()

	if not targetZoneId or targetZoneId and targetZoneId <= 0 then
		printWarn("目标区域id错误，id：", targetZoneId)

		return self:onEnd(AIConst.AIStatus.FAILD)
	end

	if self._withPath then
		local canWalk = HouseSceneUtil.canWalkToTargetZone(curZoneId, targetZoneId)

		if canWalk then
			return self:onEnd(AIConst.AIStatus.SUCCESS)
		end

		return self:onEnd(AIConst.AIStatus.FAILD)
	end

	local curRingType = NavMeshUtil.getRingTypeByZoneId(curZoneId)
	local targetRingType = NavMeshUtil.getRingTypeByZoneId(targetZoneId)

	if curRingType == targetRingType then
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

	self._withPath = true
end

function M:onDestroy()
	M.super.onDestroy(self)

	self._withPath = true
end

return M
