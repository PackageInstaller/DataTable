local UINShopThemeSkinList = class("UINShopThemeSkinList", UIBaseNode)
local base = UIBaseNode
local UINShopThemeSkinItem = require("Game.Shop.UINShopThemeSkinItem")

function UINShopThemeSkinList:OnInit()
  self.ItemDic = {}
  self.dataList = nil
  self.containThemeDic = nil
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.skinThemeList.onInstantiateItem = BindCallback(self, self.__OnNewItem)
  self.ui.skinThemeList.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.__OnClickGoodItem = BindCallback(self, self.OnClickGoodItem)
end

function UINShopThemeSkinList:ShopCommonInit(uiShop)
  self.uiShop = uiShop
  self.shopCtrl = uiShop.shopCtrl
  self.purchaseRoot = uiShop.ui.quickPurchaseRoot
  self.resloader = uiShop.resloader
end

function UINShopThemeSkinList:RefreshShopNode(shopId, pageId, autoSelectShelfId)
  self.shopCtrl:GetShopData(shopId, function(shopData)
    local shopGoodsDic = shopData:GetCurShopGoods(pageId)
    local shopInTimeDic = {}
    for shelfId, goodsData in pairs(shopGoodsDic) do
      local hasTimeLimit, inTime, startTime, endTime = goodsData:GetStillTime()
      if hasTimeLimit and inTime then
        shopInTimeDic[shelfId] = goodsData
      end
    end
    local topItemIds = shopData:SetResourceDisplay(shopGoodsDic)
    if self.gameObject.activeInHierarchy then
      UIUtil.RefreshTopResId(topItemIds)
    end
    self:RefreshShelfItems(shopInTimeDic, autoSelectShelfId, shopData)
    self.uiShop:RefreshHeadBar(shopData)
  end)
end

function UINShopThemeSkinList:RefreshShelfItems(shopGoodsDic, autoSelectShelfId, shopData)
  self.dataList = {}
  self.containThemeDic = {}
  for shelfId, goodData in pairs(shopGoodsDic) do
    local skin = ConfigData.skin[goodData.itemId]
    local themeData = ConfigData.skinTheme[skin.theme]
    if self.containThemeDic[themeData] == nil then
      self.containThemeDic[themeData] = {}
      table.insert(self.dataList, themeData)
    end
    table.insert(self.containThemeDic[themeData], goodData.itemId)
  end
  table.sort(self.dataList, function(a, b)
    local order_a = a.shop_order
    local order_b = b.shop_order
    if order_a ~= order_b then
      return order_a > order_b
    end
    return b.id < a.id
  end)
  local num = #self.dataList
  self.ui.skinThemeList.totalCount = num
  self.ui.skinThemeList:RefillCells()
end

function UINShopThemeSkinList:OnClickGoodItem(goodData)
  if goodData.isSoldOut then
    return
  end
  local itemCfg = ConfigData.item[self.containThemeDic[goodData][1]]
  if itemCfg.type == eItemType.Skin then
    UIManager:ShowWindowAsync(UIWindowTypeID.HeroSkin, function(win)
      if win == nil then
        return
      end
      local skinId = self.containThemeDic[goodData][1]
      local skinIds = {}
      for i, v in ipairs(self.containThemeDic[goodData]) do
        table.insert(skinIds, v)
      end
      local SkinEnum = require("Game.Skin.SkinEnum")
      win:SetSkinFromWhere(SkinEnum.fromWhere.shopOrGift)
      win:InitSkinBySkinList(skinId, skinIds, nil, function()
        local shopWin = UIManager:GetWindow(UIWindowTypeID.ShopMain)
        if shopWin ~= nil then
          shopWin:Show()
        end
      end)
      local shopWin = UIManager:GetWindow(UIWindowTypeID.ShopMain)
      if shopWin ~= nil then
        shopWin:Hide()
      end
    end)
  end
end

function UINShopThemeSkinList:__OnNewItem(go)
  local goodItem = UINShopThemeSkinItem.New()
  goodItem:Init(go)
  goodItem:InitItem(self.resloader, self.__OnClickGoodItem)
  self.ItemDic[go] = goodItem
end

function UINShopThemeSkinList:__OnChangeItem(go, index)
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

function UINShopThemeSkinList:OnDelete()
  base.OnDelete(self)
end

return UINShopThemeSkinList
