-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/unit/component/navigation/UnitCompNavMeshMover.lua

module("logic.scene.unit.component.navigation.UnitCompNavMeshMover", package.seeall)

local M = class("UnitCompNavMeshMover", UnitComponentBase)
local AnimationState = HouseEnum.AnimationState
local PlayerStatus = HouseEnum.PlayerStatus
local NavMeshAreas = SceneEnum.NavMeshAreas
local UnitDirection = HouseEnum.UnitDirection

function M:ctor(unit)
	M.super.ctor(self, unit)

	self._cacheDeltaForRota = list:new()
	self._sumDeltaForRota = Vector3.New()
	self._cacheDeltaForMove = list:new()
	self._sumDeltaForMove = Vector3.New()
	self._cacheMoveSpeed = list:new()
	self._lastPos = Vector3.New()

	self:_resetData()
end

function M:onInit()
	self:_resetData()
	self:resetActionName()
	self:_setEvents(true)
end

function M:onReuse()
	self:_setEvents(true)
end

function M:onReset()
	self:_setEvents(false)
	self:_resetData()
	self:resetActionName()
	self._unit:removeInnerEventListener(UnitActionType.NavMeshAreaChange, self._initStatus, self)
end

function M:onDestroy()
	self:onReset()

	self._animNameIdle = nil
	self._animNameWalk = nil
	self._cacheDeltaForRota = nil
	self._sumDeltaForRota = nil
	self._cacheDeltaForMove = nil
	self._sumDeltaForMove = nil
	self._cacheMoveSpeed = nil
	self._lastPos = nil
end

function M:_resetData()
	self._idleCount = 0
	self._stopAngle = false
	self._rotationTargetGO = false
	self._isArrivedDestination = false
	self._needModifyDestination = true

	self._cacheDeltaForRota:clear()
	self._sumDeltaForRota:Set(0, 0, 0)
	self._cacheDeltaForMove:clear()
	self._sumDeltaForMove:Set(0, 0, 0)
	self._cacheMoveSpeed:clear()

	self._sumMoveSpeed = 0

	self._lastPos:Set(0, 0, 0)

	self._slowlyCount = 0
end

function M:_setEvents(add)
	if add then
		self._unit:addInnerEventListener(UnitActionType.NavMeshAreaChange, self._dealAreaChange, self)
	else
		self._unit:removeInnerEventListener(UnitActionType.NavMeshAreaChange, self._dealAreaChange, self)
	end
end

function M:setIdleName(name)
	self._animNameIdle = name
end

function M:setWalkName(name)
	self._animNameWalk = name
end

function M:resetActionName()
	self._animNameIdle = AnimationState.Idle
	self._animNameWalk = AnimationState.Walk
end

function M:setStopChangeAngle(stop)
	self._stopAngle = stop

	if stop then
		self._cacheDeltaForRota:clear()
		self._sumDeltaForRota:Set(0, 0, 0)
	end
end

function M:_dealAreaChange(e, actionType, curAreaType, preAreaType, areaName)
	if NavMeshAreas.Link == curAreaType then
		self._unit.navMesh:startManualNavMeshLink()

		if self._unit.navMesh:getIsMainPlayer() then
			self:lookAtPos(self._unit.navMesh:getLinkEndPos())
		end
	end
end

function M:setRotation(isRight)
	local pos = Vector3.New()

	pos:Set(Astral.TransformUtil.GetPos(self._unit.go.transform, 0, 0, 0))

	local forward = Vector3.New(-pos.x, -pos.y, 0)
	local angle = isRight and 90 or -90
	local yAngle = Quaternion.Euler(0, angle, 0)
	local upToCenter = Quaternion.LookRotation(Vector3.forward, forward)
	local q = upToCenter * yAngle

	Astral.TransformUtil.SetRotation(self._unit.go.transform, q.x, q.y, q.z, q.w)
end

function M:setDirection(dir)
	local newRotaX, newRotaY, newRotaZ = self:getRotationWithDir(dir)

	Astral.TransformUtil.SetLocalRotation(self._unit.go.transform, newRotaX, newRotaY, newRotaZ)
end

function M:getRotationWithDir(dir)
	local posX, posY, posZ = self._unit.navMesh:getNavMeshGoPos()
	local angle = self:_calculateMoveAngle(posX, posY)
	local rotaX, rotaY, rotaZ = Astral.TransformUtil.GetLocalRotation(self._unit.go.transform, 0, 0, 0)
	local newRotaX, newRotaY, newRotaZ = HouseSceneUtil.adjustUnitAngle(angle, rotaX, rotaY, rotaZ, dir)

	return newRotaX, newRotaY, newRotaZ
