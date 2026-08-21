require("ui_shop_secret_good")
_class("UIShopSecretGoodCampaign", UIShopSecretGood)
UIShopSecretGoodCampaign = UIShopSecretGoodCampaign

function UIShopSecretGoodCampaign:Refresh(subTabType, goodData, targetShopId)
  self.subTabType = subTabType
  self.goodData = goodData
  self.targetShopId = targetShopId
  self.shopModule = self:GetModule(ShopModule)
  self.clientShop = self.shopModule:GetClientShop()
  local shopCampaign, shopCampaignCfg = self.clientShop:GetSecretCampaign(self.subTabType)
  self._shopComponent = shopCampaign:GetComponent(shopCampaignCfg.ComponentID)
  local itemId = self.goodData.m_reward.assetid
  local cfgItem = Cfg.cfg_item[itemId]
  for i = 1, 3 do
    self.tag[i].tagGO:SetActive(false)
  end
  if not cfgItem then
    Log.error("###[UIShopSecretGoodCampaign] not cfg , id:", itemId)
  end
  self.nameShadow:SetText(StringTable.Get(cfgItem.Name))
  self.nameTxt:SetText(StringTable.Get(cfgItem.Name))
  self.nameShadow2:SetText(StringTable.Get(cfgItem.Name))
  self.nameTxt2:SetText(StringTable.Get(cfgItem.Name))
  if self.qualityIcon then
    local frameName = self.ItemColorFrame[cfgItem.Color]
    if frameName ~= "" then
      self.qualityIcon.gameObject:SetActive(true)
      self.qualityIcon.sprite = self.atlas:GetSprite(frameName)
    else
      self.qualityIcon.gameObject:SetActive(false)
    end
  end
  local specialIcon
  local specialSkin = false
  if self.goodData.m_is_special then
    local cfgItem = Cfg.cfg_activity_shop_special_item_icon_client[itemId]
    if cfgItem ~= nil then
      specialIcon = cfgItem.SpecialIcon
      specialSkin = cfgItem.IsSpecialSkin
    end
  end
  if specialIcon ~= nil then
    self.icon:LoadImage(specialIcon)
  else
    self.icon:LoadImage(cfgItem.Icon)
  end
  if specialSkin then
    self.icon.transform.sizeDelta = Vector2(316, 642)
  else
    self.icon.transform.sizeDelta = Vector2(240, 240)
  end
  local count = self.goodData.m_reward.count
  self.countPanelGO:SetActive(1 < count)
  self.itemCountTxt:SetText(count)
  if self.goodData.m_exchange_limit_count == -1 then
    self.remainGO:SetActive(false)
    self.remainTxt:SetText(StringTable.Get("str_n26_item_unlimit_count"))
  elseif self.goodData.m_can_exchange_count <= 0 then
    self.remainGO:SetActive(false)
  else
    self.remainGO:SetActive(true)
    self.remainTxt:SetText(StringTable.Get("str_shop_secret_good_remain") .. self.goodData.m_can_exchange_count)
  end
  self.moneyIcon1GO:SetActive(true)
  self.moneyIcon2GO:SetActive(false)
  self.moneyIcon1.gameObject:SetActive(true)
  self.moneyIcon1RL.gameObject:SetActive(false)
  self:_SetPriceIcon(self.moneyIcon1)
  self:_SetPrice(self.price1Txt)
  self.moneyicon12.gameObject:SetActive(true)
  self.moneyicon22.gameObject:SetActive(false)
  if self.moneyicon12 ~= nil then
    local moneyIcon1 = self:GetChildComponent(self.moneyicon12, "Image", "moneyicon1")
    local moneyIcon1RL = self:GetChildComponent(self.moneyicon12, "RawImageLoader", "moneyicon1RL")
    local price1Txt = self:GetChildComponent(self.moneyicon12, "UILocalizationText", "price")
    moneyIcon1.gameObject:SetActive(true)
    moneyIcon1RL.gameObject:SetActive(false)
    self:_SetPriceIcon(moneyIcon1)
    self:_SetPrice(price1Txt)
  end
  if self.goodData.m_exchange_limit_count ~= -1 and self.goodData.m_can_exchange_count == 0 then
    self.isSellGO:SetActive(true)
  else
    self.isSellGO:SetActive(false)
  end
end

function UIShopSecretGoodCampaign:_SetPriceIcon(iconObj)
  iconObj.sprite = self.uiCommonAtlas:GetSprite(ClientShop.GetCurrencyImageName(self.goodData.m_cost_item_id))
end

function UIShopSecretGoodCampaign:_SetPrice(textObj)
  local icon, count = self._shopComponent:GetCostItemIconText()
  local need = self.goodData.m_cost_count
  local changeColor = count < need
  textObj:SetText(need)
  textObj.color = changeColor and Color.red or Color.white
end

function UIShopSecretGoodCampaign:ActivityEndCb(activityEndCb)
  self._activityEndCb = activityEndCb
end

function UIShopSecretGoodCampaign:ShopBuySuccess(goodId)
  goodId = nil
end

function UIShopSecretGoodCampaign:BgOnClick()
  local shopCampaign, shopCampaignCfg = self.clientShop:GetSecretCampaign(self.subTabType)
  if not shopCampaign:CheckCampaignOpen() then
    local msg = StringTable.Get("str_activity_error_109")
    ToastManager.ShowToast(msg)
    if self._activityEndCb then
      self._activityEndCb(self.subTabType)
    end
    return
  end
  local uiItemData = DCampaignShopItemBase:New()
  uiItemData:Refresh(self.goodData, self._shopComponent)
  local useNormalDlg = false
  if not uiItemData:IsUnLimit() then
    local remainCount = uiItemData:GetRemainCount()
    if remainCount <= 0 then
      ToastManager.ShowToast(StringTable.Get("str_shop_item_has_empty_tips"))
      return
    end
    if remainCount == 1 then
      useNormalDlg = true
    end
  end
  local tb = {
    [true] = "UICampaignShopConfirmNormalController",
    [false] = "UICampaignShopConfirmDetailController"
  }
  self:ShowDialog(tb[useNormalDlg], uiItemData)
end
