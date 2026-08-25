local CompPublicPopupFullTips, Super = NewViewComponent("CompPublicPopupFullTips")

function CompPublicPopupFullTips:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Common_Popup_Tips_FullResource(uiNode)
  self.data = data
end

function CompPublicPopupFullTips:OnEnterComponent()
  if self.data.textTitleCN then
    self:SetText(self.ui.Text_Title, LT.Text(self.data.textTitleCN))
  end
  if self.data.textTitleEN then
    self:SetText(self.ui.Text_Title_En, LT.Text(self.data.textTitleEN))
  end
end

function CompPublicPopupFullTips:OnExitComponent()
  Super.OnExitComponent(self)
end

return CompPublicPopupFullTips
