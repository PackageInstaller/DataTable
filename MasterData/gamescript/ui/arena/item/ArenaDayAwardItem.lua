local ArenaDayAwardItem, Super = System.NewComponent("ArenaDayAwardItem")

function ArenaDayAwardItem:ctor(uiNode, data)
  Super.ctor(self)
  self.ui = Item_Day_AwardResource(uiNode)
  self.itemData = data
end

function ArenaDayAwardItem:OnBind(binder)
  self.binder = binder
  self:SetLabel()
end

function ArenaDayAwardItem:SetLabel()
  local binder = self.binder
  binder:SetText(self.ui.Text_Name, self.itemData.title)
  binder:SetText(self.ui.Text_Desc, self.itemData.desc)
end

return ArenaDayAwardItem