end

function M:getDirection()
	local posX, posY, posZ = self._unit.navMesh:getNavMeshGoPos()
	local angle = self:_calculateMoveAngle(posX, posY)
	local rotaX, rotaY, rotaZ = Astral.TransformUtil.GetLocalRotation(self._unit.go.transform, 0, 0, 0)
	local dirAngle = HouseSceneUtil.getUnitDirAngle(angle, rotaX, rotaY, rotaZ)

	if MathUtil.isAngleInRange(dirAngle, UnitDirection.Left - 45, UnitDirection.Left + 45) then
		return UnitDirection.Left
	elseif MathUtil.isAngleInRange(dirAngle, UnitDirection.Right - 45, UnitDirection.Right + 45) then
		return UnitDirection.Right
	elseif MathUtil.isAngleInRange(dirAngle, UnitDirection.Back - 45, UnitDirection.Back + 45) then
		return UnitDirection.Back
	end

	return UnitDirection.Forward
end

function M:lookAtPos(pos)
	local posX, posY, posZ = self._unit.navMesh:getNavMeshGoPos()
	local angle = self:_calculateMoveAngle(posX, posY)
	local newRotaX, newRotaY, newRotaZ = HouseSceneUtil.getUnitAngleByPos(angle, posX, posY, posZ, pos.x, pos.y, pos.z)

	Astral.TransformUtil.SetLocalRotation(self._unit.go.transform, newRotaX, newRotaY, newRotaZ)
end

function M:getCurrAngle()
	local posX, posY, posZ = self._unit.navMesh:getNavMeshGoPos()
	local angle = self:_calculateMoveAngle(posX, posY)

	return MathUtil.normalizeAngle(angle)
end

function M:setModifyDestination(modify)
	self._needModifyDestination = modify
end

function M:isArrivedDestination()
	return self._isArrivedDestination
end

function M:initStatus()
	self._unit:addInnerEventListener(UnitActionType.NavMeshAreaChange, self._initStatus, self)
end

function M:_initStatus()
	self._unit:removeInnerEventListener(UnitActionType.NavMeshAreaChange, self._initStatus, self)
	self:setDirection(UnitDirection.Forward)
end

function M:setRotationTarget(rotationTargetGO)
	self._rotationTargetGO = rotationTargetGO
end

function M:update()
	local posX, posY, posZ = self._unit.navMesh:getNavMeshGoPos()
	local deltaPos = Vector3.New(posX - self._lastPos.x, posY - self._lastPos.y, posZ - self._lastPos.z)

	self._lastPos:Set(posX, posY, posZ)
	self:_moveFrame()
	self:_rotationFrame(posX, posY, posZ, deltaPos)
end

function M:resetIdleCount()
	self._idleCount = 0
	self._isArrivedDestination = false
end

function M:clearFrameData()
	self._cacheDeltaForRota:clear()
	self._sumDeltaForRota:Set(0, 0, 0)
	self._cacheDeltaForMove:clear()
	self._sumDeltaForMove:Set(0, 0, 0)
	self._cacheMoveSpeed:clear()

	self._sumMoveSpeed = 0
end

function M:_moveFrame()
	if not self:_isMovable() then
		return
	end

	local distance = self._unit.navMesh:getRemainingDistance()

	if distance and distance <= 0.04 then
		self:_arriveDestination()
	else
		self:_moving()
	end

	self:_moveSlowlyCount()
	self:_adjustRadius()
end

function M:_isMovable()
	if not self._unit.navMesh:getIsEnable() then
		return false
	end

	if self._unit.gravity and self._unit.gravity:isWeightless() == true then
		return false
	end

	if self._unit.model and self._unit.model:judgeStatus(PlayerStatus.Draging) then
		return false
	end

	if self._unit.navMesh:getIsManualWalk() then
		return false
	end

	return true
end

function M:_moveSlowlyCount()
	if not self._isArrivedDestination then
		local velocity = self._unit.navMesh:getAgentVelocity()
		local moveSpeed = velocity:Magnitude()

		if self:_isMovingSlowly(moveSpeed) then
			self._slowlyCount = self._slowlyCount + 1
		else
			self._slowlyCount = self._slowlyCount - 1
		end

		self._slowlyCount = self._slowlyCount < 0 and 0 or self._slowlyCount
	end
