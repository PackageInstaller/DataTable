local ShopDataBase = class("ShopDataBase")
local ShopEnum = require("Game.Shop.ShopEnum")
local ShopGoodData = require("Game.Shop.ShopGoodData")

function ShopDataBase:ctor()
  self.shopId = nil
  self.shopCfg = nil
  self.shopType = nil
  self.shopName = nil
  self.shopName_EN = nil
  self.shopGoodsDic = {}
  self.__shopDataCompDic = {}
  self.__shopDataComplist = {}
end

function ShopDataBase:InitShopData(shopDataMsg, shopId)
  self.shopId = shopId
  local shopCfg = ConfigData.shop[self.shopId]
  if shopCfg == nil then
    error("shop cfg is null,ID:" .. tostring(self.shopId))
    return
  end
  self.shopCfg = shopCfg
  self.shopType = shopCfg.shop_type
  self.shopName = LanguageUtil.GetLocaleText(shopCfg.name)
  self.shopName_EN = LanguageUtil.GetLocaleText(shopCfg.name_en)
  self:UpdateShopData(shopDataMsg)
end

function ShopDataBase:UpdateShopGoodsData(shopDataMsg)
  if shopDataMsg == nil then
    return
  end
  for shelfId, shopGoods in pairs(self.shopGoodsDic) do
    if shopDataMsg.data[shelfId] == nil then
      self.shopGoodsDic[shelfId] = nil
    end
  end
  for _, data in pairs(shopDataMsg.data) do
    local shopGoodsData = self.shopGoodsDic[data.shelfId]
    if shopGoodsData == nil then
      self.shopGoodsDic[data.shelfId] = ShopGoodData.CreateShopGoodData(data, self.shopType, self.shopId)
    else
      shopGoodsData:InitShopGoodData(data, self.shopType, self.shopId)
    end
  end
end

function ShopDataBase:UpdateShopComps(shopDataMsg)
  for _, comp in ipairs(self.__shopDataComplist) do
    comp:UpdateShopDataComp(self, shopDataMsg)
  end
end

function ShopDataBase:AddShopDataComp(compType)
  if self.__shopDataCompDic[compType] ~= nil then
    error("shopData already have this comp" .. tostring(compType))
    return
  end
  local compClass = ShopEnum.eShopDataCompClass[compType]
  if compClass == nil then
    error("can't find shopData comp" .. tostring(compType))
    return
  end
  local comp = compClass.New()
  table.insert(self.__shopDataComplist, comp)
  self.__shopDataCompDic[compType] = comp
end

function ShopDataBase:GetShopDataComp(compType)
  return self.__shopDataCompDic[compType]
end

function ShopDataBase:UpdateShopData(shopDataMsg)
  self:UpdateShopGoodsData(shopDataMsg)
  self:UpdateShopComps(shopDataMsg)
end

function ShopDataBase:GetIsHavePages()
  return self:GetShopDataComp(ShopEnum.eShopDataCompType.page) ~= nil
end

function ShopDataBase:GetPageDic()
  local pageComp = self:GetShopDataComp(ShopEnum.eShopDataCompType.page)
  return pageComp:GetShopPagesDic()
end

function ShopDataBase:HasShopGoodsInPage(pageId)
  local pageComp = self:GetShopDataComp(ShopEnum.eShopDataCompType.page)
  return pageComp:HasShopGoodsInPage(pageId)
end

function ShopDataBase:GetCurShopGoods(pageId)
  local pageComp = self:GetShopDataComp(ShopEnum.eShopDataCompType.page)
  if pageComp == nil or pageId == nil then
    return self.shopGoodsDic
  else
    local shelfIds = pageComp:GetShopPagesDic()[pageId]
    local goodsDatas = {}
    for index, shelfId in ipairs(shelfIds.shelfIds) do
      table.insert(goodsDatas, self.shopGoodsDic[shelfId])
    end
    return goodsDatas
  end
end

function ShopDataBase:GetIsHaveRefresh()
  return self:GetShopDataComp(ShopEnum.eShopDataCompType.refresh) ~= nil
end

function ShopDataBase:GetIsCouldRefresh()
  return self.couldFresh
end

function ShopDataBase:GetRemainAutoRefreshTime(needZero)
  if self:GetIsHaveRefresh() then
    return self:GetShopDataComp(ShopEnum.eShopDataCompType.refresh):GetRemainAutoRefreshTime()
  end
end

function ShopDataBase:GetIsHaveLimitTime()
  return self:GetShopDataComp(ShopEnum.eShopDataCompType.timeLimit) ~= nil
end

function ShopDataBase:GetIsLimitTimeRefresh()
  if self:GetIsHaveLimitTime() then
    return self:GetShopDataComp(ShopEnum.eShopDataCompType.timeLimit):GetNeedRefreshGoodsTs()
  end
  return -1
end

function ShopDataBase:GetIsHaveRefreshItem()
  local latestRT
  for _, goodData in pairs(self.shopGoodsDic) do
    if goodData.isLimit then
      if latestRT == nil then
        latestRT = goodData.freshTm
      else
        latestRT = math.min(goodData.freshTm, latestRT)
      end
    end
  end
  if latestRT == nil then
    return false
  end
  return latestRT - PlayerDataCenter.timestamp <= 0
end

function ShopDataBase:GetShopGoodDataByItemId(itemId, isCheckGift)
  for shelfId, goodsData in pairs(self.shopGoodsDic) do
    if goodsData.itemId == itemId then
      return goodsData
    elseif isCheckGift then
      local itemCfg = ConfigData.item[goodsData.itemId]
      if itemCfg.type == eItemType.Package then
        for i = 1, #itemCfg.arg do
          if itemCfg.arg[i] == itemId then
            return goodsData
          end
        end
      end
    end
  end
end

function ShopDataBase:GetNormalShopGoodByItemId(itemId)
  for shelfId, goodsData in pairs(self.shopGoodsDic) do
    if goodsData.itemId == itemId then
      return goodsData
    end
  end
end

function ShopDataBase:SetResourceDisplay(shopGoodsDic)
  local idDic = {}
  if shopGoodsDic ~= nil then
    for _, goodsData in pairs(shopGoodsDic) do
      if goodsData.currencyId ~= nil then
        idDic[goodsData.currencyId] = true
      end
    end
  end
  if self:GetIsHaveRefresh() and self.refreshCost then
    idDic[self.refreshCost.costId] = true
  end
  if idDic[ConstGlobalItem.PaidSubItem] then
    idDic[ConstGlobalItem.PaidItem] = true
  end
  local ids = {}
  for id, _ in pairs(idDic) do
    table.insert(ids, id)
  end
  table.sort(ids, function(a, b)
    return a < b
  end)
  return ids
end

function ShopDataBase:GetShopInSellDormThemeDic(themeIdDic)
  for _, goodData in pairs(self.shopGoodsDic) do
    local themeId = goodData.shelfCfg.theme_id
    if themeId ~= 0 then
      themeIdDic[themeId] = true
    end
  end
end

return ShopDataBase
