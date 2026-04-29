_class("UIShopGiftPackTab", UICustomWidget)
UIShopGiftPackTab = UIShopGiftPackTab

function UIShopGiftPackTab:Constructor()
  self.shopModule = self:GetModule(ShopModule)
  self.clientShop = self.shopModule:GetClientShop()
  self._dataRecharge = self.clientShop:GetRechargeShopData()
  self._data = self.clientShop:GetGiftPackShopData()
  self._mRole = GameGlobal.GameLogic():GetModule(RoleModule)
  self._curSelTab = 1
end

function UIShopGiftPackTab:OnShow()
  self:AttachEvent(GameEventType.UpdateGiftPackShop, self.EnsureFlush)
  self._anim = self:GetUIComponent("Animation", "UIShopGiftPackTab")
  self._content = self:GetUIComponent("RectTransform", "Content")
  self._tabSv = self:GetUIComponent("ScrollRect", "tabSv")
  self._tabContent = self:GetUIComponent("UISelectObjectPath", "TabContent")
  self._tabContentLayout = self:GetUIComponent("GridLayoutGroup", "TabContent")
  self._scrollRect = nil
  self:Flush()
  self:OpenSelectAgePanel()
  self:AttachEvent(GameEventType.ShopNew, self.CheckAllTabNew)
end

function UIShopGiftPackTab:OnHide()
  self:DetachEvent(GameEventType.UpdateGiftPackShop, self.EnsureFlush)
  self:DetachEvent(GameEventType.ShopNew, self.CheckAllTabNew)
end

function UIShopGiftPackTab:EnsureFlush()
  local root = self:RootUIOwner():GetGameObject()
  local goDepth
  while goDepth == nil do
    if string.find(root.name, "depth_") then
      goDepth = root
    else
      root = root.transform.parent.gameObject
    end
    if root == nil then
      goDepth = self._content.gameObject
    end
  end
  if goDepth.activeInHierarchy then
    self:Flush()
  else
    self:StartSafeTask("UIShopGiftPackTab::EnsureFlush", function(lockName, TT)
      while not goDepth.activeInHierarchy do
        YIELD(TT)
      end
      self:Flush()
    end)
  end
end

function UIShopGiftPackTab:InitListView(scrollView, index)
  local item = scrollView:NewListViewItem("dsvItem")
  local itemPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if self._poolItems ~= nil then
    self._poolItems[index] = itemPool
  end
  if not item.IsInitHandlerCalled then
    item.IsInitHandlerCalled = true
    itemPool:SpawnObjects("UIShopGiftPackItemContainer", 1)
  end
  local luaIndex = index + 1
  local uiItem = itemPool:GetAllSpawnList()[1]
  local dataItem = self.filterItems[luaIndex]
  uiItem:Flush(dataItem:GetId())
  return item
end

function UIShopGiftPackTab:OpenSelectAgePanel()
end

function UIShopGiftPackTab:JumpItem()
  local roleModule = GameGlobal.GetModule(RoleModule)
  if roleModule:IsJapanZone() then
    local payModule = GameGlobal.GetModule(PayModule)
    if payModule:IsShowSelectAgePanel() then
      self:ShowDialog("UISetAgeConfirmController")
      payModule:OpenSelectAgePanel()
      return
    end
  end
  if self._param then
    local jumpId = self._param[4] or 0
    if jumpId then
      for i, item in ipairs(self.filterItems) do
        if item and item:GetId() == jumpId then
          if self._poolItems == nil then
            self._poolItems = {}
          end
          self._scrollRect:MovePanelToItemIndex(i - 1, 0)
          local uiItem = self._poolItems[i - 1]:GetAllSpawnList()[1]
          uiItem:OpenUIShopGiftPackDetail()
          break
        end
      end
    end
  end
end

function UIShopGiftPackTab:Flush()
  self:FlushAllItems()
  self:CreateTab()
  self:FlushTab()
  local filterItems = self:FilterFlush()
  self:FlushTabContent(filterItems)
end

function UIShopGiftPackTab:FlushAllItems()
  self._poolItems = {}
  self._items = self._data:GetGoods()
  local newItems = {}
  for k, v in pairs(self._items) do
    if not v:IsShowInSkinsTab() and not v:GetRechargeGift() then
      table.insert(newItems, v)
    end
  end
  self._items = newItems
  return newItems
end

function UIShopGiftPackTab:CreateTab()
  if not self._curSelTab then
    self._curSelTab = 1
  end
  local oldCount = 0
  if self._tabBtns ~= nil then
    oldCount = #self._tabBtns
  end
  self._tabs = {}
  self._tabBtns = {}
  local tmpTab = {}
  local cfgTabs = Cfg.cfg_shop_gift_pack_tab({})
  local insertionOrder = {}
  for key in pairs(cfgTabs) do
    table.insert(insertionOrder, key)
  end
  local cfgTabsOrder = {}
  for _, key in ipairs(insertionOrder) do
    table.insert(cfgTabsOrder, cfgTabs[key])
  end
  for index, value in ipairs(cfgTabsOrder) do
    for key, val in pairs(self._items) do
      if val:GetShopGiftTabID() == value.ID then
        tmpTab[value.ID] = value
        break
      end
    end
  end
  local allItemsTab = {}
  allItemsTab.ID = 0
  allItemsTab.Name = "str_shop_giftmarket_tab_name1"
  table.insert(self._tabBtns, allItemsTab)
  for key, value in pairs(tmpTab) do
    table.insert(self._tabBtns, value)
  end
  table.sort(self._tabBtns, function(a, b)
    return a.ID < b.ID
  end)
  local count = #self._tabBtns
  if oldCount ~= 0 and oldCount ~= count then
    self._curSelTab = 1
  end
  local idTab = 1
  local uiTabs = self._tabContent:SpawnObjects("UIShopGiftPackTabBtn", count)
  for k, v in ipairs(self._tabBtns) do
    local item = {
      data = {},
      ui = uiTabs[idTab]
    }
    item.ui:SetData(idTab, v.ID, StringTable.Get(v.Name), function(keyTab, go)
      self:OnTabClick(keyTab, go)
    end)
    self._tabs[k] = item
    item.ui:FlushNew(self:CheckTabNew(idTab, v.ID))
    idTab = idTab + 1
    item.ui:GiftPackTabDetachEvent()
  end
