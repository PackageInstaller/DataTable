local BossRushPassedCombatLoadLayer = class("BossRushPassedCombatLoadLayer", import(".BossRushPassedLayer"))

BossRushPassedCombatLoadLayer.GROW_TIME = 0.55

function BossRushPassedCombatLoadLayer:getUIName()
	return "BossRushPassedUI"
end

function BossRushPassedCombatLoadLayer:didEnter()
	self.tweenObjs = {}

	pg.UIMgr.GetInstance():OverlayPanel(self._tf)
	self:updateSlider(self.curIndex)
	self:initSliderArea(self.curIndex)

	self._tf:GetComponent("Animator").enabled = false

	self:combatPreload()

	return
end

function BossRushPassedCombatLoadLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	for iter_3_0, iter_3_1 in ipairs(self.tweenObjs) do
		LeanTween.cancel(iter_3_1)
	end

	self.tweenObjs = {}

	return
end

function BossRushPassedCombatLoadLayer:onBackPressed()
	return
end

function BossRushPassedCombatLoadLayer:initData()
	self.curIndex = self.contextData.curIndex

	return
end

function BossRushPassedCombatLoadLayer:combatPreload()
	PoolMgr.GetInstance():DestroyAllSprite()

	self._loadObs = {}

	ys.Battle.BattleFXPool.GetInstance():Init()

	local var_6_0 = ys.Battle.BattleResourceManager.GetInstance()

	var_6_0:Init()

	local var_6_1, var_6_2 = CombatLoadUI.GetTotalResourceList(self.contextData)

	for iter_6_0, iter_6_1 in ipairs(var_6_1) do
		var_6_0:AddPreloadResource(iter_6_1)
	end

	for iter_6_2, iter_6_3 in ipairs(var_6_2) do
		var_6_0:AddPreloadCV(iter_6_3)
	end

	local var_6_3 = 0

	setActive(pg.UIMgr.GetInstance():GetMainCamera(), true)

	var_6_3 = var_6_0:StartPreload(function()
		self:updateSlider(self.curIndex + 1)
		self:emit(ChallengePassedCombatLoadMediator.FINISH, self._loadObs)

		return
	end, function(arg_8_0)
		self:moveSlider(var_6_3 == 0 and 0 or arg_8_0 / var_6_3)

		return
	end)

	return
end

function BossRushPassedCombatLoadLayer:initSliderArea()
	local var_9_0 = self.curIndex

	if self.contextData.maxIndex < self.curIndex then
		var_9_0 = var_9_0 % self.contextData.maxIndex == 0 and self.contextData.maxIndex or var_9_0 % self.contextData.maxIndex
	end

	self.curpercent = (var_9_0 - 1) * (1 / (self.contextData.maxIndex - 1))
	self.nextprecent = var_9_0 * (1 / (self.contextData.maxIndex - 1))
	self.deltaPercent = self.nextprecent - self.curpercent

	return
end

function BossRushPassedCombatLoadLayer:moveSlider(arg_10_1)
	self.sliderSC.value = self.curpercent + self.deltaPercent * arg_10_1

	return
end

return BossRushPassedCombatLoadLayer
