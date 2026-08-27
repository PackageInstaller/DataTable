local UINShopNormalGoodsList = class("UINShopNormalGoodsList", UIBaseNode)
local base = UIBaseNode
local UINShopNormalGoogsItem = require("Game.Shop.UINShopNormalGoogsItem")
local cs_Canvas = CS.UnityEngine.Canvas
local ShopUtil = require("Game.Shop.ShopUtil")
local ShopEnum = require("Game.Shop.ShopEnum")

function UINShopNormalGoodsList:OnInit()
  self.ItemDic = {}
  self.dataList = {}
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.goodListNode.onInstantiateItem = BindCallback(self, self.__OnNewItem)
  self.ui.goodListNode.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self._OnItemRefresh = BindCallback(self, self.OnItemRefresh)
  self._RefreshItemView = BindCallback(self, self.RefreshItemView)
  self._ResortShelfItems = BindCallback(self, self.ResortShelfItems)
  self.__OnNormalTimerRefresh = BindCallback(self, self.OnNormalTimerRefresh)
end

function UINShopNormalGoodsList:OnShow()
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self._OnItemRefresh)
  MsgCenter:AddListener(eMsgEventId.ShopGoodsBuyed, self._RefreshItemView)
  base.OnShow(self)
end

function UINShopNormalGoodsList:ShopCommonInit(uiShop)
  self.uiShop = uiShop
  self.shopCtrl = uiShop.shopCtrl
end

function UINShopNormalGoodsList:RefreshShopNode(shopId, pageId, autoSelectShelfId)
  self.__shopId = shopId
  self.__pageId = pageId
  self.shopCtrl:GetShopData(shopId, function(shopData)
    local shopGoodsDic = shopData:GetCurShopGoods(pageId)
    for shelfId, goodsData in pairs(shopGoodsDic) do
      local hasTimeLimit, inTime, startTime, endTime = goodsData:GetStillTime()
      if hasTimeLimit then
        if inTime then
          self.uiShop:SetNeedRefreshTm(endTime)
        else
          self.uiShop:SetNeedRefreshTm(startTime)
        end
      end
    end
    local topItemIds = shopData:SetResourceDisplay(shopGoodsDic)
    if self.gameObject.activeInHierarchy then
      UIUtil.RefreshTopResId(topItemIds)
    end
    self:RefreshShelfItems(shopGoodsDic, self.uiShop.ui.quickPurchaseRoot, shopData, autoSelectShelfId)
    self.uiShop:RefreshHeadBar(shopData)
    self.shopCtrl:AddShopTimerCallback(self.__OnNormalTimerRefresh, "NormalGoodsList" .. tostring(shopId))
  end)
end

function UINShopNormalGoodsList:RefreshShelfItems(shopGoodsDic, purchaseRoot, shopData, autoSelectShelfId)
  self.purchaseRoot = purchaseRoot
  self.dataList = {}
  for shelfId, goodData in pairs(shopGoodsDic) do
    table.insert(self.dataList, goodData)
  end
  self._isFreshShop = shopData.shopCfg.isRefreshShop
  ShopUtil.CommonAndFragSrotGoodList(self.dataList, self._isFreshShop)
  local num = #self.dataList
  cs_Canvas.ForceUpdateCanvases()
  self.ui.goodListNode.totalCount = num
  self.ui.goodListNode:RefillCells()
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
        for k, v in pairs(self.ItemDic) do
          if v.goodData == goodsData then
            v:RefreshGoods()
          end
        end
      end, true, resIds)
      win:OnClickAdd(true)
    end)
  end
end

function UINShopNormalGoodsList:ResortShelfItems()
  ShopUtil.CommonAndFragSrotGoodList(self.dataList, self._isFreshShop)
  local num = #self.dataList
  cs_Canvas.ForceUpdateCanvases()
  self.ui.goodListNode.totalCount = num
  self.ui.goodListNode:RefillCells()
end

function UINShopNormalGoodsList:__OnNewItem(go)
  local goodItem = UINShopNormalGoogsItem.New()
  goodItem:Init(go)
  self.ItemDic[go] = goodItem
  goodItem:BindNorShopAllRefreshCallback(self._ResortShelfItems)
end

function UINShopNormalGoodsList:__OnChangeItem(go, index)
  local goodItem = self.ItemDic[go]
  if goodItem == nil then
    error("Can't find goodItem by gameObject")
    return
  end
  local goodData = self.dataList[index + 1]
  if goodData == nil then
    error("Can't find goodData by index, index = " .. tostring(index))
  end
  goodItem:InitNormalGoodsItem(goodData, self.purchaseRoot)
end

function UINShopNormalGoodsList:m_GetItemGoByIndex(index)
  if index >= self.ui.goodListNode.content.childCount then
    return nil
  end
  local go = self.ui.goodListNode:GetCellByIndex(index)
  if go ~= nil then
    local goodItem = self.ItemDic[go]
    return goodItem
  end
  return nil
end

function UINShopNormalGoodsList:RefreshItemView(shopId, shelfId)
  if self.__shopId ~= ShopEnum.ShopId.hero or self.__shopId ~= shopId then
    return
  end
  for index, goodData in ipairs(self.dataList) do
    if goodData.shelfId == shelfId then
      goodData:RefreshDataWithSeverMsg()
      local item = self:m_GetItemGoByIndex(index - 1)
      if item ~= nil then
        item:RefreshGoods()
      end
    end
  end
end

function UINShopNormalGoodsList:OnItemRefresh(itemUpdate)
  if self.__shopId ~= ShopEnum.ShopId.hero then
    return
  end
  for index, goodData in ipairs(self.dataList) do
    if itemUpdate[goodData.itemId] ~= nil then
      goodData:RefreshDataWithSeverMsg()
      local item = self:m_GetItemGoByIndex(index - 1)
      if item ~= nil then
        item:RefreshGoods()
      end
    end
  end
end

function UINShopNormalGoodsList:OnNormalTimerRefresh()
  if self.__shopId == ShopEnum.ShopId.photoCommemorate then
    for index, goodData in ipairs(self.dataList) do
      local item = self:m_GetItemGoByIndex(index - 1)
      if item ~= nil then
        item:RefreshLeftSellTime()
      end
    end
  end
end

function UINShopNormalGoodsList:OnHide()
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self._OnItemRefresh)
  MsgCenter:RemoveListener(eMsgEventId.ShopGoodsBuyed, self._RefreshItemView)
  self.shopCtrl:RemoveShopTimerCallback(self.__OnNormalTimerRefresh)
  base.OnHide(self)
end

function UINShopNormalGoodsList:OnDelete()
  base.OnDelete(self)
end

return UINShopNormalGoodsList
