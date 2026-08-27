local UIWarehouse = class("UIWarehouse", UIBaseWindow)
local base = UIBaseWindow
local UINSortButtonItem = require("Game.Hero.NewUI.SortList.UINSortButtonItem")
local UINWarehouseItem = require("Game.Warehouse.UINWarehouseItem")
local UINWarehouseTab = require("Game.Warehouse.UINWarehouseTab")
local JumpManager = require("Game.Jump.JumpManager")
local cs_Canvas = CS.UnityEngine.Canvas
local cs_ResLoader = CS.ResLoader
local eWareHouseType = require("Game.Warehouse.eWareHouseType")
local allShowTabId = eWareHouseType.wharehouseType.all

function UIWarehouse:OnInit()
  UIUtil.SetTopStatus(self, self.OnClickClose)
  self.itemDic = {}
  self.dataList = {}
  self.dataDic = {}
  self.ui.itemScroll.onInstantiateItem = BindCallback(self, self.OnInstantiateItem)
  self.ui.itemScroll.onChangeItem = BindCallback(self, self.OnChangeItem)
  self.SortButtonItem = UINSortButtonItem.New()
  self.SortButtonItem:Init(self.ui.sortBtnItem)
  self.SortButtonItem:InitSortButtonItem(0, true, BindCallback(self, self.OnSortChangeCallback))
  self.tabPool = UIItemPool.New(UINWarehouseTab, self.ui.btn_Page_pre)
  self.ui.btn_Page_pre:SetActive(false)
  self.resloader = cs_ResLoader.Create()
  self.__OnTabSelectCallback = BindCallback(self, self.OnTabSelectCallback)
  self.__OnItemUpdate = BindCallback(self, self.OnItemUpdateWarehouse)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__OnItemUpdate)
  self.__OnListenReddotWarehouse = BindCallback(self, self.OnListenReddotWarehouse)
  RedDotController:AddListener(RedDotDynPath.WarehousePath, self.__OnListenReddotWarehouse)
  self._onWarehouseItemClick = BindCallback(self, self._OnWarehouseItemClick)
end

function UIWarehouse:InitWarehouse(itemId, openType)
  self._lastCouldUseItemJump = JumpManager.couldUseItemJump
  JumpManager.couldUseItemJump = true
  self.tabId = 0
  self.isAscendState = 0
  self.SortButtonItem:SetAllStateUI(false)
  local tabList = {}
  for _, cfg in pairs(ConfigData.warehouse) do
    table.insert(tabList, cfg)
  end
  table.sort(tabList, function(a, b)
    if a.order_id ~= b.order_id then
      return a.order_id < b.order_id
    end
    return a.id < b.id
  end)
  cs_Canvas.ForceUpdateCanvases()
  local rectTr = self.ui.rect:GetComponent(typeof(CS.UnityEngine.RectTransform))
  local count = (rectTr.rect.width - self.ui.rect.padding.left - self.ui.rect.padding.right + self.ui.rect.spacing.x) / (self.ui.rect.cellSize.x + self.ui.rect.spacing.x)
  self.ui.rect.constraintCount = math.floor(count)
  self.tabPool:HideAll()
  for _, cfg in ipairs(tabList) do
    if cfg.id ~= eWareHouseType.wharehouseType.LimitTimeItem or PlayerDataCenter:GetIsHasLimitTime() then
      local item = self.tabPool:GetOne()
      item:InitWarehouseTab(cfg, self.__OnTabSelectCallback, self.resloader)
    end
  end
  if openType == nil then
    self:OnTabSelectCallback(allShowTabId)
  else
    self:OnTabSelectCallback(openType)
  end
  if itemId ~= nil then
    local index = self.dataDic[itemId]
    if index ~= nil then
      self.ui.itemScroll:LocationItem(index - 1, 0)
    end
  end
end

function UIWarehouse:OnTabSelectCallback(id)
  if self.tabId == id then
    return
  end
  for _, tab in ipairs(self.tabPool.listItem) do
    if tab.warehouseTabCfg.id == self.tabId then
      tab:SetSelectState(false)
    end
    if tab.warehouseTabCfg.id == id then
      tab:SetSelectState(true)
    end
  end
  self.tabId = id
  self:UpdateItemShow(false)
