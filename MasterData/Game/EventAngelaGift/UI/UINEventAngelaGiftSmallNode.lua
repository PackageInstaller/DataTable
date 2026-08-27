local UINEventAngelaGiftSmallNode = class("UINEventAngelaGiftSmallNode", UIBaseNode)
local base = UIBaseNode
local ShopEnum = require("Game.Shop.ShopEnum")
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")
local CS_MessageCommon = CS.MessageCommon
UINEventAngelaGiftSmallNode.eGiftState = {
  Picked = 0,
  CanBuy = 1,
  Locked = 2
}

function UINEventAngelaGiftSmallNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_buy, self, self.OnClickBtnBuy)
  self._rewardItemPool = UIItemPool.New(UINBaseItemWithReceived, self.ui.obj_rewardItem)
  self.ui.obj_rewardItem:SetActive(false)
end

function UINEventAngelaGiftSmallNode:InitAngelaGiftNode(giftInfo, buyCallback)
  self._giftInfo = giftInfo
  self._buyCallback = buyCallback
  local payId = giftInfo.defaultCfg.payId
  local payCtrl = ControllerManager:GetController(ControllerTypeId.Pay)
  local _, priceNum = payCtrl:GetPayPriceShow(payId)
  local priceUnit = payCtrl:GetPayShowUnitStr()
  self.ui.textItem_price:SetIndex(0, tostring(priceUnit), tostring(priceNum))
  local groupCfg = giftInfo.groupCfg
  if groupCfg.tagType == ShopEnum.ePayGiftTag.Discount then
    self.ui.obj_discount:SetActive(true)
    if Consts.GameChannelType.IsInland() then
      self.ui.textItem_discount:SetIndex(1, tostring(10 - groupCfg.tagValue / 10))
    else
      self.ui.textItem_discount:SetIndex(0, tostring(groupCfg.tagValue))
    end
  else
    self.ui.obj_discount:SetActive(false)
  end
  self.currentState = UINEventAngelaGiftSmallNode.eGiftState.Locked
  self.rewardIds = self._giftInfo.defaultCfg.awardIds
  self.rewardCounts = self._giftInfo.defaultCfg.awardCounts
  self:_RefreshAngelaGiftNode()
end

function UINEventAngelaGiftSmallNode:OnClickBtnBuy()
  if self._giftInfo == nil then
    return
  end
  if not self._giftInfo:IsUnlock() then
    CS_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(7208))
    return
  end
  local giftCtrl = ControllerManager:GetController(ControllerTypeId.PayGift, true)
  giftCtrl:SendBuyGifit(self._giftInfo.defaultCfg, nil, function()
    if self._buyCallback ~= nil then
      self._buyCallback()
    end
  end)
end

function UINEventAngelaGiftSmallNode:SetAngelaGiftState(newState)
  self.currentState = newState
  self:_RefreshAngelaGiftNode()
end

function UINEventAngelaGiftSmallNode:_RefreshAngelaGiftNode()
  self._rewardItemPool:HideAll()
  for index, rewardId in ipairs(self.rewardIds) do
    local itemCfg = ConfigData.item[rewardId]
    local count = self.rewardCounts[index]
    local rewardItem = self._rewardItemPool:GetOne()
    local isPicked = self.currentState == UINEventAngelaGiftSmallNode.eGiftState.Picked
    rewardItem:InitItemWithCount(itemCfg, count, nil, isPicked)
  end
  self.ui.textItem_buy:SetIndex(self.currentState)
  self.ui.btn_buy.interactable = self.currentState == UINEventAngelaGiftSmallNode.eGiftState.CanBuy
end

return UINEventAngelaGiftSmallNode
