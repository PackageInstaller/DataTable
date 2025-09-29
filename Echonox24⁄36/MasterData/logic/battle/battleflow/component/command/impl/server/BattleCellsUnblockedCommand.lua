-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/server/BattleCellsUnblockedCommand.lua

module("logic.battle.battleflow.component.command.impl.server.BattleCellsUnblockedCommand", package.seeall)

local BattleCellsUnblockedCommand = class("BattleCellsUnblockedCommand", BattleCommandBase)

function BattleCellsUnblockedCommand:parseServerCommand(cmdParser, cellsUnblockedEventNO)
	local cmd = BattleCellsUnblockedCommand:createInstance()

	cmd:setEntityId(cellsUnblockedEventNO.entity)
	cmd:setSkillCode(cellsUnblockedEventNO.skill)
	cmd:setCoordinatesList(cellsUnblockedEventNO.cells)
	cmdParser:addCommand(cmd)
end

function BattleCellsUnblockedCommand:onInit()
	self._entityId = 0
	self._skillCode = 0
	self._unionIndexList = {}
end

function BattleCellsUnblockedCommand:onClear()
	self._entityId = 0
	self._skillCode = 0

	BattleTableUtil.clearTable(self._unionIndexList)
end

function BattleCellsUnblockedCommand:execute(battleFlow)
	local boardModel = battleFlow.boardModel
	local unionIndexList = self._unionIndexList
	local cellStateMO = CheckerBoardCellStateMO:createInstance()

	for _, unionIndex in ipairs(unionIndexList) do
		local cellMO = boardModel:getBoardCellMO(unionIndex)

		cellStateMO:setEntityId(self._entityId)
		cellStateMO:setSkillCode(self._skillCode)
		cellStateMO:setState(BattleEnum.CellState.BLOCKED)
		cellMO:removeStateMO(cellStateMO)
	end

	cellStateMO:returnSelf()
	self:finish(true)
end

function BattleCellsUnblockedCommand:toString()
	return string.format("[cells unblocked command entityId = %s,skillCode = %s,unionIndexList = %s]", self._entityId, self._skillCode, BattleTableUtil.arrayToString(self._unionIndexList))
end

function BattleCellsUnblockedCommand:setEntityId(entityId)
	self._entityId = entityId

	return self
end

function BattleCellsUnblockedCommand:setSkillCode(skillCode)
	self._skillCode = skillCode

	return self
end

function BattleCellsUnblockedCommand:setCoordinatesList(coordinatesList)
	for _, coordinates in ipairs(coordinatesList) do
		table.insert(self._unionIndexList, BoardIndexConverter.coordinatesToUnionIndex(coordinates.x, coordinates.z))
	end

	return self
end

return BattleCellsUnblockedCommand
