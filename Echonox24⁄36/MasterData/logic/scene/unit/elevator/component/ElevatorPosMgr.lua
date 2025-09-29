-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/unit/elevator/component/ElevatorPosMgr.lua

module("logic.scene.unit.elevator.component.ElevatorPosMgr", package.seeall)

local M = class("ElevatorPosMgr", UnitComponentBase)
local kMaxPlayer = 2
local vec3Temp1 = Vector3.New()
local vec3Temp2 = Vector3.New()
local UnitDirection = HouseEnum.UnitDirection

function M:ctor(unit)
	M.super.ctor(self, unit)

	self._posGoList = {}
	self._mainPosGO = nil
	self._mainMovePosGO = nil
	self._rideUnitQueue = {}
end

function M:onInit()
	self:_initPos()
end

function M:clear()
	table.clear(self._posGoList)
	table.clear(self._rideUnitQueue)

	self._mainPosGO = nil
	self._mainMovePosGO = nil
end

function M:_initPos()
	for i = 1, kMaxPlayer do
		local go = goutil.findChild(self._unit.go, "point_" .. i)

		if go then
			self._posGoList[i] = go
		end
	end

	self._mainPosGO = goutil.findChild(self._unit.go, "point_" .. kMaxPlayer + 1)
	self._mainMovePosGO = goutil.findChild(self._mainPosGO, "pos")
end

function M:getMainPos()
	local posX, posY, posZ = Astral.TransformUtil.GetPos(self._mainPosGO.transform, 0, 0, 0)

	vec3Temp1:Set(posX, posY, posZ)

	return vec3Temp1
end

function M:getRidePosByUnit(unit)
	local idx = self:getRideQueueIdx(unit)

	if idx then
		local go = self._posGoList[idx]
		local seatPosX, seatPosY, seatPosZ = Astral.TransformUtil.GetPos(go.transform, 0, 0, 0)

		vec3Temp1:Set(seatPosX, seatPosY, seatPosZ)

		return vec3Temp1
	end
end

function M:addRideUnit(unit)
	if not self:getRideQueueIdx(unit) then
		for i = 1, kMaxPlayer do
			if self._rideUnitQueue[i] == nil then
				self._rideUnitQueue[i] = unit

				return true
			end
		end
	end

	return false
end

function M:removeRideUnit(unit)
	for i = 1, kMaxPlayer do
		if self._rideUnitQueue[i] == unit then
			self._rideUnitQueue[i] = nil

			break
		end
	end
end

function M:isRideQueueFull()
	for i = 1, kMaxPlayer do
		if self._rideUnitQueue[i] == nil then
			return false
		end
	end

	return true
end

function M:isRideQueueEmpty()
	for i = 1, kMaxPlayer do
		if self._rideUnitQueue[i] then
			return false
		end
	end

	return true
end

function M:getRideQueueIdx(unit)
	for i = 1, kMaxPlayer do
		if self._rideUnitQueue[i] == unit then
			return i
		end
	end
end

function M:getRideUnitsByTargetLevel(level)
	local units = {}

	for i, unit in pairs(self._rideUnitQueue) do
		if unit.model:getTowardLevel() == level then
			table.insert(units, unit)
		end
	end

	return units
end

function M:getRideHeroTargetLevels()
	local levels = {}

	for i, unit in pairs(self._rideUnitQueue) do
		table.insert(levels, unit.model:getTowardLevel())
	end

	return levels
end

function M:refreshRideUnitPos()
	for i, unit in pairs(self._rideUnitQueue) do
		unit.navMesh:setNavMeshAgentStatus(false)
		unit.navMeshMover:setStopChangeAngle(true)

		local go = self._posGoList[i]
		local posX, posY, posZ = Astral.TransformUtil.GetPos(go.transform, 0, 0, 0)

		unit.navMesh:setNavAgentPos(posX, posY, posZ)
		unit.navMeshMover:setDirection(UnitDirection.Forward)
		unit.followRobot:setPos(posX, posY, posZ + 0.5, 0, 0.5)

		local robot = unit.followRobot:getFollowUnit()

		if robot then
			robot.navMeshMover:setStopChangeAngle(true)
			robot.navMeshMover:setDirection(UnitDirection.Forward)
		end
	end

	self:_refreshMainPlayerPos()
end

function M:_refreshMainPlayerPos()
	local mainPlayer = HouseSceneUtil.getMainPlayer()

	if mainPlayer and self._unit:isMainPlayerIn() then
		mainPlayer.navMesh:setNavMeshAgentStatus(false)
		mainPlayer.navMeshMover:setStopChangeAngle(true)

		local posX, posY, posZ = Astral.TransformUtil.GetPos(self._mainMovePosGO.transform, 0, 0, 0)

		mainPlayer.navMesh:setNavAgentPos(posX, posY, posZ)
		mainPlayer.navMeshMover:setDirection(UnitDirection.Forward)
	end
end

function M:isAllRideUnitInEvlavtor()
	local inEleavtor = true

	for i, unit in pairs(self._rideUnitQueue) do
		local status = unit.model:getElevatorStatus()

		inEleavtor = inEleavtor and status == SceneEnum.ElevatorHeroStatus.InEleavtor
	end

	return inEleavtor
end

function M:isUnitNear(unit, distance)
	local elePosX, elePosY, elePosZ = Astral.TransformUtil.GetPos(self._mainPosGO.transform, 0, 0, 0)

	vec3Temp1:Set(elePosX, elePosY, elePosZ)

	local posX, posY, posZ = unit.navMesh:getNavMeshGoPos()

	vec3Temp2:Set(posX, posY, posZ)

	return distance > Vector3.Distance(vec3Temp1, vec3Temp2)
end

return M
