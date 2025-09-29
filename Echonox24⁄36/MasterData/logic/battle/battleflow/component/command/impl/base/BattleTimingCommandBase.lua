-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/base/BattleTimingCommandBase.lua

module("logic.battle.battleflow.component.command.impl.base.BattleTimingCommandBase", package.seeall)

local BattleTimingCommandBase = class("BattleTimingCommandBase", BattleCommandBase)

function BattleTimingCommandBase:ctor()
	self._internalTimeWaiter = TimeWaiter.New()

	BattleTimingCommandBase.super.ctor(self)
end

function BattleTimingCommandBase:clear(interrupt)
	self._internalTimeWaiter:clear()
	BattleTimingCommandBase.super.clear(self, interrupt)
end

function BattleTimingCommandBase:startTimer(duration)
	self._internalTimeWaiter:setTimeScale(BattleTime.timeScale)
	self._internalTimeWaiter:start(duration or 0, self._internalOnTimerDone, self)
end

function BattleTimingCommandBase:_internalOnTimerDone()
	self:finish(true)
end

return BattleTimingCommandBase
