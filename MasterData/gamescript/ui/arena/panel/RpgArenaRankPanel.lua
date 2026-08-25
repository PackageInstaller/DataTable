local RpgArenaRankPanel, Super = System.NewClass("RpgArenaRankPanel", UIBasePanel)
RpgArenaRankPanel.uiResCls = Popup_Arena_RankResource

function RpgArenaRankPanel:ctor()
  Super.ctor(self)
end

function RpgArenaRankPanel:OnBind(binder)
  self.binder = binder
  self:BindButton()
  self:SetLabel()
  binder:BindToCircularListView(self.ui.ScrollView_Arena_Rank_List, function()
    return DataCenter.rpgArenaData.ranks
  end, function(childBinder, item, index)
    childBinder:BindComponent(ArenaRankItem(item, DataCenter.rpgArenaData.ranks[index]))
  end)
end

function RpgArenaRankPanel:BindButton()
  local binder = self.binder
  binder:BindButtonClick(self.ui.Btn_Reward_Detail, System.fn(self, self.BtnRewardDetailClick))
  binder:BindButtonClick(self.ui.Btn_Confirm, System.fn(self, self.BtnConfirmClick))
end

function RpgArenaRankPanel:SetLabel()
  local binder = self.binder
  local rpgArenaData = DataCenter.rpgArenaData
  binder:SetText(self.ui.Text_Current_Rank, string.format(LT.Text("RPGJJC_Str_Ranking"), rpgArenaData.myRole.order))
  binder:SetText(self.ui.Text_Name, DataCenter.playerData.DRole.name)
  binder:SetText(self.ui.Text_Level_Count, DataCenter.playerData.DRole.level)
  binder:SetText(self.ui.Text_Power_Count, rpgArenaData.myRole.zl)
  binder:SetText(self.ui.Text_Max_Rank, string.format(LT.Text("RPGJJCRanking_Str_BestRanking"), tostring(rpgArenaData.myRole.historyOrder or 0)))
end

function RpgArenaRankPanel:BtnRewardDetailClick()
  UIManager.Instance:Reopen(Urls.RpgArenaAwardPanel)
end

function RpgArenaRankPanel:BtnConfirmClick()
  self:Close()
end

return RpgArenaRankPanel
