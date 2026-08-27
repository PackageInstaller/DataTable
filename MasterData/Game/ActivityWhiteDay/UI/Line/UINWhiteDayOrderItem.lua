local UINWhiteDayOrderItem = class("UINWhiteDayOrderItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")

function UINWhiteDayOrderItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Produce, self, self.OnClickStartProduce)
  self.baseItemWithCount = UINBaseItemWithCount.New()
  self.baseItemWithCount:Init(self.ui.uINBaseItemWithCount)
end

function UINWhiteDayOrderItem:InitWDOrderItem(orderData, onClickkStartProduce)
  self.orderData = orderData
  self.onClickkStartProduce = onClickkStartProduce
  self.AWDData = orderData:GetWDAWDData()
  self:RefreshWDOrderItem()
end

function UINWhiteDayOrderItem:RefreshWDOrderItem()
  local randomId, _ = self.AWDData:GetWDRandomPhotoItemIdAndNum()
  local exchangeId, _ = self.AWDData:GetWDExchangePhotoItemIdAndNum()
  local isLimit = self.AWDData:GetWhiteDayPhotoConvertItemIsAboveLimit()
  self.ui.tex_Name.text = self.orderData:GetWDLineOrderName()
  local costTime = self.orderData:GetWDLineOrderCostTime()
  self.ui.tex_Time.text = TimeUtil:TimestampToTime(costTime)
  self.ui.tex_Experience.text = tostring(self.orderData:GetWDLineOrderExp())
  local totalTime = self.orderData:GetWDLineOrderTotalUseTime()
  local usedTime = self.orderData:GetWDLineOrderUsedTime()
  self.ui.tex_Count:SetIndex(0, tostring(usedTime), tostring(totalTime))
  local itemId = self.orderData:GetWDOrderItemId()
  local orderItemCfg, itemNum = self.orderData:GetWDOrderItemIdAndNum()
  self.baseItemWithCount:InitItemWithCount(orderItemCfg, itemNum)
  if randomId == itemId or exchangeId == itemId then
    self.baseItemWithCount:SetItemRecycyleTag(isLimit)
  end
end

function UINWhiteDayOrderItem:OnClickStartProduce()
  if self.onClickkStartProduce ~= nil then
    self.onClickkStartProduce(self.orderData)
  end
end

function UINWhiteDayOrderItem:OnDelete()
  base.OnDelete(self)
end

return UINWhiteDayOrderItem
