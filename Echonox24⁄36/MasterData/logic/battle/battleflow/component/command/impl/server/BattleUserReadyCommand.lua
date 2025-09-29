-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/server/BattleUserReadyCommand.lua

module("logic.battle.battleflow.component.command.impl.server.BattleUserReadyCommand", package.seeall)

local BattleUserReadyCommand = class("BattleUserReadyCommand", BattleCommandBase)

function BattleUserReadyCommand:parseServerCommand(cmdParser, eventFieldInt32)
	local cmd = BattleUserReadyCommand:createInstance()

	cmd:setCampId(eventFieldInt32)
	cmdParser:addCommand(cmd)
end

function BattleUserReadyCommand:onInit()
	self._campId = 0
end

function BattleUserReadyCommand:onClear()
	self._campId = 0
end

function BattleUserReadyCommand:execute(battleFlow, runningContext)
	local model = battleFlow.model
	local campInfo = model:getCampInfo(self._campId)

	BattleDispatcher:dispatchEvent(BattleEventType.ON_RECEIVE_USER_READY, campInfo.userId)
	self:finish(true)
end

function BattleUserReadyCommand:toString()
	return string.format("[user ready command campId = %s]", self._campId)
end

function BattleUserReadyCommand:setCampId(campId)
	self._campId = campId

	return self
end

return BattleUserReadyCommand
