local UINFosterUpgradeCostItem = class("UINFosterUpgradeCostItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItem = require("Game.CommonUI.Item.UINBaseItem")

function UINFosterUpgradeCostItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINFosterUpgradeCostItem:InitCostItem(itemId, num)
  self.requireNum = num
  self.itemId = itemId
  self.itemNum = PlayerDataCenter:GetItemCount(self.itemId)
  local itemCfg = ConfigData.item[itemId]
  if self:IsHaveEnoughItem() then
    self.ui.tex_TotalCount:SetIndex(1, tostring(num), tostring(self.itemNum))
  else
    self.ui.tex_TotalCount:SetIndex(2, tostring(num), tostring(self.itemNum))
  end
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(itemCfg.name)
  local item = UINBaseItem.New()
  item:Init(self.ui.obj_BaseItem)
  item:InitBaseItem(itemCfg)
end

function UINFosterUpgradeCostItem:IsHaveEnoughItem()
  if self.itemNum >= self.requireNum then
    return true
  end
  return false
end

function UINFosterUpgradeCostItem:OnDelete()
  base.OnDelete(self)
end

return UINFosterUpgradeCostItem
