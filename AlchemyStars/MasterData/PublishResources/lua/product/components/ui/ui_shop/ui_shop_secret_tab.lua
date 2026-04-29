_class("UIShopSecretTab", UICustomWidget)
UIShopSecretTab = UIShopSecretTab
local modf = math.modf
local BattlePassMarketType = {Shop_BattlePass_Pay = 1, Shop_BattlePass_Free = 2}
_enum("BattlePassMarketType", BattlePassMarketType)

function UIShopSecretTab:Constructor()
  self.tabNames = {
    [MarketType.Shop_BlackMarket] = StringTable.Get("str_shop_secret_black_name"),
    [MarketType.Shop_MysteryMarket] = StringTable.Get("str_shop_secret_secret_name"),
    [MarketType.Shop_WorldBoss] = StringTable.Get("str_shop_secret_worldboss_name"),
    [MarketType.Shop_BattlePass] = StringTable.Get("str_shop_bp_name"),
    [MarketType.Shop_Season] = StringTable.Get("str_shop_season")
  }
  self.battlePassTabNames = {
    [BattlePassMarketType.Shop_BattlePass_Pay] = StringTable.Get("str_shop_bp_name2"),
    [BattlePassMarketType.Shop_BattlePass_Free] = StringTable.Get("str_shop_bp_name")
  }
  self.nestSubTabNames = {}
  self.nestSubTabCont = {}
  self.SortTab = Cfg.cfg_shop_main_tab[ShopMainTabType.Secret].SubTab
  for k, v in pairs(self.SortTab) do
    if v >= MarketType.Shop_CampaignMarket then
      local tabName = ""
      local cfgTab = Cfg.cfg_shop_campaign_secret_tab[v]
      if cfgTab.TabName ~= nil then
        tabName = StringTable.Get(cfgTab.TabName)
      end
      self.tabNames[v] = tabName
    end
    self.nestSubTabCont[v] = self.nestSubTabCont[v] or 0
    if self.nestSubTabNames[v] == nil then
      self.nestSubTabNames[v] = {}
    end
    if v == MarketType.Shop_BattlePass then
      self.nestSubTabCont[v] = self.nestSubTabCont[v] + 1
      self.nestSubTabNames[v][self.nestSubTabCont[v]] = self.battlePassTabNames[self.nestSubTabCont[v]]
    end
  end
  self.subTabType = 1
  self.nestSubTabType = 1
  self.time = 0
  self.itemCountPerRow = 2
  self.itemTable = {}
  self.uiGoods = {}
  self.first = true
  self.remainSecond = 0
  self._countdownTimer = 0
  self._endtimeCampaignMarket = 0
  self._listItemTotalCount = 0
  self.bigCampaignList = {}
  self.smallCampaignList = {}
  self.buyState = 0
  self.bigBattlePassList = {}
  self.smallBattlePassList = {}
  self._showSeasonDataList = {}
  self._refreshTaskID = nil
  self.uiCommonAtlas = self:GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas)
end

function UIShopSecretTab:SetData(param)
  self:FlushTab()
  self:ResetTogglePos()
  self.show = true
  self.gotoType = param and param[1]
  local mainTabType = param and param[2]
  local subTabType = param and param[3] or self.visibleSortTab[1]
  self.targetShopId = param and param[4]
  if subTabType and subTabType == MarketType.Shop_BattlePass and param then
    self.nestSubTabType = self.nestSubTabCont[MarketType.Shop_BattlePass]
  end
  self:OnClickTabBtn(subTabType, self.nestSubTabType, true)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ChangeShopBg, ShopMainTabType.Secret)
  self:AddListener()
  self:CheckCampaignOpen(subTabType)
end

function UIShopSecretTab:ResetTogglePos()
  if self._toggleRect then
    self._toggleRect.anchoredPosition = Vector2(0, 0)
  end
end

function UIShopSecretTab:ExcuteHideLogic(callBack)
  self.show = false
  if callBack then
    callBack(self)
  end
  self:ClearFlag()
  for i, toggle in ipairs(self.allToggle) do
    if i == 1 then
      self.subTabType = self.visibleSortTab[1]
      if toggle then
        toggle:Select(true)
      end
    elseif toggle then
      toggle:Select(false)
    end
  end
  self:DetachEvent(GameEventType.ShopBuySuccess, self.ShopBuySuccess)
  self:DetachEvent(GameEventType.ActivityShopBuySuccess, self.ActivityShopBuySuccess)
  self:DetachEvent(GameEventType.CampaignComponentStepChange, self.OnComponentStepChange)
  self:DetachEvent(GameEventType.UpdateSecretBattlePassShop, self.ShopBuySuccess)
  self:DetachEvent(GameEventType.UpdateExchangeSeasonShop, self.ShopBuySuccess)
end

function UIShopSecretTab:Update(deltaTimeMS)
  if self.startTime then
    if self._isCutting then
      return
    end
    self._countdownTimer = self._countdownTimer + deltaTimeMS
    if self._countdownTimer > 20 then
      self._countdownTimer = 0
      self:CountDown()
    end
  end
end

function UIShopSecretTab:IsCampaignMarket()
  return self.subTabType >= MarketType.Shop_CampaignMarket
end

function UIShopSecretTab:IsBattlePass()
  return self.subTabType == MarketType.Shop_BattlePass
