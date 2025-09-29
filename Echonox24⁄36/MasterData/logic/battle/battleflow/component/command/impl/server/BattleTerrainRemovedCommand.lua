-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/server/BattleTerrainRemovedCommand.lua

module("logic.battle.battleflow.component.command.impl.server.BattleTerrainRemovedCommand", package.seeall)

local BattleTerrainRemovedCommand = class("BattleTerrainRemovedCommand", BattleCommandBase)

function BattleTerrainRemovedCommand:parseServerCommand(cmdParser, cellNOList)
	local cmd = BattleTerrainRemovedCommand:createInstance()

	cmd:addFromCellNOList(cellNOList)
	cmdParser:addCommand(cmd)
end

function BattleTerrainRemovedCommand:onInit()
	self._cellInfoList = {}
end

function BattleTerrainRemovedCommand:onClear()
	BattleTableUtil.clearReusableTable(self._cellInfoList)
end

function BattleTerrainRemovedCommand:execute(battleFlow, runningContext)
	local additionalTerrainMgr = battleFlow.additionalTerrainMgr

	additionalTerrainMgr:removeTerrainUnits(self._cellInfoList)
	BattleDispatcher:dispatchEvent(BattleEventType.OnTerrainRemove)
	self:finish(true)
end

function BattleTerrainRemovedCommand:toString()
	return string.format("[terrain removed command, cellInfoList = %s]", BattleTableUtil.arrayToString(self._cellInfoList))
end

function BattleTerrainRemovedCommand:addFromCellNOList(cellNOList)
	for _, cellNO in ipairs(cellNOList) do
		local cellIndex = BoardIndexConverter.cellNOToUnionIndex(cellNO)
		local cellInfo = BattleCellInfo:createInstance(cellIndex)
		local additionalTerrainNOList = cellNO.additionalTerrains

		for _, additionalTerrainNO in ipairs(additionalTerrainNOList) do
			cellInfo:setFromAdditionalTerrainNO(additionalTerrainNO)
		end

		table.insert(self._cellInfoList, cellInfo)
	end

	return self
end

return BattleTerrainRemovedCommand
