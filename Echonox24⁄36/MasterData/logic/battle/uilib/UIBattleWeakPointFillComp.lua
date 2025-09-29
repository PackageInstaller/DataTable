-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/uilib/UIBattleWeakPointFillComp.lua

module("logic.battle.uilib.UIBattleWeakPointFillComp", package.seeall)

local M = class("UIBattleWeakPointFillComp")
local kTextColor = "#FFFFFFFF"

function M:ctor(mainGO)
	self.mainGO = mainGO

	self:buildUI()

	self._showBroken = true
end

function M:buildUI()
	self._goFillDi = goutil.findChild(self.mainGO, "fillDi")
	self._goTingZhi = goutil.findChild(self.mainGO, "tingzhi")
	self._imgBlood = goutil.findChildImageComponent(self.mainGO, "fill")
	self._imgBloodForecast = goutil.findChildImageComponent(self.mainGO, "yujia")
	self._bloodForecastAnimation = goutil.addComponentOnce(self._imgBloodForecast.gameObject, ComponentType.Animation)
	self._rollingFillPercentTxt = UIEffectUtil.getTextRollingEffect(goutil.findChild(self.mainGO, "txtFill"))

	self._rollingFillPercentTxt:setFormatPattern("%d%%")

	self._rollingFillPercentTxtAnimation = goutil.addComponentOnce(goutil.findChild(self.mainGO, "txtFill"), ComponentType.Animation)
	self._forcastUnitEntityId = false
	self._isSelected = false
	self._enableState = GameObjectVisibleState.New()

	self:setPercentTextVisible(true)
end

function M:reset()
	self._enableState:clear()

	self._unit = false
end

function M:destroyUI()
	BattleSynAnimUtil.stopAnim(self._rollingFillPercentTxtAnimation)

	self._imgBlood = nil
end

function M:destroy()
	self:destroyUI()

	self.mainGO = nil
end

function M:setVisible(visible, key)
	self._enableState:setEnable(key, visible)

	local isActive = self._enableState:isEnable()

	goutil.setActive(self.mainGO, isActive)

	if self._visibleFunc then
		self._visibleFunc(self._visibleHandler, isActive)
	end
end

function M:setVisibleCallBack(visibleFunc, visibleHandler)
	self._visibleFunc = visibleFunc
	self._visibleHandler = visibleHandler
end

function M:checkVisible()
	local unit = self._unit

	if not unit or not unit.property:isShowWeakPoint() then
		self:setVisible(false)

		return
	end

	if self._isSelected then
		self:setVisible(false)

		return
	end

	self:setVisible(true)

	return true
end

function M:setSelected(status)
	self._isSelected = status

	self:checkVisible()
end

function M:updateBaseInfo(unit)
	self._unit = unit

	if not self:checkVisible() then
		return
	end

	local maxHp = unit.property:getWeakPointMaxHp()
	local curHp = unit.property:getWeakPointHp()
	local fillAmount = curHp / maxHp

	self._currentFillAmount = fillAmount

	if curHp <= 0 then
		goutil.setActive(self._goFillDi, false)
		goutil.setActive(self._goTingZhi, true)

		self._imgBloodForecast.fillAmount = 0
		self._imgBlood.fillAmount = 0

		self._rollingFillPercentTxt:setText("")
	else
		goutil.setActive(self._goFillDi, true)
		goutil.setActive(self._goTingZhi, false)

		self._imgBloodForecast.fillAmount = 0
		self._imgBlood.fillAmount = fillAmount

		self._rollingFillPercentTxt:setValue(self:_formatPercentValue(fillAmount))
	end

	self:_setRollingFillPercentTxtAnimation(false)
end

function M:setPercentTextVisible(visible)
	self._rollingFillPercentTxt:setVisible(visible)
end

