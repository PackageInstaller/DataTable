local UINShopFntItemList = {}
local UINShopFntItemList = class("UINShopFntItemList", UIBaseNode)
local base = UIBaseNode
local UINShopFntItem = require("Game.Shop.Dorm.UINShopFntItem")
local cs_Canvas = CS.UnityEngine.Canvas
local ShopUtil = require("Game.Shop.ShopUtil")
local ShopEnum = require("Game.Shop.ShopEnum")
local fntNormalItem = require("Game.Shop.Dorm.UINShopFntNormalItem")
local fntEmptyItem = require("Game.Shop.Dorm.UINShopFntEmptyItem")
local fntTitleItem = require("Game.Shop.Dorm.UINShopFntTitleItem")

function UINShopFntItemList:OnInit()
  self.ItemDic = {}
  self.dataList = {}
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.fntNormalItemPool = UIItemPool.New(fntNormalItem, self.ui.obj_shopFurnitureItem)
  self.fntEmptyItemPool = UIItemPool.New(fntEmptyItem, self.ui.obj_emptyFurnitureItem)
  self.fntTitleItemPool = UIItemPool.New(fntTitleItem, self.ui.obj_furnitureThemeItem)
  self.ui.fntListNode.onInstantiateItem = BindCallback(self, self.__OnNewItem)
  self.ui.fntListNode.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.ui.fntListNode.onReturnItem = BindCallback(self, self.__OnReturnItem)
  self.__SortAndRefreshFntData = BindCallback(self, self.SortAndRefreshFntData)
  self.__OnFntTimerRefresh = BindCallback(self, self.OnFntTimerRefresh)
  self.__OnBuyFntSuitRefresh = BindCallback(self, self.RereshFntShopNodeData)
  MsgCenter:AddListener(eMsgEventId.ShopSuitGoodsBuyed, self.__OnBuyFntSuitRefresh)
end

function UINShopFntItemList:ShopCommonInit(uiShop)
  self.uiShop = uiShop
  self.shopCtrl = uiShop.shopCtrl
end

function UINShopFntItemList:RefreshShopNode(shopId, pageId, autoSelectShelfId)
  self.shopId = shopId
  self.pageId = pageId
  self.needFresh = true
  self.autoSelectShelfId = autoSelectShelfId
  self.shopCtrl:GetShopData(shopId, function(shopData)
    local shopGoodsDic = shopData:GetCurShopGoods(pageId)
    local topItemIds = shopData:SetResourceDisplay(shopGoodsDic)
    UIUtil.RefreshTopResId(topItemIds, self:GetDormCoinQuickBuyFunc())
    self:RefreshShopFntItems(shopGoodsDic, self.uiShop.ui.quickPurchaseRoot, autoSelectShelfId, shopData)
    self.uiShop:RefreshHeadBar(shopData)
  end)
  self.suitsOtherList = self:GetFurnitureSuits()
end

function UINShopFntItemList:RereshFntShopNodeData()
  self.needFresh = true
  self.shopCtrl:GetShopData(self.shopId, function(shopData)
    local shopGoodsDic = shopData:GetCurShopGoods(self.pageId)
    local topItemIds = shopData:SetResourceDisplay(shopGoodsDic)
    UIUtil.RefreshTopResId(topItemIds, self:GetDormCoinQuickBuyFunc())
    self:RefreshShopFntItems(shopGoodsDic, self.uiShop.ui.quickPurchaseRoot, self.autoSelectShelfId, shopData)
    self.uiShop:RefreshHeadBar(shopData)
  end)
end

function UINShopFntItemList:GetFurnitureSuits()
  if self.shopId == ShopEnum.ShopId.dormFnt then
    return ShopEnum.FurnitureSuits.defaultSuits
  else
    return ShopEnum.FurnitureSuits.actSuits
  end
end

