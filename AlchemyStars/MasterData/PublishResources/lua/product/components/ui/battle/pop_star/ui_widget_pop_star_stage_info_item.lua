_class("UIWidgetPopStarStageInfoItem", UICustomWidget)
UIWidgetPopStarStageInfoItem = UIWidgetPopStarStageInfoItem

function UIWidgetPopStarStageInfoItem:OnShow()
  self._txtDesc = self:GetUIComponent("UILocalizationText", "txtDesc")
end

function UIWidgetPopStarStageInfoItem:OnHide()
end

function UIWidgetPopStarStageInfoItem:Init(desc)
  self._txtDesc:SetText(StringTable.Get(desc))
end
