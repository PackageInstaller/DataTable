_class("UIShopHomelandPrecious", UIController)
UIShopHomelandPrecious = UIShopHomelandPrecious

function UIShopHomelandPrecious:Constructor()
  self._shopModule = self:GetModule(ShopModule)
  self._clientShop = self._shopModule:GetClientShop()
  self._shopData = self._clientShop:GetHomelandShopData()
  self._deltaTime = 0
  self._perColumn = 8
  self._currentIndex = 0
  self._items = {}
end

function UIShopHomelandPrecious:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UIShopHomelandPrecious:OnShow(uiParams)
  self._data = uiParams[1]
  self:_GetComponents()
  self:_OnValue()
  self:AttachEvent(GameEventType.ShopBuySuccess, self._OnBuySuccess)
  self:AttachEvent(GameEventType.OpenShop, self.OpenShop)
end

function UIShopHomelandPrecious:_GetComponents()
  self._preciousNameOutLineText = self:GetUIComponent("UILocalizationText", "PreciousNameOutLineText")
  self._preciousName = self:GetUIComponent("UILocalizedTMP", "PreciousName")
  self._content = self:GetUIComponent("UISelectObjectPath", "Content")
  self._refreshTime = self:GetUIComponent("UILocalizationText", "RefreshTime")
  local menu = self:GetUIComponent("UISelectObjectPath", "CurrencyMenu")
  self._currencyMenu = menu:SpawnObject("UICurrencyMenu")
  self._scrollView = self:GetUIComponent("RectTransform", "ScrollView")
  self._safeArea = self:GetUIComponent("RectTransform", "SafeArea")
  self._index = self:GetUIComponent("UISelectObjectPath", "Index")
end

function UIShopHomelandPrecious:_OnValue()
  local name = StringTable.Get(self._data.cfg.Name)
  self._preciousNameOutLineText:SetText(name)
  self._preciousName:SetText(name)
  self._currencyMenu:SetData({
    RoleAssetID.RoleAssetFurnitureCoin,
    RoleAssetID.RoleAssetGlow
  })
  self._remainTime = self._shopData.remainRefreshTime + 1
  self:_CountDown()
  self._totalCount = #self._data.goods
  self._column = math.ceil(self._totalCount / self._perColumn)
  self:_ClassifyData()
  self._index:SpawnObjects("UIShopHomelandIndex", self._column)
  self._indexPointWidgets = self._index:GetAllSpawnList()
  for _, widget in pairs(self._indexPointWidgets) do
    widget:SetData(false)
  end
  self._canvas = self._safeArea.parent:GetComponent("RectTransform")
  local safesize = self._canvas.rect.size
  safesize.x = safesize.x * (self._safeArea.anchorMax.x - self._safeArea.anchorMin.x)
  safesize.x = safesize.x + 1
  safesize.y = safesize.y + 1
  self._scrollViewHelper = H3DScrollViewHelper:New(self, "ScrollView", "UIShopHomelandGoodsSetItem", function(index, uiwidget)
    return self:_OnShowItem(index, uiwidget)
  end)
  self._scrollViewHelper:SetGroupChangedCallback(function(index, item)
    if index + 1 > self._column then
      return
    end
    self:_ShowItemData(index + 1)
  end)
  self._scrollViewHelper:Init(self._column, 1, safesize)
  self._scrollView.anchoredPosition = Vector2(0, -60)
end

function UIShopHomelandPrecious:_ClassifyData()
  self._columnData = {}
  local curColumn = 1
  for _, goods in pairs(self._data.goods) do
    if not self._columnData[curColumn] then
      self._columnData[curColumn] = {}
    end
    table.insert(self._columnData[curColumn], goods)
    if #self._columnData[curColumn] == self._perColumn then
      curColumn = curColumn + 1
    end
  end
end

function UIShopHomelandPrecious:CloseBtnOnClick(go)
  self:CloseDialog()
end

function UIShopHomelandPrecious:OnUpdate(ms)
  self._deltaTime = self._deltaTime + ms
  if self._deltaTime > 1000 then
    self._deltaTime = 0
    self._remainTime = self._remainTime - 1
    self:_CountDown()
  end
end

function UIShopHomelandPrecious:_CountDown()
  local timeStr = HelperProxy:GetInstance():FormatTime_2(math.floor(self._remainTime))
  self._refreshTime:SetText(StringTable.Get("str_shop_homeland_refreshtime", timeStr))
  if self._remainTime <= 0 then
    self:StartTask(function(TT)
      if not self._clientShop:SendProtocal(TT, ShopMainTabType.Homeland) then
        return
      end
      if self._scrollViewHelper then
        self._scrollViewHelper:Dispose()
      end
      self:_RefreshPreciousGoods()
      self:_OnValue()
    end)
  end
end

function UIShopHomelandPrecious:_RefreshPreciousGoods()
  local allPreciousGoods = self._shopData.goodsSet[MarketType.Shop_Furniture_Precious][FurnitureShopType.FRN_Precious]
  if allPreciousGoods then
    for shopID, goods in pairs(allPreciousGoods) do
      local shopItemSet = HomelandShopItemSet:New(FurnitureShopType.FRN_Precious, shopID, goods)
      self._data = shopItemSet
    end
  end
end

function UIShopHomelandPrecious:_ShowItemData(index)
  if self._indexPointWidgets[self._currentIndex] then
    self._indexPointWidgets[self._currentIndex]:SetData(false)
  end
  self._currentIndex = index
  if self._indexPointWidgets[self._currentIndex] then
    self._indexPointWidgets[self._currentIndex]:SetData(true)
  end
end

function UIShopHomelandPrecious:_OnShowItem(index, widget)
  widget:SetData(self._data, self._columnData[index], MarketType.Shop_Furniture_Precious, function()
    self:_BuySuccessCallBack()
  end)
  self._items[index] = widget
end

function UIShopHomelandPrecious:OnHide()
  self._currentIndex = 0
  self._safeArea = nil
  if self._scrollViewHelper then
    self._scrollViewHelper:Dispose()
  end
end

function UIShopHomelandPrecious:_BuySuccessCallBack()
  self:_ClassifyData()
  self._scrollViewHelper:RefreshAllShownItem()
end

function UIShopHomelandPrecious:OpenShop(mainTabType)
  if mainTabType == ShopMainTabType.Recharge then
    self:CloseDialog()
  end
end
