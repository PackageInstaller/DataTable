local PvpPasswordEnterView, _ = NewClass("PvpPasswordEnterView", BaseView)
PvpPasswordEnterView.uiResCls = UI_Pvp_Popup_FightResource

function PvpPasswordEnterView:OnBuildView()
end

function PvpPasswordEnterView:OnEnterView()
end

function PvpPasswordEnterView:OnEnterViewFinished()
end

function PvpPasswordEnterView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Create, System.fn(self, self._OnBtnCreate))
  self:AddButtonClickListener(self.ui.Btn_Joinin, System.fn(self, self._OnBtnJoinin))
  self:AddButtonClickListener(self.ui.Btn_Mask, System.fn(self, self.Close))
  self:AddButtonClickListener(self.ui.Btn_Rule, System.fn(self, self._OnBtnRule))
end

function PvpPasswordEnterView:_OnBtnCreate()
  UIManager.Instance:Reopen(Urls.PvpPasswordCreateView)
  self:Close()
end

function PvpPasswordEnterView:_OnBtnJoinin()
  UIManager.Instance:Reopen(Urls.PvpPasswordJoinView)
  self:Close()
end

function PvpPasswordEnterView:_OnBtnRule()
  UIManager.Instance:Reopen(Urls.AlertToolTipsPanel, {
    title = "",
    desc = LT.Text("PasswordBattleRuleTips")
  }, self.ui.Btn_Rule)
end

return PvpPasswordEnterView
