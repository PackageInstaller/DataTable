local UINGiftItemListPage = class("UINGiftItemListPage", UIBaseNode)
local base = UIBaseNode
local UINChipGiftRewardItem = require("Game.PayGift.UINChipGiftRewardItem")

function UINGiftItemListPage:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Buy, self, self.OnClickBuy)
  UIUtil.AddButtonListener(self.ui.btn_Buy_Icon, self, self.OnClickBuy)
  self._itemPool = UIItemPool.New(UINChipGiftRewardItem, self.ui.rewardItem)
  self.ui.rewardItem:SetActive(false)
end

function UINGiftItemListPage:InitGiftItemListPage(giftInfo, callback)
  self._giftInfo = giftInfo
  self._callback = callback
  self._itemPool:HideAll()
  local itemids, itemnums = self._giftInfo:GetPayGiftRewards()
  for i, itemid in ipairs(itemids) do
    local item = self._itemPool:GetOne()
    local itemCount = itemnums[i]
    item:InitChipGiftReward(itemid, itemCount)
  end
  self.ui.tex_GiftName.text = LanguageUtil.GetLocaleText(self._giftInfo.groupCfg.name)
  local payCtrl = ControllerManager:GetController(ControllerTypeId.Pay)
  if self._giftInfo:IsUseItemPay() then
    self.ui.btn_Buy.gameObject:SetActive(false)
    self.ui.btn_Buy_Icon.gameObject:SetActive(true)
    self.ui.tex_Cost.text = tostring(self._giftInfo.defaultCfg.costCount)
    local itemCfg = ConfigData.item[self._giftInfo.defaultCfg.costId]
    self.ui.img_Item.sprite = CRH:GetSpriteByItemConfig(itemCfg, true)
  else
    self.ui.btn_Buy.gameObject:SetActive(true)
    self.ui.btn_Buy_Icon.gameObject:SetActive(false)
    self.ui.tex_Buy.text = payCtrl:GetPayPriceShow(self._giftInfo.defaultCfg.payId)
  end
end

function UINGiftItemListPage:OnClickBuy()
  local payGiftCtrl = ControllerManager:GetController(ControllerTypeId.PayGift)
  payGiftCtrl:SendBuyGifitInfo(self._giftInfo, nil, function()
    UIUtil.OnClickBackByWinId(UIWindowTypeID.QuickBuy)
    if self._callback ~= nil then
      self._callback()
    end
  end)
end

return UINGiftItemListPage