function M:forecast(unit, toWeakPointHp)
	self._unit = unit and unit or self._unit

	if not self:checkVisible() then
		return
	end

	local unit = self._unit

	toWeakPointHp = toWeakPointHp or 0

	local maxHp = unit.property:getWeakPointMaxHp()
	local fromHp = unit.property:getWeakPointHp()
	local toHp = math.max(0, toWeakPointHp)
	local fromFillAmount = fromHp / maxHp
	local toFillAmount = toHp / maxHp

	self._imgBlood:DOKill(true)

	self._imgBlood.fillAmount = toFillAmount
	self._imgBloodForecast.fillAmount = fromFillAmount

	local entityId = unit.property:getEntityId()

	if self._forcastUnitEntityId ~= entityId then
		self._forcastUnitEntityId = entityId

		self._rollingFillPercentTxt:setValue(self:_formatPercentValue(fromFillAmount))
	end

	BattleSynAnimUtil.playAnimSyn(self._bloodForecastAnimation, "weak_fill_yujia")

	local isWeakPointHpChanged = fromHp ~= toHp
	local isWeakPointWillBroken = not unit.property:isWeakPointBroken() and toHp <= 0

	if isWeakPointWillBroken then
		goutil.setActive(self._goFillDi, false)
		goutil.setActive(self._goTingZhi, true)
		self._rollingFillPercentTxt:setText("击破")
	elseif not isWeakPointHpChanged then
		goutil.setActive(self._goFillDi, true)
		goutil.setActive(self._goTingZhi, false)
		self:_setRollingFillPercentTxtAnimation(false)

		self._imgBloodForecast.fillAmount = 0

		self._rollingFillPercentTxt:setText("")
	else
		goutil.setActive(self._goFillDi, true)
		goutil.setActive(self._goTingZhi, false)
		self:_setRollingFillPercentTxtAnimation(false)
		self._rollingFillPercentTxt:setValue(self:_formatPercentValue(fromFillAmount))
		self._rollingFillPercentTxt:setColor(kTextColor)
		self._rollingFillPercentTxt:rollToValue(self:_formatPercentValue(toFillAmount), 0.5)
	end
end

function M:updatePerformance(unit)
	self._unit = unit and unit or self._unit

	if not self:checkVisible() then
		return
	end

	local maxHp = unit.property:getWeakPointMaxHp()
	local toHp = math.max(0, unit.property:getWeakPointHp())
	local isWeakPointWillBroken = toHp <= 0

	if not self._isPlayingFill then
		self._imgBloodForecast.fillAmount = self._currentFillAmount
	end

	if isWeakPointWillBroken then
		goutil.setActive(self._goFillDi, false)
		goutil.setActive(self._goTingZhi, true)
		self._imgBlood:DOKill(true)

		self._imgBlood.fillAmount = 0

		self._imgBloodForecast:DOKill(false)

		self._imgBloodForecast.fillAmount = 0
		self._currentFillAmount = 0

		self._rollingFillPercentTxt:setText("")
		self:_setRollingFillPercentTxtAnimation(false)
		BattleSynAnimUtil.stopAnim(self._bloodForecastAnimation)
	else
		goutil.setActive(self._goFillDi, true)
		goutil.setActive(self._goTingZhi, false)

		local toFillAmount = toHp / maxHp

		self._imgBlood.fillAmount = toFillAmount

		self._imgBlood:DOKill(false)

		self._isPlayingFill = true
		self._currentFillAmount = toFillAmount

		self._imgBloodForecast:DOKill(false)
		AnimationUtils.ResetAnimation(self._bloodForecastAnimation)
		self._imgBloodForecast:DOFillAmount(toFillAmount, 1):OnComplete(self._onFillAmountFinish, self)
		self._rollingFillPercentTxt:setValue(self:_formatPercentValue(toFillAmount))
		self:_setRollingFillPercentTxtAnimation(false)
		BattleSynAnimUtil.stopAnim(self._bloodForecastAnimation)
	end
end

function M:_onFillAmountFinish()
	self._isPlayingFill = false
end

function M:_formatPercentValue(fillAmount)
	return BattleUnitUtil.formatWeakPointValue(fillAmount)
end

function M:_setRollingFillPercentTxtAnimation(enabled)
	if enabled then
		BattleSynAnimUtil.playAnimSyn(self._rollingFillPercentTxtAnimation, "weak_txtfill_yujia")
	else
		BattleSynAnimUtil.stopAnim(self._rollingFillPercentTxtAnimation)
	end
end

return M
