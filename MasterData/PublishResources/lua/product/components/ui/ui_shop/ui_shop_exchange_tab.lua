_class("UIShopExchangeTab", UICustomWidget)
UIShopExchangeTab = UIShopExchangeTab

function UIShopExchangeTab:Constructor()
  self.tabNames = {
    [MarketType.Shop_XingZuan] = StringTable.Get("str_shop_xingzuan"),
    [MarketType.Shop_HuiYao] = StringTable.Get("str_shop_huiyao"),
    [MarketType.Shop_HongPiao] = StringTable.Get("str_shop_hongpiao"),
    [MarketType.Shop_GuangPo] = StringTable.Get("str_shop_guangpo"),
    [MarketType.Shop_Season] = StringTable.Get("str_shop_season"),
    [MarketType.Shop_BlackMarket] = StringTable.Get("str_shop_secret_black_name")
  }
  self.SortTab = Cfg.cfg_shop_main_tab[ShopMainTabType.Exchange].SubTab
end

function UIShopExchangeTab:OnShow()
  self._shopModule = self:GetModule(ShopModule)
  self._clienShop = self._shopModule:GetClientShop()
  self._timeModule = self:GetModule(SvrTimeModule)
  self._curShop = nil
  self._anim = self:GetUIComponent("Animation", "UIShopExchangeTab")
  self._remainTime = self:GetUIComponent("UILocalizationText", "time")
  self._refreshPanal = self:GetGameObject("refreshpanel")
  self.itemCountPerRow = 2
  self.itemCountPerSeasonRow = 1
  self.scrollGo = self:GetGameObject("ScrollView")
  self.scrollView = self:GetUIComponent("UIDynamicScrollView", "ScrollView")
  self.scrollView:InitListView(1, function(_scrollView, index)
    return self:createItem(_scrollView, index)
  end)
  self.scrollSeasonGo = self:GetGameObject("ScrollViewSeason")
  self.scrollViewSeason = self:GetUIComponent("UIDynamicScrollView", "ScrollViewSeason")
  self.scrollViewSeason:InitListView(0, function(_scrollView, index)
    return self:createItemSeason(_scrollView, index)
  end)
  local tglGroup = self:GetUIComponent("ToggleGroup", "toggle")
  self._toggleRect = self:GetUIComponent("RectTransform", "toggle")
  local shopPool = self:GetUIComponent("UISelectObjectPath", "toggle")
  local toggleCount = #self.SortTab
  shopPool:SpawnObjects("UIShopSecretTabBtn", toggleCount)
  self._shopBtns = {}
  local shopBtns = shopPool:GetAllSpawnList()
  for index, btn in ipairs(shopBtns) do
    local marketType = self.SortTab[index]
    btn:Init(marketType, self.tabNames[marketType], 1, function()
      self:OnChangeShop(marketType)
    end)
    self._shopBtns[marketType] = btn
  end
  local refreshBtnGen = self:GetUIComponent("UISelectObjectPath", "RefreshBtnArea")
  self._refreshBtnAreaGo = self:GetGameObject("RefreshBtnArea")
  self._refreshBtnWidget = refreshBtnGen:SpawnObject("UIWidgetShopRefreshBtn")
  self._refreshBtnWidget:SetData(function()
    self:BtnRefreshOnClick()
  end)
  self._refreshBtnAreaGo:SetActive(false)
  self._countDownTimer = nil
  self._btnOneKeyBuyGO = self:GetGameObject("BtnOneKeyBuy")
end

function UIShopExchangeTab:OnHide()
  if self._countDownTimer then
    GameGlobal.Timer():CancelEvent(self._countDownTimer)
    self._countDownTimer = nil
  end
end

function UIShopExchangeTab:SetData(params)
  local default = self.SortTab[1]
  if params and params[3] then
    default = params[3]
  end
  self:OnChangeShop(default)
  self:ResetTogglePos()
  self:AttachEvent(GameEventType.ShopBuySuccess, self.onBuySuccess)
  self:AttachEvent(GameEventType.UpdateExchangeSeasonShop, self.onBuySuccess)
end

function UIShopExchangeTab:ResetTogglePos()
  if self._toggleRect then
    self._toggleRect.anchoredPosition = Vector2(0, 0)
  end
end

function UIShopExchangeTab:Update()
end

function UIShopExchangeTab:OnChangeShop(shop)
  if self._curShop == shop then
    return
  end
  self:StartTask(self.reqRefreshShop, self, shop)
