-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ai/impl/action/AIOperateShelterDevice.lua

module("logic.extensions.ai.impl.action.AIOperateShelterDevice", package.seeall)

local M = class("AIOperateShelterDevice", AINode)
local AnimationState = HouseEnum.AnimationState
local vec3Temp = Vector3.New()

function M:ctor(context)
	M.super.ctor(self, context)

	self._minOperateTime = 0
	self._maxOperateTime = 0
	self._minPanicTime = 0
	self._maxPanicTime = 0
	self._endTime = 0
	self._moveFrameCount = 0
	self._operateStep = 0
	self._panicPlayTime = 0
end

function M:initFromConfig(aiConfigData)
	M.super.initFromConfig(self, aiConfigData)

	self._minOperateTime = aiConfigData.minOperateTime
	self._maxOperateTime = aiConfigData.maxOperateTime
	self._minPanicTime = aiConfigData.minPanicTime
	self._maxPanicTime = aiConfigData.maxPanicTime
end

function M:onStart()
	M.super.onStart(self)

	self._operateStep = 1

	return self:onEnd(AIConst.AIStatus.SUCCESS)
end

function M:handleEnd()
	return
end

function M:onUpdate()
	local unit = self:getContext():getUnit()
	local hasArrived = unit.navMeshMover:isArrivedDestination()

	if self._operateStep == 1 and hasArrived then
		self._operateStep = 2

		unit.navMesh:setNavMeshAgentStatus(false)
		unit.spine:setDirection(UnitSpineDir.Right)
		unit:addInnerEventListener(UnitActionType.SpineEvent, self._onHeroSpineEvent, self)
		unit.spine:play(AnimationState.Control1, false)
	end

	if self._operateStep == 3 and Time.time >= self._endTime then
		self._operateStep = 4

		unit:addInnerEventListener(UnitActionType.SpineEvent, self._onHeroSpineEvent, self)
		unit.spine:play(AnimationState.Control3, false)
	end

	if self._operateStep == 3 and self._panicPlayTime > 0 and Time.time >= self._panicPlayTime then
		self._panicPlayTime = 0

		self:_playHeroPanic()
	end

	if self._operateStep == 5 then
		return self:onEnd(AIConst.AIStatus.SUCCESS)
	end

	return self
end

function M:_searchDevicePos()
	local unit = self:getContext():getUnit()
	local roomId = unit.navMesh:getCurZoneId()
	local roomMgr = SceneMgr.instance:getCurScene().roomMgr
	local roomUnit = roomMgr:getUnitById(roomId)

	if roomUnit then
		local roomGO = roomUnit.resLoader:getRoomGO()
		local posX, posY, posZ = roomUnit.model:getShelterDevicePos()

		if roomGO and posX and posY and posZ then
			local targetX, targetY, targetZ = roomUnit.resLoader:getWorldPosWithLocal(posX, posY, posZ)

			vec3Temp:Set(targetX, targetY, targetZ)
			unit.navMesh:setNavMeshAgentStatus(true)
			unit.navMesh:resumeNavMesh()
			unit.navMesh:setDestination(vec3Temp)

			return true
		end
	end

	return false
end

function M:_playHeroPanic()
	local unit = self:getContext():getUnit()

	unit:addInnerEventListener(UnitActionType.SpineEvent, self._onHeroSpineEvent, self)
	unit.spine:play(AnimationState.Panic, false)
end

function M:_tryStartPanicCountdown()
	self._panicPlayTime = 0

	local panicCd = self._minPanicTime

	if self._maxPanicTime > self._minPanicTime then
		panicCd = math.random(self._minPanicTime, self._maxPanicTime)
	end

	if panicCd > 0 then
		self._panicPlayTime = Time.time + panicCd
	end
end

function M:_getOperateTime()
	if self._minOperateTime == self._maxOperateTime then
		return self._minOperateTime
	else
		return math.random(self._minOperateTime, self._maxOperateTime)
	end
end

function M:_onHeroSpineEvent(eventId, actionType, animationName, eventName, eventParam)
	local unit = self:getContext():getUnit()

	if eventName == SpineEventName.Complete then
		if animationName == AnimationState.Control1 then
			self:_removeUnitSpineEvent()

			self._endTime = Time.time + self:_getOperateTime()

			unit.spine:play(AnimationState.Control2, true)
			self:_tryStartPanicCountdown()

			self._operateStep = 3
		elseif animationName == AnimationState.Control3 then
			self:_removeUnitSpineEvent()

			self._operateStep = 5
		elseif animationName == AnimationState.Panic then
			self:_removeUnitSpineEvent()
			unit.spine:play(AnimationState.Control2, true)
			self:_tryStartPanicCountdown()
		end
	end
end

function M:onReset()
	if self._operateStep > 1 then
		self:_removeUnitSpineEvent()
	end

	M.super.onReset(self)

	self._endTime = 0
	self._moveFrameCount = 0
	self._operateStep = 0
	self._panicPlayTime = 0
end

function M:onReuse(context)
	M.super.onReuse(self, context)
end

function M:onRecycle()
	self:_removeUnitSpineEvent()
	M.super.onRecycle(self)

	self._endTime = 0
	self._moveFrameCount = 0
	self._operateStep = 0
	self._panicPlayTime = 0
end

function M:onDestroy()
	M.super.onDestroy(self)

	self._endTime = nil
	self._moveFrameCount = nil
	self._operateStep = nil
	self._panicPlayTime = nil
end

function M:_removeUnitSpineEvent()
	local unit = self:getContext():getUnit()

	unit:removeInnerEventListener(UnitActionType.SpineEvent, self._onHeroSpineEvent, self)
end

return M
