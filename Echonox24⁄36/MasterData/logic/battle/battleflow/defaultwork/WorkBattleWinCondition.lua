-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/defaultwork/WorkBattleWinCondition.lua

module("logic.battle.battleflow.defaultwork.WorkBattleWinCondition", package.seeall)

local M = class("WorkBattleWinCondition", WorkBase)

function M:ctor()
	M.super.ctor(self)

	self._timeWaiter = TimeWaiter.New()
end

function M:onEnter(context)
	if not OOPUtil.isInstanceOf(context, LevelBattleFlowBase) then
		self:_onConditionNotifyFinish()

		return
	end

	ViewMgr.instance:open(ViewName.BattleConditions)
	self._timeWaiter:start(BattleConst.DelayThree, self._onConditionNotifyFinish, self)
end

function M:onExit(isInterrupt)
	self._timeWaiter:clear()
	ViewMgr.instance:close(ViewName.BattleConditions)
end

function M:_onConditionNotifyFinish()
	self:onDone(WorkResult.Succeed)
end

return M
