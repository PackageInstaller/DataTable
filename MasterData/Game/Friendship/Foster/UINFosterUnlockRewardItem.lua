local UINFosterUnlockRewardItem = class("UINFosterUnlockRewardItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItem = require("Game.CommonUI.Item.UINBaseItem")

function UINFosterUnlockRewardItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINFosterUnlockRewardItem:InitItem(itemId, num)
  local itemCfg = ConfigData.item[itemId]
  self.ui.tex_TotalCount.text = tostring(num)
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(itemCfg.name)
  local baseItem = UINBaseItem.New()
  baseItem:Init(self.ui.obj_BaseItem)
  baseItem:InitBaseItem(itemCfg, nil)
end

function UINFosterUnlockRewardItem:OnDelete()
  base.OnDelete(self)
end

return UINFosterUnlockRewardItem
