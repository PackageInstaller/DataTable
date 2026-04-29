_class("UIShopHomelandTab", UICustomWidget)
UIShopHomelandTab = UIShopHomelandTab

function UIShopHomelandTab:Constructor()
  self._shopModule = self:GetModule(ShopModule)
  self._clientShop = self._shopModule:GetClientShop()
  self._shopData = self._clientShop:GetHomelandShopData()
end

function UIShopHomelandTab:OnShow(uiParams)
  self:_GetComponents()
  self:_OnValue()
  self:AttachEvent(GameEventType.UpdateHomelandShop, self._RefreshUIInfo)
  self:AttachEvent(GameEventType.ShopBuySuccess, self._OnBuySuccess)
end

function UIShopHomelandTab:OnHide()
  if self._refreshTaskID then
    GameGlobal.TaskManager():KillTask(self._refreshTaskID)
    self._refreshTaskID = nil
  end
  self:DetachEvent(GameEventType.UpdateHomelandShop, self._RefreshUIInfo)
end

function UIShopHomelandTab:_GetComponents()
  self._emptyTipsGo = self:GetGameObject("EmptyTips")
  self._scrollView = self:GetUIComponent("UIDynamicScrollView", "ScrollView")
  self._anim = self:GetUIComponent("Animation", "UIShopHomelandTab")
end

function UIShopHomelandTab:Update()
end

function UIShopHomelandTab:_OnValue()
  self:_ClassifyData()
  self:_InitDynamicScrollView()
  self:_RefreshUIInfo()
end

function UIShopHomelandTab:_ClassifyData()
  self._data = {}
  local matketTypes = {
    MarketType.Shop_Furniture,
    MarketType.Shop_Furniture_Precious
  }
  for _, marketType in pairs(matketTypes) do
    if self._shopData.goodsSet[marketType] then
      for _, furnitureShopType in pairs(FurnitureShopType) do
        if self._shopData.goodsSet[marketType][furnitureShopType] then
          for shopID, goods in pairs(self._shopData.goodsSet[marketType][furnitureShopType]) do
            local shopItemSet = HomelandShopItemSet:New(furnitureShopType, shopID, goods)
            table.insert(self._data, shopItemSet)
          end
        end
      end
    end
  end
  table.sort(self._data, function(a, b)
    return a.sequenceID < b.sequenceID
  end)
end

function UIShopHomelandTab:_InitDynamicScrollView()
  self._scrollView:InitListView(#self._data, function(scrollview, index)
    return self:_OnGetItemByIndex(scrollview, index)
  end)
end

function UIShopHomelandTab:_OnGetItemByIndex(scrollview, index)
  local data = self._data[index + 1]
  local item
  if data.shopType == FurnitureShopType.FRN_Set and data:IsDiscount() then
    item = scrollview:NewListViewItem("UIShopHomelandItemSet")
  else
    item = scrollview:NewListViewItem("UIShopHomelandItem")
  end
  local itemPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if not item.IsInitHandlerCalled then
    item.IsInitHandlerCalled = true
    itemPool:SpawnObjects("UIShopHomelandItem", 1)
  end
  local itemWidgets = itemPool:GetAllSpawnList()
  local itemWidget = itemWidgets[1]
  if itemWidget then
    itemWidget:SetData(data)
  end
  return item
end

function UIShopHomelandTab:_RefreshScrollView(move)
  self._scrollView:SetListItemCount(#self._data)
  self._scrollView:RefreshAllShownItem()
end

function UIShopHomelandTab:_RefreshUIInfo()
  if self._shopData:IsEmpty() then
    self._emptyTipsGo:SetActive(true)
  else
    self._emptyTipsGo:SetActive(false)
  end
  self:_ClassifyData()
  self:_RefreshScrollView()
end

function UIShopHomelandTab:SetData(param)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ShopTabChange, ShopMainTabType.Homeland)
  self._param = param
end

function UIShopHomelandTab:RefreshPanel(subTabType)
end

function UIShopHomelandTab:ExcuteHideLogic(callBack)
  if callBack then
    callBack(self)
  end
  self._param = nil
end

function UIShopHomelandTab:ShowSelf()
  self._anim:Stop()
  self._anim:Play()
end

function UIShopHomelandTab:HideSelf()
end
