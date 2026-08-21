_class("UIShopFlashSaleTab", UICustomWidget)
UIShopFlashSaleTab = UIShopFlashSaleTab

function UIShopFlashSaleTab:Constructor()
  self.shopModule = self:GetModule(ShopModule)
  self.clientShop = self.shopModule:GetClientShop()
  self._data = self.clientShop:GetFlashSaleShopData()
end

function UIShopFlashSaleTab:OnShow(uiParams)
  self._content = self:GetUIComponent("UISelectObjectPath", "Content")
  self._anim = self:GetUIComponent("Animation", "UIShopFlashSaleTab")
  self:Flush()
  self:AttachEvent(GameEventType.UpdateFlashSaleShop, self.Flush)
end

function UIShopFlashSaleTab:OnHide()
end

function UIShopFlashSaleTab:Flush(uniqueid)
  uniqueid = uniqueid or self.uiOwner.curMainTabUniqueid
  self._componentID = self.uiOwner:GetComponentIDByUniqueID(uniqueid)
  self._flashsaleLocalProcess = self.uiOwner:GetFlashSaleLocalProgress()
  self._componentInfo = self._flashsaleLocalProcess:GetComponentInfo(self._componentID)
  self._items = self:_FilterData(self._data:GetGoods(), self._componentInfo.m_campaign_gift_list)
  if not self._items then
    return
  end
  self._content:SpawnObjects("UIShopFlashSaleItemContainer", table.count(self._items))
  self.uiItems = self._content:GetAllSpawnList()
  for i, uiItem in ipairs(self.uiItems) do
    local item = self._items[i]
    if item then
      uiItem:Flush(self._items[i])
    else
      Log.fatal("### item nil. i=", i)
    end
  end
end

function UIShopFlashSaleTab:JumpItem()
  if self._param then
    local jumpId = self._param[4] or 0
    if jumpId then
      for i, item in ipairs(self._items) do
        if item and item:GetId() == jumpId then
          self.uiItems[i]:OpenUIShopFlashSaleDetail()
        end
      end
    end
  end
end

function UIShopFlashSaleTab:Update(deltaTimeMS)
end

function UIShopFlashSaleTab:SetData(param)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ShopTabChange, ShopMainTabType.FlashSale)
  self._param = param
  self:JumpItem()
end

function UIShopFlashSaleTab:RefreshPanel(subTabType)
end

function UIShopFlashSaleTab:ExcuteHideLogic(callBack)
  if callBack then
    callBack(self)
  end
  self._param = nil
end

function UIShopFlashSaleTab:_FilterData(allGoods, filterList)
  local function checkFunction(id)
    for _, value in pairs(filterList) do
      if value.m_gift_id == id then
        return true
      end
    end
    return false
  end
  
  local result = {}
  for _, goods in ipairs(allGoods) do
    if checkFunction(goods:GetId()) then
      table.insert(result, goods)
    end
  end
  return result
end

function UIShopFlashSaleTab:ShowSelf()
  self._anim:Stop()
  self._anim:Play()
end

function UIShopFlashSaleTab:HideSelf()
end
