_class("UISeasonStageDiffTips", UIController)
UISeasonStageDiffTips = UISeasonStageDiffTips

function UISeasonStageDiffTips:OnShow(uiParams)
  self._offset = self:GetUIComponent("RectTransform", "offset")
end

function UISeasonStageDiffTips:BgOnClick()
  self:CloseDialog()
end