end

function UIShopExchangeTab:reqRefreshShop(TT, shop)
  local success = self:requestShopData(TT, shop)
  if success then
    self:showShop(shop)
  end
end

function UIShopExchangeTab:showShop(shop)
  if self._curShop then
    self._shopBtns[self._curShop]:Select(false)
  end
  self._curShop = shop
  if self._curShop then
    self._shopBtns[self._curShop]:Select(true)
  end
  self._refreshBtnAreaGo:SetActive(false)
  self._refreshPanal:SetActive(false)
  self._btnOneKeyBuyGO:SetActive(false)
  if self._countDownTimer then
    GameGlobal.Timer():CancelEvent(self._countDownTimer)
    self._countDownTimer = nil
  end
  if self._curShop == MarketType.Shop_XingZuan then
    self:showCountDown()
    self._refreshPanal:SetActive(true)
  elseif self._curShop == MarketType.Shop_HuiYao then
    self:showCountDown()
    self._refreshPanal:SetActive(true)
  elseif self._curShop == MarketType.Shop_GuangPo then
  elseif self._curShop == MarketType.Shop_Season then
    self._shopModule:ClearExchangeTab_SeasonNew()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ShopNew)
  elseif self._curShop == MarketType.Shop_BlackMarket then
    self:showCountDown()
    self._refreshPanal:SetActive(true)
    self._refreshBtnAreaGo:SetActive(true)
    self._btnOneKeyBuyGO:SetActive(true)
  end
  self:refreshGoods(true)
  self:refreshRefreshBtnArea()
  self:InAnimation()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ShopTabChange, ShopMainTabType.Exchange, self._curShop)
end

function UIShopExchangeTab:showCountDown()
  if self._countDownTimer then
    GameGlobal.Timer():CancelEvent(self._countDownTimer)
    self._countDownTimer = nil
  end
  
  local function refresh()
    local time = self._clienShop:GetExchangeShopResetTime()
    self._remainTime:SetText(StringTable.Get("str_shop_black_refresh", UIShopToolFunctions.GetRemainTime(time)))
    if time <= 0 then
      self:onTimeUp()
    end
  end
  
  refresh()
  self._countDownTimer = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, refresh)
end

function UIShopExchangeTab:onTimeUp()
  if self._countDownTimer then
    GameGlobal.Timer():CancelEvent(self._countDownTimer)
    self._countDownTimer = nil
  end
  self:StartTask(self.reqRefreshShop, self, self._curShop)
end

function UIShopExchangeTab:refreshGoods(reScroll)
  self._poolItems = {}
  if self._curShop == MarketType.Shop_Season then
    self.scrollSeasonGo:SetActive(true)
    self.scrollGo:SetActive(false)
    self:CreateSeasonShopData()
    local row = #self._showSeasonDataList
    self.scrollViewSeason:SetListItemCount(row)
    if reScroll then
      self.scrollViewSeason:MovePanelToItemIndex(0, 0)
    else
      self.scrollViewSeason:RefreshAllShownItem()
    end
  else
    self.scrollSeasonGo:SetActive(false)
    self.scrollGo:SetActive(true)
    local row = math.ceil(table.count(self._clienShop:GetExchangeShopData(self._curShop)) / self.itemCountPerRow)
    self.scrollView:SetListItemCount(row)
    self.scrollView:RefreshAllShownItem()
    if reScroll then
      self.scrollView:MovePanelToItemIndex(0, 0)
    end
  end
end

function UIShopExchangeTab:refreshRefreshBtnArea()
  if self._curShop == MarketType.Shop_BlackMarket then
    local data = self._clienShop:GetExchangeShopStoreData()
    self._refreshBtnWidget:RefreshInfo(data:GetCurCount(), data:GetMaxCount(), data:GetConsume(), data:GetCostType())
  end
end

