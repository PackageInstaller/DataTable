-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewbossblood/BattleBossWeakPointHintView.lua

module("logic.extensions.battle.viewbossblood.BattleBossWeakPointHintView", package.seeall)

local M = class("BattleBossWeakPointHintView")

function M:ctor(gameObject)
	self.mainGO = gameObject

	self:buildUI()
end

function M:buildUI()
	self._weakPointBar = goutil.findChildImageComponent(self.mainGO, "fill")
	self._weakPointForecastBar = goutil.findChildImageComponent(self.mainGO, "forecast")
	self._weakPointBarAnim = goutil.addComponentOnce(self._weakPointForecastBar, ComponentType.Animation)
end

function M:destroy()
	self:destroyUI()
end

function M:destroyUI()
	self._weakPointBar = false
	self._weakPointForecastBar = false
end

function M:setVisible(state)
	goutil.setActive(self.mainGO, state)
end

function M:updateBaseInfo(unit)
	self._unit = unit

	local maxHp = unit.property:getWeakPointMaxHp()
	local curHp = unit.property:getWeakPointHp()
	local fillAmount = curHp / maxHp

	self._currentFillAmount = fillAmount
	self._weakPointBar.fillAmount = fillAmount

	goutil.setActive(self._weakPointForecastBar.gameObject, false)

	self._weakPointForecastBar.fillAmount = fillAmount
end

function M:forecast(unit, toWeakPointHp)
	unit = unit or self._unit

	goutil.setActive(self._weakPointForecastBar.gameObject, true)

	local maxHp = unit.property:getWeakPointMaxHp()
	local curHp = toWeakPointHp

	self._weakPointForecastBar.fillAmount = self._currentFillAmount

	local fillAmount = curHp / maxHp

	self._weakPointBar.fillAmount = fillAmount

	BattleSynAnimUtil.playAnimSyn(self._weakPointBarAnim, "boss_xuetiao_loop")
end

function M:clearForecast(unit)
	BattleSynAnimUtil.stopAnim(self._weakPointBarAnim)
	goutil.setActive(self._weakPointForecastBar.gameObject, false)
end

function M:updatePerformance()
	local unit = self._unit
	local maxHp = unit.property:getWeakPointMaxHp()
	local curHp = unit.property:getWeakPointHp()
	local toFillAmount = curHp / maxHp
	local toHp = math.max(0, unit.property:getWeakPointHp())
	local isWeakPointWillBroken = not unit.property:isWeakPointBroken() and toHp <= 0

	if not self._isPlayingFill then
		self._weakPointForecastBar.fillAmount = self._currentFillAmount
	end

	if isWeakPointWillBroken then
		self._weakPointBar.fillAmount = 0
		self._currentFillAmount = 0

		BattleSynAnimUtil.stopAnim(self._weakPointBarAnim)
		goutil.setActive(self._weakPointForecastBar.gameObject, false)
	else
		self._weakPointBar.fillAmount = toFillAmount
		self._isPlayingFill = true
		self._currentFillAmount = toFillAmount

		goutil.setActive(self._weakPointForecastBar.gameObject, true)
		self._weakPointForecastBar:DOKill(false)
		AnimationUtils.ResetAnimation(self._weakPointBarAnim)
		self._weakPointForecastBar:DOFillAmount(toFillAmount, 1):OnComplete(self._onFillAmountFinish, self)
	end
end

function M:_onFillAmountFinish()
	self._isPlayingFill = false

	goutil.setActive(self._weakPointForecastBar.gameObject, false)
end

function M:startWeakPointFillScroll(fWeak)
	self._weakPointForecastBar.color = Astral.ColorUtil.ParseColor("#ffffffff")
	self._weakPointForecastBar.fillAmount = fWeak
	self._weakPointBar.fillAmount = fWeak
end

function M:setWeakPointFillAmount(fillAmount)
	self._weakPointBar.fillAmount = fillAmount
end

return M
