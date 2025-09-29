-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewbossblood/BattleBossBloodHintView.lua

module("logic.extensions.battle.viewbossblood.BattleBossBloodHintView", package.seeall)

local M = class("BattleBossBloodHintView")

function M:ctor(gameObject)
	self.mainGO = gameObject

	self:buildUI()
end

function M:buildUI()
	self._forecastCureGo = goutil.findChild(self.mainGO, "xuetiao_yujia")
	self._forecastDamageGo = goutil.findChild(self.mainGO, "xuetiao_yukou")
	self._forecastDoubleDamageGo = goutil.findChild(self.mainGO, "xuetiao_yukou_double")
	self._bossHp = goutil.findChildTextComponent(self.mainGO, "txtNum")
	self._bloodImg = goutil.findChildComponent(self.mainGO, "fill1", typeof(FillAmountImage))
	self._forecastDamagedImg = goutil.findChildComponent(self.mainGO, "xuetiao_yukou", typeof(FillAmountImage))
	self._forecastCuredImg = goutil.findChildComponent(self.mainGO, "xuetiao_yujia", typeof(FillAmountImage))
	self._forecastDoubleDamagedImg = goutil.findChildComponent(self.mainGO, "xuetiao_yukou_double", typeof(FillAmountImage))
	self._forecastCureAnim = self._forecastCureGo:GetComponent(ComponentType.Animation)
	self._forecastDamageAnim = self._forecastDamageGo:GetComponent(ComponentType.Animation)
	self._forecastDoubleDamageAnim = self._forecastDoubleDamageGo:GetComponent(ComponentType.Animation)
end

function M:forecast(forecastEntityInfo)
	local p1 = self._unit.property:getAttribute(BattleExtension_pb.Attribute.CURRENT_HP) / self._unit.property:getAttribute(BattleExtension_pb.Attribute.MAX_HP)
	local p2 = forecastEntityInfo:getAttribute(BattleExtension_pb.Attribute.CURRENT_HP) / forecastEntityInfo:getAttribute(BattleExtension_pb.Attribute.MAX_HP)
	local isDouble = self._unit.property:isWeakPointBroken()

	self:forecastByValue(p1, p2, isDouble)
end

function M:forecastByValue(p1, p2, isDouble)
	local isCure = p1 < p2

	if isCure then
		goutil.setActive(self._forecastDamageGo, false)
		goutil.setActive(self._forecastCureGo, true)
		goutil.setActive(self._forecastDoubleDamageGo, false)
		self:_setFill(self._forecastCuredImg, p1, p2)
		self:_setFill(self._bloodImg, 0, p1)
		BattleSynAnimUtil.playAnimSyn(self._forecastCureAnim, "boss_xuetiao_loop")
	else
		goutil.setActive(self._forecastDamageGo, true)
		goutil.setActive(self._forecastCureGo, false)
		goutil.setActive(self._forecastDoubleDamageGo, isDouble)
		BattleSynAnimUtil.playAnimSyn(self._forecastDamageAnim, "boss_xuetiao_loop")

		if isDouble then
			self:_setFill(self._bloodImg, 0, p2)
			self:_setFill(self._forecastDamagedImg, p2 + (p1 - p2) / 2, p1)
			self:_setFill(self._forecastDoubleDamagedImg, p2, p2 + (p1 - p2) / 2)
			BattleSynAnimUtil.playAnimSyn(self._forecastDoubleDamageAnim, "boss_xuetiao_loop1")
		else
			self:_setFill(self._bloodImg, 0, p2)
			self:_clearFill(self._forecastDamagedImg)
			self:_setFill(self._forecastDamagedImg, p2, p1)
		end
	end
end

function M:preparePlayScrollForecast(p1)
	self:_setFill(self._bloodImg, 0, p1)
	goutil.setActive(self._forecastDamageGo, false)
	goutil.setActive(self._forecastCureGo, false)
	goutil.setActive(self._forecastDoubleDamageGo, false)
end

