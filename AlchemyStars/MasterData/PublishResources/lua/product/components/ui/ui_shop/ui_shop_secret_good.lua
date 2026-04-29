_class("UIShopSecretGood", UICustomWidget)
UIShopSecretGood = UIShopSecretGood

function UIShopSecretGood:Constructor()
  self.ItemColorFrame = {
    [ItemColor.ItemColor_White] = "shop_duihuan_di01",
    [ItemColor.ItemColor_Green] = "shop_duihuan_di02",
    [ItemColor.ItemColor_Blue] = "shop_duihuan_di03",
    [ItemColor.ItemColor_Purple] = "shop_duihuan_di04",
    [ItemColor.ItemColor_Yellow] = "shop_duihuan_di05",
    [ItemColor.ItemColor_Golden] = "shop_duihuan_di06"
  }
  self._itemClickLock = "UIShopSecretGoodSelectItemLock"
end

function UIShopSecretGood:OnShow()
  self.canvasGroup = self:GetUIComponent("CanvasGroup", "item")
  self.nameShadow = self:GetUIComponent("UILocalizationText", "nameShadow")
  self.nameTxt = self:GetUIComponent("UILocalizationText", "name")
  self.itemCountTxt = self:GetUIComponent("UILocalizationText", "itemcount")
  self.countPanelGO = self:GetGameObject("countpanel")
  self.price1Txt = self:GetUIComponent("UILocalizationText", "price")
  self.remainTxt = self:GetUIComponent("UILocalizationText", "remain")
  self.remainGO = self:GetGameObject("remaingo")
  self.icon = self:GetUIComponent("RawImageLoader", "icon")
  self.qualityIcon = self:GetUIComponent("Image", "qualityIcon")
  self.tag = {}
  for i = 1, 3 do
    self.tag[i] = {}
    self.tag[i].tagGO = self:GetGameObject("tag" .. i)
    self.tag[i].txt = self:GetUIComponent("UILocalizationText", "tag" .. i .. "txt")
  end
  self.tag[1].tagGO:SetActive(false)
  self.moneyIcon1GO = self:GetGameObject("moneyicon1")
  self.moneyIcon1 = self:GetChildComponent(self.moneyIcon1GO, "Image", "moneyicon1")
  self.moneyIcon1RL = self:GetChildComponent(self.moneyIcon1GO, "RawImageLoader", "moneyicon1RL")
  self.moneyIcon2GO = self:GetGameObject("moneyicon2")
  self.moneyIcon2 = self:GetChildComponent(self.moneyIcon2GO, "Image", "moneyicon2")
  self.yuanjiaTxt = self:GetUIComponent("UILocalizationText", "yuanjia")
  self.xianjiaTxt = self:GetUIComponent("UILocalizationText", "xianjia")
  self.isSellGO = self:GetGameObject("issell")
  self.isSellTr = self:GetUIComponent("RectTransform", "issell")
  self.rectTrans = self:GetGameObject().transform:GetComponent("RectTransform")
  self.tagPanelGO = self:GetGameObject("alltag")
  self.alltagRect = self:GetUIComponent("RectTransform", "alltag")
  self.uiNormal = self:GetUIComponent("RectTransform", "uiNormal")
  self.nameShadow2 = self:GetUIComponent("UILocalizationText", "nameShadow2")
  self.nameTxt2 = self:GetUIComponent("UILocalizationText", "name2")
  self.moneyicon12 = self:GetUIComponent("RectTransform", "moneyicon12")
  self.moneyicon22 = self:GetUIComponent("RectTransform", "moneyicon22")
  self.isLockGO = self:GetGameObject("isLock")
  self.lockText = self:GetUIComponent("UILocalizationText", "lockText")
  self.module = self:GetModule(ResDungeonModule)
  self.atlas = self:GetAsset("UIShop.spriteatlas", LoadType.SpriteAtlas)
  self.uiCommonAtlas = self:GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas)
  self.trans = self:GetGameObject().transform
  self.animation = self.trans:GetComponent("Animation")
  self:AttachEvent(GameEventType.ShopBuySuccess, self.ShopBuySuccess)
end

