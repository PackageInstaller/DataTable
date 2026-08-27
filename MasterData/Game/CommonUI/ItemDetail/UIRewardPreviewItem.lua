local UIRewardPreviewItem = class("UIRewardPreviewItem", UIBaseNode)
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")

function UIRewardPreviewItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.baseItem = UINBaseItemWithCount.New()
  self.baseItem:Init(self.ui.UINBaseItemWithCount)
end

function UIRewardPreviewItem:InitItemWithCount(itemCfg, count, clickEvent, wareHouseNum, clickExtrEvent, isHideLoopFx)
  self.baseItem:InitItemWithCount(itemCfg, count, clickEvent, wareHouseNum, clickExtrEvent, isHideLoopFx)
end

function UIRewardPreviewItem:SetHasFlagObjActive(bValue)
  self.baseItem:SetHasFlagObjActive(bValue)
end

return UIRewardPreviewItem
