local ArenaRankItem, Super = System.NewComponent("ArenaRankItem")

function ArenaRankItem:ctor(uiNode, itemData)
  Super.ctor(self)
  self.ui = Item_Arena_Rank_ListResource(uiNode)
  self.itemData = itemData
  self.iconItem = {}
end

function ArenaRankItem:OnBind(binder)
  self.binder = binder
  for i = 1, 6 do
    local obj = self.ui["Awaker_" .. i]
    self.iconItem[i] = binder:BindComponent(RpgTeamRoleIconItem(obj))
  end
  self:UpdateView()
end

function ArenaRankItem:UpdateView()
  local data = self.itemData
  if nil == data then
    return
  end
  local binder = self.binder
  binder:SetText(self.ui.Text_Name, data.name)
  binder:SetText(self.ui.Text_Level_Count, data.lv)
  binder:SetText(self.ui.Text_Power_Count, data.zl)
  if data.order then
    binder:SetText(self.ui.Text_Ranking_Number, string.format(LT.Text("RPGJJC_Str_Ranking"), data.order))
  else
    binder:SetText(self.ui.Text_Ranking_Number, "")
  end
  for i, v in ipairs(data.team) do
    self.iconItem[i].ui.uiNode:SetActive(true)
    self.iconItem[i]:ResetData({
      configId = v.roleId,
      lv = v.lv,
      star = v.star
    })
  end
  for i = #data.team + 1, 6 do
    self.iconItem[i].ui.uiNode:SetActive(false)
  end
end

function ArenaRankItem:ResetData(data)
  self.itemData = data
  self:UpdateView()
end

function ArenaRankItem:OnUnbind()
  self.iconItem = nil
  self.itemData = nil
end

return ArenaRankItem
