_class("UIShopController", UIController)
UIShopController = UIShopController

function UIShopController:Constructor()
  self.curMainTabType = nil
  self.curMainTabUniqueid = 0
  self.shopModule = self:GetModule(ShopModule)
  self.clientShop = self.shopModule:GetClientShop()
  self.mRedDot = GameGlobal.GetModule(RedDotModule)
  self._refreshTaskID = nil
  self._refreshSubTaskID = nil
  self:OnApplicationFocus(true)
  self._homeLandModule = GameGlobal.GetUIModule(HomelandModule)
end

function UIShopController:LoadDataOnEnter(TT, res, uiParams)
  self._openFromCampaign = self:_OpenFromCampaign(uiParams)
  self.params = uiParams
  local mainTabType = self.params and self.params[2] or ShopMainTabType.Exchange
  if mainTabType ~= ShopMainTabType.Secret and mainTabType ~= ShopMainTabType.Exchange and mainTabType ~= ShopMainTabType.Homeland then
    mainTabType = ShopMainTabType.Secret
    if self.params and self.params[3] then
      self.params[3] = MarketType.Shop_BlackMarket
    end
  end
  if self.clientShop:SendProtocal(TT, mainTabType, self.params and self.params[3] or MarketType.Shop_BlackMarket) then
    res:SetSucc(true)
    self.clientShop:SendProtocal(TT, ShopMainTabType.Skins)
    if mainTabType ~= ShopMainTabType.Recommend and mainTabType ~= ShopMainTabType.MonthCard and mainTabType ~= ShopMainTabType.Recharge then
      self.clientShop:SendProtocal(TT, ShopMainTabType.Recommend)
    end
  else
    res:SetSucc(false)
  end
  if self.params ~= nil and #self.params >= 4 then
    local shopId = self.params[4]
    local cfgv = Cfg.cfg_shop_giftmarket_goods[shopId]
    if cfgv ~= nil and cfgv.ShowInSkinsTab then
      self.params = {
        uiParams[1],
        ShopMainTabType.Skins,
        uiParams[3],
        uiParams[4]
      }
      mainTabType = self.params[2]
    end
  end
  if mainTabType == ShopMainTabType.Skins then
    local followTabType = ShopMainTabType.Gift
    if self.clientShop:SendProtocal(TT, followTabType, self.params and self.params[3] or MarketType.Shop_BlackMarket) then
      res:SetSucc(res:GetSucc())
    else
      res:SetSucc(false)
    end
  end
  self.clientShop:SendCampaign(TT, ShopMainTabType.Secret, subTabType)
  local sailingPlanHelper = UIShopSailingPlanHelper:New()
  local active = sailingPlanHelper:CheckActive()
  if active then
    self:GetSailingPlanShop(TT)
  end
  self:BattlePassData(TT)
end

function UIShopController:_OpenFromCampaign(uiParams)
  local mainTabType = uiParams and uiParams[2]
  local shopCfgId = uiParams and uiParams[3]
  local campaign = uiParams and uiParams[4]
  if mainTabType ~= ShopMainTabType.Secret then
    return
  end
  return campaign
end

function UIShopController:BattlePassData(TT)
  Log.debug("###[UIShopController] start load battle pass campaign data !")
  local res = AsyncRequestRes:New()
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_BATTLEPASS, ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_LV_REWARD, ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_BUY_GIFT)
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  if not res:GetSucc() then
    Log.error("###[UIShopController] battle pass shop data is fail ! result:", res:GetResult())
  end
end

