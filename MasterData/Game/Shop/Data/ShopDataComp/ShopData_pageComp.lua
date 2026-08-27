local ShopData_pageComp = class("ShopData_pageComp")

function ShopData_pageComp:ctor()
end

function ShopData_pageComp:UpdateShopDataComp(shopData, shopDataMsg)
  self.shopData = shopData
  self.shopData.shopPagesDic = {}
  self:__SplitShopGoods2Page(shopData)
end

function ShopData_pageComp:GetShopPagesDic()
  return self.shopData.shopPagesDic
end

function ShopData_pageComp:HasShopGoodsInPage(pageId)
  local pageData = self.shopData.shopPagesDic[pageId]
  if pageData == nil or pageData.shelfIds == nil then
    return false
  end
  for _, shelfId in ipairs(pageData.shelfIds) do
    local goods = self.shopData.shopGoodsDic[shelfId]
    if goods ~= nil then
      local hasTime, inTime = goods:GetStillTime()
      if not hasTime or inTime then
        return true
      end
    end
  end
  return false
end

function ShopData_pageComp:__SplitShopGoods2Page(shopData)
  for shelfId, goodData in pairs(shopData.shopGoodsDic) do
    if goodData.pageId == nil then
      error("normal shop doog don't have page shelfId=" .. tostring(shelfId))
    else
      if self.shopData.shopPagesDic[goodData.pageId] == nil then
        local name
        if ConfigData.shop_page[goodData.pageId] == nil or ConfigData.shop_page[goodData.pageId].page == nil then
          name = ""
        else
          name = ConfigData.shop_page[goodData.pageId].page
        end
        self.shopData.shopPagesDic[goodData.pageId] = {}
        self.shopData.shopPagesDic[goodData.pageId].name = name
        self.shopData.shopPagesDic[goodData.pageId].shelfIds = {}
      end
      table.insert(self.shopData.shopPagesDic[goodData.pageId].shelfIds, shelfId)
    end
  end
end

return ShopData_pageComp