end

function UIShopSecretTab:IsSeason()
  return self.subTabType == MarketType.Shop_Season
end

function UIShopSecretTab:GetFormatTimerStr(deltaTime, txtColor)
  local id = {
    day = "str_activity_common_day",
    hour = "str_activity_common_hour",
    min = "str_activity_common_minute",
    zero = "str_activity_common_less_minute",
    over = "str_activity_error_107",
    format = "%s%s",
    clrFormat = "<color=#%s>%s</color>"
  }
  local clrFormat = id.clrFormat
  if txtColor == nil then
    clrFormat = id.format
    txtColor = ""
  end
  local day = 0
  local hour = 0
  local min = 0
  local second = 0
  if 0 <= deltaTime then
    day, hour, min, second = UIActivityHelper.Time2Str(deltaTime)
  end
  local timeStr
  if 0 < day and 0 < hour then
    timeStr = string.format(clrFormat, txtColor, day) .. StringTable.Get(id.day)
    timeStr = timeStr .. string.format(clrFormat, txtColor, hour) .. StringTable.Get(id.hour)
  elseif 0 < day then
    timeStr = string.format(clrFormat, txtColor, day) .. StringTable.Get(id.day)
  elseif 0 < hour and 0 < min then
    timeStr = string.format(clrFormat, txtColor, hour) .. StringTable.Get(id.hour)
    timeStr = timeStr .. string.format(clrFormat, txtColor, min) .. StringTable.Get(id.min)
  elseif 0 < hour then
    timeStr = string.format(clrFormat, txtColor, hour) .. StringTable.Get(id.hour)
  elseif 0 < min then
    timeStr = string.format(clrFormat, txtColor, min) .. StringTable.Get(id.min)
  else
    timeStr = string.format(clrFormat, txtColor, StringTable.Get(id.zero))
  end
  return timeStr
end

function UIShopSecretTab:CountDown()
  if self:IsCampaignMarket() then
    local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
    local curTime = svrTimeModule and math.floor(svrTimeModule:GetServerTime() * 0.001) or 0
    local end_time = self._endtimeCampaignMarket
    local time = end_time - curTime
    if 0 <= time then
      local timeStr = self:GetFormatTimerStr(math.max(time, 0))
      timeStr = string.format("<color=#00FFEA>%s</color>", timeStr)
      self.timeTxt:SetText(StringTable.Get("str_shop_buy_refresh_time_campaigntips", timeStr))
    else
      local timeStr = StringTable.Get("str_activity_error_107")
      timeStr = string.format("<color=#00FFEA>%s</color>", timeStr)
      self.timeTxt:SetText(timeStr)
    end
  elseif self.data ~= nil then
    local remainTime = self.data:GetRemainSecond()
    if not remainTime then
      return
    end
    local time = remainTime + 1
    local timeStr = UIShopToolFunctions.GetRemainTime(time)
    timeStr = string.format("<color=#00FFEA>%s</color>", timeStr)
    self.timeTxt:SetText(StringTable.Get("str_shop_buy_refresh_time_tips", timeStr))
    if time <= 0 then
      self:StartTask(function(TT)
        if not self.clientShop:SendProtocal(TT, ShopMainTabType.Secret, self.subTabType) then
          return
        end
        self:RefreshPanel()
      end)
    end
  end
end

function UIShopSecretTab:FlushTab()
  self.visibleSortTab = {}
  local shopCampaign, shopCampaignCfg = self.clientShop:GetSecretCampaign()
  for k, v in pairs(shopCampaignCfg) do
    table.insert(self.visibleSortTab, v.ID)
  end
  for k, v in pairs(self.SortTab) do
    if v < MarketType.Shop_CampaignMarket then
      table.insert(self.visibleSortTab, v)
    end
  end
  local toggle = self:GetUIComponent("UISelectObjectPath", "toggle")
  self._toggleRect = self:GetUIComponent("RectTransform", "toggle")
  local len = #self.visibleSortTab
  self.allToggle = toggle:SpawnObjects("UIShopSecretTabBtn", len)
  self.allToggleNestIndex = {}
  for i, v in ipairs(self.allToggle) do
    local subTabInex = self.visibleSortTab[i]
    if self.nestSubTabCont[subTabInex] ~= nil and self.nestSubTabCont[subTabInex] > 0 then
      if self.allToggleNestIndex[subTabInex] == nil then
        self.allToggleNestIndex[subTabInex] = 1
      else
        self.allToggleNestIndex[subTabInex] = self.allToggleNestIndex[subTabInex] + 1
      end
      local nestIndex = self.allToggleNestIndex[subTabInex]
      v:Init(subTabInex, self.nestSubTabNames[subTabInex][nestIndex], nestIndex, self.OnClickTabBtn, self)
    else
      v:Init(subTabInex, self.tabNames[subTabInex], 1, self.OnClickTabBtn, self)
    end
  end
end

