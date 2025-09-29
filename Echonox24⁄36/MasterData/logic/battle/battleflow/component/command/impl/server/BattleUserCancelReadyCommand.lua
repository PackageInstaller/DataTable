-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/server/BattleUserCancelReadyCommand.lua

module("logic.battle.battleflow.component.command.impl.server.BattleUserCancelReadyCommand", package.seeall)

local BattleUserCancelReadyCommand = class("BattleUserCancelReadyCommand", BattleCommandBase)

function BattleUserCancelReadyCommand:parseServerCommand(cmdParser, eventFieldInt32)
	local cmd = BattleUserCancelReadyCommand:createInstance()

	cmd:setCampId(eventFieldInt32)
	cmdParser:addCommand(cmd)
end

function BattleUserCancelReadyCommand:onInit()
	self._campId = 0
end

function BattleUserCancelReadyCommand:onClear()
	self._campId = 0
end

function BattleUserCancelReadyCommand:execute(battleFlow, runningContext)
	local model = battleFlow.model
	local campInfo = model:getCampInfo(self._campId)

	BattleDispatcher:dispatchEvent(BattleEventType.ON_RECEIVE_USER_CANCEL_READY, campInfo.userId)
	self:finish(true)
end

function BattleUserCancelReadyCommand:toString()
	return string.format("[user cancel ready command campId = %s]", self._campId)
end

function BattleUserCancelReadyCommand:setCampId(campId)
	self._campId = campId

	return self
end

return BattleUserCancelReadyCommand
