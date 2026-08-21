_class("UISimpleHauteCoutureDrawTitle", UICustomWidget)
UISimpleHauteCoutureDrawTitle = UISimpleHauteCoutureDrawTitle

function UISimpleHauteCoutureDrawTitle:OnShow()
  self._endTimeTxt = self:GetUIComponent("UILocalizationText", "endTimeTxt")
  self._animObj = self:GetGameObject("anim")
end

function UISimpleHauteCoutureDrawTitle:SetTimeText(timeText)
  self._endTimeTxt:SetText(timeText)
end

function UISimpleHauteCoutureDrawTitle:PlayInAnimation()
  self._animObj:SetActive(false)
  self._animObj:SetActive(true)
end
