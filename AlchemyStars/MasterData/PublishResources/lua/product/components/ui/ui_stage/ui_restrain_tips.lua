_class("UIRestrainTips", UIController)
UIRestrainTips = UIRestrainTips

function UIRestrainTips:OnShow(uiParams)
  self._offset = self:GetUIComponent("RectTransform", "offset")
end

function UIRestrainTips:bgOnClick()
  self:CloseDialog()
end
