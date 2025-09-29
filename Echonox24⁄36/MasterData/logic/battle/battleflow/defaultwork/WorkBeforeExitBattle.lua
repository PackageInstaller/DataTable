-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/defaultwork/WorkBeforeExitBattle.lua

module("logic.battle.battleflow.defaultwork.WorkBeforeExitBattle", package.seeall)

local M = class("WorkBeforeExitBattle", WorkBase)

function M:onEnter(context, isShowBlack)
	LoadingFacade.instance:showLoading(isShowBlack)
	context:internal_BeforeExit()
	self:onDone(WorkResult.Succeed)
	BattleDispatcher:dispatchEvent(BattleEventType.OnBeforeExitBattle, 1, false)
end

function M:onExit(isInterrupt)
	return
end

return M
