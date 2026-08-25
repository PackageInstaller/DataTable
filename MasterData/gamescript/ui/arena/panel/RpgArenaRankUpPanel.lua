local RpgArenaRankUpPanel, Super = System.NewClass("RpgArenaRankUpPanel", UIBasePanel)
RpgArenaRankUpPanel.uiResCls = Popup_Arena_Level_AwardResource

function RpgArenaRankUpPanel:ctor(data)
  Super.ctor(self)
  self.viewData = data
end

function RpgArenaRankUpPanel:OnBind(binder)
  self.binder = binder
  binder:BindButtonClick(self.ui.Btn_Confirm, System.fn(self, self.OnOkClick))
  binder:SetText(self.ui.Text_Arena_Level, self.viewData.order)
  local changeCount = math.max(0, self.viewData.oldOrder - self.viewData.order)
  binder:SetText(self.ui.Text_Desc, string.format(LT.Text("RPGJJCRankingUp_Str_RankingUpTips"), changeCount))
  local items = self.viewData.items[1]
  binder:SetText(self.ui.Text_Award_Count, ItemNumUtils.GetStr(items.tid, items.num))
end

function RpgArenaRankUpPanel:OnOkClick()
  self:Close()
end

return RpgArenaRankUpPanel