function UIShopExchangeTab:CreateSeasonShopData()
  self._showSeasonDataList = {}
  self._seasonDataList = self._clienShop:GetExchangeShopData(self._curShop)
  local filterList = {}
  for index, value in ipairs(self._seasonDataList) do
    if value:GetRemainCount() > 0 then
      local AddBagNum = value:AddBagNum()
      if AddBagNum and AddBagNum == 1 then
        local itemid = value:GetItemId()
        if itemid >= RoleAssetID.RoleAssetPetSkinBegin and itemid <= RoleAssetID.RoleAssetPetSkinEnd then
          local skinid = itemid - RoleAssetID.RoleAssetPetSkinBegin
          local petModule = GameGlobal.GetModule(PetModule)
          local haveSkin = petModule:HaveSkin(skinid)
          if haveSkin then
            Log.debug("###[UIShopExchangeTab] season his shop have skin , skinid:", skinid)
          else
            table.insert(filterList, value)
          end
        elseif itemid >= RoleAssetID.RoleAssetPetBegin and itemid <= RoleAssetID.RoleAssetPetEnd then
          local petModule = GameGlobal.GetModule(PetModule)
          local have = petModule:GetPetByTemplateId(itemid)
          if have then
            Log.debug("###[UIShopExchangeTab] season his shop have pet , petid:", itemid)
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

function UIShopExchangeTab:createItemSeason(_scrollView, _index)
  if _index < 0 or not self._curShop then
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

function UIShopExchangeTab:createItem(_scrollView, _index)
  if _index < 0 or not self._curShop then
    return nil
  end
  local item = _scrollView:NewListViewItem("item")
  local pool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if self._poolItems ~= nil then
    self._poolItems[_index] = pool
  end
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    pool:SpawnObjects("UIShopSecretGood", self.itemCountPerRow)
  end
  local goods = self._clienShop:GetExchangeShopData(self._curShop)
  local rowList = pool:GetAllSpawnList()
  for i = 1, self.itemCountPerRow do
    local item = rowList[i]
    local itemIndex = _index * self.itemCountPerRow + i
    local data = goods[itemIndex]
    if data then
      item:Enable(true)
      local targetShopId
      if self.gotoType == ShopGotoType.OpenShopConfirm then
        targetShopId = self.targetShopId
        self:ClearFlag()
      end
      item:Refresh(self._curShop, data, targetShopId)
    else
      item:Enable(false)
    end
  end
  return item
end

function UIShopExchangeTab:ExcuteHideLogic(cb)
  if cb then
    cb(self)
  end
  if self._countDownTimer then
    GameGlobal.Timer():CancelEvent(self._countDownTimer)
    self._countDownTimer = nil
  end
  if self._curShop then
    self._shopBtns[self._curShop]:Select(false)
  end
  self._curShop = nil
  self:DetachEvent(GameEventType.ShopBuySuccess, self.onBuySuccess)
  self:DetachEvent(GameEventType.UpdateExchangeSeasonShop, self.onBuySuccess)
end

function UIShopExchangeTab:ClearFlag()
  self.gotoType = nil
  self.targetShopId = nil
end

function UIShopExchangeTab:onBuySuccess()
  self:StartTask(self.refreshCurShop, self)
end

function UIShopExchangeTab:refreshCurShop(TT)
  local success = self:requestShopData(TT, self._curShop)
  if success then
    self:refreshGoods(false)
  end
end

function UIShopExchangeTab:requestShopData(TT, shop)
  self:Lock(self:GetName())
  local res
  local success = false
  if shop == MarketType.Shop_XingZuan then
    res = self._shopModule:RequestXingzuanMarket(TT)
  elseif shop == MarketType.Shop_HuiYao then
    res = self._shopModule:RequestHuiyaoMarket(TT)
  elseif shop == MarketType.Shop_GuangPo then
    res = self._shopModule:RequestGlowMarket(TT)
  elseif shop == MarketType.Shop_HongPiao then
    res = self._shopModule:RequestHongPiaoMarket(TT)
  elseif shop == MarketType.Shop_Season then
    res = self._shopModule:RequestSeasonMarket(TT)
  elseif shop == MarketType.Shop_BlackMarket then
    res = self._shopModule:RequestGetBlackMarket(TT)
  end
  if res then
    if res:GetSucc() then
      self._clienShop:RefreshExchangeShopData(shop)
      success = true
    elseif res:GetResult() == SHOP_CODE.SHOP_SHOPTYPE_ERROR then
      ToastManager.ShowToast(StringTable.Get("str_shop_subtype_error"))
    else
      ToastManager.ShowToast(StringTable.Get("str_shop_unkown_error", res:GetResult()))
    end
  end
  self:UnLock(self:GetName())
  return success
end

