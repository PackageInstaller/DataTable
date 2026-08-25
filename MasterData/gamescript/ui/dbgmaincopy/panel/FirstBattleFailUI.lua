local FirstBattleFailUI, Super = System.NewClass("FirstBattleFailUI", UIBasePanel)
FirstBattleFailUI.uiResCls = UI_Dungeous_Popup_FailTipResource

function FirstBattleFailUI:ctor(params)
  Super.ctor(self)
end

function FirstBattleFailUI:OnBind(binder)
  binder:SetText(self.ui.Text_Tips, LT.Text("StrongerTitle"))
  binder:SetText(self.ui.Text_Desc, LT.Text("StrongerWay"))
  binder:SetText(self.ui.Text_Title, LT.Text("StrongerWayTitle"))
  binder:BindButtonClick(self.ui.UI_Common_Btn_Back1, System.fn(self, self.Close))
end

return FirstBattleFailUI
