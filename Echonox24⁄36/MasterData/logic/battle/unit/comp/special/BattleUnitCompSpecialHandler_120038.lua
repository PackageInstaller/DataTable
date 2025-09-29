-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/unit/comp/special/BattleUnitCompSpecialHandler_120038.lua

module("logic.battle.unit.comp.special.BattleUnitCompSpecialHandler_120038", package.seeall)

local M = class("BattleUnitCompSpecialHandler_120038", BattleUnitCompSpecialHandler)

function M:onInit()
	self:_setEvent(true)

	self._leftAlive = false
	self._rightAlive = false
	self._initFrameCount = 0

	self._unit.meshModelMover:mapBaseAnimation(UnitAnimState.Idle, UnitAnimState.NoneIdle)
	self:onReuse()
end

function M:onReset()
	self._leftAlive = false
	self._rightAlive = false
end

function M:onDestroy()
	self:_setEvent(false)
end

function M:onReuse()
	self._initFrameCount = Time.frameCount
end

function M:handleDie(deadType, isSanityDeadth)
	self._unit.dieHandler:handleDie(deadType, isSanityDeadth)
end

function M:_setEvent(isOn)
	if isOn then
		self._unit:addInnerEventListener(UnitActionType.MeshModelLoaded, self._onMeshModelLoaded, self)
	else
		self._unit:removeInnerEventListener(UnitActionType.MeshModelLoaded, self._onMeshModelLoaded, self)
	end
end

function M:handleLinkedUnitDie(isLeftHand)
	local isBothAlive = self._leftAlive and self._rightAlive

	if isLeftHand then
		if isBothAlive then
			self._unit.meshModel:playAndAutoIdle(UnitAnimState.BothToRight)
			self._unit.meshModelMover:mapBaseAnimation(UnitAnimState.Idle, UnitAnimState.RightIdle)
			self._unit.meshModelMover:mapBaseAnimation(UnitAnimState.Idle2, UnitAnimState.RightIdle)
		else
			self._unit.meshModel:playAndAutoIdle(UnitAnimState.LeftToNone)
			self._unit.meshModelMover:mapBaseAnimation(UnitAnimState.Idle, UnitAnimState.NoneIdle)
			self._unit.meshModelMover:mapBaseAnimation(UnitAnimState.Idle2, UnitAnimState.NoneIdle)
		end

		self._leftAlive = false
	else
		if isBothAlive then
			self._unit.meshModel:playAndAutoIdle(UnitAnimState.BothToLeft)
			self._unit.meshModelMover:mapBaseAnimation(UnitAnimState.Idle, UnitAnimState.LeftIdle)
			self._unit.meshModelMover:mapBaseAnimation(UnitAnimState.Idle2, UnitAnimState.LeftIdle)
		else
			self._unit.meshModel:playAndAutoIdle(UnitAnimState.RightToNone)
			self._unit.meshModelMover:mapBaseAnimation(UnitAnimState.Idle, UnitAnimState.NoneIdle)
			self._unit.meshModelMover:mapBaseAnimation(UnitAnimState.Idle2, UnitAnimState.NoneIdle)
		end

		self._rightAlive = false
	end

	self:_syncAnimationMapToLinkedParts()
end

function M:handleLinkedUnitBorn(isLeftHand)
	if isLeftHand then
		self._leftAlive = true
	else
		self._rightAlive = true
	end

	if self._initFrameCount == Time.frameCount then
		if self._leftAlive and self._rightAlive then
			self._unit.meshModelMover:mapBaseAnimation(UnitAnimState.Idle, UnitAnimState.BothIdle)
			self._unit.meshModelMover:mapBaseAnimation(UnitAnimState.Idle2, UnitAnimState.BothIdle)
		elseif self._leftAlive and not self._rightAlive then
			self._unit.meshModelMover:mapBaseAnimation(UnitAnimState.Idle, UnitAnimState.LeftIdle)
			self._unit.meshModelMover:mapBaseAnimation(UnitAnimState.Idle2, UnitAnimState.LeftIdle)
		elseif self._rightAlive and not self._leftAlive then
			self._unit.meshModelMover:mapBaseAnimation(UnitAnimState.Idle, UnitAnimState.RightIdle)
			self._unit.meshModelMover:mapBaseAnimation(UnitAnimState.Idle2, UnitAnimState.RightIdle)
		else
			self._unit.meshModelMover:mapBaseAnimation(UnitAnimState.Idle, UnitAnimState.NoneIdle)
			self._unit.meshModelMover:mapBaseAnimation(UnitAnimState.Idle2, UnitAnimState.NoneIdle)
		end

		self._unit.meshModelMover:playIdle()
	else
		local isBothAlive = self._leftAlive and self._rightAlive

		if isBothAlive then
			self._unit.meshModelMover:mapBaseAnimation(UnitAnimState.Idle, UnitAnimState.BothIdle)
			self._unit.meshModelMover:mapBaseAnimation(UnitAnimState.Idle2, UnitAnimState.BothIdle)
			self._unit.meshModel:playAndAutoIdle(UnitAnimState.NoneToBoth)
		end
	end

	self:_syncAnimationMapToLinkedParts()
end

function M:_syncAnimationMapToLinkedParts()
	local unitMgr = BattleMgr.instance:getUnitMgr()

	self:_syncAnimationMapToLinkedPart(self._unit, unitMgr:getUnitByModelCode(120039))
	self:_syncAnimationMapToLinkedPart(self._unit, unitMgr:getUnitByModelCode(120040))
end

function M:_syncAnimationMapToLinkedPart(srcUnit, targetUnit)
	if not srcUnit or not targetUnit then
		return
	end

	local animState = srcUnit.meshModelMover:getMappedAnimation(UnitAnimState.Idle)

	targetUnit.meshModelMover:mapBaseAnimation(UnitAnimState.Idle, animState)
	targetUnit.meshModelMover:mapBaseAnimation(UnitAnimState.Idle1, animState)
	targetUnit.meshModelMover:mapBaseAnimation(UnitAnimState.Idle2, animState)
end

function M:_onMeshModelLoaded()
	local unit = self._unit
	local animState = unit.meshModelMover:getMappedAnimation(UnitAnimState.Idle)
	local hitList = UnitAnimState.HitList

	for _, state in ipairs(hitList) do
		unit.meshModel:mapResourceAnimation(state, animState)
	end
end

return M