function UIShopSecretGood:Refresh(subTabType, goodData, targetShopId)
  self.subTabType = subTabType
  self.goodData = goodData
  self.targetShopId = targetShopId
  if not self.goodData then
    return
  end
  local cfgItem = Cfg.cfg_item[self.goodData:GetItemId()]
  if not cfgItem then
    return
  end
  if self.targetShopId and self.targetShopId == self.goodData:GetGoodId() then
    self:BgOnClick()
  end
  local moneyIcon1RL = self:GetChildComponent(self.moneyicon12, "RawImageLoader", "moneyicon1RL")
  moneyIcon1RL.gameObject:SetActive(false)
  self.moneyIcon1RL.gameObject:SetActive(false)
  self.icon:LoadImage(cfgItem.Icon)
  if self.qualityIcon then
    local frameName = self.ItemColorFrame[cfgItem.Color]
    if frameName ~= "" then
      self.qualityIcon.gameObject:SetActive(true)
      self.qualityIcon.sprite = self.atlas:GetSprite(frameName)
    else
      self.qualityIcon.gameObject:SetActive(false)
    end
  end
  self.nameShadow:SetText(StringTable.Get(cfgItem.Name))
  self.nameTxt:SetText(StringTable.Get(cfgItem.Name))
  self.nameShadow2:SetText(StringTable.Get(cfgItem.Name))
  self.nameTxt2:SetText(StringTable.Get(cfgItem.Name))
  local count = self.goodData:GetItemCount()
  if count <= 1 then
    self.countPanelGO:SetActive(false)
  else
    self.countPanelGO:SetActive(true)
    self.itemCountTxt:SetText(count)
  end
  local showRemain = self.goodData:ShowRemain()
  local remainCount = self.goodData:GetRemainCount()
  if showRemain == false then
    self.remainGO:SetActive(false)
  elseif self.goodData:IsUnLimit() then
    self.remainGO:SetActive(false)
  elseif remainCount <= 0 then
    self.remainGO:SetActive(false)
  else
    local max = self.goodData:GetRemainTotalCount()
    self.remainGO:SetActive(true)
    self.remainTxt:SetText(StringTable.Get("str_shop_secret_good_remain") .. remainCount)
  end
  if remainCount <= 0 then
    self.isSellGO:SetActive(true)
    self.uiNormal.gameObject:SetActive(false)
    self.canvasGroup.alpha = 1
    self.canvasGroup.blocksRaycasts = false
  else
    self.isSellGO:SetActive(false)
    self.uiNormal.gameObject:SetActive(true)
    self.canvasGroup.alpha = 1
    self.canvasGroup.blocksRaycasts = true
  end
  local showTag = self.goodData:ShowSaleTag()
  if showTag then
    local saleTag = self.goodData:GetSaleTag()
    Log.debug("saleTag discount: ", saleTag)
    if saleTag == 1 then
      self.tag[2].tagGO:SetActive(true)
      self.tag[3].tagGO:SetActive(false)
    elseif 0 < saleTag and saleTag < 100 then
      self.tag[2].tagGO:SetActive(false)
      self.tag[3].tagGO:SetActive(true)
      local discount = 100 - saleTag
      local i, f = math.modf(discount)
      if f <= 0 then
        discount = i
      end
      local str = string.format("<size=36>%s</size>", discount)
      str = StringTable.Get("str_pay_discount_percent", str)
      self.tag[3].txt:SetText(str)
    elseif saleTag == 0 then
      self.tag[2].tagGO:SetActive(false)
      self.tag[3].tagGO:SetActive(false)
    end
  else
    self.tag[2].tagGO:SetActive(false)
    self.tag[3].tagGO:SetActive(false)
  end
  local discount = self.goodData:GetDiscount()
  if 0 < discount and discount < 100 then
    self.moneyIcon1GO:SetActive(false)
    self.moneyIcon2GO:SetActive(true)
    self.moneyIcon2.sprite = self.uiCommonAtlas:GetSprite(ClientShop.GetCurrencyImageName(self.goodData:GetSaleType()))
    self.yuanjiaTxt:SetText(self.goodData:GetOriginalSalePrice())
    self.xianjiaTxt:SetText(self.goodData:GetSalePrice())
    self.moneyicon12.gameObject:SetActive(false)
    self.moneyicon22.gameObject:SetActive(true)
    local moneyIcon2 = self:GetChildComponent(self.moneyicon22, "Image", "moneyicon2")
    local yuanjiaTxt = self:GetChildComponent(self.moneyicon22, "UILocalizationText", "yuanjia")
    local xianjiaTxt = self:GetChildComponent(self.moneyicon22, "UILocalizationText", "xianjia")
    moneyIcon2.sprite = self.uiCommonAtlas:GetSprite(ClientShop.GetCurrencyImageName(self.goodData:GetSaleType()))
    yuanjiaTxt:SetText(self.goodData:GetOriginalSalePrice())
    xianjiaTxt:SetText(self.goodData:GetSalePrice())
  else
    self.moneyIcon1GO:SetActive(true)
    self.moneyIcon2GO:SetActive(false)
    self.moneyIcon1.sprite = self.uiCommonAtlas:GetSprite(ClientShop.GetCurrencyImageName(self.goodData:GetSaleType()))
    self.price1Txt:SetText(self.goodData:GetSalePrice())
    self.moneyicon12.gameObject:SetActive(true)
    self.moneyicon22.gameObject:SetActive(false)
    local moneyIcon1 = self:GetChildComponent(self.moneyicon12, "Image", "moneyicon1")
    local price1Txt = self:GetChildComponent(self.moneyicon12, "UILocalizationText", "price")
    moneyIcon1.sprite = self.uiCommonAtlas:GetSprite(ClientShop.GetCurrencyImageName(self.goodData:GetSaleType()))
    price1Txt:SetText(self.goodData:GetSalePrice())
  end
end

function UIShopSecretGood:RefreshLock(islock, lockText)
  self.isLockGO:SetActive(islock)
  if islock then
    self.lockText:SetText(StringTable.Get(lockText))
  else
    self.lockText:SetText("")
  end
end

function UIShopSecretGood:OnHide()
  self:DetachEvent(GameEventType.ShopBuySuccess, self.ShopBuySuccess)
end

function UIShopSecretGood:ShopBuySuccess(goodId)
  if self.goodData and self.goodData:GetGoodId() == goodId then
    local remainCount = self.goodData:GetRemainCount()
    if remainCount <= 0 then
    end
  end
end

function UIShopSecretGood:BgOnClick()
  local remainCount = self.goodData:GetRemainCount()
  if remainCount <= 0 then
    return
  end
  if self.goodData:GetRemainCount() <= 1 then
    self:ShowDialog("UIShopConfirmNormalController", self.goodData, self.subTabType)
  else
    self:ShowDialog("UIShopConfirmDetailController", self.goodData, self.subTabType)
  end
end

function UIShopSecretGood:PlayInAnimation()
  if self.animation.gameObject.activeInHierarchy then
    self.animation:Stop()
    local state = self.animation:get_Item("uieff_UIShopSecretGood_In")
    if state then
      state.time = 0
      self.animation.enabled = true
    end
    self.animation:Play("uieff_UIShopSecretGood_In")
  end
  return 417
end
