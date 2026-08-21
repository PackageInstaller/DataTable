_class("UIThreeStarTips", UIController)
UIThreeStarTips = UIThreeStarTips

function UIThreeStarTips:OnShow(uiParams)
  self._offset = self:GetUIComponent("RectTransform", "offset")
end

function UIThreeStarTips:bgOnClick()
  self:CloseDialog()
end
