local UINShopNormalGiftItem = class("UINShopNormalGiftItem", UIBaseNode)
local base = UIBaseNode
local CS_ClientConsts = CS.ClientConsts
local ShopEnum = require("Game.Shop.ShopEnum")

function UINShopNormalGiftItem:OnInit()
  self.shopCtrl = ControllerManager:GetController(ControllerTypeId.Shop, false)
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_CNY, self, self.OnClickGiftBuy)
  self.__ShowGiftCutDown = BindCallback(self, self.ShowGiftCutDown)
end

function UINShopNormalGiftItem:InitGiftItem(data, purchaseRoot, resloader, refreshFunc)
  self.data = data
  self.purchaseRoot = purchaseRoot
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(self.data.groupCfg.name)
  self.refreshFunc = refreshFunc
  local payCtrl = ControllerManager:GetController(ControllerTypeId.Pay, true)
  local showOldPrice, oldPrice = data:TryGetPayGiftOldPrice()
  self.ui.tex_oldPrice.gameObject:SetActive(showOldPrice)
  if self.data:IsUseItemPay() then
    self.ui.imgIcon.gameObject:SetActive(true)
    self.ui.tex_curPrice:SetIndex(1, tostring(self.data.defaultCfg.costCount))
    local itemCfg = ConfigData.item[self.data.defaultCfg.costId]
    self.ui.imgIcon.sprite = CRH:GetSprite(itemCfg.small_icon)
    if showOldPrice then
      self.ui.tex_oldPrice.text = tostring(oldPrice)
    end
  else
    self.ui.imgIcon.gameObject:SetActive(false)
    local payId = self.data.defaultCfg.payId
    local priceStr, priceNum = payCtrl:GetPayPriceShow(payId)
    if priceNum == 0 then
      self.ui.tex_curPrice:SetIndex(0)
    else
      self.ui.tex_curPrice:SetIndex(1, priceStr)
    end
    if showOldPrice then
      local priceUnit = payCtrl:GetPayShowUnitStr()
      local oldPriceStr = priceUnit .. oldPrice
      self.ui.tex_oldPrice.text = oldPriceStr
    end
  end
  self._finimalGiftIcon = self.data.groupCfg.icon
  local textureName = self.data.groupCfg.icon
  self.ui.img_GiftBag.gameObject:SetActive(false)
  resloader:LoadABAssetAsync(PathConsts:GetShopGiftBgPath(textureName), function(texture)
    if not IsNull(texture) and textureName == self._finimalGiftIcon then
      self.ui.img_GiftBag.gameObject:SetActive(true)
      self.ui.img_GiftBag.texture = texture
    end
  end)
  self.ui.obj_Discount.gameObject:SetActive(false)
  self.ui.img_tag.gameObject:SetActive(false)
  if not CS_ClientConsts.IsAudit and not ConfigData.game_config.payGiftdiscountHide and 0 < self.data.groupCfg.tagType then
    local groupCfg = self.data.groupCfg
    if groupCfg.tagType == ShopEnum.ePayGiftTag.Discount then
      self.ui.obj_Discount.gameObject:SetActive(true)
      if Consts.GameChannelType.IsInland() then
        self.ui.tex_Discount:SetIndex(1, tostring(10 - groupCfg.tagValue / 10))
      else
        self.ui.tex_Discount:SetIndex(0, tostring(groupCfg.tagValue))
      end
    else
      self.ui.img_tag.gameObject:SetActive(true)
      self.ui.img_tag:SetIndex(groupCfg.tagValue - 1)
      self.ui.tex_Tag:SetIndex(groupCfg.tagType - 2)
    end
  end
  self:RefreshGiftItem()
end

function UINShopNormalGiftItem:RefreshGiftItem()
  local isSoldOut = self.data:IsSoldOut()
  local isLimit, times, limitTimes = self.data:GetLimitBuyCount()
  self.ui.obj_SoldOut.gameObject:SetActive(isSoldOut)
  self.ui.obj_limit:SetActive(isLimit)
  if isLimit then
    local index = self.data.needRefresh and 1 or 0
    self.ui.text_limit:SetIndex(index, tostring(limitTimes - times))
  end
  self.ui.obj_time:SetActive(false)
  self.shopCtrl:RemoveShopTimerCallback(self.__ShowGiftCutDown)
  if self.data:NeedRefreshTime() then
    self.ui.obj_time:SetActive(true)
    self.lastRefreshTime = math.floor(self.data:GetPayGiftNextTime())
    self.shopCtrl:AddShopTimerCallback(self.__ShowGiftCutDown, "GiftItem")
    self:ShowGiftCutDown()
  else
    local flag, startTime, endTime = self.data:IsUnlockTimeCondition()
    if flag and endTime > PlayerDataCenter.timestamp then
      self.ui.obj_time:SetActive(true)
      self.lastRefreshTime = endTime
      self.shopCtrl:AddShopTimerCallback(self.__ShowGiftCutDown, "GiftItem")
      self:ShowGiftCutDown()
    end
  end
  local isNewGift = self.data:IsNewGiftInShop()
  self.ui.obj_NewGift:SetActive(isNewGift)
end

function UINShopNormalGiftItem:ShowGiftCutDown()
  local time = self.lastRefreshTime - PlayerDataCenter.timestamp
  if time < 0 then
    if self.refreshFunc ~= nil then
      self.refreshFunc()
    end
    self.shopCtrl:RemoveShopTimerCallback(self.__ShowGiftCutDown)
    return
  end
  local d, h, m, s = TimeUtil:TimestampToTimeInter(time, false, true)
  if 0 < d then
    self.ui.text_time:SetIndex(0, tostring(d), tostring(h))
  elseif 0 < h then
    self.ui.text_time:SetIndex(1, tostring(h), tostring(m))
  elseif 0 < m then
    self.ui.text_time:SetIndex(2, tostring(m))
  else
    self.ui.text_time:SetIndex(2, tostring(1))
  end
end

function UINShopNormalGiftItem:OnClickGiftBuy()
  UIManager:ShowWindowAsync(UIWindowTypeID.QuickBuy, function(window)
    window:SlideIn()
    window:InitBuyPayGift(self.data)
  end)
  self.ui.obj_NewGift:SetActive(false)
end

function UINShopNormalGiftItem:SetGiftItemReddot(flag)
  self.ui.redDot:SetActive(flag)
end

function UINShopNormalGiftItem:OnHide()
  self.shopCtrl:RemoveShopTimerCallback(self.__ShowGiftCutDown)
  base.OnHide(self)
end

function UINShopNormalGiftItem:OnDelete()
  self.shopCtrl:RemoveShopTimerCallback(self.__ShowGiftCutDown)
  base.OnDelete(self)
end

return UINShopNormalGiftItem