function UIShopController:OnShow(uiParams)
  self._checkMonthCardTips = uiParams[5]
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIShop)
  local mainTabType = self.params and self.params[2]
  if mainTabType ~= ShopMainTabType.Secret and mainTabType ~= ShopMainTabType.Exchange and mainTabType ~= ShopMainTabType.Homeland then
    mainTabType = ShopMainTabType.Secret
  end
  self:AddListener()
  local topButton = self:GetUIComponent("UISelectObjectPath", "topbtn")
  self.topButton = topButton:SpawnObject("UINewCommonTopButton")
  self._lastBGMResName = AudioHelperController.GetCurrentBgm()
  local hideHomeBtn = self._homeLandModule:IsRunning()
  self.topButton:SetData(function()
    local curUIState = GameGlobal.UIStateManager():CurUIStateType()
    if curUIState == UIStateType.UIShopController then
      self:SwitchState(UIStateType.UIMain)
    else
      if self._openFromCampaign then
        self._openFromCampaign:CheckCampaignClose_ShowClientError()
      end
      self:CloseDialog()
    end
  end, nil, nil, hideHomeBtn)
  local sop = self:GetUIComponent("UISelectObjectPath", "mainmenu")
  self.shopCurrencyMenu = sop:SpawnObject("UICurrencyMenu_Shop")
  local mainToggle = self:GetUIComponent("UISelectObjectPath", "maintoggle")
  self.clientShop:ResetUniqueid()
  local tabDatas = self.clientShop:GetMainTabDatas()
  mainToggle:SpawnObjects("UIShopMainTabBtn", #tabDatas)
  self.allTab = mainToggle:GetAllSpawnList()
  local tabs = mainToggle:GetAllSpawnList()
  for i, tab in ipairs(tabs) do
    local tabData = tabDatas[i]
    self.allTab[tabData:GetUniqueID()] = tab
    tab:Init(tabData, self.OnClickTabBtn, self)
    local childIdx = self:GetChildIndex(tabData)
    local itemGo = tab:GetGameObject()
    itemGo.transform:SetSiblingIndex(childIdx)
    itemGo.name = childIdx
    if tab:GetTabType() == mainTabType and 7 <= childIdx then
      local parentSv
      local transform = mainToggle:Engine().transform
      while parentSv == nil and transform ~= nil do
        transform = transform.parent
        parentSv = transform:GetComponent("ScrollRect")
      end
      if parentSv ~= nil then
        parentSv.verticalNormalizedPosition = 0
      end
    end
  end
  self:InitBg()
  self:InitPlayerSpine()
  self._refreshTaskID = nil
  if self._checkMonthCardTips then
    local isRed, isTips, state = self.shopModule:ShowMonthCardRedPoint()
    if isRed then
      mainTabType = ShopMainTabType.MonthCard
    end
  end
  mainTabType = mainTabType or ShopMainTabType.Exchange
  self:OnClickTabBtn(mainTabType, true)
  self:GetModule(PetModule):GetAllPetsSnapshoot()
  local mRole = GameGlobal.GetModule(RoleModule)
  local isUnLock = mRole:CheckModuleUnlock(GameModuleID.MD_Shop)
  for i, tab in ipairs(self.allTab) do
    local go = tab:GetGameObject()
    if false and tab:GetTabType() ~= ShopMainTabType.Gift and tab:GetTabType() ~= ShopMainTabType.Exchange and tab:GetTabType() ~= ShopMainTabType.Secret then
      go:SetActive(false)
    elseif isUnLock then
      if tab:GetTabType() == ShopMainTabType.Skins then
        tab:CheckSkinTabHide()
      elseif tab:GetTabType() == ShopMainTabType.Homeland then
        tab:CheckHomelandTabHide()
      else
        go:SetActive(true)
      end
    else
      local mainTabType = tabDatas[i]:GetMainTab()
      if mainTabType == ShopMainTabType.Recharge or mainTabType == ShopMainTabType.Gift then
        go:SetActive(true)
      else
        go:SetActive(false)
      end
    end
    tab:Select(tab:GetTabType() == mainTabType)
  end
  self:CoFlushTabNew()
  self:AttachEvent(GameEventType.ShopNew, self.CoFlushTabNew)
  self.mRedDot:ListenRedDot({
    [RedDotType.RDT_SHOP_GIFT_NEW] = GameEventType.ShopNew,
    [RedDotType.RDT_SHOP_SIGN_NEW] = GameEventType.ShopNew
  })
  self:CheckMonthCardTips(self._checkMonthCardTips)
end

function UIShopController:GetChildIndex(data)
  local tabDatas = self.clientShop:GetMainTabDatas()
  local idx = data:GetSortIndex()
  local retIndex = 0
  for key, value in pairs(tabDatas) do
    local valIdx = value:GetSortIndex()
    if idx > valIdx then
      retIndex = retIndex + 1
    end
  end
  return retIndex
end

function UIShopController:OnHide()
  AudioHelperController.PlayBGM(self._lastBGMResName, AudioConstValue.BGMCrossFadeTime)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowHideTSFBtn, false)
  if self._refreshTaskID then
    GameGlobal.TaskManager():KillTask(self._refreshTaskID)
    self._refreshTaskID = nil
  end
  self:DetachEvent(GameEventType.ChangeShopBg, self.ChangeShopBg)
  self:DetachEvent(GameEventType.ShopTabChange, self.ShopTabChange)
  self:DetachEvent(GameEventType.OpenShop, self.OpenShop)
  self:DetachEvent(GameEventType.ApplicationFocus, self.OnApplicationFocus)
  self:DetachEvent(GameEventType.ShopNew, self.CoFlushTabNew)
  self.mRedDot:UnListenRedDot({
    RedDotType.RDT_SHOP_GIFT_NEW,
    RedDotType.RDT_SHOP_SIGN_NEW
  })
  self.allTab = nil
