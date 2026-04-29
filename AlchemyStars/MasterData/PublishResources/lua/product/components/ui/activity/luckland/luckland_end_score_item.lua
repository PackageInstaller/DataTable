_class("UILuckLandEndScoreItem", UICustomWidget)
UILuckLandEndScoreItem = UILuckLandEndScoreItem

function UILuckLandEndScoreItem:OnShow(uiParams)
  self:_InitWidget()
end

function UILuckLandEndScoreItem:_InitWidget()
  self._desc = self:GetUIComponent("UILocalizationText", "Desc")
  self._num = self:GetUIComponent("UILocalizationText", "Num")
end

function UILuckLandEndScoreItem:SetData(str, score)
  self._desc:SetText(StringTable.Get(str))
  self._num:SetText(score)
end
