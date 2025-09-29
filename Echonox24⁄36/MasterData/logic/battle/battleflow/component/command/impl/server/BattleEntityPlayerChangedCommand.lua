-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/server/BattleEntityPlayerChangedCommand.lua

module("logic.battle.battleflow.component.command.impl.server.BattleEntityPlayerChangedCommand", package.seeall)

local BattleEntityPlayerChangedCommand = class("BattleEntityPlayerChangedCommand", BattleTimingCommandBase)

function BattleEntityPlayerChangedCommand:parseServerCommand(cmdParser, entityPlayerChangedList)
	for _, entityPlayerChangedNO in ipairs(entityPlayerChangedList) do
		local cmd = BattleEntityPlayerChangedCommand:createInstance()

		cmd:setEntityId(entityPlayerChangedNO.entity)
		cmd:setPlayerId(entityPlayerChangedNO.player)
		cmd:setChangedReason(entityPlayerChangedNO.reason)
		cmdParser:addCommand(cmd)
	end
end

function BattleEntityPlayerChangedCommand:onInit()
	self._entityId = false
	self._playerId = false
	self._reason = false
end

function BattleEntityPlayerChangedCommand:onClear()
	self._entityId = false
	self._playerId = false
	self._reason = false

	if self._timelineTask then
		self._timelineTask:clear()
	end
end

function BattleEntityPlayerChangedCommand:execute(battleFlow)
	local unitMgr = battleFlow.unitMgr
	local localLogic = battleFlow.localLogic
	local unit = unitMgr:getUnit(self._entityId)

	if not unit then
		if BattleLog.enableWarn then
			BattleLog.warn(string.format("cannot find entity[%s]", self._entityId))
		end

		self:finish(true)

		return
	end

	unitMgr:removeUnit(unit)
	unit.property:setCampId(self._playerId)
	unit.uiProxy:rebuildUI()
	unit.sceneProxy:rebuildUI()
	unitMgr:addUnit(unit)
	unit.meshModelMover:playMappedAnimationIfExists(UnitAnimState.Hit)

	if localLogic:isActiveCampId(self._playerId) then
		unit.property:activeState(BattleEnum.State.STEPPED)
	end

	if self._reason == BattleExtension_pb.PlayerChangeReason.OVERDRAWN_SANITY then
		unit.property:activeState(BattleEnum.State.SANITY_BROKEN)
		BattleEntityDeadCommand:notifyEntityDead(self._entityId)

		self._timelineTask = self._timelineTask or TimelineTask.New()

		self._timelineTask:clear()
		self._timelineTask:addTask(0, self._playSanityBrokenEffect, self)
		self._timelineTask:addTask(2, self._playSanityBrokenLoopEffect, self)
		self._timelineTask:setTimeScale(BattleTime.timeScale)
		self._timelineTask:start(unit)
	else
		self:finish(true)
	end
end

function BattleEntityPlayerChangedCommand:_playSanityBrokenEffect(unit)
	unit.effectPlayer:playEffect(BattleConst.SANITY_BROKEN)
end

function BattleEntityPlayerChangedCommand:_playSanityBrokenLoopEffect(unit)
	unit.effectPlayer:playLoopEffect(BattleConst.SANITY_BROKEN_LOOP)
	self:finish(true)
end

function BattleEntityPlayerChangedCommand:toString()
	return string.format("[entity player changed command entityId = %s,playerId = %s]", self._entityId, self._playerId)
end

function BattleEntityPlayerChangedCommand:setEntityId(entityId)
	self._entityId = entityId

	return self
end

function BattleEntityPlayerChangedCommand:setPlayerId(playerId)
	self._playerId = playerId

	return self
end

function BattleEntityPlayerChangedCommand:setChangedReason(reason)
	self._reason = reason

	return self
end

return BattleEntityPlayerChangedCommand
