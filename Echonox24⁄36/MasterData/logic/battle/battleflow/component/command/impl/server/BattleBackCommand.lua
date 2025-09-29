-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/server/BattleBackCommand.lua

module("logic.battle.battleflow.component.command.impl.server.BattleBackCommand", package.seeall)

local BattleBackCommand = class("BattleBackCommand", BattleTimingCommandBase)

function BattleBackCommand:parseServerCommand(cmdParser, backEventNO)
	local cmd = BattleBackCommand:createInstance()

	cmd:setBackInfoNO(backEventNO)
	cmdParser:addCommand(cmd)
end

function BattleBackCommand:onInit()
	self._battleInfoNO = false
end

function BattleBackCommand:onClear()
	self._battleInfoNO = false
end

function BattleBackCommand:execute(battleFlow)
	local model = battleFlow.model

	if model:isRecord() then
		BattleDispatcher:dispatchEvent(BattleEventType.OnUndoBattlefieldUpdate, self._battleInfoNO)
	end

	self:finish(true)
end

function BattleBackCommand:toString()
	return "[back command]"
end

function BattleBackCommand:setBackInfoNO(battleInfoNO)
	self._battleInfoNO = battleInfoNO

	return self
end

return BattleBackCommand