end

function UIWarehouse:OnSortChangeCallback(sortType)
  self.SortButtonItem:ReversalAscend()
  self.isAscendState = self.SortButtonItem.isAscend and 1 or -1
  self:UpdateItemShow(true)
end

function UIWarehouse:UpdateItemShow(isJustSortChange)
  self.__LimitTimeItems = {}
  if not isJustSortChange then
    self.dataList = {}
    local mergeItemDic = {}
    for itemId, itemData in pairs(PlayerDataCenter.itemDic) do
      local mergeList = eItemMergeDic[itemId]
      local itemCfg = itemData.itemCfg
      if mergeList ~= nil then
        itemId = mergeList[1]
        if mergeItemDic[itemId] ~= nil then
          goto lbl_76
        end
        mergeItemDic[itemId] = true
        itemCfg = ConfigData.item[itemId]
      end
      local page = itemCfg.warehouse_page
      local isInPage = self.tabId == allShowTabId and 0 < page or page == self.tabId
      if itemData:IsLimitTime() then
        isInPage = isInPage or 0 < page and self.tabId == eWareHouseType.wharehouseType.LimitTimeItem
      end
      if isInPage then
        if itemData:IsDynLimitTime() then
          for i = 1, itemData:GetStackCount() do
            table.insert(self.dataList, itemCfg)
          end
        else
          table.insert(self.dataList, itemCfg)
        end
      end
      ::lbl_76::
    end
    self.dataDic = {}
    for index, itemCfg in pairs(self.dataList) do
      self.dataDic[itemCfg.id] = index
    end
    local hasItem = #self.dataList > 0
    self.ui.itemScroll.gameObject:SetActive(hasItem)
    self.ui.scrollbar:SetActive(hasItem)
    self.ui.objEmpty:SetActive(not hasItem)
    if hasItem then
      self.SortButtonItem:Show()
    else
      self.SortButtonItem:Hide()
      return
    end
  end
  if self.isAscendState == 1 then
    table.sort(self.dataList, function(a, b)
      if a.quality ~= b.quality then
        return a.quality < b.quality
      end
      if a.warehouse_order ~= b.warehouse_order then
        return a.warehouse_order < b.warehouse_order
      end
      return a.id < b.id
    end)
  elseif self.isAscendState == -1 then
    table.sort(self.dataList, function(a, b)
      if a.quality ~= b.quality then
        return a.quality > b.quality
      end
      if a.warehouse_order ~= b.warehouse_order then
        return a.warehouse_order < b.warehouse_order
      end
      return a.id < b.id
    end)
  else
    table.sort(self.dataList, function(a, b)
      if a.warehouse_order ~= b.warehouse_order then
        return a.warehouse_order < b.warehouse_order
      end
      return a.id < b.id
    end)
  end
  self.dataDic = {}
  for index, itemCfg in pairs(self.dataList) do
    self.dataDic[itemCfg.id] = index
  end
  cs_Canvas.ForceUpdateCanvases()
  self.ui.itemScroll.totalCount = #self.dataList
  self.ui.itemScroll:RefillCells()
end

function UIWarehouse:OnInstantiateItem(go)
  local item = UINWarehouseItem.New()
  item:Init(go)
  self.itemDic[go] = item
end

