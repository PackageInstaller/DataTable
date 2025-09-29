-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/server/BattleEntityRemovedCommand.lua

module("logic.battle.battleflow.component.command.impl.server.BattleEntityRemovedCommand", package.seeall)

local BattleEntityRemovedCommand = class("BattleEntityRemovedCommand", BattleCommandBase)

function BattleEntityRemovedCommand:parseServerCommand(cmdParser, entityRemovedNO)
	local cmd = BattleEntityRemovedCommand:createInstance()

	cmd:setPerformanceEnable(self:_judgeEnablePerformance(cmdParser, entityRemovedNO))
	cmd:setEntityId(entityRemovedNO.id)
	cmd:setRemoveReason(entityRemovedNO.reason)
	cmdParser:addCommand(cmd)
end

function BattleEntityRemovedCommand:_judgeEnablePerformance(cmdParser, entityRemovedNO)
	local defaultResult = entityRemovedNO.reason == BattleExtension_pb.RemoveReason.REASON_RETREAT

	return BattleCmdUtil.isEnablePerformance(cmdParser, defaultResult)
end

function BattleEntityRemovedCommand:onInit()
	self._entityId = 0
	self._removeReason = false
	self._isEnablePerformance = false
	self._timelineTask = false
end

function BattleEntityRemovedCommand:onClear()
	if self._timelineTask then
		self._timelineTask:clear()
	end

	self._entityId = 0
	self._isEnablePerformance = false
	self._removeReason = false
end

function BattleEntityRemovedCommand:execute(battleFlow)
	if self._removeReason == BattleExtension_pb.RemoveReason.REASON_RETREAT then
		BattleDispatcher:dispatchEvent(BattleEventType.OnArriveEvacuationPoint, self._entityId)
	end

	if self._isEnablePerformance then
		self._timelineTask = self._timelineTask or TimelineTask.New()

		self._timelineTask:clear()
		self._timelineTask:addTask(0, self._tFocusUnit, self)
		self._timelineTask:addTask(0.5, self._tDisappear, self)
		self._timelineTask:addTask(1)
		self._timelineTask:addFinishListener(self._notifyFinish, self)
		self._timelineTask:setTimeScale(BattleTime.timeScale)
		self._timelineTask:start()
	else
		local unitMgr = battleFlow.unitMgr
		local unit = unitMgr:getUnit(self._entityId)

		BattleUnitGenerator.removeUnit(unit)
		BattleUnitGenerator.destroyUnit(unit)
		self:_notifyFinish()
	end
end

function BattleEntityRemovedCommand:_tFocusUnit()
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local unit = unitMgr:getUnit(self._entityId)
	local x, y, z = unit.meshModelMover:getPosXYZ()

	BattleCameraUtil.doFollowPosition(x, y, z, BattleConst.DelayZeroPointFive)
end

function BattleEntityRemovedCommand:_tDisappear()
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local unit = unitMgr:getUnit(self._entityId)

	BattleUnitGenerator.removeUnit(unit)
	unit.dieHandler:handleDisappear()
end

function BattleEntityRemovedCommand:_notifyFinish()
	BattleDispatcher:dispatchEvent(BattleEventType.OnEntityRemoved)
	self:finish(true)
end

function BattleEntityRemovedCommand:toString()
	return string.format("[battle entity removed command,entityId = %s,enablePerformance = %s]", self._entityId, tostring(self._isEnablePerformance))
end

function BattleEntityRemovedCommand:setEntityId(entityId)
	self._entityId = entityId

	return self
end

function BattleEntityRemovedCommand:setRemoveReason(reason)
	self._removeReason = reason

	return self
end

function BattleEntityRemovedCommand:setPerformanceEnable(isEnable)
	self._isEnablePerformance = isEnable

	return self
end

return BattleEntityRemovedCommand
