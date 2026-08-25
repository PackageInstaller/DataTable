local ShopExtModel = NewClass("ShopExtModel", BaseModel)
local MainShopTypeTag = CommonDefine.MainShopTypeTag

function ShopExtModel:OnReset()
  self.monthCardData = {}
  self.shopGoodsListMap = {}
  self.mainShopTypeList = nil
end

function ShopExtModel:OnInit()
  self:OnReset()
end

function ShopExtModel:GetShopConfig(tid)
  if not tid then
    return
  end
  return DT.Shop[tid]
end

function ShopExtModel:GetShopTypeConfig(tid)
  if not tid then
    return
  end
  return DT.ShopType[tid]
end

function ShopExtModel:GetShopTypeTag(tid)
  local shopTypeConfig = self:GetShopTypeConfig(tid)
  return shopTypeConfig and shopTypeConfig.TypeTag
end

function ShopExtModel:CalcGoodsList(shopTypeTid)
  local goodsList = self:_CalcGoodsList(shopTypeTid)
  if not goodsList then
    return
  end
  goodsList = self:_SortGoodsList(goodsList)
  local shopTypeConfig = self:GetShopTypeConfig(shopTypeTid)
  if shopTypeConfig.TypeTag == MainShopTypeTag.GiftBag and self:EnableShowMonthCard() then
    goodsList = self:_CalcMonthCardGoodsAppend(goodsList)
  end
  self.shopGoodsListMap[shopTypeTid] = goodsList
end

function ShopExtModel:_CalcGoodsList(shopTypeTid)
  local oriGoodsList = MainShopDataUtils.GetShopGoodsList(shopTypeTid)
  if not oriGoodsList then
    return
  end
  local calcGoodsList = {}
  for _, shopData in ipairs(oriGoodsList) do
    local itemTid = shopData.itemTid
    if not MainShopDataUtils.CheckShopItemIsOnSale(shopData) then
    else
      local awakerTid = ItemDataUtils.GetAwakerTidByItemTid(itemTid)
      if ItemDataUtils.IsAwakerChip(itemTid) and not AwakerDataUtils.HasOwnedAwaker(awakerTid) then
      else
        table.insert(calcGoodsList, shopData)
      end
    end
  end
  calcGoodsList = MainShopDataUtils.MergeShopData2Show(calcGoodsList)
  return calcGoodsList
end

function ShopExtModel:_CalcMonthCardGoodsAppend(goodsList)
  local monthCardState = MainShopDataUtils.GetEnergyMonthCardState()
  local monthCardGoodsData = self:_GetMonthCardGoodsData()
  if monthCardState == CommonDefine.MonthCardState.InEffect then
    local insertPos = #goodsList + 1
    for idx, item in ipairs(goodsList) do
      if item.isSell == true then
        insertPos = idx
        break
      end
    end
    table.insert(goodsList, insertPos, monthCardGoodsData)
  else
    table.insert(goodsList, 1, monthCardGoodsData)
  end
  return goodsList
end

function ShopExtModel:_SortGoodsList(list)
  do return MainShopDataUtils.SortGoods, nil end
  return MainShopDataUtils.SortGoods, nil, list
end

function ShopExtModel:GetGoodsList(shopTypeTid, needCalc)
  if not self.shopGoodsListMap[shopTypeTid] or needCalc then
    self:CalcGoodsList(shopTypeTid)
  end
  return self.shopGoodsListMap[shopTypeTid]
end

function ShopExtModel:_CalcMainShopTypeList()
  local mainShopTypeTagList = {
    MainShopTypeTag.MoonCard,
    MainShopTypeTag.BattlePassReview,
    MainShopTypeTag.GiftBag,
    MainShopTypeTag.GoldShop,
    MainShopTypeTag.AdvanceDC,
    MainShopTypeTag.DailyChallenge,
    MainShopTypeTag.DiamondShop,
    MainShopTypeTag.TowerShop,
    MainShopTypeTag.MainCopyShop
  }
  for i = #mainShopTypeTagList, 1, -1 do
    local typeTag = mainShopTypeTagList[i]
    if not MainShopDataUtils.GetFeatrueUnlockByMainShopTypeTag(typeTag) or MainShopDataUtils.GetShopDataByTag(typeTag) == nil then
      table.remove(mainShopTypeTagList, i)
    end
  end
  table.sort(mainShopTypeTagList, function(a, b)
    local aTypeTag = a
    local bTypeTag = b
    local aUnlockWeight = MainShopDataUtils.GetFeatrueUnlockByMainShopTypeTag(aTypeTag) and 1 or 0
    local bUnlockWeight = MainShopDataUtils.GetFeatrueUnlockByMainShopTypeTag(bTypeTag) and 1 or 0
    local aBaseSortId = MainShopDataUtils.GetShopTypeCfgByTypeTag(aTypeTag).BaseSortID
    local bBaseSortId = MainShopDataUtils.GetShopTypeCfgByTypeTag(bTypeTag).BaseSortID
    if aUnlockWeight ~= bUnlockWeight then
      return aUnlockWeight > bUnlockWeight
    end
    return aBaseSortId < bBaseSortId
  end)
  local shopTypeList = {}
  for _, typeTag in ipairs(mainShopTypeTagList) do
    local shopTypeTid = MainShopDataUtils.GetShopTypeIDByTag(typeTag)
    table.insert(shopTypeList, shopTypeTid)
  end
  self.mainShopTypeList = shopTypeList
end

function ShopExtModel:GetMainShopTypeList(reCalcList)
  if not self.mainShopTypeList or reCalcList then
    self:_CalcMainShopTypeList()
  end
  return self.mainShopTypeList
end

function ShopExtModel:GetShopTypeListByActivityTid(activityTid)
  do return ActivityDataUtils.GetShopList end
  return ActivityDataUtils.GetShopList, activityTid
end

function ShopExtModel:GetGoodsRefreshPrice(shopTypeTid)
  local refreshTimes = MainShopDataUtils.GetFreshCount(shopTypeTid)
  local refreshPriceGroup = PlayerDataUtils.GetGoldShopRefeshGroup(PlayerDataUtils.GetLevel())
  local price = refreshPriceGroup[refreshTimes + 1] or 0
  return price or 0
end

function ShopExtModel:UpdateMonthCardData(monthCardType, svrData)
  if not monthCardType then
    return
  end
  self.monthCardData[monthCardType] = svrData
  self:LocalNotify(NotifyId.OnUpdateMonthCardData, monthCardType, svrData)
end

function ShopExtModel:GetMonthCardData(monthCardType)
  return self.monthCardData[monthCardType]
end

function ShopExtModel:EnableShowMonthCard()
  local conditionLevel = DT.GetConstant("EnergyMonthlyCardDisplayConditions") or 0
  return conditionLevel <= DataCenter.playerData.DRole.level
end

function ShopExtModel:_GetMonthCardGoodsData()
  local goodsData = {
    itemTid = DT.GetConstant("EnergyMonthlyCardDropItemId"),
    price = DT.GetOriginalConstant("EnergyMonthlyCardPrice")[2],
    costItemTid = DT.GetOriginalConstant("EnergyMonthlyCardPrice")[1],
    isMonthCardGoods = true
  }
  return goodsData
end

return ShopExtModel