end

function M:_isMovingSlowly(moveSpeed)
	return moveSpeed <= self._unit.navMesh:getAgentSpeed() * HouseEnum.SLOWLY_SPEED_RATE
end

function M:_adjustRadius()
	local radius = self._unit.navMesh:getRadius()

	radius = self._slowlyCount == 0 and radius or radius / self._slowlyCount

	self._unit.navMesh:setAgentRadius(radius)
end

function M:_arriveDestination()
	if self._slowlyCount >= 1 then
		self._slowlyCount = 0
		self._isArrivedDestination = true

		self._unit.meshModel:play(self._animNameIdle, true)
		self._unit.navMesh:stopNavMesh()
	end
end

function M:_moving()
	self._isArrivedDestination = false

	self._unit.navMesh:resumeNavMesh()
	self._unit.meshModel:play(self._animNameWalk, true)
end

function M:_rotationFrame(posX, posY, posZ, deltaPos)
	if self._stopAngle then
		return
	end

	if self._unit.navMesh:getIsManualWalk() then
		return
	end

	local angle = self:_calculateMoveAngle(posX, posY)

	if self._unit.navMesh:getIsEnable() then
		if self._unit.navMesh:getIsStopped() then
			self:_trySetForwardDirection(angle)
			self._cacheDeltaForRota:clear()
			self._sumDeltaForRota:Set(0, 0, 0)
		else
			local speed = self._unit.navMesh:getAgentSpeed()
			local velocity = self._unit.navMesh:getAgentVelocity()

			if velocity:Magnitude() > 1e-06 and deltaPos:Magnitude() < speed / 4 then
				self._cacheDeltaForRota:push(deltaPos)
				self._sumDeltaForRota:Add(deltaPos)

				if self._cacheDeltaForRota.length > 4 then
					local v = self._cacheDeltaForRota:shift()

					self._sumDeltaForRota:Sub(v)

					if self._sumDeltaForRota:Magnitude() >= speed / UnityEngine.Application.targetFrameRate * 2 then
						self:_rotaByVelocity(self._sumDeltaForRota, angle, posX, posY, posZ)
					end
				elseif deltaPos:Magnitude() >= speed / UnityEngine.Application.targetFrameRate * 0.9 then
					self:_rotaByVelocity(deltaPos, angle, posX, posY, posZ)
				end
			else
				self:_trySetForwardDirection(angle)
				self._cacheDeltaForRota:clear()
				self._sumDeltaForRota:Set(0, 0, 0)
			end
		end
	else
		self:_trySetForwardDirection(angle)
		self._cacheDeltaForRota:clear()
		self._sumDeltaForRota:Set(0, 0, 0)
	end
end

function M:_rotaByVelocity(velocity, angle, posX, posY, posZ)
	local newRotaX, newRotaY, newRotaZ

	if self._rotationTargetGO then
		local targetPosX, targetPosY, targetPosZ = Astral.TransformUtil.GetPos(self._rotationTargetGO.transform, 0, 0, 0)

		newRotaX, newRotaY, newRotaZ = HouseSceneUtil.getUnitAngleByPos(angle, posX, posY, posZ, targetPosX, targetPosY, targetPosZ)
	else
		newRotaX, newRotaY, newRotaZ = HouseSceneUtil.getUnitAngleByPos(angle, posX, posY, posZ, posX + velocity.x, posY + velocity.y, posZ + velocity.z)
	end

	Astral.TransformUtil.SetLocalRotation(self._unit.go.transform, newRotaX, newRotaY, newRotaZ)
end

function M:_trySetForwardDirection(angle)
	local rotaX, rotaY, rotaZ = Astral.TransformUtil.GetLocalRotation(self._unit.go.transform, 0, 0, 0)
	local offset, newRotaX, newRotaY, newRotaZ = HouseSceneUtil.getUnitAngleOffset(angle, rotaX, rotaY, rotaZ)

	if offset >= 1 then
		Astral.TransformUtil.SetLocalRotation(self._unit.go.transform, newRotaX, newRotaY, newRotaZ)
	end
end

function M:_calculateMoveAngle(posX, posY)
	return NavMeshUtil.calculateMoveAngle(posX, posY, self._unit.navMesh:getCurAreaType(), self._unit.navMesh:getCurZoneId())
end

return M