function UIShopSecretTab:OnShow()
  self._anim = self:GetUIComponent("Animation", "UIShopSecretTab")
  self._refreshTaskID = nil
  self.timeTxt = self:GetUIComponent("UILocalizationText", "time")
  self.timeRect = self:GetUIComponent("RectTransform", "time")
  self.priceTxt = self:GetUIComponent("UILocalizationText", "price")
  self.priceLayout = self:GetUIComponent("UILocalizationText", "priceLayout")
  self.moneyIcon = self:GetUIComponent("Image", "moneyicon")
  self.curCountTxt = self:GetUIComponent("UILocalizationText", "curcount")
  self.maxCountTxt = self:GetUIComponent("UILocalizationText", "maxcount")
  self.refreshGO = self:GetGameObject("refreshpanel")
  self.scrollView = self:GetUIComponent("UIDynamicScrollView", "ScrollView")
  self.scrollViewCampaign = self:GetUIComponent("UIDynamicScrollView", "ScrollViewCampaign")
  self.scrollViewBattlePass = self:GetUIComponent("UIDynamicScrollView", "ScrollViewBattlePass")
  self.contentRect = self:GetUIComponent("RectTransform", "btnrefresh")
  self.btnRefreshGO = self:GetGameObject("btnrefresh")
  self.reftimeGO = self:GetGameObject("reftime")
  self.countTxtGO = self:GetGameObject("refcount")
  self.scrollView:InitListView(5, function(scrollView, index)
    return self:CreateItem(scrollView, index)
  end)
  self.scrollViewCampaign:InitListView(5, function(scrollView, index)
    return self:CreateItemCampaign(scrollView, index)
  end)
  self.scrollViewBattlePass:InitListView(5, function(scrollView, index)
    return self:CreateItemBattlePass(scrollView, index)
  end)
  self.shopModule = self:GetModule(ShopModule)
  self.clientShop = self.shopModule:GetClientShop()
  self.itemCountPerSeasonRow = 1
  self.scrollSeasonGo = self:GetGameObject("ScrollViewSeason")
  self.scrollViewSeason = self:GetUIComponent("UIDynamicScrollView", "ScrollViewSeason")
  self.scrollViewSeason:InitListView(0, function(_scrollView, index)
    return self:createItemSeason(_scrollView, index)
  end)
end

function UIShopSecretTab:OnHide()
  if self._refreshTaskID then
    GameGlobal.TaskManager():KillTask(self._refreshTaskID)
    self._refreshTaskID = nil
  end
end

function UIShopSecretTab:AddListener()
  self:AttachEvent(GameEventType.CampaignComponentStepChange, self.OnComponentStepChange)
  self:AttachEvent(GameEventType.ShopBuySuccess, self.ShopBuySuccess)
  self:AttachEvent(GameEventType.ActivityShopBuySuccess, self.ActivityShopBuySuccess)
  self:AttachEvent(GameEventType.UpdateSecretBattlePassShop, self.ShopBuySuccess)
  self:AttachEvent(GameEventType.UpdateExchangeSeasonShop, self.ShopBuySuccess)
end

function UIShopSecretTab:GetTabBtnBySubType(subTabType)
  for k, v in pairs(self.allToggle) do
    if v:GetSubType() == subTabType then
      return v
    end
  end
  return nil
end

function UIShopSecretTab:OnClickTabBtn(subTabType, nestSubTabType, force, noAni)
  if not force and self.subTabType == subTabType and self.nestSubTabType == nestSubTabType then
    return
  end
  self.subTabType = subTabType
  self.nestSubTabType = nestSubTabType
  self._isCutting = true
  for k, v in pairs(self.allToggle) do
    v:Select(v:GetSubType() == subTabType and v:GetNestSubType() == nestSubTabType)
  end
  local bSendCampaign = false
  if self:IsCampaignMarket() then
    local shopCampaign, shopCampaignCfg = self.clientShop:GetSecretCampaign(self.subTabType)
    if shopCampaign == nil or not shopCampaign:CheckCampaignOpen() then
      local msg = StringTable.Get("str_activity_error_109")
      ToastManager.ShowToast(msg)
      bSendCampaign = true
    else
      self._endtimeCampaignMarket = shopCampaign:GetSample().end_time
    end
  end
  self.buyState = self:RefreshBattlePassInfo()
  local bSendBattlePass = false
  if self:IsBattlePass() then
    bSendBattlePass = true
  end
  if bSendCampaign then
    self.first = false
    self:SendProtocal(subTabType, bSendCampaign)
  elseif bSendBattlePass then
    self.first = false
    self:SendProtocal(subTabType, bSendCampaign)
  elseif self.first then
    self.first = false
    self:RefreshPanel(subTabType)
  else
    self:SendProtocal(subTabType, bSendCampaign)
  end
end

function UIShopSecretTab:SendProtocal(subTabType, bSendCampaign, nestSubTabType)
  self:Lock("UIShopSecretTab_OnClickTabBtn")
  self._refreshTaskID = self:StartTask(function(TT)
    if bSendCampaign then
      local mainTabType = ShopMainTabType.Secret
      subTabType = self.clientShop:SendCampaign(TT, mainTabType, subTabType)
      self.subTabType = subTabType
    end
    if not self.clientShop:SendProtocal(TT, ShopMainTabType.Secret, subTabType) then
      self:UnLock("UIShopSecretTab_OnClickTabBtn")
      return
    end
    if bSendCampaign then
      self:RootUIOwner():FlushCampaignLimitedTime()
      self:FlushTab()
      for k, v in pairs(self.allToggle) do
        if nestSubTabType then
          v:Select(v:GetSubType() == subTabType and nestSubTabType == v:GetNestSubType())
        else
          v:Select(v:GetSubType() == subTabType)
        end
      end
    end
    self:RefreshPanel(subTabType)
    self:UnLock("UIShopSecretTab_OnClickTabBtn")
  end, self)
