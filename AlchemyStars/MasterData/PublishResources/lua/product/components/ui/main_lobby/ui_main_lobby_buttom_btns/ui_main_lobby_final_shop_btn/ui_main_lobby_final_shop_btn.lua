_class("UIMainLobbyFinalShopBtn", UICustomWidget)
UIMainLobbyFinalShopBtn = UIMainLobbyFinalShopBtn

function UIMainLobbyFinalShopBtn:OnShow()
  self._active = true
  self.shopBtnBg = self:GetUIComponent("Image", "shopBtnBg")
  self._shopBtnPool = self:GetUIComponent("UISelectObjectPath", "BtnShop")
  self._storeNameChLabel = self:GetUIComponent("UILocalizationText", "name")
  self._shopRedpoint = self:GetGameObject("ShopRedpoint")
  self.imgNewShop = self:GetGameObject("imgNewShop")
  self._atlas = self:GetAsset("UIMainLobby.spriteatlas", LoadType.SpriteAtlas)
  self:AttachEvent(GameEventType.CheckMonthCardRedpoint, self._FlushNewAndRedPoint)
  self:AttachEvent(GameEventType.ShopNew, self._FlushNewAndRedPoint)
  self.mRedDot = GameGlobal.GetModule(RedDotModule)
  self.mRedDot:ListenRedDot({
    [RedDotType.RDT_SHOP_HOMEPAGE_NEW] = GameEventType.ShopNew
  })
  self.mShop = GameGlobal.GetModule(ShopModule)
  self:_FlushNewAndRedPoint()
end

function UIMainLobbyFinalShopBtn:OnHide()
  self:RemoveAllCustomEventListener()
  self:DetachEvent(GameEventType.CheckMonthCardRedpoint, self._FlushNewAndRedPoint)
  self:DetachEvent(GameEventType.ShopNew, self._FlushNewAndRedPoint)
  self.mRedDot:UnListenRedDot({
    RedDotType.RDT_SHOP_HOMEPAGE_NEW
  })
  self._active = false
end

function UIMainLobbyFinalShopBtn:_FlushNewAndRedPoint()
  self:StartTask(function(TT)
    self._shopRedpoint:SetActive(false)
    local res = self.mRedDot:RequestRedDotStatus(TT, {
      RedDotType.RDT_SHOP_HOMEPAGE_NEW
    })
    if res and res[RedDotType.RDT_SHOP_HOMEPAGE_NEW] then
      self.imgNewShop:SetActive(false)
      return
    end
    if self.mShop:GetHomelandRechargeTabNew() then
      self.imgNewShop:SetActive(false)
      return
    end
    if self.mShop:GetHomelandShopTabNew() then
      self.imgNewShop:SetActive(true)
      return
    end
    if self:GetExchangeShopNew() then
      self.imgNewShop:SetActive(true)
      return
    end
    if self:GetSecretTabShopNew() then
      self.imgNewShop:SetActive(true)
      return
    end
    self.imgNewShop:SetActive(false)
    self:_FlushShopBtnRedpoint()
  end, self)
end

function UIMainLobbyFinalShopBtn:_FlushShopBtnRedpoint()
  local monthRed = self.mShop:ShowMonthCardRedPoint()
  local sailingPlanHelper = UIShopSailingPlanHelper:New()
  local sailingRed = sailingPlanHelper:CheckRed()
  self._shopRedpoint:SetActive(false)
end

function UIMainLobbyFinalShopBtn:FlushLockStatus()
  local shopButtonFunction = self._shopBtnPool:SpawnObject("UIMainLobbyLockBtn")
  shopButtonFunction:SetFunctionType(GameModuleID.MD_Shop)
  shopButtonFunction:SetColorImage(self.shopBtnBg)
end

function UIMainLobbyFinalShopBtn:GetSailingPlanShopTabNew()
  local sailingPlanHelper = UIShopSailingPlanHelper:New()
  return sailingPlanHelper:CheckNew()
end

function UIMainLobbyFinalShopBtn:GetExchangeShopNew()
  local shopModule = GameGlobal.GetModule(ShopModule)
  local exChangeNew = shopModule:GetExchangeTabNew()
  return exChangeNew
end

function UIMainLobbyFinalShopBtn:GetSecretTabShopNew()
  local shopModule = GameGlobal.GetModule(ShopModule)
  local exChangeNew = shopModule:GetSecretTabNew()
  return exChangeNew
end

function UIMainLobbyFinalShopBtn:GetFlashSaleShopNew(TT)
  local res = AsyncRequestRes:New()
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_SHOP_HELPER, ECCampaignShopInlandComponentID.ECAMPAIGN_INLAND_ShopHelper1, ECCampaignShopInlandComponentID.ECAMPAIGN_INLAND_ShopHelper2, ECCampaignShopInlandComponentID.ECAMPAIGN_INLAND_ShopHelper3, ECCampaignShopInlandComponentID.ECAMPAIGN_INLAND_ShopHelper4, ECCampaignShopInlandComponentID.ECAMPAIGN_INLAND_ShopHelper5, ECCampaignShopInlandComponentID.ECAMPAIGN_INLAND_ShopHelper6, ECCampaignShopInlandComponentID.ECAMPAIGN_INLAND_ShopHelper7, ECCampaignShopInlandComponentID.ECAMPAIGN_INLAND_ShopHelper8, ECCampaignShopInlandComponentID.ECAMPAIGN_INLAND_ShopHelper9, ECCampaignShopInlandComponentID.ECAMPAIGN_INLAND_ShopHelper0)
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  if not res:GetSucc() then
    Log.error("UIShopController No FlashSale.")
    return
  end
  local flashsaleLocalProcess = self._campaign:GetLocalProcess()
  local components = flashsaleLocalProcess:GetComponents()
  for _, value in pairs(components) do
    if value:ComponentIsOpen() then
      local buyGiftComponentInfo = value:GetComponentInfo()
      for _, campaignGiftInfo in pairs(buyGiftComponentInfo.m_campaign_gift_list) do
        local record = UIShopToolFunctions.GetLocalDBInt(campaignGiftInfo.m_gift_id, 0)
        if record <= 0 then
          return true
        end
      end
    end
  end
  return false
end

function UIMainLobbyFinalShopBtn:BtnShopOnClick(go)
  GameGlobal.UAReportForceGuideEvent("UIMainClick", {
    "Click_ShopController"
  }, true)
  local module = GameGlobal.GetModule(RoleModule)
  local isLock = not module:CheckModuleUnlock(GameModuleID.MD_Shop)
  if isLock then
    ToastManager.ShowToast(StringTable.Get("str_function_lock_unlock"))
    return
  end
  GameGlobal.GetModule(RoleModule):OnHomePageEnter(CLICKENTRANCE.CE_SHOP)
  ClientShop.OpenShop(nil, nil, nil, nil, true)
end