end

function UIShopGiftPackTab:FlushTab()
  for _, value in ipairs(self._tabs) do
    local ui = value.ui
    ui:SetSelected(self._curSelTab == ui:GetTabId())
  end
end

function UIShopGiftPackTab:FilterFlush()
  self.filterItems = {}
  if self._curSelTab == 1 then
    self.filterItems = self._items
    return self.filterItems
  end
  for i = 1, #self._items do
    local curShopGiftTabID = self._tabBtns[self._curSelTab].ID
    if self._items[i]:GetShopGiftTabID() == curShopGiftTabID then
      table.insert(self.filterItems, self._items[i])
    end
  end
  return self.filterItems
end

function UIShopGiftPackTab:FlushTabContent()
  local itemCount = table.count(self.filterItems)
  local localPosition = self._content.localPosition
  if self._scrollRect then
    self._scrollRect:SetListItemCount(itemCount)
    self._scrollRect:ResetListView()
    self._scrollRect:RefreshAllShownItem()
    self._scrollRect:MovePanelToItemIndex(0, 0)
  else
    self._scrollRect = self:GetUIComponent("UIDynamicScrollView", "ScrollView")
    self._scrollRect:InitListView(itemCount, function(scrollView, index)
      return self:InitListView(scrollView, index)
    end, nil)
  end
  local localPositionY = localPosition.y
  localPosition = self._content.localPosition
  self._content.localPosition = Vector3(localPosition.x, localPositionY, localPosition.z)
end

function UIShopGiftPackTab:CheckAllTabNew()
  for _, tab in ipairs(self._tabs) do
    tab.ui:FlushNew(self:CheckTabNew(tab.ui:GetTabId(), tab.ui:GetTiftPackTabId()))
  end
end

function UIShopGiftPackTab:CheckTabNew(tabId, giftPackTabId)
  local items = self:FlushAllItems()
  for k, tab in pairs(self._tabs) do
    if tabId == tab.ui:GetTabId() then
      for _, item in pairs(items) do
        if (item:GetShopGiftTabID() == giftPackTabId or tabId == 1) and self:CheckNew(item:GetId()) then
          return true
        end
      end
    end
  end
  return false
end

function UIShopGiftPackTab:CheckNew(itemId)
  local itemData = self._data:GetGoodBuyId(itemId)
  local isNew = itemData:GetNew()
  if itemData:GetRechargeGift() then
    local key = "UIShopGiftPackItem" .. self:GetNewFlagKey(itemData:GetId())
    return LocalDB.GetInt(key, 0) == 0
  end
  return isNew
end

function UIShopGiftPackTab:OnTabClick(keyTab, go)
  if self._curSelTab == keyTab then
    return
  end
  self._curSelTab = keyTab
  self:FlushAllItems()
  self:FlushTab()
  local filterItems = self:FilterFlush()
  self:FlushTabContent(filterItems)
  self:InAnimation()
end

function UIShopGiftPackTab:Update(deltaTimeMS)
end

function UIShopGiftPackTab:SetData(param)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ShopTabChange, ShopMainTabType.Gift)
  self._param = param
  self:JumpItem()
  if self._param == nil or self._param[4] == nil then
    self:InAnimation()
  end
end

function UIShopGiftPackTab:RefreshPanel(subTabType)
end

function UIShopGiftPackTab:ExcuteHideLogic(callBack)
  if callBack then
    callBack(self)
  end
  self._param = nil
end

function UIShopGiftPackTab:InAnimation()
  if self._poolItems == nil then
    return
  end
  local taskMgr = GameGlobal.TaskManager()
  local task = taskMgr:FindTask(self._inAnimationTask)
  if task and task.state ~= TaskState.Stop then
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
  self._inAnimationTask = self:StartSafeTask("UIShopGiftPackTab::InAnimation", function(lockName, TT)
    YIELD(TT)
    local animLength = 0
    for index = 0, math.maxinteger do
      if not self._poolItems then
        Log.debug("###[UIShopGiftPackTab] play anim , pools is reset , wait next play .")
        self._poolItems = nil
        return
      end
      local pool = self._poolItems[index]
      if pool == nil then
        break
      end
      local rowList = pool:GetAllSpawnList()
      for ik, item in pairs(rowList) do
        local luaIndex = index + 1
        local data = self.filterItems[luaIndex]
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
    self._inAnimationTask = nil
  end)
end

function UIShopGiftPackTab:ShowSelf()
  self._anim:Stop()
  self._anim:Play()
end

function UIShopGiftPackTab:HideSelf()
end
