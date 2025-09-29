-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/clientonly/EmptyCommand.lua

module("logic.battle.battleflow.component.command.impl.clientonly.EmptyCommand", package.seeall)

local EmptyCommand = class("EmptyCommand", BattleCommandBase)

function EmptyCommand:parseServerCommand(cmdParser, buffTriggeredEventNO)
	local cmd = EmptyCommand:createInstance()

	cmdParser:addCommand(cmd)
end

function EmptyCommand:onInit()
	return
end

function EmptyCommand:onClear()
	return
end

function EmptyCommand:execute(battleFlow)
	self:finish(true)
end

function EmptyCommand:toString()
	return "EmptyCommand Execute"
end

return EmptyCommand
