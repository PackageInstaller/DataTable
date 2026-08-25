local PvPOtherSelectInitCardPanel, Super = System.NewClass("PvPOtherSelectInitCardPanel", UIBasePanel)
PvPOtherSelectInitCardPanel.uiResCls = UI_Pvp_Popup_ReplacementResource

function PvPOtherSelectInitCardPanel:OnBind(binder)
  Super.OnBind(self, binder)
  self:SetRendered(false)
end

function PvPOtherSelectInitCardPanel:GetBattlePanel()
  do return UIManager.Instance.GetWindow, UIManager.Instance end
  return UIManager.Instance.GetWindow, UIManager.Instance, Urls.PvPBattleOppsiteMainPanel
end

return PvPOtherSelectInitCardPanel
