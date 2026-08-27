local UINShopHeroGoodsList = class("UINShopHeroGoodsList", UIBaseNode)
local base = UIBaseNode
local UINShopHeroGoodsItem = require("Game.Shop.UINShopHeroGoodsItem")
local cs_Canvas = CS.UnityEngine.Canvas
local ShopEnum = require("Game.Shop.ShopEnum")

function UINShopHeroGoodsList:OnInit()
  self.ItemDic = {}
  self.dataList = {}
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.heroItemList.onInstantiateItem = BindCallback(self, self.__OnNewItem)
  self.ui.heroItemList.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self._OnItemRefresh = BindCallback(self, self.OnItemRefresh)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self._OnItemRefresh)
  self._RefreshItemView = BindCallback(self, self.RefreshItemView)
  MsgCenter:AddListener(eMsgEventId.ShopGoodsBuyed, self._RefreshItemView)
  self.__OnTimerRefresh = BindCallback(self, self.OnTimerRefresh)
  self.__OnClickGoodItem = BindCallback(self, self.OnClickGoodItem)
end

function UINShopHeroGoodsList:ShopCommonInit(uiShop)
  self.uiShop = uiShop
  self.shopCtrl = uiShop.shopCtrl
  self.purchaseRoot = uiShop.ui.quickPurchaseRoot
  self.resloader = uiShop.resloader
end

function UINShopHeroGoodsList:RefreshShopNode(shopId, pageId, autoSelectShelfId)
  self.shopCtrl:GetShopData(shopId, function(shopData)
    for shelfId, goodsData in pairs(shopData.shopGoodsDic) do
      local hasTimeLimit, inTime, startTime, endTime = goodsData:GetStillTime()
      if hasTimeLimit then
        if inTime then
          self.uiShop:SetNeedRefreshTm(endTime)
        else
          self.uiShop:SetNeedRefreshTm(startTime)
        end
      end
    end
    local shopGoodsDic = shopData:GetCurShopGoods(pageId)
    local topItemIds = shopData:SetResourceDisplay(shopGoodsDic)
    if self.gameObject.activeInHierarchy then
      UIUtil.RefreshTopResId(topItemIds)
    end
    self:RefreshShelfItems(shopGoodsDic, autoSelectShelfId, shopData)
    local shopCfg = ConfigData.shop[shopId]
    self.uiShop:RefreshHeadBar(shopData, shopCfg)
    if shopId == ShopEnum.ShopId.skin or shopId == ShopEnum.ShopId.vow then
      self.shopCtrl:SetHaveNewGoodItemInShop(shopData)
      self.uiShop.pageBtnListNode:OnShopReddotRefresh()
    end
  end)
end

function UINShopHeroGoodsList:RefreshShelfItems(shopGoodsDic, autoSelectShelfId, shopData)
  self.ui.heroItemList:ClearCells()
  self.dataList = {}
  for shelfId, goodData in pairs(shopGoodsDic) do
    table.insert(self.dataList, goodData)
  end
  self.__shopId = 0
  local num = #self.dataList
  if 0 < num then
    self.__shopId = self.dataList[1].shopId
  end
  self.ui.emptySkin:SetActive(num <= 0)
  self:SortAndSetData()
  self.shopCtrl:AddShopTimerCallback(self.__OnTimerRefresh, "HeroGoodsList")
  if autoSelectShelfId == nil then
    return
  end
  local selecData
  for k, v in pairs(shopGoodsDic) do
    if v.shelfId == autoSelectShelfId then
      selecData = v
      break
    end
  end
  if selecData ~= nil then
    self:OnClickGoodItem(selecData)
  end
end

