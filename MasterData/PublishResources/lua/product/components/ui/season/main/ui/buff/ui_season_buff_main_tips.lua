_class("UISeasonBuffMainTips", UIController)
UISeasonBuffMainTips = UISeasonBuffMainTips

function UISeasonBuffMainTips:OnShow(uiParams)
  self._offset = self:GetUIComponent("RectTransform", "offset")
  self.contentText = self:GetUIComponent("UILocalizationText", "Content")
end

function UISeasonBuffMainTips:BgOnClick()
  self:CloseDialog()
end
