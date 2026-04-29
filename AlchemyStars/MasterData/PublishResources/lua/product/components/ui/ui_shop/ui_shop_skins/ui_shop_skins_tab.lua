_class("UIShopSkinsTab", UICustomWidget)
UIShopSkinsTab = UIShopSkinsTab

function UIShopSkinsTab:Constructor()
  self.shopModule = self:GetModule(ShopModule)
  self.clientShop = self.shopModule:GetClientShop()
  self._data = self.clientShop:GetSkinsShopData()
  self._giftData = self.clientShop:GetGiftPackShopData()
  self._mRole = GameGlobal.GameLogic():GetModule(RoleModule)
  self._countPerPage = 4
  self._currentSelTab = SkinsShopTabEnum.ALL
end

function UIShopSkinsTab:OnShow(uiParams)
  self:InitWidget()
  self:AttachEvent(GameEventType.UpdateSkinsShop, self.EnsureFlush)
  self:AttachEvent(GameEventType.UpdateGiftPackShop, self.EnsureFlush)
  self:AttachEvent(GameEventType.ShopNew, self.FlushTabNew)
  self:Flush()
  self:FlushTab()
end

function UIShopSkinsTab:OnHide()
  self:DetachEvent(GameEventType.UpdateSkinsShop, self.EnsureFlush)
  self:DetachEvent(GameEventType.UpdateGiftPackShop, self.EnsureFlush)
  self:DetachEvent(GameEventType.ShopNew, self.FlushTabNew)
end

function UIShopSkinsTab:InitWidget()
  self._scrollRect = nil
  self._content = self:GetUIComponent("RectTransform", "Content")
  self._emptyTipsGo = self:GetGameObject("EmptyTips")
  self._tabSv = self:GetUIComponent("ScrollRect", "tabSv")
  self._tabContent = self:GetUIComponent("UISelectObjectPath", "tabContent")
  self._tabContentLayout = self:GetUIComponent("GridLayoutGroup", "tabContent")
  self._anim = self:GetUIComponent("Animation", "UIShopSkinsTab")
end

function UIShopSkinsTab:OnTabClick(keyTab, go)
  if self._currentSelTab == keyTab then
    return
  end
  self._currentSelTab = keyTab
  self:FlushTab()
  self:FlushTabContent()
  self:TabAnimation()
  self:InAnimation()
end

function UIShopSkinsTab:CreateTab()
  self._currentSelTab = SkinsShopTabEnum.ALL
  if self._tabs == nil then
    self._tabs = {}
    self._tabBtns = {}
    local tmpTab = {}
    local cfgTabs = Cfg.cfg_shop_common_goods_tab({})
    for index, value in ipairs(cfgTabs) do
      if value.ID == 1 then
        tmpTab[value.ID] = value
      else
        for key, val in pairs(self._items) do
          if val:GetTabID() == value.ID then
            tmpTab[value.ID] = value
            break
          end
        end
      end
    end
    for key, value in pairs(tmpTab) do
      table.insert(self._tabBtns, value)
    end
    table.sort(self._tabBtns, function(a, b)
      return a.ID < b.ID
    end)
    local count = #self._tabBtns
    local idTab = 1
    local uiTabs = self._tabContent:SpawnObjects("UIShopSecretTabBtn", count)
    for k, v in ipairs(self._tabBtns) do
      local item = {
        data = {},
        ui = uiTabs[idTab]
      }
      idTab = idTab + 1
      item.ui:SetData(v.ID, StringTable.Get(v.Name), function(keyTab, go)
        self:OnTabClick(keyTab, go)
      end)
      self._tabs[k] = item
      item.ui:SkinTabDetachEvent()
    end
  end
end

function UIShopSkinsTab:FlushTab()
  for index, value in ipairs(self._tabs) do
    local ui = value.ui
    ui:SetSelected(self._currentSelTab == self._tabBtns[index].ID)
  end
end

function UIShopSkinsTab:EnsureFlush()
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
    self:StartSafeTask("UIShopSkinsTab::EnsureFlush", function(lockName, TT)
      while not goDepth.activeInHierarchy do
        YIELD(TT)
      end
      self:Flush()
    end)
  end
end

function UIShopSkinsTab:Flush()
  self._items = {}
  local skinsItems = self:FilterFlush()
  local giftItems = self._giftData:GetGoods()
  for k, v in pairs(skinsItems) do
    local item = ShopUnionSkinsGiftItem:New(v, nil)
    table.insert(self._items, item)
  end
  for k, v in pairs(giftItems) do
    if v:IsShowInSkinsTab() then
      local item = ShopUnionSkinsGiftItem:New(nil, v)
      table.insert(self._items, item)
    end
  end
  self:CreateTab()
  self:FlushTab()
  self:FlushTabContent()
  self:FlushTabNew()
end