end

function UIShopController:AddListener()
  self:AttachEvent(GameEventType.ChangeShopBg, self.ChangeShopBg)
  self:AttachEvent(GameEventType.ShopTabChange, self.ShopTabChange)
  self:AttachEvent(GameEventType.OpenShop, self.OpenShop)
  self:AttachEvent(GameEventType.ApplicationFocus, self.OnApplicationFocus)
end

function UIShopController.CheckIsOpen(mainTabType)
  if mainTabType == ShopMainTabType.Recharge or mainTabType == ShopMainTabType.Gift then
    return not UIConst.IsShieldPay
  end
  return true
end

function UIShopController:OpenShop(mainTabType)
  self:OnClickTabBtn(mainTabType or ShopMainTabType.Recommend)
end

function UIShopController:OnClickTabBtn(mainTabType, first, uniqueid)
  uniqueid = uniqueid or self:GetUniqueIDByMainTabType(mainTabType)
  if not uniqueid then
    return
  end
  if self.curMainTabUniqueid == uniqueid then
    return
  end
  if not UIShopController.CheckIsOpen(mainTabType) then
    return
  end
  if first then
    self:RefreshPanel(mainTabType, first, uniqueid)
  elseif mainTabType == ShopMainTabType.Skins then
    self:RefreshTask(mainTabType, ShopMainTabType.Gift, uniqueid)
  else
    self:RefreshTask(mainTabType, nil, uniqueid)
  end
end

function UIShopController:RefreshTask(mainTabType, followTabType, uniqueid)
  if self._refreshTaskID then
    GameGlobal.TaskManager():KillTask(self._refreshTaskID)
    self._refreshTaskID = nil
  end
  if self._refreshSubTaskID then
    GameGlobal.TaskManager():KillTask(self._refreshSubTaskID)
    self._refreshSubTaskID = nil
  end
  local reqRemainCount = 1
  
  local function fnRefreshPanel()
    reqRemainCount = reqRemainCount - 1
    if reqRemainCount == 0 then
      self:RefreshPanel(mainTabType, false, uniqueid)
    end
  end
  
  if followTabType ~= nil then
    reqRemainCount = reqRemainCount + 1
    self._refreshSubTaskID = self:StartTask(function(TT)
      self:Lock("UIShopController:RefreshTask_SubTask")
      if not self.clientShop:SendProtocal(TT, followTabType, self.params and self.params[3] or MarketType.Shop_BlackMarket, uniqueid) then
        return
      end
      fnRefreshPanel()
      self:UnLock("UIShopController:RefreshTask_SubTask")
    end, self)
  end
  self._refreshTaskID = self:StartTask(function(TT)
    self:Lock("UIShopController:RefreshTask_MainTask")
    local subTabType = self.params and self.params[3]
    if mainTabType == ShopMainTabType.Secret then
      subTabType = self.clientShop:SendCampaign(TT, mainTabType, subTabType)
    end
    if not self.clientShop:SendProtocal(TT, mainTabType, self.params and self.params[3] or subTabType, uniqueid) then
      return
    end
    fnRefreshPanel()
    self:UnLock("UIShopController:RefreshTask_MainTask")
  end, self)
end