function UINShopHeroGoodsList:OnClickGoodItem(goodData)
  local itemCfg = ConfigData.item[goodData.itemId]
  if itemCfg.type == eItemType.Skin then
    local skinId = goodData.itemId
    local isInTimeRange = PlayerDataCenter.skinData:IsInSkinUpgradeTimeRange(skinId)
    local skinUpOpen = PlayerDataCenter.skinData:IsSkinCanUpgrade(skinId)
    skinUpOpen = isInTimeRange and skinUpOpen
    if goodData.isSoldOut and not skinUpOpen then
      return
    end
    UIManager:ShowWindowAsync(UIWindowTypeID.HeroSkin, function(win)
      if win == nil then
        return
      end
      local skinIds = {}
      for i, v in ipairs(self.dataList) do
        local cfg = ConfigData.item[v.itemId]
        if cfg.type == eItemType.Skin then
          table.insert(skinIds, v.itemId)
        end
      end
      local SkinEnum = require("Game.Skin.SkinEnum")
      win:SetSkinFromWhere(SkinEnum.fromWhere.shopOrGift)
      win:InitSkinBySkinList(skinId, skinIds, nil, function()
        local shopWin = UIManager:GetWindow(UIWindowTypeID.ShopMain)
        if shopWin ~= nil then
          shopWin:Show()
        end
        for k, v in pairs(self.ItemDic) do
          if v.goodData.itemId == goodData.itemId then
            v:RefreshGoods()
          end
        end
      end)
      local shopWin = UIManager:GetWindow(UIWindowTypeID.ShopMain)
      if shopWin ~= nil then
        shopWin:Hide()
      end
    end)
  else
    if goodData.isSoldOut then
      return
    end
    UIManager:ShowWindowAsync(UIWindowTypeID.QuickBuy, function(win)
      if win == nil then
        return
      end
      local resIds = {}
      table.insert(resIds, goodData.currencyId)
      if goodData.currencyId == ConstGlobalItem.PaidSubItem and not table.contain(resIds, ConstGlobalItem.PaidItem) then
        table.insert(resIds, 1, ConstGlobalItem.PaidItem)
      end
      win:SlideIn()
      win:InitBuyTarget(goodData, function()
        for k, v in pairs(self.ItemDic) do
          if v.goodData.itemId == goodData.itemId then
            v:RefreshGoods()
          end
        end
      end, true, resIds)
      win:OnClickAdd(true)
    end)
  end
end

function UINShopHeroGoodsList:SortAndSetData()
  table.sort(self.dataList, function(a, b)
    if a.isSoldOut ~= b.isSoldOut then
      return b.isSoldOut
    end
    if a.order ~= b.order then
      return a.order > b.order
    end
    return a.shelfId < b.shelfId
  end)
  local num = #self.dataList
  cs_Canvas.ForceUpdateCanvases()
  self.ui.heroItemList.totalCount = num
  self.ui.heroItemList:RefillCells()
end

function UINShopHeroGoodsList:__OnNewItem(go)
  local goodItem = UINShopHeroGoodsItem.New()
  goodItem:Init(go)
  goodItem:InitItem(self.resloader, self.__OnClickGoodItem)
  self.ItemDic[go] = goodItem
end

function UINShopHeroGoodsList:__OnChangeItem(go, index)
  local goodItem = self.ItemDic[go]
  if goodItem == nil then
    error("Can't find goodItem by gameObject")
    return
  end
  local goodData = self.dataList[index + 1]
  if goodData == nil then
    error("Can't find goodData by index, index = " .. tostring(index))
  end
  goodItem:InitNormalGoodsItem(goodData, self, self.purchaseRoot)
end

function UINShopHeroGoodsList:RefreshItemView(shopId, shelfId)
  if self.__shopId ~= shopId then
    return
  end
  self:SortAndSetData()
end

function UINShopHeroGoodsList:m_GetItemGoByIndex(index)
  if index >= self.ui.heroItemList.content.childCount then
    return nil
  end
  local go = self.ui.heroItemList:GetCellByIndex(index)
  if go ~= nil then
    local goodItem = self.ItemDic[go]
    return goodItem
  end
  return nil
end

function UINShopHeroGoodsList:OnTimerRefresh()
  for go, goodsItem in pairs(self.ItemDic) do
    if go.activeInHierarchy and goodsItem.goodData ~= nil then
      goodsItem:RefreshSkinLeftTime()
      goodsItem:RefreshSkinUpGrade()
    end
  end
end

function UINShopHeroGoodsList:OnItemRefresh(itemUpdate)
  for index, goodData in ipairs(self.dataList) do
    if itemUpdate[goodData.itemId] ~= nil then
      local item = self:m_GetItemGoByIndex(index - 1)
      if item ~= nil then
        item:RefreshFrgNum()
      end
    end
  end
end

function UINShopHeroGoodsList:OnShow()
  base.OnShow(self)
  self.shopCtrl:RemoveShopTimerCallback(self.__OnTimerRefresh)
end

function UINShopHeroGoodsList:OnHide()
  base.OnHide(self)
  self.shopCtrl:RemoveShopTimerCallback(self.__OnTimerRefresh)
end

function UINShopHeroGoodsList:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self._OnItemRefresh)
  MsgCenter:RemoveListener(eMsgEventId.ShopGoodsBuyed, self._RefreshItemView)
  self.shopCtrl:RemoveShopTimerCallback(self.__OnTimerRefresh)
  base.OnDelete(self)
end

return UINShopHeroGoodsList