end

function UIShopSecretTab:CheckCampaignOpen(subTabType)
  self:RootUIOwner():FlushCampaignLimitedTime()
  if subTabType >= MarketType.Shop_CampaignMarket then
    return
  end
  if self.clientShop:HaveShopCampaignEnd() then
    local msg = StringTable.Get("str_activity_error_109")
    ToastManager.ShowToast(msg)
  end
end

function UIShopSecretTab:RefreshPanel(subTabType)
  self._isCutting = false
  if self.subTabType == MarketType.Shop_BlackMarket then
    self.scrollView.gameObject:SetActive(true)
    self.scrollViewCampaign:ResetListView()
    self.scrollViewCampaign.gameObject:SetActive(false)
    self.scrollViewBattlePass:ResetListView()
    self.scrollViewBattlePass.gameObject:SetActive(false)
    self.scrollViewSeason:ResetListView()
    self.scrollViewSeason.gameObject:SetActive(false)
    self.btnRefreshGO:SetActive(true)
    self.reftimeGO:SetActive(true)
    self.countTxtGO:SetActive(true)
  elseif self.subTabType == MarketType.Shop_MysteryMarket then
    self.scrollView.gameObject:SetActive(true)
    self.scrollViewCampaign:ResetListView()
    self.scrollViewCampaign.gameObject:SetActive(false)
    self.scrollViewBattlePass:ResetListView()
    self.scrollViewBattlePass.gameObject:SetActive(false)
    self.scrollViewSeason:ResetListView()
    self.scrollViewSeason.gameObject:SetActive(false)
    self.btnRefreshGO:SetActive(false)
    self.reftimeGO:SetActive(true)
    self.countTxtGO:SetActive(false)
  elseif self.subTabType == MarketType.Shop_WorldBoss then
    self.scrollView.gameObject:SetActive(true)
    self.scrollViewCampaign:ResetListView()
    self.scrollViewCampaign.gameObject:SetActive(false)
    self.scrollViewBattlePass:ResetListView()
    self.scrollViewBattlePass.gameObject:SetActive(false)
    self.scrollViewSeason:ResetListView()
    self.scrollViewSeason.gameObject:SetActive(false)
    self.btnRefreshGO:SetActive(false)
    self.reftimeGO:SetActive(false)
    self.countTxtGO:SetActive(false)
  elseif self.subTabType == MarketType.Shop_BattlePass then
    self.scrollView.gameObject:SetActive(false)
    self.scrollViewCampaign:ResetListView()
    self.scrollViewCampaign.gameObject:SetActive(false)
    self.scrollViewBattlePass.gameObject:SetActive(true)
    self.scrollViewSeason:ResetListView()
    self.scrollViewSeason.gameObject:SetActive(false)
    self.btnRefreshGO:SetActive(false)
    self.reftimeGO:SetActive(false)
    self.countTxtGO:SetActive(false)
  elseif self.subTabType == MarketType.Shop_Season then
    self.scrollView.gameObject:SetActive(false)
    self.scrollViewCampaign.gameObject:SetActive(false)
    self.scrollViewBattlePass.gameObject:SetActive(false)
    self.scrollViewSeason.gameObject:SetActive(true)
    self.btnRefreshGO:SetActive(false)
    self.reftimeGO:SetActive(false)
    self.countTxtGO:SetActive(false)
  elseif self.subTabType >= MarketType.Shop_CampaignMarket then
    self.scrollView.gameObject:SetActive(false)
    self.scrollViewCampaign.gameObject:SetActive(true)
    self.scrollViewBattlePass.gameObject:SetActive(false)
    self.scrollViewSeason:ResetListView()
    self.scrollViewSeason.gameObject:SetActive(false)
    self.btnRefreshGO:SetActive(false)
    self.reftimeGO:SetActive(true)
    self.countTxtGO:SetActive(false)
  end
  if self.subTabType == MarketType.Shop_BlackMarket then
    self.startTime = true
    self:RefreshStore()
    self:CountDown()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ShopTabChange, ShopMainTabType.Secret, MarketType.Shop_BlackMarket)
  elseif self.subTabType == MarketType.Shop_MysteryMarket then
    self.startTime = true
    self:RefreshStore()
    self:CountDown()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ShopTabChange, ShopMainTabType.Secret, MarketType.Shop_MysteryMarket)
  elseif self.subTabType == MarketType.Shop_WorldBoss then
    self.startTime = false
    self:RefreshStore()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ShopTabChange, ShopMainTabType.Secret, MarketType.Shop_WorldBoss)
  elseif self.subTabType == MarketType.Shop_BattlePass then
    self.startTime = false
    self:RefreshStoreBattlePass()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ShopTabChange, ShopMainTabType.Secret, MarketType.Shop_BattlePass)
  elseif self.subTabType == MarketType.Shop_Season then
    self.startTime = false
    self:RefreshStoreSeason()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ShopTabChange, ShopMainTabType.Secret, MarketType.Shop_Season)
  elseif self.subTabType >= MarketType.Shop_CampaignMarket then
    self.startTime = true
    self:RefreshStoreCampaign()
    self:CountDown()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ShopTabChange, ShopMainTabType.Secret, self.subTabType)
  end
  self:InAnimation()
