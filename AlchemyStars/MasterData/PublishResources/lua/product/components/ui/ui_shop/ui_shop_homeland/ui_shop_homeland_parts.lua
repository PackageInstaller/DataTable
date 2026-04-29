_class("UIShopHomelandParts", UIController)
UIShopHomelandParts = UIShopHomelandParts

function UIShopHomelandParts:Constructor()
  self._shopModule = self:GetModule(ShopModule)
  self._clientShop = self._shopModule:GetClientShop()
  self._shopData = self._clientShop:GetHomelandShopData()
  self._perColumn = 8
  self._currentIndex = 0
  self._items = {}
end

function UIShopHomelandParts:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UIShopHomelandParts:OnShow(uiParams)
  self._data = uiParams[1]
  self:_GetComponents()
  self:_OnValue()
  self:AttachEvent(GameEventType.OpenShop, self.OpenShop)
end

function UIShopHomelandParts:_GetComponents()
  self._partsNameOutLineText = self:GetUIComponent("UILocalizationText", "PartsNameOutLineText")
  self._partsName = self:GetUIComponent("UILocalizedTMP", "PartsName")
  self._content = self:GetUIComponent("UISelectObjectPath", "Content")
  local menu = self:GetUIComponent("UISelectObjectPath", "CurrencyMenu")
  self._currencyMenu = menu:SpawnObject("UICurrencyMenu")
  self._scrollView = self:GetUIComponent("RectTransform", "ScrollView")
  self._safeArea = self:GetUIComponent("RectTransform", "SafeArea")
  self._index = self:GetUIComponent("UISelectObjectPath", "Index")
end

function UIShopHomelandParts:_OnValue()
  local name = StringTable.Get(self._data.cfg.Name)
  self._partsNameOutLineText:SetText(name)
  self._partsName:SetText(name)
  self._currencyMenu:SetData({
    RoleAssetID.RoleAssetFurnitureCoin,
    RoleAssetID.RoleAssetGlow
  })
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
  self._scrollView.anchoredPosition = Vector2(0, -55)
end

function UIShopHomelandParts:_ClassifyData()
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

function UIShopHomelandParts:CloseBtnOnClick(go)
  self:CloseDialog()
end

function UIShopHomelandParts:_ShowItemData(index)
  if self._indexPointWidgets[self._currentIndex] then
    self._indexPointWidgets[self._currentIndex]:SetData(false)
  end
  self._currentIndex = index
  if self._indexPointWidgets[self._currentIndex] then
    self._indexPointWidgets[self._currentIndex]:SetData(true)
  end
end

function UIShopHomelandParts:_OnShowItem(index, widget)
  widget:SetData(self._data, self._columnData[index], MarketType.Shop_Furniture, function()
    self:_BuySuccessCallBack()
  end)
  self._items[index] = widget
end

function UIShopHomelandParts:_BuySuccessCallBack()
  self:_ClassifyData()
  self._scrollViewHelper:RefreshAllShownItem()
end

function UIShopHomelandParts:OnHide()
  self._currentIndex = 0
  self._safeArea = nil
  if self._scrollViewHelper then
    self._scrollViewHelper:Dispose()
  end
end

function UIShopHomelandParts:OpenShop(mainTabType)
  if mainTabType == ShopMainTabType.Recharge then
    self:CloseDialog()
  end
end