function UIShopSkinsTab:FlushTabNew()
  local pools = self._tabContent:GetAllSpawnList()
  for index, value in ipairs(self._tabBtns) do
    local isNew = false
    for key, val in pairs(self._items) do
      if val:GetTabID() == value.ID or value.ID == 1 then
        local data
        if val:GetSkinData() == nil then
          data = self._giftData:GetGoodBuyId(val:GetId())
        else
          data = self._data:GetGoodById(val:GetId())
        end
        if data and data:GetNew() then
          isNew = true
          break
        end
      end
    end
    pools[index]:FlushNew(isNew)
  end
end

function UIShopSkinsTab:FlushTabContent()
  self._selItems = {}
  self._poolItems = {}
  if self._currentSelTab == SkinsShopTabEnum.ALL then
    self._selItems = self._items
  else
    for k, v in pairs(self._items) do
      if v:GetTabID() == self._currentSelTab then
        table.insert(self._selItems, v)
      end
    end
  end
  self:SortFlush()
  local itemCount = #self._selItems
  self._emptyTipsGo:SetActive(itemCount == 0)
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

function UIShopSkinsTab:InitListView(scrollView, index)
  local item = scrollView:NewListViewItem("dsvItem")
  local itemPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if self._poolItems ~= nil then
    self._poolItems[index] = itemPool
  end
  if not item.IsInitHandlerCalled then
    item.IsInitHandlerCalled = true
    itemPool:SpawnObjects("UIShopUnionSkinsGiftItem", 1)
  end
  local luaIndex = index + 1
  local uiItem = itemPool:GetAllSpawnList()[1]
  uiItem:GetGameObject().name = 0
  local dataItem = self._selItems[luaIndex]
  uiItem:Flush(dataItem, function(uiSubItem)
    uiSubItem:Flush(dataItem:GetId())
    uiSubItem:SetOutTimeClickFunc(function()
      self:_ConfirmSkinOverTimeBox()
    end)
  end, function(uiSubItem)
    uiSubItem:Flush(dataItem:GetId())
  end)
  return item
end

function UIShopSkinsTab:TabAnimation()
  if self._tabAnimationIndex == nil then
    self._tabAnimationIndex = 1
  end
  local spawns = self._tabContent:GetAllSpawnList()
  local luaIndex = 1
  local count = #spawns
  for k, v in pairs(spawns) do
    if v:IsSelected() then
      luaIndex = k
      break
    end
  end
  local contentWidth = 0
  local viewWidth = self._tabSv.transform.rect.width
  contentWidth = contentWidth + self._tabContentLayout.padding.left
  contentWidth = contentWidth + self._tabContentLayout.padding.right
  contentWidth = contentWidth + count * self._tabContentLayout.cellSize.x
  contentWidth = contentWidth + (count - 1) * self._tabContentLayout.spacing.x
  if viewWidth >= contentWidth then
    return
  end
  if self._tabAnimationIndex == luaIndex then
    return
  end
  local doAnimation = false
  local leftPosition = 0
  local pastPosition = self._tabSv.horizontalNormalizedPosition * (contentWidth - viewWidth)
  if luaIndex > self._tabAnimationIndex then
    self._tabAnimationIndex = luaIndex
    luaIndex = luaIndex + 1
    luaIndex = math.min(luaIndex, count)
    leftPosition = leftPosition + self._tabContentLayout.padding.left
    leftPosition = leftPosition + self._tabContentLayout.padding.right
    leftPosition = leftPosition + luaIndex * self._tabContentLayout.cellSize.x
    leftPosition = leftPosition + (luaIndex - 1) * self._tabContentLayout.spacing.x
    leftPosition = leftPosition + 0.5 * self._tabContentLayout.spacing.x
    leftPosition = leftPosition - viewWidth
    leftPosition = math.max(leftPosition, 0)
    doAnimation = pastPosition < leftPosition
  else
    self._tabAnimationIndex = luaIndex
    luaIndex = luaIndex - 1
    luaIndex = math.max(luaIndex, 1)
    leftPosition = leftPosition + self._tabContentLayout.padding.left
    leftPosition = leftPosition + luaIndex * self._tabContentLayout.cellSize.x
    leftPosition = leftPosition + (luaIndex - 1) * self._tabContentLayout.spacing.x
    leftPosition = leftPosition + 0.5 * self._tabContentLayout.spacing.x
    leftPosition = leftPosition - self._tabContentLayout.spacing.x - self._tabContentLayout.cellSize.x
    leftPosition = math.max(leftPosition, 0)
    doAnimation = pastPosition > leftPosition
  end
  if doAnimation then
    local cur = self._tabSv.horizontalNormalizedPosition
    local dst = leftPosition / (contentWidth - viewWidth)
    dst = math.max(dst, 0)
    dst = math.min(dst, 1)
    self:StartSafeTask("UIShopSkinsTab::TabAnimation", function(lockName, TT)
      self:Lock(lockName)
      local period = 500
      local deltaMs = 0
      local speed = (dst - cur) / period
      local value = cur
      while period >= deltaMs do
        local dt = GameGlobal:GetInstance():GetDeltaTime()
        deltaMs = deltaMs + dt
        value = value + speed * dt
        if period < deltaMs then
          value = dst
        end
        self._tabSv.horizontalNormalizedPosition = value
        YIELD()
      end
      self:UnLock(lockName)
    end)
  end
