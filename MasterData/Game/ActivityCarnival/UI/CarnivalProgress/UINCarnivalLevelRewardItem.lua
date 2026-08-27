local base = UIBaseNode
local UINCarnivalLevelRewardItem = class("UINCarnivalLevelRewardItem", base)
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")

function UINCarnivalLevelRewardItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.baseItem = UINBaseItemWithReceived.New()
  self.baseItem:Init(self.ui.uINBaseItemWithReceived)
end

function UINCarnivalLevelRewardItem:InitCarnivalLevelRewardItem(itemId, itemNum, clickEvent, isPicked, pickable)
  local itemCfg = ConfigData.item[itemId]
  if itemCfg == nil then
    error("Cant get itemCfg, id = " .. tostring(itemId))
    return
  end
  self.ui.img_Black:SetActive(pickable)
  self.baseItem:InitItemWithCount(itemCfg, itemNum, clickEvent, isPicked)
  self.baseItem:SetNotNeedAnyJump(true)
end

function UINCarnivalLevelRewardItem:OnDelete()
  self.baseItem:Delete()
  base.OnDelete(self)
end

return UINCarnivalLevelRewardItem
