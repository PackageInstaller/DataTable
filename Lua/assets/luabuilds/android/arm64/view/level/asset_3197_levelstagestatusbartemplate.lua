local LevelStageStatusBarTemplate = class("LevelStageStatusBarTemplate", BaseSubPanel)

function LevelStageStatusBarTemplate:OnInit()
	self.anim = self._go:GetComponent(typeof(Animator))
	self.animEvent = self._go:GetComponent(typeof(DftAniEvent))

	return
end

function LevelStageStatusBarTemplate:OnShow()
	pg.UIMgr.GetInstance():OverlayPanel(self._tf)
	self.animEvent:SetEndEvent(function()
		self:Hide()

		return
	end)

	return
end

function LevelStageStatusBarTemplate:OnHide()
	self.animEvent:SetEndEvent(nil)
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

function LevelStageStatusBarTemplate:PlayAnim()
	self:Hide()
	self:Show()

	return
end

return LevelStageStatusBarTemplate
