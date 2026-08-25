local ArenaHistoryCombatItem, Super = System.NewComponent("ArenaHistoryCombatItem")

function ArenaHistoryCombatItem:ctor(uiNode, data)
  Super.ctor(self)
  self.ui = Item_Arena_Relation_TipResource(uiNode)
  self.itemData = data
end

function ArenaHistoryCombatItem:OnBind(binder)
  self.binder = binder
  self:SetLabel()
  self:BindButton()
end

function ArenaHistoryCombatItem:SetLabel()
  local binder = self.binder
  local data = self.itemData
  self.ui.Text_Win:SetActive(1 == data.result)
  self.ui.Text_Lose:SetActive(1 ~= data.result)
  binder:SetText(self.ui.Text_Name, data.opponent.name)
  binder:SetText(self.ui.Text_Level_Count, data.opponent.lv)
  binder:SetText(self.ui.Text_Power_Count, data.opponent.zl)
  local time = TimeUtils.GetServerTime()
  local diff = time - data.time
  local str
  if diff > 86400 then
    diff = math.floor(diff / 86400)
    str = string.format(LT.Text("RPGJJCHistory_Str_BattleTimeHour"), diff)
  elseif diff > 3600 then
    diff = math.floor(diff / 3600)
    str = string.format(LT.Text("RPGJJCHistory_Str_BattleTimeDay"), diff)
  elseif diff > 60 then
    diff = math.floor(diff / 60)
    str = string.format(LT.Text("RPGJJCHistory_Str_BattleTimeMinute"), diff)
  else
    diff = 1
    str = string.format(LT.Text("RPGJJCHistory_Str_BattleTimeMinute"), diff)
  end
  binder:SetText(self.ui.Text_Time, str)
end

function ArenaHistoryCombatItem:BindButton()
  self.binder:BindButtonClick(self.ui.Btn_Detail, System.fn(self, self.OnDetailClick))
end

function ArenaHistoryCombatItem:OnDetailClick()
  Logger.Info("详情")
  UIManager.Instance:Reopen(Urls.RpgArenaHistoryDetailPanel, self.itemData)
end

return ArenaHistoryCombatItem
