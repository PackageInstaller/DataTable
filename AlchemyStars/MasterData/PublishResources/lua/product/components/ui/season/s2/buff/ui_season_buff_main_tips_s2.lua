_class("UISeasonBuffMainTipsS2", UIController)
UISeasonBuffMainTipsS2 = UISeasonBuffMainTipsS2

function UISeasonBuffMainTipsS2:OnShow(uiParams)
  self._offset = self:GetUIComponent("RectTransform", "offset")
  self.contentText = self:GetUIComponent("UILocalizationText", "Content")
end

function UISeasonBuffMainTipsS2:BgOnClick()
  self:CloseDialog()
end