function UIShopController:RefreshPanel(mainTabType, first, uniqueid)
  if self.curMainTabUniqueid > 0 then
    self.allTab[self.curMainTabUniqueid]:Select(false)
  end
  self.curMainTabType = mainTabType
  self.curMainTabUniqueid = uniqueid
  if self.curMainTabUniqueid > 0 then
    self.allTab[self.curMainTabUniqueid]:Select(true, first)
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowHideTSFBtn, mainTabType == ShopMainTabType.Recharge or mainTabType == ShopMainTabType.Gift or mainTabType == ShopMainTabType.Skins)
  local tabCanvasGroup, tab
  if self.curMainTabType == ShopMainTabType.Recommend then
    if not self.shopRecommendTab then
      local sop = self:GetUIComponent("UISelectObjectPath", "UIShopRecommendTab")
      self.shopRecommendTab = sop:SpawnObject("UIShopRecommendTab")
      self.shopRecommendTab_CanvasGroup = self:GetUIComponent("CanvasGroup", "UIShopRecommendTab")
      self.shopRecommendTab_CanvasGroup.alpha = 0
      self.shopRecommendTab_CanvasGroup.blocksRaycasts = false
    end
    tab = self.shopRecommendTab
    tabCanvasGroup = self.shopRecommendTab_CanvasGroup
  elseif self.curMainTabType == ShopMainTabType.Secret then
    if not self.shopSecretTab then
      local sop = self:GetUIComponent("UISelectObjectPath", "UIShopSecretTab")
      self.shopSecretTab = sop:SpawnObject("UIShopSecretTab")
      self.shopSecretTab_CanvasGroup = self:GetUIComponent("CanvasGroup", "UIShopSecretTab")
      self.shopSecretTab_CanvasGroup.alpha = 0
      self.shopSecretTab_CanvasGroup.blocksRaycasts = false
    end
    tab = self.shopSecretTab
    tabCanvasGroup = self.shopSecretTab_CanvasGroup
  elseif self.curMainTabType == ShopMainTabType.Exchange then
    if not self.exchangeTab then
      local sop = self:GetUIComponent("UISelectObjectPath", "UIShopExchangeTab")
      self.exchangeTab = sop:SpawnObject("UIShopExchangeTab")
      self.exchangeTab_CanvasGroup = self:GetUIComponent("CanvasGroup", "UIShopExchangeTab")
      self.exchangeTab_CanvasGroup.alpha = 0
      self.exchangeTab_CanvasGroup.blocksRaycasts = false
    end
    tab = self.exchangeTab
    tabCanvasGroup = self.exchangeTab_CanvasGroup
  elseif self.curMainTabType == ShopMainTabType.Recharge then
    if not self.shopRechargeTab then
      local sop = self:GetUIComponent("UISelectObjectPath", "UIShopRechargeTab")
      self.shopRechargeTab = sop:SpawnObject("UIShopRechargeTab")
      self.shopRechargeTab_CanvasGroup = self:GetUIComponent("CanvasGroup", "UIShopRechargeTab")
      self.shopRechargeTab_CanvasGroup.alpha = 0
      self.shopRechargeTab_CanvasGroup.blocksRaycasts = false
    end
    tab = self.shopRechargeTab
    tabCanvasGroup = self.shopRechargeTab_CanvasGroup
  elseif self.curMainTabType == ShopMainTabType.Gift then
    if not self.shopGiftPackTab then
      local sop = self:GetUIComponent("UISelectObjectPath", "UIShopGiftPackTab")
      self.shopGiftPackTab = sop:SpawnObject("UIShopGiftPackTab")
      self.shopGiftPackTab_CanvasGroup = self:GetUIComponent("CanvasGroup", "UIShopGiftPackTab")
      self.shopGiftPackTab_CanvasGroup.alpha = 0
      self.shopGiftPackTab_CanvasGroup.blocksRaycasts = false
    end
    tab = self.shopGiftPackTab
    tabCanvasGroup = self.shopGiftPackTab_CanvasGroup
  elseif self.curMainTabType == ShopMainTabType.Skins then
    if not self.shopSkinsPackTab then
      local sop = self:GetUIComponent("UISelectObjectPath", "UIShopSkinsTab")
      self.shopSkinsPackTab = sop:SpawnObject("UIShopSkinsTab")
      self.shopSkinsPackTab_CanvasGroup = self:GetUIComponent("CanvasGroup", "UIShopSkinsTab")
      self.shopSkinsPackTab_CanvasGroup.alpha = 0
      self.shopSkinsPackTab_CanvasGroup.blocksRaycasts = false
    end
    tab = self.shopSkinsPackTab
    tabCanvasGroup = self.shopSkinsPackTab_CanvasGroup
  elseif self.curMainTabType == ShopMainTabType.Homeland then
    if not self.shopHomelandTab then
      local sop = self:GetUIComponent("UISelectObjectPath", "UIShopHomelandTab")
      self.shopHomelandTab = sop:SpawnObject("UIShopHomelandTab")
      self.shopHomelandTab_CanvasGroup = self:GetUIComponent("CanvasGroup", "UIShopHomelandTab")
      self.shopHomelandTab_CanvasGroup.alpha = 0
      self.shopHomelandTab_CanvasGroup.blocksRaycasts = false
    end
    tab = self.shopHomelandTab
    tabCanvasGroup = self.shopHomelandTab_CanvasGroup
  elseif self.curMainTabType == ShopMainTabType.FlashSale then
    if not self.shopFlashSale then
      local sop = self:GetUIComponent("UISelectObjectPath", "UIShopFlashSaleTab")
      self.shopFlashSale = sop:SpawnObject("UIShopFlashSaleTab")
      self.shopFlashSale_CanvasGroup = self:GetUIComponent("CanvasGroup", "UIShopFlashSaleTab")
      self.shopFlashSale_CanvasGroup.alpha = 0
      self.shopFlashSale_CanvasGroup.blocksRaycasts = false
    end
    tab = self.shopFlashSale
    tabCanvasGroup = self.shopFlashSale_CanvasGroup
  elseif self.curMainTabType == ShopMainTabType.SailingPlan then
    if not self.shopSailingPlan then
      local sop = self:GetUIComponent("UISelectObjectPath", "UIShopSailingPlanTab")
      self.shopSailingPlan = sop:SpawnObject("UIShopSailingPlanTab")
      self.shopSailingPlan_CanvasGroup = self:GetUIComponent("CanvasGroup", "UIShopSailingPlanTab")
      self.shopSailingPlan_CanvasGroup.alpha = 0
      self.shopSailingPlan_CanvasGroup.blocksRaycasts = false
    end
    tab = self.shopSailingPlan
    tabCanvasGroup = self.shopSailingPlan_CanvasGroup
  elseif self.curMainTabType == ShopMainTabType.MonthCard then
    if not self.shopMonthCard then
      local sop = self:GetUIComponent("UISelectObjectPath", "UIShopMonthCardTab")
      self.shopMonthCard = sop:SpawnObject("UIShopMonthCardTab")
      self.shopMonthCard_CanvasGroup = self:GetUIComponent("CanvasGroup", "UIShopMonthCardTab")
      self.shopMonthCard_CanvasGroup.alpha = 0
      self.shopMonthCard_CanvasGroup.blocksRaycasts = false
    end
    tab = self.shopMonthCard
    tabCanvasGroup = self.shopMonthCard_CanvasGroup
  else
    Log.fatal("### unvalid mainTabType. self.mainTabType = ", self.curMainTabType)
  end
  if self.tab then
    local tab = self.tab
    self.tab:ExcuteHideLogic(function(_tab)
      if _tab:View() then
        _tab:HideSelf()
      end
    end)
  end
  if self.tabCanvasGroup then
    self.tabCanvasGroup.alpha = 0
    self.tabCanvasGroup.blocksRaycasts = false
  end
  self.tab = tab
  self.tabCanvasGroup = tabCanvasGroup
  if self.tab then
    self.tab:SetData(self.params)
    self.tab:ShowSelf()
    self.params = nil
  end
  if self.tabCanvasGroup then
    self.tabCanvasGroup.alpha = 1
    self.tabCanvasGroup.blocksRaycasts = true
  end
