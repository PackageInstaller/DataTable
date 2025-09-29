-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/defaultwork/WorkBattleExitCurrentScene.lua

module("logic.battle.battleflow.defaultwork.WorkBattleExitCurrentScene", package.seeall)

local M = class("WorkBattleExitCurrentScene", WorkBase)

function M:onEnter(context)
	SceneFace.instance:exitScene()
	self:onDone(WorkResult.Succeed)
end

function M:onExit(isInterrupt)
	return
end

return M
