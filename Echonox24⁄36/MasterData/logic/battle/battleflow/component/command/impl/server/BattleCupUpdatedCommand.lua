-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/server/BattleCupUpdatedCommand.lua

module("logic.battle.battleflow.component.command.impl.server.BattleCupUpdatedCommand", package.seeall)

local BattleCupUpdatedCommand = class("BattleCupUpdatedCommand", BattleCommandBase)

function BattleCupUpdatedCommand:parseServerCommand(cmdParser, cupNO)
	local cmd = BattleCupUpdatedCommand:createInstance()

	cmd:setCupNO(cupNO)
	cmdParser:addCommand(cmd)
end

function BattleCupUpdatedCommand:onInit()
	self._clientMsg = {}
end

function BattleCupUpdatedCommand:onClear()
	BattleTableUtil.clearTable(self._clientMsg)
end

function BattleCupUpdatedCommand:execute(battleFlow)
	MonumentAgent.instance:handleFinishPush(0, self._clientMsg)
	self:finish(true)
end

function BattleCupUpdatedCommand:toString()
	return "[cup updated command]"
end

function BattleCupUpdatedCommand:setCupNO(cupNO)
	self._clientMsg.cup = cupNO

	return self
end

return BattleCupUpdatedCommand
