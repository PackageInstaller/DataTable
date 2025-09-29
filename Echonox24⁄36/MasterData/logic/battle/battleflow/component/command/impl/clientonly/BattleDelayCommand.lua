-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/clientonly/BattleDelayCommand.lua

module("logic.battle.battleflow.component.command.impl.clientonly.BattleDelayCommand", package.seeall)

local BattleDelayCommand = class("BattleDelayCommand", BattleCommandBase)

function BattleDelayCommand:create(delay)
	local cmd = BattleDelayCommand:createInstance()

	cmd:setDelay(delay)

	return cmd
end

function BattleDelayCommand:onInit()
	self._timeWaiter = TimeWaiter.New()
	self._delay = false
end

function BattleDelayCommand:onClear(interrupt)
	self._timeWaiter:clear()

	self._delay = false
end

function BattleDelayCommand:execute(battleFlow)
	if self._delay then
		self._timeWaiter:setTimeScale(BattleTime.timeScale)
		self._timeWaiter:start(self._delay, self._onTimerDone, self)
	else
		self:_onTimerDone()
	end
end

function BattleDelayCommand:_onTimerDone()
	self:finish(true)
end

function BattleDelayCommand:toString()
	return string.format("[delay command delay = %s]", tostring(self._delay))
end

function BattleDelayCommand:setDelay(delay)
	self._delay = delay
end

return BattleDelayCommand
