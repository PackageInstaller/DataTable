local UINCmUseGiftItem = class("UINCmUseGiftItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")

function UINCmUseGiftItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_check, self, self._OnClickShowInfo)
  self.baseItem = UINBaseItemWithCount.New()
  self.baseItem:Init(self.ui.uINBaseItemWithCount)
end

function UINCmUseGiftItem:InitCmUseGiftItem(itemCfg, count, clickEvent)
  self.itemCfg = itemCfg
  self.count = count
  self.baseItem:InitItemWithCount(itemCfg, count, clickEvent)
end

function UINCmUseGiftItem:SetHasFlagObjActive(bValue)
  self.baseItem:SetHasFlagObjActive(bValue)
end

function UINCmUseGiftItem:_OnClickShowInfo()
  UIManager:ShowWindowAsync(UIWindowTypeID.GlobalItemDetail, function(window)
    window:SetNotNeedAnyJump(true)
    window:InitCommonItemDetail(self.itemCfg)
  end)
end

function UINCmUseGiftItem:OnDelete()
  self.baseItem:Delete()
  base.OnDelete(self)
end

return UINCmUseGiftItem
