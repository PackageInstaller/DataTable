-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/unit/comp/BattleUnitCompStateEffect.lua

module("logic.battle.unit.comp.BattleUnitCompStateEffect", package.seeall)

local BattleUnitCompStateEffect = class("BattleUnitCompStateEffect", BattleUnitCompBase)

function BattleUnitCompStateEffect:onInit()
	self._stateMapping = {}
	self._stateMapping[BattleEnum.State.STEPPED] = self._showSteppedState
	self._stateMapping[BattleEnum.State.WEAKPOINT_FROZEN] = self._showWeakPointFrozen
	self._stateMapping[BattleEnum.State.DIZZY_OR_SLEEP] = self._showDizzyOrSleep
	self._stateMapping[BattleEnum.State.DEAD_FROZEN] = self._showDeadState
	self._stateMapping[BattleEnum.State.UNDO_PREVIEW] = self._showUndoPreview
	self._statePriority = {
		BattleEnum.State.DEAD_FROZEN,
		BattleEnum.State.STEPPED,
		BattleEnum.State.WEAKPOINT_FROZEN,
		BattleEnum.State.DIZZY_OR_SLEEP,
		BattleEnum.State.UNDO_PREVIEW
	}
	self._property = self._unit.property
	self._frozenSignal = SignalAmount.New()
	self._decolorSignal = SignalAmount.New()
	self._effectIds = {}
	self._animationName = false
	self._animationTime = 0
	self._switchMaterialUrl = false
	self._switchMaterialAdd = false
end

function BattleUnitCompStateEffect:onReset()
	self._frozenSignal:clear()
	self._decolorSignal:clear()
	BattleTableUtil.clearTable(self._effectIds)
	self:clearAllStateEffect()
end

function BattleUnitCompStateEffect:onBeforeReset()
	self:_clearGlobalStateEffect()
end

function BattleUnitCompStateEffect:_clearGlobalStateEffect()
	local snipingDrawing = BattleMgr.instance:getSnipingDrawing()

	if not self._unit.property:getSourceUnit() and snipingDrawing then
		snipingDrawing:clearSnipingForUnit(self._unit)
	end
end

function BattleUnitCompStateEffect:onDestroy()
	return
end

function BattleUnitCompStateEffect:refreshStateEffect()
	self:_applyAllStateEffect()
end

function BattleUnitCompStateEffect:clearAllStateEffect()
	self:_clearAllStateEffect()
end

function BattleUnitCompStateEffect:applyAllStateEffect()
	self:_applyAllStateEffect()
end

function BattleUnitCompStateEffect:isFrozen()
	return self._frozenSignal:isActive()
end

function BattleUnitCompStateEffect:_clearAllStateEffect()
	local unit = self._unit

	unit.meshModel:setFrozen(false)
	unit.material:clearDecolorEffect()

	for _, effectCode in ipairs(self._effectIds) do
		unit.effectPlayer:stopLoopEffect(effectCode)
	end
end

function BattleUnitCompStateEffect:_applyAllStateEffect()
	local needRemoveEffectIds = BattleTableUtil.getTempList()

	BattleTableUtil.insertto(needRemoveEffectIds, self._effectIds)
	self._frozenSignal:clear()
	self._decolorSignal:clear()

	self._switchMaterialUrl = false
	self._switchMaterialAdd = false

	BattleTableUtil.clearTable(self._effectIds)

	for _, state in ipairs(self._statePriority) do
		if self._property:isStateActive(state) then
			local f = self._stateMapping[state]
			local doBreak = f(self)

			if doBreak then
				break
			end
		end
	end

	for _, effectCode in ipairs(needRemoveEffectIds) do
		if not table.indexof(self._effectIds, effectCode) then
			self._unit.effectPlayer:stopLoopEffect(effectCode)
		end
	end

	self:_applyFinalEffect()
end

