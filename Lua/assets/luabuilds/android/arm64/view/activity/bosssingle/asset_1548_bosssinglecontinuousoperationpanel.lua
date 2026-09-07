local BossSingleContinuousOperationPanel = class("BossSingleContinuousOperationPanel", import("view.base.BaseUI"))

function BossSingleContinuousOperationPanel:getUIName()
	return "BossSingleContinuousOperationUI"
end

function BossSingleContinuousOperationPanel:init()
	self.btnOn = self._tf:Find("Panel/On")
	self.btnOff = self._tf:Find("Panel/Off")
	self.slider = self._tf:Find("Panel/Slider")
	self._ratioFitter = GetComponent(self._tf, typeof(AspectRatioFitter))

	setText(self.btnOff:Find("common/Text"), i18n("multiple_sorties_stopped"))

	return
end

function BossSingleContinuousOperationPanel:UpdateAutoFightMark()
	setActive(self.btnOn, self.contextData.autoFlag)
	setActive(self.btnOff, not self.contextData.autoFlag)

	return
end

function BossSingleContinuousOperationPanel:didEnter()
	self.contextData.autoFlag = defaultValue(self.contextData.autoFlag, true)

	onButton(self, self.btnOn, function()
		self.contextData.autoFlag = false

		self:UpdateAutoFightMark()
		pg.TipsMgr.GetInstance():ShowTips(i18n("multiple_sorties_stop_tip"))
		self:emit(BattleMediator.HIDE_ALL_BUTTONS, true)

		return
	end, SFX_PANEL)
	onButton(self, self.btnOff, function()
		self.contextData.autoFlag = true

		self:UpdateAutoFightMark()
		pg.TipsMgr.GetInstance():ShowTips(i18n("multiple_sorties_resume_tip"))
		self:emit(BattleMediator.HIDE_ALL_BUTTONS, false)

		return
	end, SFX_PANEL)

	self._ratioFitter.aspectRatio = pg.CameraFixMgr.GetInstance():GetBattleUIRatio()

	self:UpdateAutoFightMark()
	self:UpdateBattleTimes()
	pg.UIMgr.GetInstance():OverlayPanel(self._tf)

	return
end

function BossSingleContinuousOperationPanel:UpdateBattleTimes()
	setText(self.btnOn:Find("Text"), self.contextData.totalBattleTimes - self.contextData.continuousBattleTimes + 1 .. "/" .. self.contextData.totalBattleTimes)
	setActive(self.slider, false)
	setActive(self.btnOff:Find("small"), true)
	setActive(self.btnOff:Find("common"), false)

	return
end

function BossSingleContinuousOperationPanel:OnEnterBattleResult()
	setActive(self.btnOff:Find("small"), false)
	setActive(self.btnOff:Find("common"), true)

	return
end

function BossSingleContinuousOperationPanel:AnimatingSlider()
	setActive(self.slider, true)
	self:managedTween(LeanTween.value, function()
		self:emit(BossSingleContinuousOperationMediator.ON_REENTER)

		return
	end, go(self.slider), 1, 0, 5):setOnUpdate(System.Action_float(function(arg_11_0)
		setSlider(self.slider, 0, 1, arg_11_0)

		return
	end))

	return
end

function BossSingleContinuousOperationPanel:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

function BossSingleContinuousOperationPanel:onBackPressed()
	self:emit(GAME.PAUSE_BATTLE)

	return
end

return BossSingleContinuousOperationPanel
