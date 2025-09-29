-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/gameplay/doomonly/BattleDoomForecastCommand.lua

module("logic.battle.battleflow.component.command.impl.gameplay.doomonly.BattleDoomForecastCommand", package.seeall)

local BattleDoomForecastCommand = class("BattleDoomForecastCommand", BattleCommandBase)

function BattleDoomForecastCommand:parseServerCommand(cmdParser, doomForecastNO)
	local cmd = BattleDoomForecastCommand:createInstance()

	cmd:setSelectedTargetIndex(doomForecastNO.collectorIndex + 1)
	cmd:setSelectedActionIndex(doomForecastNO.actionIndex + 1)
	cmd:setSelectedTargetEntityIds(doomForecastNO.targets)
	cmd:setSelectedEffectIndex(doomForecastNO.effectIndex + 1)
	cmd:setSelectedDoomActionIndex(doomForecastNO.randomActionIndex + 1)
	cmdParser:addCommand(cmd)
end

function BattleDoomForecastCommand:onInit()
	self._selectedTargetIndex = false
	self._selectedActionIndex = false
	self._selectedDoomActionIndex = false
	self._selectedEffectIndex = false
	self._selectedTargetEntityIds = {}
end

function BattleDoomForecastCommand:onClear()
	self._selectedTargetIndex = false
	self._selectedActionIndex = false
	self._selectedEffectIndex = false
	self._selectedDoomActionIndex = false

	BattleTableUtil.clearTable(self._selectedTargetEntityIds)
end

function BattleDoomForecastCommand:execute(battleFlow, runningContext)
	if not OOPUtil.isInstanceOf(battleFlow, DoomBattleFlow) then
		if BattleLog.enableError then
			BattleLog.error("BattleDoomForecastCommand::current battle flow is not DoomBattleFlow")
		end

		self:finish(true)

		return
	end

	battleFlow.doomLogic:setRandomInfo(self._selectedEffectIndex, self._selectedActionIndex, self._selectedTargetIndex, self._selectedDoomActionIndex, self._selectedTargetEntityIds)
	self:finish(true)
end

function BattleDoomForecastCommand:toString()
	return string.format("[battle doom forecast command selectedTargetIndex = %s,selectedActionIndex = %s,selectedEffectIndex = %s,_selectedDoomActionIndex = %s,selectedTargetEntityIds = %s]", tostring(self._selectedTargetIndex), tostring(self._selectedActionIndex), tostring(self._selectedEffectIndex), tostring(self._selectedDoomActionIndex), BattleTableUtil.arrayToString(self._selectedTargetEntityIds))
end

function BattleDoomForecastCommand:setSelectedTargetIndex(selectedTargetIndex)
	self._selectedTargetIndex = selectedTargetIndex

	return self
end

function BattleDoomForecastCommand:setSelectedActionIndex(selectedActionIndex)
	self._selectedActionIndex = selectedActionIndex

	return self
end

function BattleDoomForecastCommand:setSelectedTargetEntityIds(selectedTargetEntityIds)
	BattleTableUtil.insertto(self._selectedTargetEntityIds, selectedTargetEntityIds)

	return self
end

function BattleDoomForecastCommand:setSelectedEffectIndex(selectedEffectIndex)
	self._selectedEffectIndex = selectedEffectIndex

	return self
end

function BattleDoomForecastCommand:setSelectedDoomActionIndex(selectedDoomActionIndex)
	self._selectedDoomActionIndex = selectedDoomActionIndex

	return self
end

return BattleDoomForecastCommand
