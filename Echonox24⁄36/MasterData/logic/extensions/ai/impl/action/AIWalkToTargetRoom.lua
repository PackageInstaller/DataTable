-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ai/impl/action/AIWalkToTargetRoom.lua

module("logic.extensions.ai.impl.action.AIWalkToTargetRoom", package.seeall)

local M = class("AIWalkToTargetRoom", AINode)
local AnimationState = HouseEnum.AnimationState
local kResetDestinationInterval = 2

function M:ctor(context)
	M.super.ctor(self, context)

	self._waitForComplete = true
	self._needChangeProSuit = false
	self._wearSuitStatus = 0
	self._resetDestinationTime = 0
end

function M:initFromConfig(aiConfigData)
	M.super.initFromConfig(self, aiConfigData)
end

function M:onStart()
	M.super.onStart(self)

	self._needChangeProSuit = false
	self._resetDestinationTime = Time.time

	local unit = self:getContext():getUnit()

	unit.performCtrl:setTriggerFurniture(false)
	unit.performCtrl:setForbid(HouseEnum.PerformForbidKey.HousePerform, true)

	if self:_moveToDestination() then
		if self._waitForComplete then
			return self
		end

		return self:onEnd(AIConst.AIStatus.SUCCESS)
	end

	return self:onEnd(AIConst.AIStatus.FAILD)
end

function M:onUpdate()
	local unit = self:getContext():getUnit()
	local hasArrived = unit.navMeshMover:isArrivedDestination()

	if self._needChangeProSuit then
		-- block empty
	elseif hasArrived then
		local curZoneId = unit.navMesh:getCurZoneId()
		local targetZoneId = self:getContext():getTargetRoomId()

		if targetZoneId == curZoneId then
			return self:onEnd(AIConst.AIStatus.SUCCESS)
		elseif Time.time > self._resetDestinationTime then
			local destination = self:getContext():getDestination()

			unit.navMesh:setDestination(destination)

			self._resetDestinationTime = Time.time + kResetDestinationInterval
		end
	end

	return self
end

function M:handleEnd()
	local unit = self:getContext():getUnit()

	unit.performCtrl:setTriggerFurniture(true)
	unit.performCtrl:setForbid(HouseEnum.PerformForbidKey.HousePerform, false)
end

function M:_createEmptySuit()
	local unit = self:getContext():getUnit()
	local paramTable = {}

	paramTable.bornPos = self._targetSuitPos
	paramTable.isActive = true
	paramTable.angle = self._targetSuitAngle
	paramTable.actionName = AnimationState.Idle2
	paramTable.direction = self._emptySuitDirection
	paramTable.isFadeIn = true
	paramTable.fadeInTime = 2

	unit.protectiveSuit:createEmptySuit(paramTable)
end

function M:_moveToDestination()
	local useRamdonPos = self:getContext():getUseRandomPos()
	local unit = self:getContext():getUnit()

	unit.navMesh:setNavMeshAgentStatus(true)
	unit.navMesh:resumeNavMesh()

	if useRamdonPos then
		local targetRoomId = self:getContext():getTargetRoomId()
		local succeed, randomPos = unit.navMesh:movetoRandomPosInTargetZone(targetRoomId)

		if succeed and targetRoomId then
			self:getContext():setTargetPos(randomPos, targetRoomId)
		end

		return succeed
	else
		local destination = self:getContext():getDestination()

		if destination then
			unit.navMesh:setDestination(destination)

			return true
		end
	end

	return false
end

function M:_getSuitPos(targetRoomId)
	local unit = self:getContext():getUnit()
	local unitPosX, unitPosY, unitPosZ = unit.navMesh:getNavMeshGoPos()
	local navMO = HouseNavigationModel.instance:getMOByZoneId(targetRoomId)
	local leftSuitPos = navMO:getLeftSuitPos()
	local rightSuitPos = navMO:getRightSuitPos()
	local leftDistance = math.pow(unitPosX - leftSuitPos.x, 2) + math.pow(unitPosY - leftSuitPos.y, 2)
	local rightDistance = math.pow(unitPosX - rightSuitPos.x, 2) + math.pow(unitPosY - rightSuitPos.y, 2)
	local targetSuitPos = leftDistance < rightDistance and leftSuitPos or rightSuitPos

	self._emptySuitDirection = leftDistance < rightDistance and UnitSpineDir.Right or UnitSpineDir.Left

	return targetSuitPos
end

function M:_onUnitSpineEvent(eventId, actionType, animationName, eventName, eventParam)
	if eventName == SpineEventName.Complete and animationName == AnimationState.CastOn then
		local unit = self:getContext():getUnit()

		unit.protectiveSuit:switchWearing(true)

		self._wearSuitStatus = 2

		self:_removeUnitSpineEvent()
	end
end

function M:onReset()
	M.super.onReset(self)

	self._needChangeProSuit = false
	self._wearSuitStatus = 0
	self._resetDestinationTime = 0
end

function M:onReuse(context)
	M.super.onReuse(self, context)
end

function M:onRecycle()
	self:_removeUnitSpineEvent()
	M.super.onRecycle(self)

	self._needChangeProSuit = false
	self._wearSuitStatus = 0
	self._resetDestinationTime = 0
end

function M:onDestroy()
	M.super.onDestroy(self)

	self._needChangeProSuit = false
	self._wearSuitStatus = 0
	self._resetDestinationTime = 0
end

function M:_removeUnitSpineEvent()
	return
end

return M
