-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/unit/herounit/AirWorkShopHeroUnit.lua

module("logic.extensions.airworkshop.flow.defflow.unit.herounit.AirWorkShopHeroUnit", package.seeall)

local M = class("AirWorkShopHeroUnit", AirUnitBase)

function M:ctor(componetContainer)
	self:onReset()
	M.super.ctor(self, componetContainer)
	self:_setEvent(true)
end

function M:Update()
	self.mover:update()
end

function M:_initComponents()
	self:_addComponent("mountRoot", BattleUnitCompMountRoot)
	self:_addComponent("effectPlayer", AirWorkUnitCompEffectPlayer)
	self:_addComponent("meshModel", BattleUnitCompMeshModel)
	self:_addComponent("property", AirWorkUnitCompHeroProperty)
	self:_addComponent("transform", AirWorkUnitCompTransform)
	self:_addComponent("uiFollow", BattleUnitCompUIFollow)
	self:_addComponent("uiBloodFollow", BattleUnitCompBloodFollow)
	self:_addComponent("mover", BattleUnitCompMover)
	self:_addComponent("meshModelMover", AirWorkUnitCompMeshModelMover)
	self:_addComponent("uiProxy", AirWorkUnitCompUIProxy)
end

function M:setVisible(isActive)
	if self:isDestroyed() then
		return
	end

	self:setActive(isActive)
	printError("setVisible", isActive)
	self.uiProxy:setVisible(isActive)
end

function M:doFade(isFade)
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

function M:delayShowModel(delay)
	self.meshModel:setVisible(false)

	if self._timeWaiter then
		self._timeWaiter:clear()
	else
		self._timeWaiter = TimeWaiter.New()
	end

	self._timeWaiter:setTimeScale(BattleTime.timeScale)
	self._timeWaiter:start(delay, self._onTimerDone, self)
end

function M:_onTimerDone()
	self.meshModel:setVisible(true)
	self.meshModel:forceUpdate()
end

function M:onReset()
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

function M:addComponentAndInit(compName, compClass)
	self:_addComponent(compName, compClass)
	self._compList[#self._compList]:onInit()
	table.insert(self._uniqueCompIdxList, #self._compList)
end

function M:_removeComponentAndReset()
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

function M:_setEvent(isOn)
	if isOn then
		-- block empty
	end
end

function M:reset()
	self:_removeComponentAndReset()
	M.super.reset(self)
	self:_setEvent(false)
end

function M:reuse()
	self:onReset()
	M.super.reuse(self)
	self:_setEvent(true)
end

function M:onDestroy()
	self:_removeComponentAndReset()
	self:onReset()

	self._timeWaiter = false
end

function M:setVisible(isActive)
	if self:isDestroyed() then
		return
	end

	self:setActive(isActive)
	self.uiProxy:setVisible(isActive)
end

return M
