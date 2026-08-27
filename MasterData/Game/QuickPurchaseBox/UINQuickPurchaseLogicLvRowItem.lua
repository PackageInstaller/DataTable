local UINLogicPreviewRowBase = require("Game.CommonUI.LogicPreviewNode.UINLogicPreviewRowBase")
local UINQuickPurchaseLogicLvRowItem = class("UINQuickPurchaseLogicLvRowItem", UINLogicPreviewRowBase)
local base = UINLogicPreviewRowBase

function UINQuickPurchaseLogicLvRowItem:OnInit()
  base.OnInit(self)
end

function UINQuickPurchaseLogicLvRowItem:InitShopItemPriveInterval(isCur, interval, price)
  self.attrPool:HideAll()
  local attrItem = self.attrPool:GetOne()
  attrItem:InitAttrItem(tostring(interval), isCur)
  local attrItem = self.attrPool:GetOne()
  attrItem:InitAttrItem(tostring(price), isCur)
end

function UINQuickPurchaseLogicLvRowItem:OnDelete()
  base.OnDelete(self)
end

return UINQuickPurchaseLogicLvRowItem
