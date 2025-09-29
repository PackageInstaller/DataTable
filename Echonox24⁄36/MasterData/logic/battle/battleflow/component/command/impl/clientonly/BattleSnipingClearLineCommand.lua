-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/clientonly/BattleSnipingClearLineCommand.lua

module("logic.battle.battleflow.component.command.impl.clientonly.BattleSnipingClearLineCommand", package.seeall)

local BattleSnipingClearLineCommand = class("BattleSnipingClearLineCommand", BattleCommandBase)

function BattleSnipingClearLineCommand:create(attackerEntityId, victimEntityId)
	local cmd = BattleSnipingClearLineCommand:createInstance()

	return cmd
end

function BattleSnipingClearLineCommand:onInit()
	return
end

function BattleSnipingClearLineCommand:onClear()
	return
end

function BattleSnipingClearLineCommand:execute(battleFlow, runningContext)
	local snipingLine = runningContext:getParam(BattleCmdRunningContext.SnipingLine)

	if snipingLine then
		snipingLine:returnSelf()
		runningContext:clearParam(BattleCmdRunningContext.SnipingLine)
	end

	self:finish(true)
end

function BattleSnipingClearLineCommand:toString()
	return "[sniping clear line command]"
end

return BattleSnipingClearLineCommand
