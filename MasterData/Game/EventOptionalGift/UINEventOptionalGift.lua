local UINEventOptionalGift = class("UINEventOptionalGift", UIBaseNode)
local base = UIBaseNode
local UINOptionGiftBoxItem = require("Game.EventOptionalGift.UINOptionGiftBoxItem")
local cs_MessageCommon = CS.MessageCommon

function UINEventOptionalGift:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._itemPool = UIItemPool.New(UINOptionGiftBoxItem, self.ui.baseItemScale)
  self.ui.baseItemScale:SetActive(false)
  UIUtil.AddButtonListener(self.ui.btn_Buy, self, self.OnClickBuy)
  self.__OnSelectCustomCallback = BindCallback(self, self.__OnSelectCustom)
end

function UINEventOptionalGift:InitOptionalGift(giftInfo, selectCallback)
  self._giftInfo = giftInfo
  self._selectCallback = selectCallback
  self.ui.img_Off:SetActive(self._giftInfo.groupCfg.tagType == 1)
  if self._giftInfo.groupCfg.tagType == 1 then
    self.ui.tex_off.text = tostring(self._giftInfo:GetPayGiftTagValue())
  end
  self.ui.img_item.sprite = CRH:GetSpriteByItemId(self._giftInfo.defaultCfg.awardIds[1])
  self.ui.tex_Count.text = "x" .. tostring(self._giftInfo.defaultCfg.awardCounts[1])
  self._itemPool:HideAll()
  local customCfg = self._giftInfo:GetSelectGiftCustomCfg()
  for i = 1, self._giftInfo:GetSelectGiftCustomCount() do
    local item = self._itemPool:GetOne()
    item:InitOptionGiftSelect(i, self._giftInfo, self.__OnSelectCustomCallback)
  end
  self.ui.img_icon.gameObject:SetActive(false)
  if self._giftInfo.defaultCfg.cur_price == 0 then
    self.ui.tex_Price:SetIndex(0)
  elseif self._giftInfo:IsUseItemPay() then
    self.ui.img_icon.gameObject:SetActive(true)
    self.ui.img_icon.sprite = CRH:GetSpriteByItemId(self._giftInfo.defaultCfg.costId, true)
    self.ui.tex_Price:SetIndex(1, tostring(self._giftInfo.defaultCfg.costCount))
  else
    local payCtrl = ControllerManager:GetController(ControllerTypeId.Pay)
    local payStr = payCtrl:GetPayPriceShow(self._giftInfo.defaultCfg.payId)
    self.ui.tex_Price:SetIndex(1, payStr)
  end
  self:__RefreshSouldState()
end

function UINEventOptionalGift:RefreshOptionalGift()
  self.ui.img_SoldOut:SetActive(self._giftInfo:IsSoldOut())
  for i, v in ipairs(self._itemPool.listItem) do
    v:RefreshOptionGiftSelect()
  end
  self:__RefreshSouldState()
end

function UINEventOptionalGift:__RefreshSouldState()
  local soldOut = self._giftInfo:IsSoldOut()
  self.ui.img_SoldOut:SetActive(soldOut)
  self.ui.tex_Buy:SetIndex(soldOut and 1 or 0)
  self.ui.bottom:SetIndex(soldOut and 1 or 0)
  self.ui.reward.alpha = soldOut and 0.7 or 1
  local isLimit, times, limitTimes = self._giftInfo:GetLimitBuyCount()
  if isLimit then
    self.ui.tex_Times:SetIndex(0, tostring(limitTimes - times))
  else
    self.ui.tex_Times.text.text = nil
  end
end

function UINEventOptionalGift:__OnSelectCustom(index, item)
  if self._giftInfo:IsSoldOut() then
    return
  end
  if self._selectCallback ~= nil then
    self._selectCallback(self._giftInfo, self)
  end
end

function UINEventOptionalGift:OnClickBuy()
  if self._giftInfo:IsSoldOut() then
    return
  end
  if not self._giftInfo:GetSelfSelectGiftIsSelected() then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(423))
    return
  end
  local giftCfg = self._giftInfo.defaultCfg
  local params = self._giftInfo:GetSelfSelectGiftParams()
  ControllerManager:GetController(ControllerTypeId.PayGift):SendBuyGifit(giftCfg, params, function()
    self._giftInfo:CleanSelfSelectInfo()
    if not IsNull(self.transform) then
      self:RefreshOptionalGift()
    end
  end)
end

return UINEventOptionalGift
