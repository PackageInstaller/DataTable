local ArenaOpponentItem, Super = System.NewComponent("ArenaOpponentItem")

function ArenaOpponentItem:ctor(uiNode, itemData, callback)
  Super.ctor(self)
  self.ui = Item_Arena_Rank_ListResource(uiNode)
  self.itemData = itemData
  self.clickCallback = callback
end

function ArenaOpponentItem:OnBind(binder)
  self.binder = binder
  self:BindButton()
  self:SetLabel()
  self:UpdateTeam()
end

function ArenaOpponentItem:SetLabel()
  local binder = self.binder
  local data = self.itemData
  binder:SetText(self.ui.Text_Name, data.name)
  binder:SetText(self.ui.Text_Level_Count, data.lv)
  binder:SetText(self.ui.Text_Power_Count, data.zl)
  binder:SetText(self.ui.Text_Ranking_Number, string.format(LT.Text("RPGJJC_Str_Ranking"), tostring(data.order)))
end

function ArenaOpponentItem:BindButton()
  self.binder:BindButtonClick(self.ui.Btn_Click, function()
    if self.clickCallback then
      self.clickCallback(self.itemData)
    end
  end)
end

function ArenaOpponentItem:UpdateTeam()
  local team = self.itemData.team
  local member = 0
  for _, v in ipairs(team) do
    if 0 ~= v.roleId then
      member = member + 1
      local data = {
        configId = v.roleId,
        lv = v.lv,
        star = v.star
      }
      local obj = self.ui["Awaker_" .. member]
      if obj then
        obj:SetActive(true)
        self.binder:BindComponent(RpgTeamRoleIconItem(obj, data))
      end
    end
  end
  for i = member + 1, 6 do
    local obj = self.ui["Awaker_" .. i]
    obj:SetActive(false)
  end
end

return ArenaOpponentItem
