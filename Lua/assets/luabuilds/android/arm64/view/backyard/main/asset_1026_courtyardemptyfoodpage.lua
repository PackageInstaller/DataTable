local CourtYardEmptyFoodPage = class("CourtYardEmptyFoodPage", import("...base.BaseSubView"))

function CourtYardEmptyFoodPage:getUIName()
	return "CourtYardEmptyFoodUI"
end

function CourtYardEmptyFoodPage:OnLoaded()
	self.confirmBtn = self._tf:Find("frame/ok_btn")
	self.cancelBtn = self._tf:Find("frame/cancel_btn")

	setButtonText(self.confirmBtn, i18n("text_nofood_yes"))
	setButtonText(self.cancelBtn, i18n("text_nofood_no"))

	self.frame = self._tf:Find("frame")

	return
end

function CourtYardEmptyFoodPage:OnInit()
	onButton(self, self.confirmBtn, function()
		self:emit(CourtYardMediator.GO_GRANARY)
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.cancelBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function CourtYardEmptyFoodPage:Flush()
	self:Show()

	return
end

function CourtYardEmptyFoodPage:Show()
	CourtYardEmptyFoodPage.super.Show(self)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	LeanTween.cancel(go(self.frame))

	self.frame.localScale = Vector3(0, 0, 0)

	LeanTween.scale(self.frame, Vector3(1, 1, 1), 0.3):setEase(LeanTweenType.easeOutBack)

	return
end

function CourtYardEmptyFoodPage:Hide()
	LeanTween.cancel(go(self.frame))
	CourtYardEmptyFoodPage.super.Hide(self)
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)

	return
end

function CourtYardEmptyFoodPage:OnDestroy()
	self:Hide()

	return
end

return CourtYardEmptyFoodPage
