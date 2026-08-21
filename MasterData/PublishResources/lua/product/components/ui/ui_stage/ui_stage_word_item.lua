_class("UIStageWordItem", UICustomWidget)
UIStageWordItem = UIStageWordItem

function UIStageWordItem:OnShow()
  self._tex = self:GetUIComponent("UILocalizationText", "tex")
end

function UIStageWordItem:SetData(tex)
  self._tex:SetText(tex)
end
