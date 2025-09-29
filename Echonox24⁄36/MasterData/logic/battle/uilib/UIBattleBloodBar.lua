-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/uilib/UIBattleBloodBar.lua

module("logic.battle.uilib.UIBattleBloodBar", package.seeall)

local M = class("UIBattleBloodBar")

kMinFill = 0.571
kMaxFill = 0.933

function M:ctor(mainGO)
	self.mainGO = mainGO

	self:buildUI()
end

function M:destroy()
	self:destroyUI()

	self.mainGO = nil
end

function M:buildUI()
	self._selfBloodGo = goutil.findChild(self.mainGO, "mask/xuetiao_lan")
	self._friendBloodGo = goutil.findChild(self.mainGO, "mask/xuetiao_huang")
	self._enemyBloodGo = goutil.findChild(self.mainGO, "mask/xuetiao_hong")
	self._forecastCureGo = goutil.findChild(self.mainGO, "mask/xuetiao_yujia")
	self._forecastDamageGo = goutil.findChild(self.mainGO, "mask/xuetiao_yukou")
	self._forecastDoubleDamageGo = goutil.findChild(self.mainGO, "mask/xuetiao_yukou_double")
	self._selfCircleBlood = self._selfBloodGo:GetComponent(typeof(SpaceX.UICircleBlood))
	self._friendCircleBlood = self._friendBloodGo:GetComponent(typeof(SpaceX.UICircleBlood))
	self._enemyCircleBlood = self._enemyBloodGo:GetComponent(typeof(SpaceX.UICircleBlood))
	self._forecastCureCircleBlood = self._forecastCureGo:GetComponent(typeof(SpaceX.UICircleBlood))
	self._forecastDamageCircleBlood = self._forecastDamageGo:GetComponent(typeof(SpaceX.UICircleBlood))
	self._forecastDoubleDamageCircleBlood = self._forecastDoubleDamageGo:GetComponent(typeof(SpaceX.UICircleBlood))
	self._forecastCureAnim = self._forecastCureGo:GetComponent(ComponentType.Animation)
	self._forecastDamageAnim = self._forecastDamageGo:GetComponent(ComponentType.Animation)
	self._forecastDoubleDamageAnim = self._forecastDoubleDamageGo:GetComponent(ComponentType.Animation)
end

function M:destroyUI()
	self:_clearAnim()
end

function M:setBlood(hpPercent)
	self._hpPercent = hpPercent

	self:clearForecast()
	self:_setBlood(hpPercent)
end

function M:setActiveBloodBar(relationType)
	if relationType == BattleEnum.CampRelation.SAME then
		self._activeCircleBlood = self._selfCircleBlood

		goutil.setActive(self._selfBloodGo, true)
		goutil.setActive(self._friendBloodGo, false)
		goutil.setActive(self._enemyBloodGo, false)
	elseif relationType == BattleEnum.CampRelation.FRIEND then
		self._activeCircleBlood = self._friendCircleBlood

		goutil.setActive(self._selfBloodGo, false)
		goutil.setActive(self._friendBloodGo, true)
		goutil.setActive(self._enemyBloodGo, false)
	elseif relationType == BattleEnum.CampRelation.ENEMY then
		self._activeCircleBlood = self._enemyCircleBlood

		goutil.setActive(self._selfBloodGo, false)
		goutil.setActive(self._friendBloodGo, false)
		goutil.setActive(self._enemyBloodGo, true)
	end
end

function M:forecast(hpPercent, forecastHpPercent, isDouble)
	hpPercent = hpPercent and hpPercent or self._hpPercent

	local isCure = hpPercent < forecastHpPercent

	if isCure then
		goutil.setActive(self._forecastCureGo, true)
		goutil.setActive(self._forecastDamageGo, false)
		goutil.setActive(self._forecastDoubleDamageGo, false)
		BattleSynAnimUtil.playAnimSyn(self._forecastCureAnim, "battle_xuetiao_loop")
		self:_setBlood(hpPercent)
		self:_setCircleBlood(self._forecastCureCircleBlood, hpPercent, forecastHpPercent)
	else
		goutil.setActive(self._forecastCureGo, false)
		goutil.setActive(self._forecastDamageGo, true)
		goutil.setActive(self._forecastDoubleDamageGo, isDouble)
		BattleSynAnimUtil.playAnimSyn(self._forecastDamageAnim, "battle_xuetiao_loop")
		self:_setBlood(forecastHpPercent)

		if isDouble then
			local halfHp = (hpPercent - forecastHpPercent) / 2

			self:_setCircleBlood(self._forecastDamageCircleBlood, hpPercent - halfHp, hpPercent)
			self:_setCircleBlood(self._forecastDoubleDamageCircleBlood, forecastHpPercent, forecastHpPercent + halfHp)
			BattleSynAnimUtil.playAnimSyn(self._forecastDoubleDamageAnim, "battle_xuetiao_loop1")
		else
			self:_setCircleBlood(self._forecastDamageCircleBlood, forecastHpPercent, hpPercent)
		end
	end
end

function M:clearForecast()
	goutil.setActive(self._forecastCureGo, false)
	goutil.setActive(self._forecastDamageGo, false)
	goutil.setActive(self._forecastDoubleDamageGo, false)
	self:_clearAnim()
end

function M:_clearAnim()
	BattleSynAnimUtil.stopAnim(self._forecastCureAnim)
	BattleSynAnimUtil.stopAnim(self._forecastDamageAnim)
	BattleSynAnimUtil.stopAnim(self._forecastDoubleDamageAnim)
end

function M:_setBlood(hpPercent)
	if self._activeCircleBlood then
		self:_setCircleBlood(self._activeCircleBlood, 0, hpPercent)
	end
end

function M:_getFillNumByPercent(p)
	return kMinFill + (kMaxFill - kMinFill) * p
end

function M:_setCircleBlood(circleBlood, p1, p2)
	circleBlood:SetFromFillAndToFill(self:_getFillNumByPercent(p1), self:_getFillNumByPercent(p2))
end

function M:SetPlaySpeed()
	return
end

function M:setPerformanceHp(hp)
	self._performanceHp = hp

	self:_setPerformanceHp(hp)
end

function M:_setPerformanceHp(hp)
	self._showPerformanceHp = hp

	if self._showPerformanceHp <= self._hpPercent then
		goutil.setActive(self._forecastDamageGo, false)
	else
		goutil.setActive(self._forecastDamageGo, true)
		self:_setCircleBlood(self._forecastDamageCircleBlood, self._hpPercent, self._showPerformanceHp)
	end
end

function M:playBloodGradualChange(bloodPercent, time)
	if self._performanceHp == bloodPercent then
		self:_setPerformanceHp(self._showPerformanceHp)

		return
	end

	self._performanceHp = bloodPercent

	DG.Tweening.DOTween.Kill(self.mainGO, false)

	local lastBloodPercent = self._showPerformanceHp
	local tweenTime = time and time or 0.3

	self._tweener = DoTweenUtil.To(0, 1, tweenTime, function(progress)
		self:_setPerformanceHp(lastBloodPercent + progress * (bloodPercent - lastBloodPercent))
	end)

	self._tweener:OnComplete(function()
		self:_onCompleteTweener()
	end)
	self._tweener:SetTarget(self.mainGO)
end

function M:_onCompleteTweener()
	return
end

return M
