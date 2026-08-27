local UINItemWithCost = class("UINItemWithCost", UIBaseNode)
local base = UIBaseNode
local UINBaseItem = require("Game.CommonUI.Item.UINBaseItem")

function UINItemWithCost:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.baseItem = UINBaseItem.New()
  self.baseItem:Init(self.ui.uINBaseItem)
end

function UINItemWithCost:InitItemWithCost(itemCfg, costNum, containNum, clickFunc)
  self.baseItem:InitBaseItem(itemCfg, clickFunc)
  self.itemCfg = itemCfg
  self.costNum = costNum
  self:RefreshItemWithCost(containNum)
end

function UINItemWithCost:RefreshItemWithCost(containNum)
  if containNum == nil then
    containNum = PlayerDataCenter:GetItemCount(self.itemCfg.id)
  end
  local enough = containNum >= self.costNum
  self.ui.tex_ConsumeCount:SetIndex(enough and 0 or 1, tostring(self.costNum), tostring(containNum))
end

function UINItemWithCost:OnDelete()
  self.baseItem:Delete()
  base.OnDelete(self)
end

return UINItemWithCost