end

function UIShopSecretTab:RefreshStore(noResetTime)
  if self.gotoType == ShopGotoType.SortGoods then
    self.clientShop:ReSortSecretGoods(self.subTabType, self.targetShopId)
    self:ClearFlag()
  end
  self.data = self.clientShop:GetSecretTabData(self.subTabType)
  if self.data then
    if not noResetTime then
      self.remainSecond = self.data:GetRemainSecond()
      if not self.remainSecond then
        self.remainSecond = 0
      end
    end
    self.curCountTxt:SetText(self.data:GetMaxCount() - self.data:GetCurCount())
    self.maxCountTxt:SetText(self.data:GetMaxCount())
    self.priceTxt:SetText(self.data:GetConsume())
    self.priceLayout:SetText(self.data:GetConsume())
    UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.contentRect)
    self.uiGoods = self.data:SortSecretGoods(self.subTabType, self.buyState)
    local _cfg = Cfg.cfg_top_tips[self.data:GetCostType()]
    self.moneyIcon.sprite = self.uiCommonAtlas:GetSprite(_cfg.Icon)
    self:RefreshScroll()
  end
end

function UIShopSecretTab:RefreshStoreCampaign()
  local shopCampaign, shopCampaignCfg = self.clientShop:GetSecretCampaign(self.subTabType)
  local itemComponent = shopCampaign:GetComponent(shopCampaignCfg.ComponentID)
  local itemComponentInfo = itemComponent:GetComponentInfo()
  self.bigCampaignList = {}
  self.smallCampaignList = {}
  for k, itemInfo in ipairs(itemComponentInfo.m_exchange_item_list) do
    local isSpecial = itemInfo.m_is_special
    if isSpecial then
      table.insert(self.bigCampaignList, itemInfo)
    else
      table.insert(self.smallCampaignList, itemInfo)
    end
  end
  self._poolItems = {}
  self._listItemTotalCount = #self.smallCampaignList
  local bigRow = #self.bigCampaignList
  local smallRow = self:_CalcTotalRow(self._listItemTotalCount)
  self.scrollViewCampaign:SetListItemCount(bigRow + smallRow)
  self.scrollViewCampaign:RefreshAllShownItem()
  if self.dontMove then
    self.dontMove = false
  else
    self.scrollViewCampaign:MovePanelToItemIndex(0, 0)
  end
end

function UIShopSecretTab:RefreshStoreBattlePass()
  self.data = self.clientShop:GetSecretTabData(self.subTabType)
  local uigoods = self.data:SortSecretGoods(self.subTabType, self.nestSubTabType, self.buyState)
  if uigoods then
    self.bigBattlePassList = {}
    self.smallBattlePassList = {}
    for k, goodInfo in ipairs(uigoods) do
      local itemid = goodInfo.cfg[ConfigKey.ConfigKey_ItemId]
      if itemid >= RoleAssetID.RoleAssetPetSkinBegin and itemid <= RoleAssetID.RoleAssetPetSkinEnd then
        local skinid = itemid - RoleAssetID.RoleAssetPetSkinBegin
        local petModule = GameGlobal.GetModule(PetModule)
        local haveSkin = petModule:HaveSkin(skinid)
        if haveSkin then
          Log.debug("###[UIShopSecretTab] season his shop have skin , skinid:", skinid)
        else
          table.insert(self.bigBattlePassList, goodInfo)
          self.shopModule:SetBattlePassTabNew(goodInfo.goodId)
        end
      else
        table.insert(self.smallBattlePassList, goodInfo)
        self.shopModule:SetBattlePassTabNew(goodInfo.goodId)
      end
    end
    self:RootUIOwner():CoFlushTabNew()
    for k, v in pairs(self.allToggle) do
      if v:GetSubType() == self.subTabType then
        v:ShopNew()
      end
    end
    self:RootUIOwner():FlushCampaignLimitedTime()
    self._poolItems = {}
    self._listItemTotalCount = #self.smallBattlePassList
    local bigRow = #self.bigBattlePassList
    local smallRow = self:_CalcTotalRow(self._listItemTotalCount)
    self.scrollViewBattlePass:SetListItemCount(bigRow + smallRow)
    self.scrollViewBattlePass:RefreshAllShownItem()
    if self.dontMove then
      self.dontMove = false
    else
      self.scrollViewBattlePass:MovePanelToItemIndex(0, 0)
    end
  end
end

