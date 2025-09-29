-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/unit/elevator/impl/ElevatorLobby.lua

module("logic.scene.unit.elevator.impl.ElevatorLobby", package.seeall)

local M = class("ElevatorLobby", UnitBase)

function M:setConfig(co)
	self._co = co
end

function M:getConfig()
	return self._co
end

function M:getElevatorId()
	return self._co.id
end

function M:getlevelList()
	return self._co.levelId
end

function M:getLevelNum()
	return 0
end

function M:getTag()
	return UnitTag.ElevatorNpc
end

function M:isLevelLegal(level)
	if level > 0 then
		local list = self:getlevelList()
		local id = list[level]

		if checknumber(id) > 0 then
			return true
		end
	end

	return false
end

function M:getTopLevelUnit()
	local list = self:getlevelList()

	for i = 1, #list do
		local id = list[i]

		if id > 0 then
			return HouseSceneUtil.getElevatorUnit(id)
		end
	end
end

function M:getBottomLevelUnit()
	local list = self:getlevelList()

	for i = #list, 1, -1 do
		local id = list[i]

		if id > 0 then
			return HouseSceneUtil.getElevatorUnit(id)
		end
	end
end

function M:getElevatorLevels()
	local units = {}

	for _, id in ipairs(self:getlevelList()) do
		if id > 0 then
			table.insert(units, HouseSceneUtil.getElevatorUnit(id))
		end
	end

	return units
end

function M:getElevatorLevelById(id)
	if table.indexof(self:getlevelList(), id) then
		return HouseSceneUtil.getElevatorUnit(id)
	end
end

function M:getElevatorLevelByLevel(level)
	local list = self:getlevelList()
	local id = list[level]

	return HouseSceneUtil.getElevatorUnit(checknumber(id))
end

function M:isMainPlayerIn()
	return self:_judgeMainPlayerStatus(SceneEnum.ElevatorHeroStatus.InEleavtor)
end

function M:isMainPlayerMoveIn()
	return self:_judgeMainPlayerStatus(SceneEnum.ElevatorHeroStatus.MoveInEleavtor)
end

function M:isMainPlayerMoveOut()
	return self:_judgeMainPlayerStatus(SceneEnum.ElevatorHeroStatus.MoveOutEleavtor)
end

function M:_judgeMainPlayerStatus(targetStatus)
	local mainPlayer = HouseSceneUtil.getMainPlayer()

	if mainPlayer then
		local levelId, moveDir = mainPlayer.controller:getElevatorTarget()
		local status = mainPlayer.controller:getElevatorStatus()

		if levelId > 0 then
			local levelCO = HouseConfig.instance:getElevatorCoById(levelId)

			if levelCO.levelId[1] == self:getElevatorId() and status == targetStatus then
				return true
			end
		end
	end

	return false
end

function M:clear()
	local len = #self._compList

	for i = 1, len do
		self._compList[i]:clear()
	end

	self._co = nil
end

function M:_initComponents()
	self:_addComponent("mover", ElevatorCompMover)
	self:_addComponent("posMgr", ElevatorPosMgr)
	self:_addComponent("ctrl", ElevatorCompCtrl)
end

function M:Update()
	self.mover:update()
end

return M
