-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/unit/component/model/UnitCompPlayerModel.lua

module("logic.scene.unit.component.model.UnitCompPlayerModel", package.seeall)

local M = class("UnitCompPlayerModel", UnitComponentBase)
local PlayerStatus = HouseEnum.PlayerStatus
local BehaviorStatus = HouseEnum.BehaviorStatus
local ElevatorHeroStatus = SceneEnum.ElevatorHeroStatus

function M:ctor(unit)
	M.super.ctor(self, unit)

	self._elevatorCurrentLevelId = 0
	self._elevatorTowardLevel = 0
	self._elevatorLobbyId = 0
	self._elevatorStatus = ElevatorHeroStatus.None
	self._status = nil
	self._behaviorStatus = nil
	self._occupyRoomId = nil
	self._isReadyFurniturePerform = false
end

function M:onInit()
	self:clear()
end

function M:onReuse()
	return
end

function M:onReset()
	self:clear()
end

function M:clear()
	self:clearElevator()

	self._status = PlayerStatus.None
	self._behaviorStatus = BehaviorStatus.None
	self._occupyRoomId = nil
	self._isReadyFurniturePerform = false
end

function M:onDestroy()
	self:clear()
end

function M:setLevelIdAndRingType(currentId, ringType)
	self._elevatorCurrentLevelId = currentId

	local elevatorLevelCo = HouseConfig.instance:getElevatorCoById(self._elevatorCurrentLevelId)

	self._elevatorLobbyId = elevatorLevelCo.levelId[1]
	self._elevatorTowardLevel = ringType
end

function M:getCurrentLevelId()
	return self._elevatorCurrentLevelId
end

function M:getTowardLevel()
	return self._elevatorTowardLevel
end

function M:getLobbyId()
	return self._elevatorLobbyId
end

function M:setElevatorStatus(status)
	self._elevatorStatus = status
end

function M:getElevatorStatus()
	return self._elevatorStatus
end

function M:getTowardDirection()
	local currentLevelCo = HouseConfig.instance:getElevatorCoById(self._elevatorCurrentLevelId)

	if currentLevelCo.ringType < self._elevatorTowardLevel then
		return SceneEnum.ElevatorMoveStatus.Down
	elseif currentLevelCo.ringType > self._elevatorTowardLevel then
		return SceneEnum.ElevatorMoveStatus.Up
	end

	printWarn("电梯数据错误，目标层和所在层一样")
end

function M:clearElevator()
	self._elevatorCurrentLevelId = 0
	self._elevatorTowardLevel = 0
	self._elevatorLobbyId = 0
	self._elevatorStatus = ElevatorHeroStatus.None
end

function M:setStatus(status)
	self._status = status
end

function M:clearStatus(status)
	if self._status == status then
		self._status = PlayerStatus.None
	end
end

function M:judgeStatus(targetStatus)
	return self._status == targetStatus
end

function M:setBehaviorStatus(status)
	self._behaviorStatus = status
end

function M:clearBehaviorStatus(status)
	if self._behaviorStatus == status then
		self._behaviorStatus = BehaviorStatus.None
	end
end

function M:judgeBehaviorStatus(targetStatus)
	return self._behaviorStatus == targetStatus
end

function M:setOccupyRoom(roomId)
	self._occupyRoomId = roomId
end

function M:getOccupyRoom()
	return self._occupyRoomId
end

function M:setReadyFurniturePerform(isReady)
	self._isReadyFurniturePerform = isReady
end

function M:isReadyFurniturePerform()
	return self._isReadyFurniturePerform
end

return M
