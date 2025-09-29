-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/server/BattleAiModeChangeCommand.lua

module("logic.battle.battleflow.component.command.impl.server.BattleAiModeChangeCommand", package.seeall)

local BattleAiModeChangeCommand = class("BattleAiModeChangeCommand", BattleCommandBase)

function BattleAiModeChangeCommand:parseServerCommand(cmdParser, aiModeChangeNO)
	local cmd = BattleAiModeChangeCommand:createInstance()

	cmd:_setAiMode(aiModeChangeNO.aiMode)
	cmdParser:addCommand(cmd)
end

function BattleAiModeChangeCommand:onInit()
	return
end

function BattleAiModeChangeCommand:onClear(interrupt)
	return
end

function BattleAiModeChangeCommand:execute(battleFlow, runningContext)
	battleFlow.model:setAiMode(self._aiMode)

	local isAuto = self._aiMode == BattleExtension_pb.AiMode.USER_RECORD or self._aiMode == BattleExtension_pb.AiMode.BEHAVIOR_TREE

	battleFlow.settingModel:setAutoBattle(isAuto)
	self:finish(true)
end

function BattleAiModeChangeCommand:toString()
	return string.format("[ai mode change command %s]", tostring(self._aiMode))
end

function BattleAiModeChangeCommand:_setAiMode(aiMode)
	self._aiMode = aiMode
end

return BattleAiModeChangeCommand
