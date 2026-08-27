local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local UINKeyExertionRewardItem = class("UINKeyExertionRewardItem", UINBaseItemWithCount)
local base = UINBaseItemWithCount

function UINKeyExertionRewardItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.baseItem = UINBaseItemWithCount.New()
  self.baseItem:Init(self.ui.uINBaseItemWithCount)
  self.baseItem:SetNotNeedAnyJump(false)
end

function UINKeyExertionRewardItem:InitKeyExertionRewardItem(itemCfg, itemNum, isAllPicked)
  self.baseItem:InitItemWithCount(itemCfg, itemNum)
  self.ui.isClear:SetActive(isAllPicked)
  self.ui.obj_ClearMask:SetActive(isAllPicked)
end

function UINKeyExertionRewardItem:OnDelete()
  self.baseItem:Delete()
  base.OnDelete(self)
end

return UINKeyExertionRewardItem