function UIShopExchangeTab:InAnimation()
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
  local goods = self._clienShop:GetExchangeShopData(self._curShop)
  self:StartSafeTask("UIShopExchangeTab::InAnimation", function(lockName, TT)
    local animLength = 0
    for index = 0, math.maxinteger do
      if not self._poolItems then
        Log.debug("###[UIShopExchangeTab] play anim , pools is reset , wait next play .")
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
        if self._curShop == MarketType.Shop_Season then
          local idx = index * self.itemCountPerSeasonRow + 1
          local dataList = self._showSeasonDataList[idx]
          data = dataList.list[ik]
        else
          local itemIndex = index * self.itemCountPerRow + ik
          data = goods[itemIndex]
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
  end)
end

function UIShopExchangeTab:ShowSelf()
  self._anim:Stop()
  self._anim:Play()
end

function UIShopExchangeTab:HideSelf()
end

function UIShopExchangeTab:BtnRefreshOnClick()
  local data = self._clienShop:GetExchangeShopStoreData()
  local cur = data:GetCurCount()
  local max = data:GetMaxCount()
  if cur >= max then
    ToastManager.ShowToast(StringTable.Get("str_shop_black_refresh_no_count"))
    return
  end
  local consume = data:GetConsume()
  local costType = data:GetCostType()
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
  if self._curShop == MarketType.Shop_BlackMarket then
    str = StringTable.Get("str_shop_black_refresh_box", consume, StringTable.Get(moneyCfg.Title))
  end
  PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, "", str, function(param)
    self:StartTask(function(TT)
      self:Lock("UIShopSecretTab.Refresh")
      local shopCode, marketinfo
      if self._curShop == MarketType.Shop_BlackMarket then
        shopCode, marketinfo = self._shopModule:ApplyRefreshBlackMarket(TT)
      end
      self:UnLock("UIShopSecretTab.Refresh")
      if marketinfo ~= {} and marketinfo ~= nil then
        local result = ClientShop.CheckShopCode(shopCode)
        if result and self._curShop == MarketType.Shop_BlackMarket then
          self._clienShop:RefreshExchangeShopData(self._curShop)
          self:showShop(self._curShop)
        end
      end
    end, self)
  end, nil, function(param)
    Log.debug("sale cancel. .")
  end, nil)
end

function UIShopExchangeTab:BtnOneKeyBuyOnClick()
  local goods = self._clienShop:GetExchangeShopData(self._curShop)
  local totalPrice = 0
  for i = 1, #goods do
    local good = goods[i]
    if 0 < good:GetRemainCount() then
      totalPrice = totalPrice + good:GetSalePrice()
    end
  end
  if totalPrice == 0 then
    ToastManager.ShowToast(StringTable.Get("str_shop_exchange_black_one_key_buy_nothing_left"))
    return
  end
  local roleModule = GameGlobal.GameLogic():GetModule(RoleModule)
  local goldNum = roleModule:GetGold()
  if totalPrice > goldNum then
    ToastManager.ShowToast(StringTable.Get("str_shop_gold_not_enough"))
    return
  end
  PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, "", StringTable.Get("str_shop_exchange_black_one_key_buy_confirm"), function()
    self:StartTask(function(TT)
      local shopModule = self:GetModule(ShopModule)
      self:Lock("UIShopExchangeTab:BtnOneKeyBuyOnClick")
      local allRemainGoods = {}
      local assetList = {}
      for i = 1, #goods do
        local good = goods[i]
        if good:GetRemainCount() > 0 then
          local goodBuyInfo = EventBuyItemOnce:New()
          goodBuyInfo.goods_id = good:GetGoodId()
          goodBuyInfo.buy_num = 1
          goodBuyInfo.currency_type = RoleAssetID.RoleAssetGold
          goodBuyInfo.selling_price = good:GetSalePrice()
          allRemainGoods[#allRemainGoods + 1] = goodBuyInfo
          local roleAsset = RoleAsset:New()
          roleAsset.assetid = good:GetItemId()
          roleAsset.count = good:GetItemCount()
          assetList[#assetList + 1] = roleAsset
        end
      end
      local result = shopModule:BuyItem(TT, MarketType.Shop_BlackMarket, nil, nil, nil, nil, allRemainGoods)
      self:UnLock("UIShopExchangeTab:BtnOneKeyBuyOnClick")
      if ClientShop.CheckShopCode(result) then
        self:ShowDialog("UIGetItemController", assetList, function()
          GameGlobal.EventDispatcher():Dispatch(GameEventType.ShopBuySuccess)
        end)
      end
    end, self)
  end)
end