function M:startPlayScrollForecast(p1, p2, isDouble)
	local isCure = p1 < p2

	self._scrollIsCure = isCure
	self._fromSideValue = isCure and p1 or 0

	if isCure then
		goutil.setActive(self._forecastDamageGo, false)
		goutil.setActive(self._forecastCureGo, true)
		goutil.setActive(self._forecastDoubleDamageGo, false)
		self:_setFill(self._forecastCuredImg, p1, p1)

		self._forecastCuredImg.color = Astral.ColorUtil.ParseColor("#ffffffff")

		self:_setFill(self._bloodImg, 0, p1)
	else
		goutil.setActive(self._forecastDamageGo, true)
		goutil.setActive(self._forecastCureGo, false)
		self:_setFill(self._bloodImg, 0, p1)
		self:_clearFill(self._forecastDamagedImg)
		self:_setFill(self._forecastDamagedImg, p2, p1)

		self._forecastDamagedImg.color = Astral.ColorUtil.ParseColor("#ffffffff")
	end
end

function M:playScrollForecast(p)
	if self._scrollIsCure then
		self:_setFill(self._forecastCuredImg, self._fromSideValue, p)
	else
		self:_setFill(self._bloodImg, self._fromSideValue, p)
	end
end

function M:_clearFill(img)
	img.leftFillAmount = 0
	img.rightFillAmount = 1
end

function M:_setFill(img, from, to)
	img:SetFillAmount(to, 1 - from)
end

function M:getFromValue(img)
	return 1 - img.rightFillAmount
end

function M:clearForecast()
	self:_clearFill(self._forecastDamagedImg)
	goutil.setActive(self._forecastDamageGo, false)
	goutil.setActive(self._forecastCureGo, false)
	goutil.setActive(self._forecastDoubleDamageGo, false)

	local property = self._unit.property

	self:_setFill(self._bloodImg, 0, property:getHp() / property:getMaxHp())
	self:_clearAnim()
end

function M:_clearAnim()
	BattleSynAnimUtil.stopAnim(self._forecastCureAnim)
	BattleSynAnimUtil.stopAnim(self._forecastDamageAnim)
	BattleSynAnimUtil.stopAnim(self._forecastDoubleDamageAnim)
end

function M:updateBaseInfo(unit)
	self._unit = unit and unit or self._unit

	if not self._unit then
		return
	end

	local property = self._unit.property

	self._currentHpRate = property:getHp() / property:getMaxHp()

	self:_setFill(self._bloodImg, 0, property:getHp() / property:getMaxHp())
	self:_updateHpTxt(property)
end

function M:updatePerformance()
	if not self._unit then
		return
	end

	local property = self._unit.property
	local toFillAmount = property:getHp() / property:getMaxHp()

	self._bloodImg:DOKill(false)
	self._forecastDamagedImg:DOKill(false)

	if toFillAmount > self._currentHpRate then
		goutil.setActive(self._forecastDamageGo, false)

		self._isPerforming = true

		self._bloodImg:DOLeftFillAmount(toFillAmount, 1, self._onFillAmountDamageFinish, self)
	elseif toFillAmount < self._currentHpRate then
		if not self._isPlayingFill then
			self:_setFill(self._forecastDamagedImg, self._currentHpRate, toFillAmount)
		end

		self._forecastDamagedImg.rightFillAmount = 1 - toFillAmount

		goutil.setActive(self._forecastDamageGo, true)

		self._isPlayingFill = true

		AnimationUtils.ResetAnimation(self._forecastDamageAnim)

		self._isPerforming = true

		self._forecastDamagedImg:DOLeftFillAmount(toFillAmount, 1, self._onFillAmountDamageFinish, self)
		self:_setFill(self._bloodImg, 0, toFillAmount)
	end

	self:_updateHpTxt(property)
end

function M:_updateHpTxt(property)
	self._bossHp.text = property:getHp() .. " / " .. property:getMaxHp()
end

function M:clearPerformance()
	if self._isPerforming then
		self._forecastDamagedImg:DOKill(false)

		local property = self._unit.property
		local toFillAmount = property:getHp() / property:getMaxHp()

		self:_setFill(self._bloodImg, 0, toFillAmount)
		self:_onFillAmountDamageFinish()
	end
end

function M:_onFillAmountDamageFinish()
	local property = self._unit.property
	local fillAmount = property:getHp() / property:getMaxHp()

	self._currentHpRate = fillAmount
	self._isPerforming = false
	self._isPlayingFill = false

	goutil.setActive(self._forecastDamageGo, false)
end

function M:destroy()
	self:_clearAnim()
end

return M