function UIShopSecretTab:BtnRefreshOnClick()
  local cur = self.data:GetCurCount()
  local max = self.data:GetMaxCount()
  if cur >= max then
    ToastManager.ShowToast(StringTable.Get("str_shop_black_refresh_no_count"))
    return
  end
  local consume = self.data:GetConsume()
  local costType = self.data:GetCostType()
  local ownMoney = ClientShop.GetMoney(costType)
  if ownMoney == 0 then
    local itemMd = GameGlobal.GetModule(ItemModule)
    ownMoney = itemMd:GetItemCount(costType) or 0
  end
  if consume > ownMoney then
    if costType == RoleAssetID.RoleAssetGlow then
      GameGlobal.UIStateManager():ShowDialog("UIShopCurrency1To2", consume - ownMoney)
    else
      ToastManager.ShowToast(StringTable.Get("str_shop_black_refresh_no_diamond"))
    end
    return
  end
  local moneyCfg = Cfg.cfg_top_tips[costType]
  local str
  if self.subTabType == MarketType.Shop_BlackMarket then
    str = StringTable.Get("str_shop_black_refresh_box", consume, StringTable.Get(moneyCfg.Title))
  elseif self.subTabType == MarketType.Shop_MysteryMarket then
    str = StringTable.Get("str_shop_maze_refresh_box", consume, StringTable.Get(moneyCfg.Title))
  elseif self.subTabType == MarketType.Shop_WorldBoss then
    str = StringTable.Get("str_shop_maze_refresh_box", consume, StringTable.Get(moneyCfg.Title))
  end
  PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, "", str, function(param)
    self:StartTask(function(TT)
      self:Lock("UIShopSecretTab.Refresh")
      local shopCode, marketinfo
      if self.subTabType == MarketType.Shop_BlackMarket then
        shopCode, marketinfo = self.shopModule:ApplyRefreshBlackMarket(TT)
      elseif self.subTabType == MarketType.Shop_MysteryMarket then
        shopCode, marketinfo = self.shopModule:ApplyRefreshMysteryMarket(TT)
      elseif self.subTabType == MarketType.Shop_WorldBoss then
      end
      self:UnLock("UIShopSecretTab.Refresh")
      if marketinfo ~= {} and marketinfo ~= nil then
        local result = ClientShop.CheckShopCode(shopCode)
        if result then
          local goodsconfig
          if self.subTabType == MarketType.Shop_BlackMarket then
            goodsconfig = self.shopModule:GetBlackMarketConfig()
          elseif self.subTabType == MarketType.Shop_MysteryMarket then
            goodsconfig = self.shopModule:GetMysteryMarketConfig()
          elseif self.subTabType == MarketType.Shop_WorldBoss then
            goodsconfig = self.shopModule:RequestWorldBossMarket()
          end
          self.clientShop:SetSecretTabData(marketinfo, goodsconfig, self.subTabType)
          self:RefreshStore(true)
        end
      end
    end, self)
  end, nil, function(param)
    Log.debug("sale cancel. .")
  end, nil)
end

function UIShopSecretTab:RefreshBattlePassInfo()
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo_Local(ECampaignType.CAMPAIGN_TYPE_BATTLEPASS, ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_LV_REWARD, ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_BUY_GIFT)
  if not self._campaign:CheckCampaignOpen() then
    return 0
  end
  self._buyGiftComponentInfo = self._campaign:GetComponentInfo(ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_BUY_GIFT)
  return self._buyGiftComponentInfo.m_buy_state
end

function UIShopSecretTab:RefreshScroll()
  self._poolItems = {}
  self._listItemTotalCount = #self.uiGoods
  local row = self:_CalcTotalRow(self._listItemTotalCount)
  self.scrollView:SetListItemCount(row)
  self.scrollView:RefreshAllShownItem()
  if self.dontMove then
    self.dontMove = false
  else
    self.scrollView:MovePanelToItemIndex(0, 0)
  end
end

function UIShopSecretTab:CreateItem(scrollView, index)
  if index < 0 then
    return nil
  end
  local item = scrollView:NewListViewItem("item")
  local pool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if self._poolItems ~= nil then
    self._poolItems[index] = pool
  end
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    pool:SpawnObjects("UIShopSecretGood", self.itemCountPerRow)
  end
  local rowList = pool:GetAllSpawnList()
  for i = 1, self.itemCountPerRow do
    local item = rowList[i]
    local itemIndex = index * self.itemCountPerRow + i
    local data = self.uiGoods[itemIndex]
    if data then
      item:Enable(true)
      local targetShopId
      if self.gotoType == ShopGotoType.OpenShopConfirm then
        targetShopId = self.targetShopId
        self:ClearFlag()
      end
      item:Refresh(self.subTabType, data, targetShopId)
      self.itemTable[itemIndex] = item
    else
      item:Enable(false)
    end
  end
  return item
end

function UIShopSecretTab:CreateItemCampaign(scrollView, index)
  if index < 0 then
    return nil
  end
  if not self:IsCampaignMarket() then
    return nil
  end
  local item
  local spawnCount = 0
  local bigRow = #self.bigCampaignList
  local smallRow = self:_CalcTotalRow(self._listItemTotalCount)
  if index < bigRow then
    spawnCount = 1
    item = scrollView:NewListViewItem("itemBig")
  else
    spawnCount = self.itemCountPerRow
    item = scrollView:NewListViewItem("item")
  end
  local pool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if self._poolItems ~= nil then
    self._poolItems[index] = pool
  end
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    pool:SpawnObjects("UIShopSecretGoodCampaign", spawnCount)
  end
  local rowList = pool:GetAllSpawnList()
  for i = 1, spawnCount do
    local item = rowList[i]
    local data
    local itemIndex = 0
    if index < bigRow then
      itemIndex = index + 1
      data = self.bigCampaignList[index + 1]
    else
      itemIndex = bigRow + (index - bigRow) * self.itemCountPerRow + i
      data = self.smallCampaignList[(index - bigRow) * self.itemCountPerRow + i]
    end
    if data then
      item:Enable(true)
      item:Refresh(self.subTabType, data, targetShopId)
      item:ActivityEndCb(function(subTabType)
        self:SendProtocal(subTabType, true, BattlePassMarketType.Shop_BattlePass_Pay)
      end)
      self.itemTable[itemIndex] = item
    else
      item:Enable(false)
    end
  end
  return item
