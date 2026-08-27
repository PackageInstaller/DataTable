local UINHeroSkillUpgradeCostItem = class("UINHeroSkillUpgradeCostItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItem = require("Game.CommonUI.Item.UINBaseItem")

function UINHeroSkillUpgradeCostItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.extrBaseItem = UINBaseItem.New()
  self.extrBaseItem:Init(self.ui.obj_uINBaseItem)
end

function UINHeroSkillUpgradeCostItem:InitCostItem(itemId, num)
  local totalExtrItemNum = PlayerDataCenter:GetItemCount(itemId)
  local itemCfg = ConfigData.item[itemId]
  if itemCfg == nil then
    error("extr itemCfg error id=" .. tostring(itemId))
  else
    self.extrBaseItem:InitBaseItem(itemCfg)
  end
  if num <= totalExtrItemNum then
    self.ui.tex_ExtrCount:SetIndex(0, tostring(num), tostring(totalExtrItemNum))
  else
    self.ui.tex_ExtrCount:SetIndex(2, tostring(num), tostring(totalExtrItemNum))
  end
end

function UINHeroSkillUpgradeCostItem:OnDelete()
  base.OnDelete(self)
end

return UINHeroSkillUpgradeCostItem