function UINShopFntItemList:RefreshShopFntItems(shopGoodsDic, purchaseRoot, autoSelectShelfId, shopData)
  self.purchaseRoot = purchaseRoot
  self.shopData = shopData
  self.shopGoodsDic = shopGoodsDic
  self.dataList = {}
  for shelfId, goodData in pairs(shopGoodsDic) do
    goodData.type = ShopEnum.eFurnitureItemType.normal
    table.insert(self.dataList, goodData)
  end
  self.dataBeginIndex = 1
  self.dataEndIndex = #shopGoodsDic
  ShopUtil.CommonSortGoodList(self.dataList)
  self:SortAndRefreshFntData(true)
  if self.shopCtrl:GetIsThisShopHasTimeLimit(self.shopData.shopId) then
    self.shopCtrl:AddShopTimerCallback(self.__OnFntTimerRefresh, "FntItemList")
  end
  if autoSelectShelfId == nil then
    return
  end
  local goodsData
  for k, v in pairs(shopGoodsDic) do
    if v.shelfId == autoSelectShelfId then
      goodsData = v
    end
  end
  if goodsData ~= nil then
    UIManager:ShowWindowAsync(UIWindowTypeID.QuickBuy, function(win)
      if win == nil then
        error("can't open QuickBuy win")
        return
      end
      local resIds = {}
      table.insert(resIds, goodsData.currencyId)
      if goodsData.currencyId == ConstGlobalItem.PaidSubItem and not table.contain(resIds, ConstGlobalItem.PaidItem) then
        table.insert(resIds, 1, ConstGlobalItem.PaidItem)
      end
      win:SlideIn()
      win:InitBuyTarget(goodsData, function()
        self:SortAndRefreshFntData()
      end, true, resIds)
      win:OnClickAdd(true)
    end)
  end
end

function UINShopFntItemList:QSortFntData(dataList, left, right)
  if left < right then
    local pivot = self:Partition(dataList, left, right)
    self:QSortFntData(dataList, left, pivot - 1)
    self:QSortFntData(dataList, pivot + 1, right)
  end
end

function UINShopFntItemList.SwapFnt(dataList, i, j)
  local temp = dataList[j]
  dataList[j] = dataList[i]
  dataList[i] = temp
end

function UINShopFntItemList:Partition(dataList, left, right)
  local m = left + math.floor((right - left) / 2)
  self.SwapFnt(dataList, m, left)
  local pivotKey = dataList[left]
  while left < right do
    while left < right and self:CompareFunc(pivotKey, dataList[right]) do
      right = right - 1
    end
    self.SwapFnt(dataList, right, left)
    while left < right and self:CompareFunc(dataList[left], pivotKey) do
      left = left + 1
    end
    self.SwapFnt(dataList, right, left)
  end
  return left
end

function UINShopFntItemList:CompareFunc(a, b)
  if a.isSoldOut ~= b.isSoldOut then
    return b.isSoldOut
  end
  if a.order ~= b.order then
    return a.order < b.order
  end
  return a.shelfId <= b.shelfId
end

function UINShopFntItemList:SortAndRefreshFntData(isInit)
  self:QSortFntData(self.dataList, self.dataBeginIndex, self.dataEndIndex)
  if isInit then
    self:ReplenishFntItemList()
  end
  if self.needFresh then
    self.ui.fntListNode:ClearCells()
  end
  local num = #self.dataList
  cs_Canvas.ForceUpdateCanvases()
  if self.ui == nil then
    return
  end
  self.ui.fntListNode.totalCount = num
  if self.needFresh or isInit then
    self.ui.fntListNode:RefillCells()
  else
    self.ui.fntListNode:RefreshCells()
  end
  self.needFresh = false
end

function UINShopFntItemList:ReplenishFntItemList()
  for i, v in ipairs(self.suitsOtherList.forward) do
    if v == ShopEnum.eFurnitureItemType.title then
      table.insert(self.dataList, 1, self:__CreatTitleItem())
    else
      table.insert(self.dataList, 1, self:__CreatEmptyItem())
    end
  end
  self.dataBeginIndex = #self.suitsOtherList.forward + 1
  for i, v in ipairs(self.suitsOtherList.back) do
    if v == ShopEnum.eFurnitureItemType.title then
      table.insert(self.dataList, self:__CreatTitleItem())
    else
      table.insert(self.dataList, self:__CreatEmptyItem())
    end
  end
  self.dataEndIndex = #self.dataList - #self.suitsOtherList.back
end

function UINShopFntItemList:__CreatEmptyItem()
  return {
    type = ShopEnum.eFurnitureItemType.empty
  }
end