function BattleUnitCompStateEffect:_applyFinalEffect()
	local unit = self._unit

	if self._frozenSignal:isActive() then
		local animationName = unit.meshModelMover:getMappedAnimation(self._animationName)

		unit.meshModel:playAndAutoIdle(animationName)
		unit.meshModel:frozenAnimation(animationName, self._animationTime)
	else
		unit.meshModel:setFrozen(false)
	end

	if self._decolorSignal:isActive() then
		unit:setMask(true)
		unit.material:setDecolorEffect()
	else
		unit:setMask(false)
		unit.material:clearDecolorEffect()
	end

	for _, effectCode in ipairs(self._effectIds) do
		local effectUnit = unit.effectPlayer:playLoopEffect(effectCode)
		local unitRect = unit.transform:getRectangle()

		if unitRect then
			local offSizeX, offSizeZ = unitRect:getCenterXZ()

			effectUnit.transform:setLocalPositionXYZ(offSizeX + 0.5, 0, offSizeZ + 0.5)

			local scale = unitRect:getMaxx() - unitRect:getMinx() + 1

			effectUnit.transform:setScaleXYZ(scale, scale, scale)
		else
			effectUnit.transform:setLocalPositionXYZ(0, 0, 0)
			effectUnit.transform:setScaleXYZ(1, 1, 1)
		end
	end

	if self._switchMaterialUrl then
		unit.material:switchMaterial(self._switchMaterialUrl, self._switchMaterialAdd)
	else
		unit.material:resumeOriginalMaterial()
	end
end

function BattleUnitCompStateEffect:_showSteppedState()
	if self._unit.property:isStateActive(BattleEnum.State.SNIPING) then
		return
	end

	self._decolorSignal:addUnique(BattleEnum.State.STEPPED)

	self._animationName = UnitAnimState.Idle
	self._animationTime = 0
end

function BattleUnitCompStateEffect:_showDizzyOrSleep()
	self._frozenSignal:addUnique(BattleEnum.State.DIZZY_OR_SLEEP)

	self._animationName = UnitAnimState.Hit
	self._animationTime = BattleConst.HitHalfTime

	table.insert(self._effectIds, BattleConst.LAZZY_OR_SLEEP)

	local unit = self._unit
	local effectUnit = unit.effectPlayer:playLoopEffect(BattleConst.LAZZY_OR_SLEEP)
	local unitRect = unit.transform:getRectangle()

	if unitRect then
		local offSizeX, offSizeZ = unitRect:getCenterXZ()

		effectUnit.transform:setLocalPositionXYZ(offSizeX + 0.5, 0, offSizeZ + 0.5)

		local scale = unitRect:getMaxx() - unitRect:getMinx() + 1

		effectUnit.transform:setScaleXYZ(scale, scale, scale)
	else
		effectUnit.transform:setLocalPositionXYZ(0, 0, 0)
		effectUnit.transform:setScaleXYZ(1, 1, 1)
	end

	unit.meshModel:frozenAnimation(UnitAnimState.Hit, BattleConst.HitHalfTime)
end

function BattleUnitCompStateEffect:_showWeakPointFrozen()
	if not BattleUnitUtil.isShowWeakPointFrozen(self._unit) then
		return
	end

	self._frozenSignal:addUnique(BattleEnum.State.WEAKPOINT_FROZEN)

	self._animationName = UnitAnimState.Hit
	self._animationTime = BattleConst.HitHalfTime
	self._switchMaterialUrl = BattleResourceName.WeakpointBrokenMaterial
	self._switchMaterialAdd = true
end

function BattleUnitCompStateEffect:_showDeadState()
	self._frozenSignal:addUnique(BattleEnum.State.DEAD_FROZEN)

	local unit = self._unit

	self._animationName = unit.meshModelMover:getMappedAnimation(UnitAnimState.Death)
	self._animationTime = unit.meshModel:getAnimationDuration(self._animationName)
end

function BattleUnitCompStateEffect:_showUndoPreview()
	self._frozenSignal:addUnique(BattleEnum.State.UNDO_PREVIEW)
end

return BattleUnitCompStateEffect
