-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/server/BattleLightColumnUpdateCommand.lua

module("logic.battle.battleflow.component.command.impl.server.BattleLightColumnUpdateCommand", package.seeall)

local BattleLightColumnUpdateCommand = class("BattleLightColumnUpdateCommand", BattleCommandBase)

function BattleLightColumnUpdateCommand:parseServerCommand(cmdParser, lightColumn)
	local cmd = BattleLightColumnUpdateCommand:createInstance()

	cmd:setEntityId(lightColumn.column)
	cmd:setEffectId(lightColumn.lightRes)
	cmdParser:addCommand(cmd)
end

function BattleLightColumnUpdateCommand:onInit()
	self._entityId = false
	self._effectId = false
end

function BattleLightColumnUpdateCommand:onClear(interrupt)
	self._entityId = false
	self._effectId = false

	if self._timelineTask then
		self._timelineTask:clear()
	end
end

function BattleLightColumnUpdateCommand:execute(battleFlow, runningContext)
	local cmd = BattleAdjustFollowCenterCommand:create(0, self._entityId)

	cmd:execute(battleFlow, runningContext)

	local duaration = runningContext:getParam(BattleCmdRunningContext.Param_AdjustFollowCenterTime)

	self._timelineTask = self._timelineTask or TimelineTask.New()

	self._timelineTask:clear()
	self._timelineTask:addTask(duaration, self._playEffect, self)
	self._timelineTask:addTask(1)
	self._timelineTask:addFinishListener(self._onTimelineFinished, self)
	self._timelineTask:start(battleFlow)
end

function BattleLightColumnUpdateCommand:_playEffect(battleFlow)
	local unitMgr = battleFlow.unitMgr
	local boardMgr = battleFlow.boardMgr
	local effectPlayer = battleFlow.effectPlayer
	local terrainUnit = unitMgr:getUnit(self._entityId)
	local tx, tz = terrainUnit.transform:getCoordinates()
	local unionIndex = BoardIndexConverter.coordinatesToUnionIndex(tx, tz)
	local effectUnit = effectPlayer:playLoopEffect(self._effectId, string.format("%s_%d", self._effectId, unionIndex), 1)
	local wx, wy, wz = boardMgr:getCellPositionXYZ(unionIndex)

	effectUnit.transform:setPositionXYZ(wx, wy, wz)
end

function BattleLightColumnUpdateCommand:_onTimelineFinished()
	self:finish(true)
end

function BattleLightColumnUpdateCommand:toString()
	return string.format("[battle LightColumnUpdate column = %s,lightRes = %s]", self._entityId, self._effectId)
end

function BattleLightColumnUpdateCommand:setEntityId(entityId)
	self._entityId = entityId

	return self
end

function BattleLightColumnUpdateCommand:setEffectId(effectId)
	self._effectId = tonumber(effectId)

	return self
end

return BattleLightColumnUpdateCommand