end

function UIShopSecretTab:CreateItemBattlePass(scrollView, index)
  if index < 0 then
    return nil
  end
  local item
  local spawnCount = 0
  local bigRow = #self.bigBattlePassList
  if index < bigRow then
    spawnCount = 1
    item = scrollView:NewListViewItem("itemSkin")
  else
    spawnCount = self.itemCountPerRow
    item = scrollView:NewListViewItem("item")
  end
  local pool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if self._poolItems ~= nil then
    self._poolItems[index] = pool
  end
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    pool:SpawnObjects("UIShopSecretGoodBattlePass", spawnCount)
  end
  local rowList = pool:GetAllSpawnList()
  for i = 1, spawnCount do
    local item = rowList[i]
    local data
    local itemIndex = 0
    if index < bigRow then
      itemIndex = index + 1
      data = self.bigBattlePassList[index + 1]
    else
      itemIndex = bigRow + (index - bigRow) * self.itemCountPerRow + i
      data = self.smallBattlePassList[(index - bigRow) * self.itemCountPerRow + i]
    end
    if data then
      item:Enable(true)
      item:Refresh(self.subTabType, data, targetShopId)
      item:OnChildShow()
      item:RefreshPrice(self.subTabType, data, targetShopId)
      if index < bigRow then
        item:OnChildShow()
        item:RefreshSkin()
      end
      local lockText = "str_shop_bp_tips1"
      if data.cfg[ConfigKey.ConfigKey_BattleType] > self.buyState + 1 then
        local lockText = "str_shop_bp_tips1"
        if data.cfg[ConfigKey.ConfigKey_BattleType] == 3 then
          lockText = "str_shop_bp_tips2"
        end
        item:RefreshLock(true, lockText)
      else
        item:RefreshLock(false)
      end
      self.itemTable[itemIndex] = item
    else
      item:Enable(false)
    end
  end
  return item
end

function UIShopSecretTab:GetSkinItem(goodId)
  local item = self._skinData:GetGoodById(goodId)
  return item
end

function UIShopSecretTab:_CalcTotalRow(itemTotalCount)
  local row, mod = modf(itemTotalCount / self.itemCountPerRow)
  if mod ~= 0 then
    row = row + 1
  end
  self._listItemTotalRow = row
  return self._listItemTotalRow
end

function UIShopSecretTab:ShopBuySuccess()
  self.dontMove = true
  self:OnClickTabBtn(self.subTabType, self.nestSubTabType, true, true)
end

function UIShopSecretTab:OnComponentStepChange(campaign_id, component_id, component_step)
  if self._campaign and self._campaign._id == campaign_id then
    self:RefreshPanel()
  end
end

function UIShopSecretTab:ActivityShopBuySuccess()
  self.dontMove = true
  self:OnClickTabBtn(self.subTabType, self.nestSubTabType, true, true)
end

function UIShopSecretTab:ChangeSecondToTime(second)
  local timeTable = {
    hour = 0,
    min = 0,
    sec = 0
  }
  if second == 0 then
    return timeTable
  end
  local sec = modf(second % 60)
  local minAll = modf((second - sec) / 60)
  local min = modf(minAll % 60)
  local hour = modf((minAll - min) / 60)
  if hour < 10 then
    hour = "0" .. hour
  end
  if min < 10 then
    min = "0" .. min
  end
  if sec < 10 then
    sec = "0" .. sec
  end
  timeTable.hour = hour
  timeTable.min = min
  timeTable.sec = sec
  return timeTable
end

function UIShopSecretTab:ClearFlag()
  self.gotoType = nil
  self.targetShopId = nil
end

function UIShopSecretTab:GetGood(index)
  return self.uiGoods and self.uiGoods[index]:GetGameObject("bg")
end

function UIShopSecretTab:GetNestSubTab()
  return self.nestSubTabType
end

