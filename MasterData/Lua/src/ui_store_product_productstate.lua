local this = {}
local _productsTpl = L_GameTpl:getProductsTpl()

function this:init()
  this.super.init(self)
  self.csHomeStoreProductData = nil
  self.productHadNumRecordList = {}
  self.cacheAccessorySelectedUid = {}
  self.cacheViewIndex2groupDataIndex = {}
end

function this:getHomeProductMap()
  local result = {}
  local csHomeBuildDataList = L_HomeStore:getAllCsHomeBuildData()
  for _, csHomeBuildData in ipairs(csHomeBuildDataList) do
    local buildingGuid = csHomeBuildData.guid
    local csHomeBuildProductList = csHomeBuildData.products
    result[buildingGuid] = csHomeBuildProductList
  end
  return result
end

function this:getFastProductByIndex(index)
  self.csHomeStoreProductData = self.csHomeStoreProductData or L_HomeStore:getCsHomeStoreProductData()
  return self.csHomeStoreProductData:GetFastProductDataByIndex(index) or nil
end

function this:getFastProductMap()
  self.csHomeStoreProductData = self.csHomeStoreProductData or L_HomeStore:getCsHomeStoreProductData()
  return self.csHomeStoreProductData:GetProductGuid2FastProductDataDic()
end

function this:getFastProductRewards()
  self.csHomeStoreProductData = self.csHomeStoreProductData or L_HomeStore:getCsHomeStoreProductData()
  return self.csHomeStoreProductData:GetFastProductRewardsList()
end

function this:clearFastProductRewards()
  self.csHomeStoreProductData = self.csHomeStoreProductData or L_HomeStore:getCsHomeStoreProductData()
  self.csHomeStoreProductData:ClearFastProductRewardsList()
end

function this:getHadProductRecordNumById(productId)
  if self.productHadNumRecordList == nil then
    return 0
  end
  local num = self.productHadNumRecordList[productId] or 0
  return num
end

function this:setHadProductRecordNumList(dateList)
  self.productHadNumRecordList = self.productHadNumRecordList or {}
  local dirtyProductIdList = {}
  for _, value in ipairs(dateList) do
    local productId = value.product_id
    local productNum = value.craft_count
    self.productHadNumRecordList[productId] = productNum
    table.insert(dirtyProductIdList, productId)
  end
  if 0 < #dirtyProductIdList then
    local isMaxLimitProductDirty = false
    for _, productId in ipairs(dirtyProductIdList) do
      local productTpl = _productsTpl:getTplById(productId)
      local isHadMax, maxNum = _productsTpl:getMaxProductNum(productTpl)
      if isHadMax then
        isMaxLimitProductDirty = true
        break
      end
    end
    if isMaxLimitProductDirty then
      L_ProductStore:call(L_ProductStore.event.refreshMaxLimitProductFormulaInfo)
    end
  end
end

function this:checkProductCurrencyNumExceed(productIdList, finishNumList)
  local cacheCurrencyCount = {}
  local exceedIndexTable = {}
  for index, productId in ipairs(productIdList) do
    local tpl_pro = _productsTpl:getTplById(productId, false)
    if tpl_pro ~= nil then
      local reward = _productsTpl:getRewardId(tpl_pro)
      if reward[1] then
        local itemData = L_DataUtil.parseRewardConfigItem(reward[1])
        if itemData.itemType == L_Const.resType.currency then
          local finishNum = finishNumList[index]
          local productNum = itemData.itemNum
          local curProductTotalNum = productNum * finishNum
          local curNum = L_PlayerStore:getCurrencyNum(itemData.itemId)
          local maxNum = L_PlayerStore:getElementCurrencyMaxNum(itemData.itemId)
          local cacheNum = cacheCurrencyCount[itemData.itemId] or 0
          if maxNum < curNum + cacheNum + curProductTotalNum then
            exceedIndexTable[index] = true
          else
            cacheCurrencyCount[itemData.itemId] = cacheNum + curProductTotalNum
          end
        end
      end
    end
  end
  return exceedIndexTable
end

return this