end

function UIShopController:CoFlushTabNew()
  self:StartTask(function(TT)
    local res = self.mRedDot:RequestRedDotStatus(TT, {
      RedDotType.RDT_SHOP_GIFT_NEW,
      RedDotType.RDT_SHOP_SIGN_NEW
    })
    if not self.allTab then
      return
    end
    local tabDatas = self.clientShop:GetMainTabDatas()
    for i, tab in ipairs(self.allTab) do
      local isShow = false
      if res then
        local mainTabType = tabDatas[i]:GetMainTab()
        if mainTabType == ShopMainTabType.Gift then
          isShow = res[RedDotType.RDT_SHOP_GIFT_NEW] or false
        elseif mainTabType == ShopMainTabType.Skins then
          isShow = res[RedDotType.RDT_SHOP_SIGN_NEW] or false
        elseif mainTabType == ShopMainTabType.Homeland then
          isShow = self.shopModule:GetHomelandShopTabNew()
        elseif mainTabType == ShopMainTabType.Recharge then
          isShow = self.shopModule:GetRechargeTabNew()
        elseif mainTabType == ShopMainTabType.FlashSale then
          isShow = self:GetFlashSaleNew(tab:GetComponentID())
        elseif mainTabType == ShopMainTabType.SailingPlan then
          local sailingPlanHelper = UIShopSailingPlanHelper:New()
          isShow = sailingPlanHelper:CheckNew()
        elseif mainTabType == ShopMainTabType.Exchange then
          isShow = self.shopModule:GetExchangeTabNew()
        elseif mainTabType == ShopMainTabType.Secret then
          isShow = self.shopModule:GetSecretTabNew()
        end
      end
      tab:FlushNew(isShow)
    end
  end, self)
