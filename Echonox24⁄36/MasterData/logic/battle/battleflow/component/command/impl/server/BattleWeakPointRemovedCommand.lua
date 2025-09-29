-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/server/BattleWeakPointRemovedCommand.lua

module("logic.battle.battleflow.component.command.impl.server.BattleWeakPointRemovedCommand", package.seeall)

local M = class("BattleWeakPointRemovedCommand", BattleTimingCommandBase)

function M:parseServerCommand(cmdParser, weakPointRemovedEventNO)
	local cmd = M:createInstance()

	cmd:setEntityId(weakPointRemovedEventNO.entity)
	cmdParser:addCommand(cmd)
end

function M:onInit()
	self._entityId = false
	self._timelineTask = TimelineTask.New()
end

function M:onClear(interrupt)
	self._entityId = false

	self._timelineTask:clear()
end

function M:_clear(interrupt)
	return
end

function M:execute(battleFlow, runningContext)
	local unitMgr = battleFlow.unitMgr
	local unit = unitMgr:getUnit(self._entityId)

	if not unit then
		if BattleLog.enableWarn then
			BattleLog.warn(string.format("M::cannot find unit[%s]", self._entityId))
		end

		self:finish(true)

		return
	end

	if unit.property:isStateActive(BattleEnum.State.WEAKPOINT_FROZEN) then
		local isShowWeakPointFrozen = BattleUnitUtil.isShowWeakPointFrozen(unit)

		unit.property:inactiveState(BattleEnum.State.WEAK_POINT_PERFORMANCED)
		unit.property:inactiveState(BattleEnum.State.WEAKPOINT_FROZEN)

		if not isShowWeakPointFrozen then
			local duaration = unit.meshModel:getAnimationDuration(UnitAnimState.Change) + BattleConst.DelayZeroPointOne

			self._timelineTask:addTask(0, self._tLinkWeakPointBrokenFocusUnit, self)
			self._timelineTask:addTask(BattleConst.DelayZeroPointOne, self._tPlayLinkWeakPointResumeEffect, self)
			self._timelineTask:addTask(duaration)
			self._timelineTask:addFinishListener(self._onLinkWeakPointTimelineTaskFinish, self)
			self._timelineTask:setTimeScale(BattleTime.timeScale)
			self._timelineTask:start(unit)
		else
			self._timelineTask:addTask(0, self._tFocusUnit, self)
			self._timelineTask:addTask(BattleConst.DelayZeroPointTwo)
			self._timelineTask:addTask(BattleConst.DelayZeroPointOne, self._tPlayWeakPointResumeEffect, self)
			self._timelineTask:addTask(BattleConst.DelayZeroPointFive, self._tResumeChangeMaterial, self)
			self._timelineTask:addTask(BattleConst.DelayOnePointFive)
			self._timelineTask:addFinishListener(self._onTimelineTaskFinish, self)
			self._timelineTask:setTimeScale(BattleTime.timeScale)
			self._timelineTask:start(unit)
		end
	else
		self:finish(true)
	end
end

function M:onCommandFinish(cmd, success)
	self._effectCommand = false

	self:_tryFinish()
end

function M:_onTimelineTaskFinish()
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local unit = unitMgr:getUnit(self._entityId)

	if unit then
		unit.property:setWeakPointType(false)

		if unit.property:isStateActive(BattleEnum.State.PLAYING_DEAD_ANIMATION) then
			BattleUnitDieUtil.handleDie(unit)
		end
	end

	self:_tryFinish()
end

function M:_onLinkWeakPointTimelineTaskFinish()
	self:_tryFinish()
end

function M:_tryFinish()
	self:finish(true)
end

function M:_tFocusUnit(unit)
	local x, y, z = M:calculateUnitFocusPosition(unit)

	VirtualCameraMgr.instance:doFollowPosition(x, y, z, BattleConst.DelayZeroPointOne)
end

function M:calculateUnitFocusPosition(unit)
	return BattleUnitUtil.getUnitDiffFocusPos(unit)
end

function M:_setPermanentEffectVisible(unit, visible)
	local effectUnit = unit.effectPlayer:getLoopEffect(BattleConst.ELITE_ENEMY_EFFECT)

	if not effectUnit then
		return
	end

	goutil.setActive(effectUnit.mainGO, visible)
end

function M:_tLinkWeakPointBrokenFocusUnit(unit)
	local x, y, z = BattleUnitUtil.getUnitCellCenterPos(unit)

	VirtualCameraMgr.instance:doFollowPosition(x, y, z, BattleConst.DelayZeroPointOne)
end

function M:_tPlayWeakPointResumeEffect(unit)
	local effectCode = unit.transform:isComposite() and BattleConst.WEAK_POINT_RESUME_BOSS or BattleConst.WEAK_POINT_RESUME
	local effectUnit = unit.effectPlayer:playEffect(effectCode, false)
	local size = unit.meshModel:getBodySize()
	local goAvatar = unit.mountRoot:getAvatarRoot()
	local x, y, z = TransformUtils.GetLocalPosition(goAvatar.transform, 0, 0, 0)

	effectUnit.transform:setLocalPositionXYZ(x, size.y, z)
end

function M:_tResumeChangeMaterial(unit)
	unit:dispatchInnerEvent(UnitActionType.BattleAttributeUpdate)
	unit.stateEffect:refreshStateEffect()
	self:_setPermanentEffectVisible(unit, true)
end

function M:_tPlayLinkWeakPointResumeEffect(unit)
	unit.meshModelMover:resetBaseMappedAnimation(UnitAnimState.Idle)
	unit.meshModelMover:resetBaseMappedAnimation(UnitAnimState.Hit)
	unit.meshModelMover:resetBaseMappedAnimation(UnitAnimState.Hit2)
	unit.meshModelMover:resetBaseMappedAnimation(UnitAnimState.Death)
	unit.meshModel:playAndAutoIdleIfExists(UnitAnimState.Change2)
	unit.stateEffect:refreshStateEffect()
	unit:dispatchInnerEvent(UnitActionType.BattleAttributeUpdate)
end

function M:toString()
	return string.format("[weak point remove command entityId = %s]", self._entityId)
end

function M:setEntityId(entityId)
	self._entityId = entityId

	return self
end

return M
