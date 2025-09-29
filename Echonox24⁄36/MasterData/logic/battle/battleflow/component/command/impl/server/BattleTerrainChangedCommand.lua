-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/server/BattleTerrainChangedCommand.lua

module("logic.battle.battleflow.component.command.impl.server.BattleTerrainChangedCommand", package.seeall)

local BattleTerrainChangedCommand = class("BattleTerrainChangedCommand", BattleCommandBase)

function BattleTerrainChangedCommand:parseServerCommand(cmdParser, terrainChangeNO)
	BattleTerrainRemovedCommand:parseServerCommand(cmdParser, terrainChangeNO.removed)
	BattleTerrainAddedCommand:parseServerCommand(cmdParser, terrainChangeNO.added)
end

return BattleTerrainChangedCommand
