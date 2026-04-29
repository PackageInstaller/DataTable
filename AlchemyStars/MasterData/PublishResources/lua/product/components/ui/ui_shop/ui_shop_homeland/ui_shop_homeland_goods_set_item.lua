_class("UIShopHomelandGoodsSetItem", UICustomWidget)
UIShopHomelandGoodsSetItem = UIShopHomelandGoodsSetItem

function UIShopHomelandGoodsSetItem:Constructor()
  self._shopModule = self:GetModule(ShopModule)
  self._clientShop = self._shopModule:GetClientShop()
  self._shopData = self._clientShop:GetHomelandShopData()
end

function UIShopHomelandGoodsSetItem:OnShow(uiParams)
  self:_GetComponents()
  self:AttachEvent(GameEventType.ShopBuySuccess, self._OnBuySuccess)
end

function UIShopHomelandGoodsSetItem:_GetComponents()
  self._grid = self:GetUIComponent("UISelectObjectPath", "Grid")
  self._backGround = self:GetGameObject("Backgound")
  self._uiDrag = self:GetUIComponent("UIDrag", "Backgound")
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._backGround), UIEvent.BeginDrag, function(pointData)
    self:OnBeginDrag(pointData)
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._backGround), UIEvent.Drag, function(pointData)
    self:OnDragEvent(pointData)
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._backGround), UIEvent.EndDrag, function(pointData)
    self:OnEndDrag(pointData)
  end)
  self._dragState = 0
end

function UIShopHomelandGoodsSetItem:SetData(data, goods, marketType, callBack)
  self._data = data
  self._goods = goods
  self._goodsCount = #self._goods
  self._marketType = marketType
  self._callBack = callBack
  self._grid:SpawnObjects("UIShopHomelandGoodsItem", self._goodsCount)
  self._goodsWidgets = self._grid:GetAllSpawnList()
  for key, widget in pairs(self._goodsWidgets) do
    local valid = key <= self._goodsCount
    widget.view.gameObject:SetActive(valid)
    if valid then
      widget:SetData(key, self._goods[key], self._marketType)
    end
  end
end

function UIShopHomelandGoodsSetItem:_OnBuySuccess(goodsID)
  local refresh = false
  if self._goods then
    for _, goods in pairs(self._goods) do
      if goods:GetGoodId() == goodsID then
        refresh = true
        break
      end
    end
  end
  if not refresh then
    return
  end
  self:Lock("UIShopHomelandGoodsSetItem_OnBuySuccess")
  self._refreshTaskID = self:StartTask(function(TT)
    if self._clientShop:SendProtocal(TT, ShopMainTabType.Homeland) then
      local goods = self._shopData:GetGoodsByGoodsId(goodsID)
      self._data:UpdateGoods(goods)
      if self._callBack then
        self._callBack()
      end
    end
    self:UnLock("UIShopHomelandGoodsSetItem_OnBuySuccess")
  end, self)
end

function UIShopHomelandGoodsSetItem:OnBeginDrag(pointData)
  local delta = pointData.delta
  local d_x = delta.x
  local d_y = delta.y
  if math.abs(d_x) > math.abs(d_y) then
    self._dragState = 2
    self._uiDrag:OnBeginDrag(pointData)
  else
    self._dragState = 1
  end
end

function UIShopHomelandGoodsSetItem:OnDragEvent(pointData)
  if self._dragState == 2 and self._uiDrag then
    self._uiDrag:OnDrag(pointData)
  end
end

function UIShopHomelandGoodsSetItem:OnEndDrag(pointData)
  if self._dragState == 2 and self._uiDrag then
    self._uiDrag:OnEndDrag(pointData)
  end
  self._dragState = 0
end
