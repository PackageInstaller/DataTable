-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/clientonly/BattleCameraLockStatusCommand.lua

module("logic.battle.battleflow.component.command.impl.clientonly.BattleCameraLockStatusCommand", package.seeall)

local M = class("BattleCameraLockStatusCommand", BattleCommandBase)

function M:create(status)
	local cmd = M:createInstance()

	cmd:setStatus(status)

	return cmd
end

function M:onInit()
	self._status = false
end

function M:onClear()
	self._status = false
end

function M:execute(battleFlow, runningContext)
	runningContext:setParam(BattleCmdRunningContext.Param_CameraLocked, self._status)
	self:finish(true)
end

function M:toString()
	return string.format("[BattleCameraLockStatusCommand status = %s]", self._status)
end

function M:setStatus(status)
	self._status = status

	return self
end

return M
