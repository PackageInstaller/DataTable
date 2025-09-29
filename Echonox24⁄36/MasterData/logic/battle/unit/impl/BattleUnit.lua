-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/unit/impl/BattleUnit.lua

module("logic.battle.unit.impl.BattleUnit", package.seeall)

local BattleUnit = class("BattleUnit", BattleUnitBase)

function BattleUnit:ctor(componetContainer)
	self:onReset()
	BattleUnit.super.ctor(self, componetContainer)
	self:_setEvent(true)
end

function BattleUnit:getTag()
	return UnitTag.Player
end

function BattleUnit:getUnitType()
	return BattleEnum.UnitType.Person
end

function BattleUnit:isPerson()
	return true
end

function BattleUnit:getLayer()
	return SceneLayer.Unit_Value
end

function BattleUnit:Update()
	self.mover:update()
	self.modelMountFollow:update()
end

function BattleUnit:_initComponents()
	self:_addComponent("mountRoot", BattleUnitCompMountRoot)
	self:_addComponent("effectPlayer", BattleUnitCompEffectPlayer)
	self:_addComponent("skill", BattleUnitCompSkills)
	self:_addComponent("buff", BattleUnitCompBuffs)
	self:_addComponent("meshModel", BattleUnitCompMeshModel)
	self:_addComponent("mover", BattleUnitCompMover)
	self:_addComponent("meshModelMover", BattleUnitCompMeshModelMover)
	self:_addComponent("property", BattleUnitCompProperty)
	self:_addComponent("transform", BattleUnitCompTransform)
	self:_addComponent("uiFollow", BattleUnitCompUIFollow)
	self:_addComponent("uiBloodFollow", BattleUnitCompBloodFollow)
	self:_addComponent("sceneProxy", BattleUnitCompSceneProxy)
	self:_addComponent("uiProxy", BattleUnitCompUIProxy)
	self:_addComponent("bubble", BattleUnitCompBubble)
	self:_addComponent("material", BattleUnitCompMaterial)
	self:_addComponent("dieHandler", BattleUnitCompDieHandler)
	self:_addComponent("sign", BattleUnitCompSign)
	self:_addComponent("stateEffect", BattleUnitCompStateEffect)
	self:_addComponent("skillAreaWarning", BattleUnitCompSkillAreaWarning)
	self:_addComponent("modelMountFollow", BattleUnitCompModelMountFollow)
	self:_addComponent("meshModelWear", BattleUnitMeshModelWear)
end

function BattleUnit:getEditorDisplayName()
	local property = self.property

	return string.format("%s_%s_%s", property:getEntityId(), property:getEntityCode(), property:getName())
end

function BattleUnit:setVisible(isActive, key)
	if self:isDestroyed() then
		return
	end

	self:setActive(isActive)
	self:setProxyVisible(isActive, key)
end

function BattleUnit:setProxyVisible(isActive, key)
	if self:isDestroyed() then
		return
	end

	self.uiProxy:setVisible(isActive, false, key)
	self.sceneProxy:setVisible(isActive, key)
end

function BattleUnit:setIsInBossView(isBoss)
	self.uiProxy:setIsInBossView(isBoss)
	self.sceneProxy:setIsInBossView(isBoss)
end

function BattleUnit:setMask(isMask)
	if self._isMask == isMask then
		return
	end

	self.sceneProxy:setMask(isMask)
	self.uiProxy:setMask(isMask)

	self._isMask = isMask
end

function BattleUnit:doFade(isFade)
	if self:isDestroyed() then
		return
	end

	self.uiProxy:doFade(isFade, BattleConst.DelayZeroPointFive / BattleTime.timeScale)
	self.material:setAlphaEnable(true)

	if isFade then
		self.material:doMainAlpha(0, BattleConst.DelayZeroPointFive / BattleTime.timeScale)
	else
		self.material:doMainAlpha(1, BattleConst.DelayZeroPointFive / BattleTime.timeScale)
	end

	self.sceneProxy:setVisible(not isFade)
end

function BattleUnit:delayShowModel(delay)
	self.meshModel:setVisible(false)

	if self._timeWaiter then
		self._timeWaiter:clear()
	else
		self._timeWaiter = TimeWaiter.New()
	end

	self._timeWaiter:setTimeScale(BattleTime.timeScale)
	self._timeWaiter:start(delay, self._onTimerDone, self)
end

function BattleUnit:_onTimerDone()
	self.meshModel:setVisible(true)
	self.meshModel:forceUpdate()
end

function BattleUnit:onReset()
	self._isMask = false

	if self._timeWaiter then
		self._timeWaiter:clear()
	end

	if self._uniqueCompIdxList then
		BattleTableUtil.clearTable(self._uniqueCompIdxList)
	else
		self._uniqueCompIdxList = {}
	end
end

function BattleUnit:addComponentAndInit(compName, compClass)
	self:_addComponent(compName, compClass)
	self._compList[#self._compList]:onInit()
	table.insert(self._uniqueCompIdxList, #self._compList)
end

function BattleUnit:_removeComponentAndReset()
	if #self._uniqueCompIdxList > 0 then
		for i = #self._uniqueCompIdxList, 1, -1 do
			local idx = self._uniqueCompIdxList[i]
			local comp = self._compList[idx]

			comp:onReset()
			comp:onDestroy()
			table.remove(self._compList, idx)
		end

		BattleTableUtil.clearTable(self._uniqueCompIdxList)
	end
end

function BattleUnit:_setEvent(isOn)
	if isOn then
		GlobalDispatcher:addEventListener(EventType.REFRESH_HERO_DEPOT_DATA, self._onHeroInfoUpdate, self)
	else
		GlobalDispatcher:removeEventListener(EventType.REFRESH_HERO_DEPOT_DATA, self._onHeroInfoUpdate, self)
	end
end

function BattleUnit:_onHeroInfoUpdate(_, heroData)
	if heroData:getId() == self.property:getEntityCode() then
		BattleUnitUtil.updateUnitInfo(self, heroData)
	end
end

function BattleUnit:reset()
	self:_removeComponentAndReset()
	BattleUnit.super.reset(self)
	self:_setEvent(false)
end

function BattleUnit:reuse()
	self:onReset()
	BattleUnit.super.reuse(self)
	self:_setEvent(true)
end

function BattleUnit:onDestroy()
	self:_removeComponentAndReset()
	self:onReset()

	self._timeWaiter = false
end

return BattleUnit