function UINShopFntItemList:__CreatTitleItem()
  local item = {}
  item.type = ShopEnum.eFurnitureItemType.title
  item.shopId = self.shopId
  item.shopGoodsDic = self.shopGoodsDic
  return item
end

function UINShopFntItemList:__OnNewItem(go)
  local goodItem = UINShopFntItem.New()
  goodItem:Init(go)
  self.ItemDic[go] = goodItem
end

function UINShopFntItemList:__OnChangeItem(go, index)
  local goodItem = self.ItemDic[go]
  if goodItem == nil then
    error("Can't find goodItem by gameObject")
    return
  end
  self:ReturnItem(goodItem)
  local goodData = self.dataList[index + 1]
  if goodData == nil then
    error("Can't find goodData by index, index = " .. tostring(index))
  end
  local baseObj
  if goodData.type == ShopEnum.eFurnitureItemType.normal then
    baseObj = self.fntNormalItemPool:GetOne(true)
  elseif goodData.type == ShopEnum.eFurnitureItemType.empty then
    baseObj = self.fntEmptyItemPool:GetOne(true)
  else
    baseObj = self.fntTitleItemPool:GetOne(true)
  end
  goodItem:InitNormalGoodsItem(goodData, self.purchaseRoot, self.__SortAndRefreshFntData, baseObj)
end

function UINShopFntItemList:__OnReturnItem(go)
  local goodItem = self.ItemDic[go]
  if goodItem == nil then
    error("Can't find goodItem by gameObject")
    return
  end
  self:ReturnItem(goodItem)
end

function UINShopFntItemList:ReturnItem(goodItem)
  local goodData = goodItem.goodData
  local baseObj = goodItem.baseObj
  if baseObj == nil then
    return
  end
  baseObj.transform:SetParent(self.transform, false)
  if goodData.type == ShopEnum.eFurnitureItemType.normal then
    self.fntNormalItemPool:HideOne(baseObj)
  elseif goodData.type == ShopEnum.eFurnitureItemType.empty then
    self.fntEmptyItemPool:HideOne(baseObj)
  else
    self.fntTitleItemPool:HideOne(baseObj)
  end
  goodItem.baseObj = nil
end

function UINShopFntItemList:GetDormCoinQuickBuyFunc()
  if self.__quickCoinBuyFunc ~= nil then
    return self.__quickCoinBuyFunc
  end
  self.__quickCoinBuyFunc = {
    [ConstGlobalItem.DormCoin] = function()
      local ShopEnum = require("Game.Shop.ShopEnum")
      local quickBuyData = ShopEnum.eQuickBuy.dormCoin
      local shopId = quickBuyData.shopId
      local shelfId = quickBuyData.shelfId
      local goodData
      local ctrl = ControllerManager:GetController(ControllerTypeId.Shop, true)
      ctrl:GetShopData(shopId, function(shopData)
        goodData = shopData.shopGoodsDic[shelfId]
        UIManager:ShowWindowAsync(UIWindowTypeID.QuickBuy, function(win)
          if win == nil then
            error("can't open QuickBuy win")
            return
          end
          win:SlideIn()
          win:InitBuyTarget(goodData, nil, true, quickBuyData.resourceIds)
          win:OnClickAdd(true)
        end)
      end)
    end
  }
  return self.__quickCoinBuyFunc
end

function UINShopFntItemList:OnFntTimerRefresh()
  local isNeedRefresh
  for go, goodItem in pairs(self.ItemDic) do
    isNeedRefresh = go.activeInHierarchy and goodItem:RefreshLeftSellTime() or isNeedRefresh
  end
  if isNeedRefresh then
    self.uiShop:InitShop(self.shopId)
  end
end

function UINShopFntItemList:OnHide()
  base.OnHide(self)
  self.shopCtrl:RemoveShopTimerCallback(self.__OnFntTimerRefresh)
end

function UINShopFntItemList:OnDelete()
  self.shopCtrl:RemoveShopTimerCallback(self.__OnFntTimerRefresh)
  MsgCenter:RemoveListener(eMsgEventId.ShopSuitGoodsBuyed, self.__OnBuyFntSuitRefresh)
  self.fntTitleItemPool:DeleteAll()
  self.fntEmptyItemPool:DeleteAll()
  self.fntTitleItemPool:DeleteAll()
  base.OnDelete(self)
end

return UINShopFntItemList
