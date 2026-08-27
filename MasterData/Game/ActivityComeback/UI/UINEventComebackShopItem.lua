local UINEventComebackShopItem = class("UINEventComebackShopItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local cs_ResLoader = CS.ResLoader

function UINEventComebackShopItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_bottom, self, self.__OnClickBuy)
  self._itemPool = UIItemPool.New(UINBaseItemWithCount, self.ui.uINBaseItemWithCount)
  self.ui.uINBaseItemWithCount:SetActive(false)
end

function UINEventComebackShopItem:InitComebackGift(payGiftInfo, callback)
  self._payGiftInfo = payGiftInfo
  self._callback = callback
  if self._resloader ~= nil then
    self._resloader:Put2Pool()
    self._resloader = nil
  end
  self._resloader = cs_ResLoader.Create()
  self.ui.img_gift.gameObject:SetActive(false)
  local textureName = self._payGiftInfo.groupCfg.icon
  self._resloader:LoadABAssetAsync(PathConsts:GetShopGiftBgPath(textureName), function(texture)
    if not IsNull(texture) then
      self.ui.img_gift.gameObject:SetActive(true)
      self.ui.img_gift.texture = texture
    end
  end)
  self.ui.tex_GiftName.text = LanguageUtil.GetLocaleText(self._payGiftInfo.groupCfg.name)
  self.ui.tex_GiftInfo.text = LanguageUtil.GetLocaleText(self._payGiftInfo.groupCfg.des)
  local defaultGiftCfg = self._payGiftInfo.defaultCfg
  local awardIds = defaultGiftCfg.awardIds
  local awardCounts = defaultGiftCfg.awardCounts
  self._itemPool:HideAll()
  for index, id in ipairs(awardIds) do
    local itemCfg = ConfigData.item[id]
    local itemCount = awardCounts[index]
    local item = self._itemPool:GetOne()
    item:InitItemWithCount(itemCfg, itemCount)
  end
  local isOff = self._payGiftInfo.groupCfg.tagType == 1
  self.ui.off:SetActive(isOff)
  if isOff then
    self.ui.tex_Off:SetIndex(0, tostring(self._payGiftInfo.groupCfg.tagValue))
  end
  local payId = defaultGiftCfg.payId
  local payCtrl = ControllerManager:GetController(ControllerTypeId.Pay, true)
  local priceStr, priceNum = payCtrl:GetPayPriceShow(payId)
  self.ui.tex_CurrentPrice.text = priceStr
  local showOldPrice, oldPrice = self._payGiftInfo:TryGetPayGiftOldPrice()
  self.ui.tex_OriginalPrice.gameObject:SetActive(showOldPrice)
  if showOldPrice then
    self.ui.tex_OriginalPrice.text = tostring(oldPrice)
  end
  self:RefreshComebackShopItem()
end

function UINEventComebackShopItem:RefreshComebackShopItem()
  local isLimit, times, totalTimes = self._payGiftInfo:GetLimitBuyCount()
  self.ui.obj_Limit:SetActive(isLimit)
  if isLimit then
    local remain = totalTimes - times
    self.ui.tex_Limit:SetIndex(0, tostring(remain))
    self.ui.soldOut:SetActive(remain == 0)
  end
end

function UINEventComebackShopItem:__OnClickBuy()
  if self._callback ~= nil then
    self._callback(self._payGiftInfo)
  end
end

function UINEventComebackShopItem:OnDelete()
  base.OnDelete(self)
  self._itemPool:DeleteAll()
  if self._resloader ~= nil then
    self._resloader:Put2Pool()
    self._resloader = nil
  end
end

return UINEventComebackShopItem
