-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/server/BattleTacitTaskProgressCommand.lua

module("logic.battle.battleflow.component.command.impl.server.BattleTacitTaskProgressCommand", package.seeall)

local BattleTacitTaskProgressCommand = class("BattleTacitTaskProgressCommand", BattleCommandBase)

function BattleTacitTaskProgressCommand:parseServerCommand(cmdParser, tacitNO)
	local cmd = BattleTacitTaskProgressCommand:createInstance()

	cmd:setTacitNO(tacitNO)
	cmdParser:addCommand(cmd)
end

function BattleTacitTaskProgressCommand:onInit()
	self._tacitTaskData = false
end

function BattleTacitTaskProgressCommand:onClear()
	self._tacitTaskData = false
end

function BattleTacitTaskProgressCommand:execute(battleFlow)
	TacitModel.instance:updateStageTips(self._tacitTaskData.taskId, self._tacitTaskData.progress)
	self:finish(true)
end

function BattleTacitTaskProgressCommand:toString()
	return "<color=green>[tacit task updated command]</color>"
end

function BattleTacitTaskProgressCommand:setTacitNO(tacitNO)
	self._tacitTaskData = tacitNO

	return self
end

return BattleTacitTaskProgressCommand
