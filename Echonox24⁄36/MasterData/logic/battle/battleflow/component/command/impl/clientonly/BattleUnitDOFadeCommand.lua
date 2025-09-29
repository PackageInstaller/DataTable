-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/clientonly/BattleUnitDOFadeCommand.lua

module("logic.battle.battleflow.component.command.impl.clientonly.BattleUnitDOFadeCommand", package.seeall)

local BattleUnitDOFadeCommand = class("BattleUnitDOFadeCommand", BattleCommandBase)

function BattleUnitDOFadeCommand:createAndExecuteCommand(fadeUnitList, isFade)
	return
end

function BattleUnitDOFadeCommand:onInit()
	self._fadeUnitList = {}
	self._timelineTask = false
	self._isFade = false
end

function BattleUnitDOFadeCommand:onClear()
	if self._timelineTask then
		self._timelineTask:clear()
	end

	self._isFade = false

	BattleTableUtil.clearTable(self._fadeUnitList)
end

function BattleUnitDOFadeCommand:execute(battleFlow, runningContext)
	self._timelineTask = self._timelineTask or TimelineTask.New()

	self._timelineTask:clear()
	self._timelineTask:addTask(0, self._doUnitFade, self)
	self._timelineTask:addTask(0.51)
	self._timelineTask:setTimeScale(BattleTime.timeScale)
	self._timelineTask:addFinishListener(self._onFadeFinish, self)
	self._timelineTask:start()
end

function BattleUnitDOFadeCommand:toString()
	return string.format("[unit do fade command isFade = %s]", self._isFade)
end

function BattleUnitDOFadeCommand:_doUnitFade()
	if self._fadeUnitList then
		for i, unit in pairs(self._fadeUnitList) do
			if not self._isFade then
				unit:setVisible(true)
			end

			unit:doFade(self._isFade)
		end
	end

	return self
end

function BattleUnitDOFadeCommand:_onFadeFinish()
	BattleGameObjectRootUtil.setVisibleForSoloPerformance(not self._isFade)

	if self._fadeUnitList and self._isFade then
		for i, unit in pairs(self._fadeUnitList) do
			unit:setVisible(false)
		end
	end

	if not self._isFade then
		for i, unit in pairs(self._fadeUnitList) do
			unit.material:setAlphaEnable(false)
		end
	end

	self:finish(true)

	return self
end

return BattleUnitDOFadeCommand