end

function UIShopController:ShowTab(params)
  self.params = params
  local mainTabType = self.params[2] or 1
  self:OnClickTabBtn(mainTabType)
end

function UIShopController:OnUpdate(deltaTimeMS)
  if self.tab then
    self.tab:Update(deltaTimeMS)
  end
end

function UIShopController:InitBg()
end

function UIShopController:ChangeShopBg(mainTabType, bgName)
end

function UIShopController:ShopTabChange(mainTabType, subTabType)
  if self._spineCanvasGroup then
    self._spineCanvasGroup.alpha = mainTabType == ShopMainTabType.Recommend and 1 or 0
  end
  if mainTabType == ShopMainTabType.Recommend then
    self.shopCurrencyMenu:SetData({
      RoleAssetID.RoleAssetGold,
      RoleAssetID.RoleAssetGlow
    })
  elseif mainTabType == ShopMainTabType.Secret then
    if subTabType == MarketType.Shop_BlackMarket then
      self.shopCurrencyMenu:SetData({
        RoleAssetID.RoleAssetGold,
        RoleAssetID.RoleAssetGlow
      })
    elseif subTabType == MarketType.Shop_MysteryMarket then
      self.shopCurrencyMenu:SetData({
        RoleAssetID.RoleAssetMazeCoin
      })
    elseif subTabType == MarketType.Shop_WorldBoss then
      self.shopCurrencyMenu:SetData({
        RoleAssetID.RoleAssetWorldBossCoin,
        RoleAssetID.RoleAssetWorldBossCoin2
      })
    elseif subTabType >= MarketType.Shop_CampaignMarket then
      local shopCampaign, shopCampaignCfg = self.clientShop:GetSecretCampaign(subTabType)
      local shopComponent = shopCampaign:GetComponent(shopCampaignCfg.ComponentID)
      local item_id = shopComponent:GetCostItemId()
      self.shopCurrencyMenu:SetData({item_id}, true)
    elseif subTabType == MarketType.Shop_BattlePass then
      self.shopCurrencyMenu:SetData(self:GetBattlePassCoin(self.shopSecretTab:GetNestSubTab()), true, false)
    elseif subTabType == MarketType.Shop_Season then
      self.shopCurrencyMenu:SetData({
        RoleAssetID.RoleAssetHistory
      })
    end
  elseif mainTabType == ShopMainTabType.Exchange then
    if subTabType == MarketType.Shop_XingZuan then
      self.shopCurrencyMenu:SetData({
        RoleAssetID.RoleAssetXingZuan
      })
    elseif subTabType == MarketType.Shop_HuiYao then
      self.shopCurrencyMenu:SetData({
        RoleAssetID.RoleAssetHuiYao
      })
    elseif subTabType == MarketType.Shop_GuangPo then
      self.shopCurrencyMenu:SetData({
        RoleAssetID.RoleAssetGlow
      })
    elseif subTabType == MarketType.Shop_HongPiao then
      self.shopCurrencyMenu:SetData({
        RoleAssetID.RoleAssetHongPiao
      })
    elseif subTabType == MarketType.Shop_Season then
      self.shopCurrencyMenu:SetData({
        RoleAssetID.RoleAssetHistory
      })
    elseif subTabType == MarketType.Shop_BlackMarket then
      self.shopCurrencyMenu:SetData({
        RoleAssetID.RoleAssetGold,
        RoleAssetID.RoleAssetGlow
      })
    end
  elseif mainTabType == ShopMainTabType.Recharge then
    self.shopCurrencyMenu:SetData({
      RoleAssetID.RoleAssetDiamond
    }, true)
  elseif mainTabType == ShopMainTabType.Gift then
    self.shopCurrencyMenu:SetData({
      RoleAssetID.RoleAssetDiamond,
      RoleAssetID.RoleAssetGlow
    })
  elseif mainTabType == ShopMainTabType.Skins then
    self.shopCurrencyMenu:SetData({
      RoleAssetID.RoleAssetDiamond
    })
  elseif mainTabType == ShopMainTabType.Homeland then
    self.shopCurrencyMenu:SetData({
      RoleAssetID.RoleAssetFurnitureCoin,
      RoleAssetID.RoleAssetGlow
    })
  elseif mainTabType == ShopMainTabType.FlashSale then
    self.shopCurrencyMenu:SetData({
      RoleAssetID.RoleAssetDiamond,
      RoleAssetID.RoleAssetGlow
    })
  elseif mainTabType == ShopMainTabType.SailingPlan then
    self.shopCurrencyMenu:SetData({
      RoleAssetID.RoleAssetDiamond,
      RoleAssetID.RoleAssetGlow
    })
  elseif mainTabType == ShopMainTabType.MonthCard then
    self.shopCurrencyMenu:SetData({
      RoleAssetID.RoleAssetDiamond,
      RoleAssetID.RoleAssetGlow
    })
  else
    Log.warn("### invalid mainTabType.", mainTabType)
  end
