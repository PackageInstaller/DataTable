_class("UIShopMainTabBtn", UICustomWidget)
UIShopMainTabBtn = UIShopMainTabBtn

function UIShopMainTabBtn:OnShow()
  self._active = true
  self.nameSelect = self:GetUIComponent("UILocalizedTMP", "nameSelect")
  self.nameNormal = self:GetUIComponent("UILocalizedTMP", "nameNormal")
  self.iconNormal = self:GetUIComponent("Image", "iconNormal")
  self.iconSelect = self:GetUIComponent("Image", "iconSelect")
  self.lock = self:GetGameObject("lock")
  self.select = self:GetGameObject("select")
  self.atlas = self:RootUIOwner():GetAsset("UIShop.spriteatlas", LoadType.SpriteAtlas)
  self._redpoint = self:GetGameObject("redpoint")
  self._redpoint:SetActive(false)
  self.imgNew = self:GetGameObject("imgNew")
  self.imgNew:SetActive(false)
  self.limitedTime = self:GetGameObject("limitedTime")
  self.limitedTime:SetActive(false)
  self:AttachEvent(GameEventType.CheckMonthCardRedpoint, self._CheckMonthCardRedpoint)
  self:AttachEvent(GameEventType.ForceShowMainTabBtn, self._ForceShowMainTabBtn)
end

function UIShopMainTabBtn:OnHide()
  self.imgNewShop = nil
  self._active = false
end

function UIShopMainTabBtn:Init(shopMainTabData, onClickTabBtn, param)
  self.shopMainTabData = shopMainTabData
  self.onClickTabBtn = onClickTabBtn
  self.shopModule = self:GetModule(ShopModule)
  self.param = param
  self.nameSelect:SetText(self.shopMainTabData:GetName())
  self.nameNormal:SetText(self.shopMainTabData:GetName())
  self.iconNormal.sprite = self.atlas:GetSprite(self.shopMainTabData:GetIcon())
  self.iconSelect.sprite = self.atlas:GetSprite(self.shopMainTabData:GetSelectIcon())
  if not self.shopMainTabData:IsOpen() then
    self.lock:SetActive(true)
  end
  self:_CheckMonthCardRedpoint()
  self:FlushCampaignLimitedTime()
end

function UIShopMainTabBtn:Select(select)
  self.nameSelect.gameObject:SetActive(select)
  self.nameNormal.gameObject:SetActive(not select)
  self.iconNormal.gameObject:SetActive(not select)
  self.iconSelect.gameObject:SetActive(select)
  self.select:SetActive(select)
end

function UIShopMainTabBtn:picOnClick(go)
  if not self.shopMainTabData:IsOpen() then
    ToastManager.ShowLockTip()
  else
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundSwitch)
    self.onClickTabBtn(self.param, self.shopMainTabData:GetMainTab(), false, self.shopMainTabData:GetUniqueID())
  end
end

function UIShopMainTabBtn:GetTabType()
  return self.shopMainTabData:GetMainTab()
end

function UIShopMainTabBtn:CheckSkinTabHide()
  if self:GetTabType() == ShopMainTabType.Skins then
    local shopModule = self:GetModule(ShopModule)
    local clientShop = shopModule:GetClientShop()
    local skinsData = clientShop:GetSkinsShopData()
    if skinsData then
      if skinsData:IsEmpty() then
        self:GetGameObject():SetActive(false)
      end
    else
      self:GetGameObject():SetActive(false)
    end
  end
end

function UIShopMainTabBtn:CheckHomelandTabHide()
  local homelandModule = GameGlobal.GetModule(HomelandModule)
  local unlock = homelandModule:CheckFunctionUnlock(HomelandUnlockType.E_HOMELAND_UNLOCK_SHOP_ARC_UI)
  self:GetGameObject():SetActive(unlock)
end

function UIShopMainTabBtn:_CheckMonthCardRedpoint()
  if self:GetTabType() == ShopMainTabType.MonthCard then
    local shopModule = GameGlobal.GetModule(ShopModule)
    local red, tips, state = shopModule:ShowMonthCardRedPoint()
    self._redpoint:SetActive(red)
  elseif self:GetTabType() == ShopMainTabType.SailingPlan then
    local helper = UIShopSailingPlanHelper:New()
    local show = helper:CheckRed()
    self._redpoint:SetActive(show)
  else
    self._redpoint:SetActive(false)
  end
end

function UIShopMainTabBtn:_ForceShowMainTabBtn(mainTabType)
  if self:GetTabType() == mainTabType then
    self:GetGameObject():SetActive(true)
  end
end

function UIShopMainTabBtn:FlushNew(isShow)
  if self.imgNew then
    self.imgNew:SetActive(isShow)
  end
end

function UIShopMainTabBtn:GetUniqueID()
  return self.shopMainTabData:GetUniqueID()
end

function UIShopMainTabBtn:GetComponentID()
  return self.shopMainTabData:GetComponentID()
end

function UIShopMainTabBtn:FlushCampaignLimitedTime()
  if self.shopMainTabData:GetId() == ShopMainTabType.Secret then
    local shopModule = self:GetModule(ShopModule)
    local clientShop = shopModule:GetClientShop()
    local shopCampaign, shopCampaignCfg = clientShop:GetSecretCampaign()
    local isNew = self.shopModule:GetSecretTabNew()
    if not isNew then
      if shopCampaign ~= nil and 0 < #shopCampaign then
        self.imgNew:SetActive(false)
        self.limitedTime:SetActive(true)
      else
        self.limitedTime:SetActive(false)
      end
    end
  end
end