function UIWarehouse:OnChangeItem(go, index)
  local item = self.itemDic[go]
  local itemCfg = self.dataList[index + 1]
  local itemId = itemCfg.id
  local limitTimeItemCfg = ConfigData.item_time_limit[itemId]
  if limitTimeItemCfg ~= nil then
    if limitTimeItemCfg.type == eLimitTimeItemType.Dyn then
      local lastIndex = self.dataDic[itemId]
      local stackCount = PlayerDataCenter:GetDynLimtTimeItemStackCount(itemId)
      local tempIndex = index + 1 - lastIndex + stackCount
      local stackInfo = PlayerDataCenter:GetDynLimtTimeItemStackInfo(itemId, tempIndex)
      item:InitWarehouseDynLimitTimeItem(itemCfg, stackInfo, self._onWarehouseItemClick)
    elseif limitTimeItemCfg.type == eLimitTimeItemType.Fixed then
      local count = PlayerDataCenter:GetItemCount(itemCfg.id)
      item:InitWarehouseLimitTimeItem(itemCfg, count, limitTimeItemCfg.time, self._onWarehouseItemClick)
    end
    if self.__LimitTimeItems == nil then
      self.__LimitTimeItems = {}
    end
    self.__LimitTimeItems[item] = item
    if self.__LimitTimeUpdateTimerId == nil then
      self.__LimitTimeUpdateTimerId = TimerManager:StartTimer(60, self.__LimitTimeItemUpdate, self, false, false, true)
    end
  else
    local count = PlayerDataCenter:GetItemCount(itemCfg.id)
    item:InitWarehouseItem(itemCfg, count, self._onWarehouseItemClick)
    if self.__LimitTimeItems ~= nil and self.__LimitTimeItems[item] ~= nil then
      self.__LimitTimeItems[item] = nil
    end
  end
end

function UIWarehouse:__LimitTimeItemUpdate()
  if self.__LimitTimeItems == nil then
    TimerManager:StopTimer(self.__LimitTimeUpdateTimerId)
    self.__LimitTimeUpdateTimerId = nil
    return
  end
  for k, v in pairs(self.__LimitTimeItems) do
    v:UpdateLimitTimeDetail()
  end
end

function UIWarehouse:GetWarehouseItemByIndex(index)
  local go = self.ui.itemScroll:GetCellByIndex(index - 1)
  return self.itemDic[go]
end

function UIWarehouse:OnItemUpdateWarehouse(itemUpdate)
  for itemId, isdelete in pairs(itemUpdate) do
    if self:IsItemInCurTab(itemId) then
      local index = self.dataDic[itemId]
      if isdelete or index == nil then
        self:UpdateItemShow(false)
        break
      else
        local count = PlayerDataCenter:GetItemCount(itemId)
        local item = self:GetWarehouseItemByIndex(index)
        if item ~= nil then
          item:SetNum(count)
        end
      end
    end
  end
end

function UIWarehouse:IsItemInCurTab(itemId)
  local itemCfg = ConfigData.item[itemId]
  if itemCfg ~= nil then
    local page = itemCfg.warehouse_page
    local isInPage = self.tabId == allShowTabId and 0 < page or page == self.tabId
    local limitTimeItemCfg = ConfigData.item_time_limit[itemId]
    if limitTimeItemCfg ~= nil then
      isInPage = isInPage or 0 < page and self.tabId == eWareHouseType.wharehouseType.LimitTimeItem
    end
    return isInPage
  end
  return false
end

function UIWarehouse:OnListenReddotWarehouse()
  for _, tabItem in ipairs(self.tabPool.listItem) do
    tabItem:RefreshRedDotState()
  end
  for _, warehouseItem in pairs(self.itemDic) do
    warehouseItem:RefreshRedDotState()
  end
end

function UIWarehouse:_OnWarehouseItemClick(itemCfg, stackInfo)
  if GuideManager.inGuide and not GuideManager:HasGuideFeature(GuideEnum.GuideFeature.ItemDetail) then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.GlobalItemDetail, function(win)
    if win ~= nil then
      local limitTimeItemCfg = ConfigData.item_time_limit[itemCfg.id]
      if limitTimeItemCfg ~= nil then
        win:InitLimitTimeItemDetail(itemCfg, stackInfo)
        win:ShowUseGiftBtn(itemCfg)
      else
        win:InitCommonItemDetail(itemCfg)
        win:ShowUseGiftBtn(itemCfg)
      end
    end
  end)
end

function UIWarehouse:OnClickClose()
  JumpManager.couldUseItemJump = self._lastCouldUseItemJump
  self:OnCloseWin()
  self:Delete()
end

function UIWarehouse:OnDelete()
  self.__LimitTimeItems = nil
  TimerManager:StopTimer(self.__LimitTimeUpdateTimerId)
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__OnItemUpdate)
  RedDotController:RemoveListener(RedDotDynPath.WarehousePath, self.__OnListenReddotWarehouse)
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  base.OnDelete(self)
end

return UIWarehouse