end

function UIShopController:GetMainTab(mainTabType)
  if self.allTab then
    for i, v in ipairs(self.allTab) do
      if v.shopMainTabData:GetMainTab() == mainTabType then
        return v:GetGameObject("pic")
      end
    end
  end
  return nil
end

function UIShopController:GetSecretGood(index)
  return self.shopSecretTab and self.shopSecretTab:GetGood(index)
end

function UIShopController:GetBattlePassCoin(nestSubTabIndex)
  local battlePassCoinList = {}
  local battlePassCoinIndex = {}
  for id, cfg in pairs(Cfg.cfg_shop_battlepass_goods()) do
    local payState = {
      [BattlePassMarketType.Shop_BattlePass_Pay] = 1,
      [BattlePassMarketType.Shop_BattlePass_Free] = 0
    }
    if payState[nestSubTabIndex] == cfg.PayType then
      if cfg.SaleType and battlePassCoinIndex[cfg.SaleType] == nil then
        battlePassCoinIndex[cfg.SaleType] = {}
        table.insert(battlePassCoinList, cfg.SaleType)
      end
      if cfg.ConvertType and battlePassCoinIndex[cfg.ConvertType] == nil then
        battlePassCoinIndex[cfg.ConvertType] = {}
        table.insert(battlePassCoinList, cfg.ConvertType)
      end
    end
  end
  return battlePassCoinList
end

function UIShopController:InitPlayerSpine()
  local spineHolder = self:GetUIComponent("RectTransform", "spineHolder")
  local sop = self:GetUIComponent("UISelectObjectPath", "UIShopRecommendTab")
  local tab = sop:SpawnObject("UIShopRecommendTab")
  tab:Enable(false)
  spineHolder:SetParent(tab:GetGameObject().transform, false)
  spineHolder:SetSiblingIndex(0)
  self.spinePlaying = false
  self._spine = self:GetUIComponent("SpineLoader", "spine")
  self._spineCanvasGroup = self:GetUIComponent("CanvasGroup", "spine")
  self._spineCanvasGroup.alpha = 0
  self:StartTask(self.WelPlayerSpine, self)
  self:InitInteractWord()
end

function UIShopController:InitInteractWord()
  self.interactWords = string.split(StringTable.Get("str_shop_interact_wel_word"), "|")
  self.stack = Stack:New()
end

function UIShopController:WelPlayerSpine(TT)
  self._spine:DestroyCurrentSpine()
  self.spinePlaying = true
  self:IdlePlayerSpine()
end

function UIShopController:IdlePlayerSpine()
  if self.spinePlaying then
    self.spinePlaying = false
    self._spine:DestroyCurrentSpine()
    self._spine:LoadSpine("duya_spine_idle")
  end
end

function UIShopController:GetInteractWord()
  if self.stack:Size() <= 0 then
    local count = 0
    local all = #self.interactWords
    while count < all do
      local index = math.random(1, all)
      if not self.stack:Contains(index) then
        self.stack:Push(index)
        count = count + 1
      end
    end
  end
  return self.interactWords[self.stack:Pop()]
end

function UIShopController:OnApplicationFocus(isFocus)
end

function UIShopController:ServiceBtnOnClick()
  HelperProxy:GetInstance():OpenServiceUrl("str_login_service_url_shop")
  GameGlobal.ReportCustomEvent("TDMReportTlog", "CustomerServiceFlow", {2})
end

function UIShopController:GetSailingPlanShop(TT)
  local res = AsyncRequestRes:New()
  self._sailingPlanCampaign = UIActivityCampaign:New()
  self._sailingPlanCampaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_INLAND_SAILING, ECCampaignInlandSailingComponentID.BUY_GIFT, ECCampaignInlandSailingComponentID.QUEST)
  self._sailingPlanCampaign:ReLoadCampaignInfo_Force(TT, res)
  if not res:GetSucc() then
    Log.error("UIShopController No sailing plan.")
  end
  local component = self._sailingPlanCampaign:GetComponent(ECCampaignInlandSailingComponentID.BUY_GIFT)
  component:GetAllGiftLocalPrice()
