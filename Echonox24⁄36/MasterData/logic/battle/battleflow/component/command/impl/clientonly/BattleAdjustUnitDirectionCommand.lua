-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/clientonly/BattleAdjustUnitDirectionCommand.lua

module("logic.battle.battleflow.component.command.impl.clientonly.BattleAdjustUnitDirectionCommand", package.seeall)

local BattleAdjustUnitDirectionCommand = class("BattleAdjustUnitDirectionCommand", BattleCommandBase)

function BattleAdjustUnitDirectionCommand:parseServerCommand(cmdParser, turnNOList)
	if not turnNOList or #turnNOList < 0 then
		return
	end

	local cmd = BattleAdjustUnitDirectionCommand:createInstance()

	cmd:setTurnNOList(turnNOList)
	cmdParser:addCommand(cmd)
end

function BattleAdjustUnitDirectionCommand:onInit()
	self._entityIdList = {}
	self._lookAtDirectionList = {}
end

function BattleAdjustUnitDirectionCommand:onClear()
	BattleTableUtil.clearTable(self._entityIdList)
	BattleTableUtil.clearReusableTable(self._lookAtDirectionList)
end

function BattleAdjustUnitDirectionCommand:execute(battleFlow)
	local unitMgr = battleFlow.unitMgr
	local boardMgr = battleFlow.boardMgr

	for index, entityId in ipairs(self._entityIdList) do
		local unit = unitMgr:getUnit(entityId)

		if unit then
			local lookAtDirection = self._lookAtDirectionList[index]
			local x, z = lookAtDirection:getXZ()

			if not MeshModelDirection.isLockDirection(unit) then
				unit.meshModel:lookAtDir(x, 0, z)
			end
		end
	end

	self:finish(true)
end

function BattleAdjustUnitDirectionCommand:toString()
	return string.format("[adjust unit direction command entityIds = %s,directionList = %s]", BattleTableUtil.arrayToString(self._entityIdList), BattleTableUtil.arrayToString(self._lookAtDirectionList))
end

function BattleAdjustUnitDirectionCommand:setTurnNOList(turnNOList)
	for _, turnNO in ipairs(turnNOList) do
		local lookAt = turnNO.lookAt

		table.insert(self._entityIdList, turnNO.entity)
		table.insert(self._lookAtDirectionList, Coordinates:createInstance(lookAt.x, lookAt.z))
	end

	return self
end

return BattleAdjustUnitDirectionCommand
