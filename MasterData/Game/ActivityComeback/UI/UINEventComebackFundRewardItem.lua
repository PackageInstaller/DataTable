local UINEventComebackFundRewardItem = class("UINEventComebackFundRewardItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")

function UINEventComebackFundRewardItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._item = UINBaseItemWithReceived.New()
  self._item:Init(self.ui.uINBaseItemWithReceived)
end

function UINEventComebackFundRewardItem:InitFundRewardItem(itemCfg, count)
  self._item:InitItemWithCount(itemCfg, count)
end

function UINEventComebackFundRewardItem:SetPickedUIActive(isPicked)
  self._item:SetPickedUIActive(isPicked)
end

function UINEventComebackFundRewardItem:SetRewardLockState(flag)
  self.ui.obj_lock:SetActive(flag)
end

function UINEventComebackFundRewardItem:OnDelete()
  base.OnDelete(self)
end

return UINEventComebackFundRewardItem