end

function UIShopController:GetSailingPlanLocalProgress()
  local localProcess = self._sailingPlanCampaign:GetLocalProcess()
  return localProcess
end

function UIShopController:GetSailingPlanID()
  return self._sailingPlanCampaign._id
end

function UIShopController:GetFlashSaleShop(TT)
  local res = AsyncRequestRes:New()
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_SHOP_HELPER, ECCampaignShopInlandComponentID.ECAMPAIGN_INLAND_ShopHelper1, ECCampaignShopInlandComponentID.ECAMPAIGN_INLAND_ShopHelper2, ECCampaignShopInlandComponentID.ECAMPAIGN_INLAND_ShopHelper3, ECCampaignShopInlandComponentID.ECAMPAIGN_INLAND_ShopHelper4, ECCampaignShopInlandComponentID.ECAMPAIGN_INLAND_ShopHelper5, ECCampaignShopInlandComponentID.ECAMPAIGN_INLAND_ShopHelper6, ECCampaignShopInlandComponentID.ECAMPAIGN_INLAND_ShopHelper7, ECCampaignShopInlandComponentID.ECAMPAIGN_INLAND_ShopHelper8, ECCampaignShopInlandComponentID.ECAMPAIGN_INLAND_ShopHelper9, ECCampaignShopInlandComponentID.ECAMPAIGN_INLAND_ShopHelper0)
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  if not res:GetSucc() then
    Log.info("UIShopController No FlashSale.")
  end
  self._flashsaleLocalProcess = self._campaign:GetLocalProcess()
end

function UIShopController:InsertFalshSaleTab()
  if self._flashsaleLocalProcess then
    self.clientShop:RemoveMainType(ShopMainTabType.FlashSale)
    local components = self._flashsaleLocalProcess:GetComponents()
    for id, value in pairs(components) do
      if value:ComponentIsOpen() then
        self.clientShop:InsertMainType(ShopMainTabType.FlashSale, id)
      end
    end
  end
end

function UIShopController:InsertSailingPlanTab()
  local sailingPlanHelper = UIShopSailingPlanHelper:New()
  local active = sailingPlanHelper:CheckActive()
  self.clientShop:RemoveMainType(ShopMainTabType.SailingPlan)
  if active then
    self.clientShop:InsertMainType(ShopMainTabType.SailingPlan)
  end
end

function UIShopController:GetUniqueIDByMainTabType(tabType)
  if tabType then
    for _, tab in ipairs(self.allTab) do
      if tab:GetTabType() == tabType then
        return tab:GetUniqueID()
      end
    end
  end
end

function UIShopController:GetComponentIDByUniqueID(uniqueid)
  if uniqueid then
    for _, tab in ipairs(self.allTab) do
      if tab:GetUniqueID() == uniqueid then
        return tab:GetComponentID()
      end
    end
  end
end

function UIShopController:GetFlashSaleLocalProgress()
  return self._flashsaleLocalProcess
end

function UIShopController:GetFlashSaleNew(componentID)
  if not self._flashsaleLocalProcess then
    return false
  end
  local components = self._flashsaleLocalProcess:GetComponents()
  for id, value in pairs(components) do
    if id == componentID and value:ComponentIsOpen() then
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

function UIShopController:CheckMonthCardTips(check)
  if check == true then
    local monthCardInfo = self.shopModule:GetMonthCardInfo()
    if monthCardInfo then
      local isRed, isTips, state = self.shopModule:ShowMonthCardRedPoint()
      if isTips then
        local saveKey, tipsKey
        if state == 2 then
          saveKey = self.shopModule:GetMonthCardWillOutDataTipsKey(monthCardInfo)
          tipsKey = "str_shop_month_card_will_out_data"
        elseif state == 3 then
          saveKey = self.shopModule:GetMonthCardOutDataTipsKey(monthCardInfo)
          tipsKey = "str_shop_month_card_out_data"
        end
        if saveKey and tipsKey then
          ToastManager.ShowToast(StringTable.Get(tipsKey))
          LocalDB.SetInt(saveKey, 1)
        end
      end
    end
  end
end

function UIShopController:FlushCampaignLimitedTime()
  for i, tab in ipairs(self.allTab) do
    tab:FlushCampaignLimitedTime()
  end
end