end

function UIShopSkinsTab:FilterFlush()
  local filterItems = self._data:GetGoods()
  local lookup = {}
  for i = 1, #filterItems do
    local binderItem = filterItems[i]
    local binderItemID = binderItem:GetId()
    lookup[binderItemID] = binderItem
  end
  local skinsItems = {}
  local cfg = Cfg.cfg_shop_common_goods({})
  for i = 1, #filterItems do
    local item = filterItems[i]
    local id = item:GetId()
    local localCfg = cfg[id]
    local binderSkinID = localCfg.CurrencySkinID
    local binderItem
    if binderSkinID then
      binderItem = lookup[binderSkinID]
    end
    if binderItem ~= nil then
      binderItem:SetBinderSkin(item)
    else
      table.insert(skinsItems, item)
    end
  end
  return skinsItems
end

function UIShopSkinsTab:SortFlush()
  table.sort(self._selItems, function(a, b)
    local aId = a:GetId()
    local aOrder = a:GetOrder()
    local aResident = a:IsResident()
    local aSoldOut = a:HasSoldOut()
    local bId = b:GetId()
    local bOrder = b:GetOrder()
    local bResident = b:IsResident()
    local bSoldOut = b:HasSoldOut()
    if not aSoldOut and bSoldOut then
      return true
    elseif aSoldOut and not bSoldOut then
      return false
    end
    local isGift_a = a:GetGiftData()
    local isGift_b = b:GetGiftData()
    if isGift_a and not isGift_b then
      return true
    elseif not isGift_a and isGift_b then
      return false
    end
    local skinid_a = a:GetSkinID()
    local skinid_b = b:GetSkinID()
    if skinid_a and skinid_b then
      local cfg_skin_a = Cfg.cfg_pet_skin[skinid_a]
      local cfg_skin_b = Cfg.cfg_pet_skin[skinid_b]
      local skinType_a = cfg_skin_a.SkinType
      local skinType_b = cfg_skin_b.SkinType
      if skinType_a ~= skinType_b then
        local tab = {
          [1] = 1,
          [2] = 10,
          [3] = 1000,
          [4] = 100,
          [5] = 100
        }
        local weight_a = tab[skinType_a]
        local weight_b = tab[skinType_b]
        return weight_a > weight_b
      end
    end
    if not aResident and bResident then
      return true
    elseif aResident and not bResident then
      return false
    end
    if aOrder < bOrder then
      return true
    elseif aOrder > bOrder then
      return false
    end
    return aId < bId
  end)
end

function UIShopSkinsTab:_ConfirmSkinOverTimeBox()
  local strTitle = StringTable.Get("str_login_msdk_tip")
  local strText = StringTable.Get("str_shop_skin_off_shelf")
  
  local function okCb()
    self:StartTask(function(TT)
      self.clientShop:SendProtocal(TT, ShopMainTabType.Skins)
    end)
  end
  
  PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.Ok, strTitle, strText, okCb, nil)
end

function UIShopSkinsTab:Update(deltaTimeMS)
end

function UIShopSkinsTab:SetData(param)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ShopTabChange, ShopMainTabType.Skins)
  self._param = param
  self:JumpItem()
  if self._param == nil or self._param[4] == nil then
    self:InAnimation()
  end
end

function UIShopSkinsTab:RefreshPanel(subTabType)
end

function UIShopSkinsTab:ExcuteHideLogic(callBack)
  if callBack then
    callBack(self)
  end
  self._param = nil
end

function UIShopSkinsTab:JumpItem()
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
      for i, item in ipairs(self._items) do
        if item and item:GetId() == jumpId then
          if self._poolItems == nil then
            self._poolItems = {}
          end
          self._scrollRect:MovePanelToItemIndex(i - 1, 0)
          local uiItem = self._poolItems[i - 1]:GetAllSpawnList()[1]
          uiItem:JumpItem()
          break
        end
      end
    end
  end
end

function UIShopSkinsTab:InAnimation()
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
  self._inAnimationTask = self:StartSafeTask("UIShopSkinsTab::InAnimation", function(lockName, TT)
    YIELD(TT)
    local animLength = 0
    for index = 0, math.maxinteger do
      if not self._poolItems then
        Log.debug("###[UIShopSkinsTab] play anim , pools is reset , wait next play .")
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
        local data = self._selItems[luaIndex]
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

function UIShopSkinsTab:ShowSelf()
  self._anim:Stop()
  self._anim:Play()
end

function UIShopSkinsTab:HideSelf()
end