function UIShopSecretTab:InAnimation()
  if self._poolItems == nil then
    return
  end
  for index = 0, math.maxinteger do
    local pool = self._poolItems[index]
    if pool == nil then
      break
    end
    local rowList = pool:GetAllSpawnList()
    for ik, item in pairs(rowList) do
      if item ~= nil then
        item:GetGameObject():SetActive(false)
      end
    end
  end
  if self._taskID then
    self:ReleaseSafeTasks()
    self._taskID = nil
  end
  self._taskID = self:StartSafeTask("UIShopSecretTab::InAnimation", function(lockName, TT)
    YIELD(TT)
    local animLength = 0
    for index = 0, math.maxinteger do
      if not self._poolItems then
        Log.debug("###[UIShopSecretTab] play anim , pools is reset , wait next play .")
        self._poolItems = nil
        return
      end
      local pool = self._poolItems[index]
      if pool == nil then
        break
      end
      local rowList = pool:GetAllSpawnList()
      for ik, item in pairs(rowList) do
        local data
        if self:IsCampaignMarket() then
          local bigRow = #self.bigCampaignList
          if index < bigRow then
            data = self.bigCampaignList[index + 1]
          else
            data = self.smallCampaignList[(index - bigRow) * self.itemCountPerRow + ik]
          end
        elseif self:IsBattlePass() then
          local bigRow = #self.bigBattlePassList
          if index < bigRow then
            data = self.bigBattlePassList[index + 1]
          else
            data = self.smallBattlePassList[(index - bigRow) * self.itemCountPerRow + ik]
          end
        elseif self:IsSeason() then
          local idx = index * self.itemCountPerSeasonRow + 1
          local dataList = self._showSeasonDataList[idx]
          if dataList then
            data = dataList.list[ik]
          end
        else
          local itemIndex = index * self.itemCountPerRow + ik
          data = self.uiGoods[itemIndex]
        end
        if data then
          item:GetGameObject():SetActive(true)
          animLength = math.max(animLength, item:PlayInAnimation())
        end
      end
      YIELD(TT)
    end
    if 0 < animLength then
      YIELD(TT, animLength)
    end
    self._taskID = nil
  end)
end

function UIShopSecretTab:ShowSelf()
  self._anim:Stop()
  self._anim:Play()
end

function UIShopSecretTab:HideSelf()
end

function UIShopSecretTab:createItemSeason(_scrollView, _index)
  if _index < 0 or not self.subTabType then
    return nil
  end
  local count = 1
  local idx = _index * self.itemCountPerSeasonRow + 1
  local data = self._showSeasonDataList[idx]
  local itemName
  local isSpecial = false
  if data.sin then
    isSpecial = true
    count = 1
    itemName = "itemSpecial"
  else
    isSpecial = false
    count = #data.list
    itemName = "itemNormal"
  end
  local item = _scrollView:NewListViewItem(itemName)
  local pool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if self._poolItems ~= nil then
    self._poolItems[_index] = pool
  end
  pool:SpawnObjects("UIShopExchangeSeasonItem", count)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
  end
  local rowList = pool:GetAllSpawnList()
  for i = 1, count do
    local widget = rowList[i]
    local singleData = data.list[i]
    if singleData then
      widget:Enable(true)
      widget:Special(isSpecial)
      widget:SetData(singleData)
    else
      widget:Enable(false)
    end
  end
  return item
end

function UIShopSecretTab:RefreshStoreSeason()
  self.shopModule:ClearExchangeTab_SeasonNew()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ShopNew)
  self._showSeasonDataList = {}
  self.data = self.clientShop:GetSecretTabData(self.subTabType)
  local uigoods = self.data:SortSecretGoods(self.subTabType, self.nestSubTabType, self.buyState)
  local filterList = {}
  if uigoods then
    self.bigBattlePassList = {}
    self.smallBattlePassList = {}
    for k, value in ipairs(uigoods) do
      if value:GetRemainCount() > 0 then
        local AddBagNum = value:AddBagNum()
        if AddBagNum and AddBagNum == 1 then
          local itemid = value:GetItemId()
          if itemid >= RoleAssetID.RoleAssetPetSkinBegin and itemid <= RoleAssetID.RoleAssetPetSkinEnd then
            local skinid = itemid - RoleAssetID.RoleAssetPetSkinBegin
            local petModule = GameGlobal.GetModule(PetModule)
            local haveSkin = petModule:HaveSkin(skinid)
            if haveSkin then
              Log.debug("###[UIShopSecretTab] season his shop have skin , skinid:", skinid)
            else
              table.insert(filterList, value)
            end
          elseif itemid >= RoleAssetID.RoleAssetPetBegin and itemid <= RoleAssetID.RoleAssetPetEnd then
            local petModule = GameGlobal.GetModule(PetModule)
            local have = petModule:GetPetByTemplateId(itemid)
            if have then
              Log.debug("###[UIShopSecretTab] season his shop have pet , petid:", itemid)
            else
              table.insert(filterList, value)
            end
          else
            local haveCount = GameGlobal.GetModule(ItemModule):GetItemCount(itemid)
            if value:GetRemainCount() - haveCount > 0 then
              table.insert(filterList, value)
            end
          end
        else
          table.insert(filterList, value)
        end
      end
    end
    local insertIdx = 0
    local insertData
    local goOn = false
    for index, value in ipairs(filterList) do
      if value:GrandPrize() then
        insertIdx = insertIdx + 1
        insertData = ExchangeSeasonShopViewData:New()
        insertData:AddData(value)
        insertData.sin = true
        self._showSeasonDataList[insertIdx] = insertData
        goOn = false
      elseif goOn then
        insertData:AddData(value)
        goOn = false
      else
        insertIdx = insertIdx + 1
        insertData = ExchangeSeasonShopViewData:New()
        insertData:AddData(value)
        insertData.sin = false
        self._showSeasonDataList[insertIdx] = insertData
        goOn = true
      end
    end
  end
  self._poolItems = {}
  local reScroll = false
  if self.dontMove then
    self.dontMove = false
  else
    reScroll = true
  end
  local row = #self._showSeasonDataList
  self.scrollViewSeason:SetListItemCount(row)
  if reScroll then
    self.scrollViewSeason:MovePanelToItemIndex(0, 0)
  else
    self.scrollViewSeason:RefreshAllShownItem()
  end
end
