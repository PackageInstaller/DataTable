local RpgArenaRelationDetailPanel, Super = System.NewClass("RpgArenaRelationDetailPanel", UIBasePanel)
RpgArenaRelationDetailPanel.uiResCls = Popup_Arena_Relation_DetailResource

function RpgArenaRelationDetailPanel:ctor(data)
  Super.ctor(self)
  self.data = data
end

function RpgArenaRelationDetailPanel:OnBind(binder)
  self.binder = binder
  binder:BindComponent(ArenaRankItem(self.ui.Item_Player_List, self.data.my))
  binder:BindComponent(ArenaRankItem(self.ui.Item_Enemy_List, self.data.opponent))
  self:BindButton()
  self:SetLabel()
end

function RpgArenaRelationDetailPanel:BindButton()
  local binder = self.binder
  binder:BindButtonClick(self.ui.Btn_Confirm, System.fn(self, self.OnConfirmClick))
  binder:BindButtonClick(self.ui.Btn_Playback, System.fn(self, self.OnBtnPlayBackClick))
  binder:BindButtonClick(self.ui.Btn_Report, System.fn(self, self.OnBtnReportClick))
end

function RpgArenaRelationDetailPanel:SetLabel()
  local binder = self.binder
  if 1 == self.data.result then
    binder:SetActive(self.ui.Text_Enemy_Lose, true)
    binder:SetActive(self.ui.Text_Player_Win, true)
    binder:SetActive(self.ui.Text_Enemy_Win, false)
    binder:SetActive(self.ui.Text_Player_Lose, false)
  else
    binder:SetActive(self.ui.Text_Enemy_Lose, false)
    binder:SetActive(self.ui.Text_Player_Win, false)
    binder:SetActive(self.ui.Text_Enemy_Win, true)
    binder:SetActive(self.ui.Text_Player_Lose, true)
  end
end

function RpgArenaRelationDetailPanel:OnBtnReportClick()
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("PvpRequest", "OnShowDetailBattle", function(data)
    RpgArenaDataUtils.OpenArenaBattleStatisPanel(self.data, data.statistics)
  end, nil, self.data.time)
end

function RpgArenaRelationDetailPanel:OnBtnPlayBackClick()
  Alert.ShowStr("敬请期待~")
end

function RpgArenaRelationDetailPanel:OnConfirmClick()
  self:Close()
end

return RpgArenaRelationDetailPanel
