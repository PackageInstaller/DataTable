local ItemType = CommonDefine.ItemType
local JuniorMoney = CommonDefine.CurrencyType.JuniorMoney
local SeniorMoney = CommonDefine.CurrencyType.SeniorMoney

local function createTrinketStrengthenModelState(strengthedType, trinketUid)
  local state = {}
  state.trinketUid = trinketUid or 0
  
  function state.trinketTid()
    local itemData = state:GetItemData(state.trinketUid)
    if not itemData then
      return 0
    end
    return itemData.tid
  end
  
  state.strengthedType = strengthedType
  state.updateGradeType = CommonDefine.TrinketUpgradeType.One
  state.exchangePlanVersion = 0
  state.lockConversionEntires = {}
  
  function state.trinketUpgradeCostItem()
    local targetLevel = state.trinketUpgradeLevel
    do return state.GetTrinketUpgradeItemCost, state end
    return state.GetTrinketUpgradeItemCost, state, targetLevel
  end
  
  function state.trinketCurrLevel()
    local currUid = state.trinketUid
    if 0 == currUid then
      return 0
    end
    local itemData = state:GetItemData(currUid)
    if not itemData then
      return 0
    end
    return itemData.level
  end
  
  function state.trinketUpgradeLevel()
    local maxLevel = state:GetTrinketMaxLevel()
    local curLevel = state.trinketCurrLevel
    local isMaxType = state.updateGradeType == CommonDefine.TrinketUpgradeType.Max
    if maxLevel <= curLevel then
      return maxLevel
    end
    local levelPace = maxLevel - curLevel
    if not isMaxType then
      return curLevel + 1
    end
    local _ = state.exchangePlanVersion
    local itemId = DT.GetConstant("TrinketUpgradeItemIndex")
    local trinketUpgradeItemNum = DT.Constant.TrinketUpgradeItemNum
    local trinketLevelUpCoinCost = DT.Constant.TrinketLevelUpCoinCost
    local itemNum = ItemDataUtils.GetItemNum(itemId) + state:GetExchangeableSealCount()
    local ownMoney = ItemDataUtils.GetItemNum(state:GetUpgradeCurrencyType())
    local targetLevel = curLevel
    for i = 1, levelPace do
      local nextLevel = curLevel + i
      local itemCost = trinketUpgradeItemNum.Data[nextLevel]
      local coinCost = trinketLevelUpCoinCost.Data[nextLevel]
      if itemNum < itemCost or ownMoney < coinCost then
        break
      end
      targetLevel = targetLevel + 1
      itemNum = itemNum - itemCost
      ownMoney = ownMoney - coinCost
    end
    if curLevel >= targetLevel then
      return curLevel + 1
    end
    return targetLevel
  end
  
  function state.trinketUpgradeNeedMoney()
    local targetLevel = state.trinketUpgradeLevel
    do return state.GetTrinketUpgradeMoneyCost, state end
    return state.GetTrinketUpgradeMoneyCost, state, targetLevel
  end
  
  function state.trinketConversionMatCost()
    do return state.GetTrinketConversionMatCost, state, state:GetCurTrinketRefineLockNum() end
    return state.GetTrinketConversionMatCost, state, state:GetCurTrinketRefineLockNum()
  end
  
  function state.trinketConversionBaseMatCost()
    do return state.GetTrinketConversionMatCost, state end
    return state.GetTrinketConversionMatCost, state, 0
  end
  
  function state.trinketConversionLockMatCost()
    do return state.GetTrinketConversionMatCost, state, (state:GetCurTrinketRefineLockNum()) end
    return state.GetTrinketConversionMatCost, state, state:GetCurTrinketRefineLockNum(), true
  end
  
  function state.trinketConversionMoneyCost()
    local temp = 0
    local lockedNum = state:GetCurTrinketRefineLockNum()
    local currency = state:GetConversionCurrencyType()
    
    local function addCurrency(costData)
      for i = 1, #costData, 2 do
        local tid = costData[i]
        if tid ~= currency then
        else
          temp = temp + costData[i + 1]
        end
      end
    end
    
    addCurrency(DT.Constant.TrinketRefineCost.Data)
    local cData = DT.Constant["TrinketRefineCostLock" .. lockedNum]
    if cData then
      addCurrency(cData.Data)
    end
    return temp
  end
  
  function state.trinketConversionMoneyCostTable()
    local temp = state.trinketConversionMoneyCost
    local cfg = {}
    cfg.num = temp
    cfg.ownedMoney = ItemDataUtils.GetItemNum(state:GetConversionCurrencyType())
    return cfg
  end
  
  function state.allTrinketConversionMaterials()
    local noLockedData = DT.Constant.TrinketRefineCost.Data
    local itemMap = {}
    for i = 1, #noLockedData, 2 do
      itemMap[noLockedData[i]] = true
    end
    local maxLockNum = state:GetTrinketRefineLockMaxNum()
    for i = 1, maxLockNum do
      local cData = DT.Constant["TrinketRefineCostLock" .. i]
      if not cData then
        break
      end
      for j = 1, #cData.Data, 2 do
        itemMap[cData.Data[j]] = true
      end
    end
    local matItems = {}
    for k, v in pairs(itemMap) do
      table.insert(matItems, k)
    end
    return matItems
  end
  
  return state
end

local function createTrinketStrengthenModelViews(data)
  local views = {}
  
  function views:GetItemData(uid)
    do return ItemDataUtils.GetItemByUid end
    return ItemDataUtils.GetItemByUid, uid
  end
  
  function views:GetItemQuality(tid)
    local config = ItemDataUtils.GetItemConfig(tid)
    return config.Quality
  end
  
  function views:GetItemType(tid)
    do return ItemDataUtils.GetItemType end
    return ItemDataUtils.GetItemType, tid
  end
  
  function views:IsAutoSupply()
    return 1 == ClientDataUtils.GetData(cd.ClientDataMainKey.Toggle, cd.ClientSubKey.TrinketTrain)
  end
  
  function views:IsShowAutoSupply()
    return 1 == self:GetCurTrinketRefineLockNum()
  end
  
  function views:GetTrinketMaxLevel()
    do return end
    return AwakerTrinketDataUtils.GetTrinketMaxLevel
  end
  
  function views:GetTrinketBaseExp(quality)
    local trinketExpKey = string.format("%sTrinketExpLevel", quality)
    return DT.GetConstant(trinketExpKey) or 0
  end
  
  function views:GetItemStory(tid)
    if not tid or 0 == tid then
      return ""
    end
    do return ItemDataUtils.GetItemStory end
    return ItemDataUtils.GetItemStory, tid
  end
  
  function views:GetTrinketUpgradeItemCost(targetLevel)
    do return AwakerTrinketDataUtils.GetTrinketUpgradeItemCost, data.trinketCurrLevel end
    return AwakerTrinketDataUtils.GetTrinketUpgradeItemCost, data.trinketCurrLevel, targetLevel
  end
  
  function views:GetTrinketUpgradeMoneyCost(targetLevel)
    local moneyCost = 0
    local curLevel = data.trinketCurrLevel
    local trinketLevelUpCoinCost = DT.Constant.TrinketLevelUpCoinCost
    for i = curLevel + 1, targetLevel do
      moneyCost = moneyCost + trinketLevelUpCoinCost.Data[i] or 0
    end
    return moneyCost
  end
  
  function views:GetExchangeableSealCount()
    local exchangePlan = AlchemyExchangeExtModel.Instance:GetExchangePlan()
    if not exchangePlan or not next(exchangePlan) then
      return 0
    end
    local chipExchangeCount = DT.GetConstant("TrinketAutoRefineExchangeChipSeal") or 1
    local featherExchangeCount = DT.GetConstant("TrinketAutoRefineExchangeFeatherSeal") or 20
    local totalExchangeable = 0
    for tid, _ in pairs(exchangePlan) do
      if tid == ItemAlchemyUtils.TrinketRefineLock then
      else
        local itemCfg = DT.Item[tid]
        if not itemCfg or itemCfg.SubType ~= CommonDefine.ItemSubType.TrinketChip then
        elseif (itemCfg.StartDropDate or 0) > TimeUtils.GetServerTime() then
        else
          local itemNum = ItemDataUtils.GetItemNum(tid)
          if itemNum > 0 then
            totalExchangeable = totalExchangeable + itemNum * chipExchangeCount
          end
        end
      end
    end
    if exchangePlan[ItemAlchemyUtils.TrinketRefineLock] then
      local refineCount = ItemDataUtils.GetItemNum(ItemAlchemyUtils.TrinketRefineLock)
      if refineCount > 0 then
        totalExchangeable = totalExchangeable + refineCount * featherExchangeCount
      end
    end
    return totalExchangeable
  end
  
  function views:GetTrinketSuitConfig()
    local suitId = AwakerTrinketDataUtils.GetSuitIdByItemTid(self:GetTrinketTid())
    do return AwakerTrinketDataUtils.GetTrinketSuitConfig end
    return AwakerTrinketDataUtils.GetTrinketSuitConfig, suitId
  end
  
  function views:GetAutoRefineMaterialPools()
    local result = {
      sealTid = ItemAlchemyUtils.TrinketMaterial,
      seal = ItemDataUtils.GetItemNum(ItemAlchemyUtils.TrinketMaterial),
      featherTid = ItemAlchemyUtils.TrinketRefineLock,
      feather = ItemDataUtils.GetItemNum(ItemAlchemyUtils.TrinketRefineLock),
      featherSwap = 0,
      chipSuitTid = nil,
      chipSuit = 0,
      chipSuitSwap = 0,
      chipOtherList = {},
      chipOther = 0
    }
    local suitCfg = self:GetTrinketSuitConfig()
    result.chipSuitTid = suitCfg and suitCfg.TrinketChip or nil
    if result.chipSuitTid then
      result.chipSuit = ItemDataUtils.GetItemNum(result.chipSuitTid)
    end
    local exchangePlan = AlchemyExchangeExtModel.Instance:GetExchangePlan() or {}
    if exchangePlan[ItemAlchemyUtils.TrinketRefineLock] then
      result.featherSwap = result.feather
    end
    local now = TimeUtils.GetServerTime()
    for tid, _ in pairs(exchangePlan) do
      if tid == ItemAlchemyUtils.TrinketRefineLock then
      else
        local itemCfg = DT.Item[tid]
        if not itemCfg or itemCfg.SubType ~= CommonDefine.ItemSubType.TrinketChip then
        elseif now < (itemCfg.StartDropDate or 0) then
        else
          local num = ItemDataUtils.GetItemNum(tid)
          if tid == result.chipSuitTid then
            result.chipSuitSwap = result.chipSuitSwap + num
          else
            table.insert(result.chipOtherList, {tid = tid, num = num})
            result.chipOther = result.chipOther + num
          end
        end
      end
    end
    table.sort(result.chipOtherList, function(a, b)
      return a.num > b.num
    end)
    return result
  end
  
  function views:GetAutoRefineCostParams()
    local sealPerRun = 0
    local refineCost = DT.Constant.TrinketRefineCost
    if refineCost then
      for i = 1, #refineCost.Data, 2 do
        if refineCost.Data[i] == ItemAlchemyUtils.TrinketMaterial then
          sealPerRun = refineCost.Data[i + 1]
        end
      end
    end
    local lock1 = DT.Constant.TrinketRefineCostLock1
    local lockChipPerRun = lock1 and lock1.Data[1] or 20
    local lockFeatherPerRun = 0
    local lock2 = DT.Constant.TrinketRefineCostLock2
    if lock2 then
      for i = 1, #lock2.Data, 2 do
        if lock2.Data[i] == ItemAlchemyUtils.TrinketRefineLock then
          lockFeatherPerRun = lock2.Data[i + 1]
        end
      end
    end
    return {
      sealPerRun = sealPerRun,
      lockChipPerRun = lockChipPerRun,
      lockFeatherPerRun = lockFeatherPerRun,
      chipSeal = DT.GetConstant("TrinketAutoRefineExchangeChipSeal") or 1,
      featherSeal = DT.GetConstant("TrinketAutoRefineExchangeFeatherSeal") or 20
    }
  end
  
  function views:GetTrinketConversionMatCost(lockedNum, onlyLock)
    local temp = {}
    local currency = self:GetConversionCurrencyType()
    
    local function addCost(costData)
      for i = 1, #costData, 2 do
        local tid = costData[i]
        if tid == currency then
        else
          local num = costData[i + 1]
          local curNum = temp[tid] or 0
          temp[tid] = curNum + num
        end
      end
    end
    
    if not onlyLock then
      addCost(DT.Constant.TrinketRefineCost.Data)
    end
    if 1 == lockedNum then
      local cData = DT.Constant["TrinketRefineCostLock" .. lockedNum]
      local suitId = AwakerTrinketDataUtils.GetSuitIdByItemTid(self:GetTrinketTid())
      local suitCfg = AwakerTrinketDataUtils.GetTrinketSuitConfig(suitId)
      local consumeId = suitCfg.TrinketChip
      local needNum = cData.Data[1]
      if self:IsAutoSupply() then
        if ItemDataUtils.IsItemEnough(consumeId, needNum) then
          local curNum = temp[consumeId] or 0
          temp[consumeId] = curNum + cData.Data[1]
        else
          local replaceItemId, num = table.unpack(DT.GetOriginalConstant("TrinketRefineCostLock1Substitute") or {})
          if replaceItemId and num then
            temp[replaceItemId] = num
          end
        end
      else
        local curNum = temp[consumeId] or 0
        temp[consumeId] = curNum + cData.Data[1]
      end
    else
      local cData = DT.Constant["TrinketRefineCostLock" .. lockedNum]
      if cData then
        addCost(cData.Data)
      end
    end
    local mats = {}
    for k, v in pairs(temp) do
      table.insert(mats, {tid = k, num = v})
    end
    return mats
  end
  
  function views:GetTrinketUid()
    return data.trinketUid
  end
  
  function views:GetTrinketTid()
    if not data.trinketUid then
      return 0
    end
    local itemData = ItemDataUtils.GetItemByUid(data.trinketUid)
    return itemData and itemData.tid or 0
  end
  
  function views:GetStrengthedType()
    return data.strengthedType
  end
  
  function views:GetOwner()
    if 0 == data.trinketUid then
      return 0
    end
    do return ItemDataUtils.GetItemOwner end
    return ItemDataUtils.GetItemOwner, data.trinketUid
  end
  
  function views:GetOwnerSmallIcon()
    local ownAwaker = self:GetOwner()
    if not ownAwaker or 0 == ownAwaker then
      return
    end
    do return AwakerDataUtils.GetLittleIcon end
    return AwakerDataUtils.GetLittleIcon, ownAwaker
  end
  
  function views:GetTrinketIcon()
    local tId = self:GetTrinketTid()
    if 0 == tId then
      return ""
    end
    do return ItemDataUtils.GetItemIcon end
    return ItemDataUtils.GetItemIcon, tId
  end
  
  function views:GetTrinketName()
    local tId = self:GetTrinketTid()
    if 0 == tId then
      return ""
    end
    local name = ItemDataUtils.GetItemName(tId)
    return name
  end
  
  function views:GetTrinketLevel()
    return data.trinketCurrLevel
  end
  
  function views:GetTrinketUpgradeLevel()
    return data.trinketUpgradeLevel
  end
  
  function views:GetUpgradeType()
    return data.updateGradeType
  end
  
  function views:GetWeaponDescList(uid)
    local descList = {}
    if not uid or 0 == uid then
      return descList
    end
    local itemData = self:GetItemData(uid)
    if not itemData then
      return descList
    end
    local tid = itemData.tid
    if self:GetItemType(tid) ~= ItemType.Weapon then
      return descList
    end
    local level = itemData.level
    local desc1 = SkillUtils.GetWeaponStateDesc(tid, level)
    if "" ~= desc1 then
      table.insert(descList, desc1)
    end
    return descList
  end
  
  function views:GetSortTypeName(sortType)
    do return AwakerTrinketDataUtils.GetSortTypeName end
    return AwakerTrinketDataUtils.GetSortTypeName, sortType
  end
  
  function views:GetSortOrderName(order)
    if not order then
      return ""
    end
    local key = "ActorString_Sort_Ascend"
    if order == CommonDefine.SortOrder.Descend then
      key = "ActorString_Sort_Descend"
    end
    do return LT.Text end
    return LT.Text, key
  end
  
  function views:GetWeaponSortTypeName(sortType)
    do return AwakerTrinketDataUtils.GetWeaponSortTypeName end
    return AwakerTrinketDataUtils.GetWeaponSortTypeName, sortType
  end
  
  function views:GetUpgradeCurrencyType()
    return JuniorMoney
  end
  
  function views:CanStrengthen()
    local costItem = data.trinketUpgradeCostItem
    if 0 == costItem.num then
      return false
    end
    local ownMoney = ItemDataUtils.GetItemNum(self:GetUpgradeCurrencyType())
    return ownMoney >= self.trinketUpgradeNeedMoney
  end
  
  function views:GetTrinketMainAttrValue(currLevel, attrId)
    do return AwakerTrinketDataUtils.GetTrinketMainAttrValue, currLevel end
    return AwakerTrinketDataUtils.GetTrinketMainAttrValue, currLevel, attrId
  end
  
  function views:IsConversionAttrLocked(uid)
    return data.lockConversionEntires[uid]
  end
  
  function views:GetCurTrinketRefineLockNum()
    if not data.lockConversionEntires then
      return 0
    end
    local num = 0
    for _, v in pairs(data.lockConversionEntires) do
      if v then
        num = num + 1
      end
    end
    return num
  end
  
  function views:GetTrinketRefineLockMaxNum()
    return DT.Constant.TrinketRefineLockMaxNum.Data[1]
  end
  
  function views:GetConversionCurrencyType()
    return JuniorMoney
  end
  
  function views:GetConversionSeniorMoneyType()
    return SeniorMoney
  end
  
  function views:GetSubConversionAttrs()
    local uid = data.trinketUid
    if not uid or 0 == uid then
      return {}
    end
    local trinket = ItemDataUtils.GetItemByUid(uid)
    if not trinket or not trinket.trainAttrs then
      return {}
    end
    local subAttrs = {}
    for _, attr in pairs(trinket.trainAttrs) do
      if not attr or 1 == attr.index then
      else
        local subAttr = AwakerTrinketDataUtils.TrinketAttrToClientAttr(attr)
        subAttr.valIndex = attr.valIndex
        subAttrs[attr.index] = subAttr
      end
    end
    return subAttrs
  end
  
  function views:GetSubConversionAttrsResult()
    local uid = data.trinketUid
    local subAttrs = self:GetSubConversionAttrs()
    if not subAttrs then
      return {}
    end
    if not table.next(subAttrs) then
      return {}
    end
    local curAttrs = AwakerTrinketDataUtils.GetSubAttrs(uid)
    for _, attr in pairs(curAttrs) do
      if not subAttrs[attr.index] then
        subAttrs[attr.index] = AwakerTrinketDataUtils.TrinketAttrToClientAttr(attr)
      end
    end
    local attrs = {}
    for k, v in pairs(subAttrs) do
      table.insert(attrs, v)
    end
    table.sort(attrs, function(a, b)
      return a.uid < b.uid
    end)
    return attrs
  end
  
  function views:IsExistedSubConversionAttrs()
    local uid = data.trinketUid
    if not uid or 0 == uid then
      return false
    end
    local trinket = ItemDataUtils.GetItemByUid(uid)
    if not trinket or not trinket.trainAttrs then
      return false
    end
    if table.next(trinket.trainAttrs) then
      return true
    end
    return false
  end
  
  function views:IsExistedToMaxValueSubAttr()
    local uid = data.trinketUid
    local trinket = ItemDataUtils.GetItemByUid(uid)
    for _, attr in pairs(trinket.attrs) do
      if not attr or 1 == attr.index then
      else
        local val = attr.val
        local attrId = attr.attrId
        local maxValue = AwakerTrinketDataUtils.GetTrinketSubAttrMaxValue(attrId)
        if val >= maxValue and self:IsConversionAttrLocked(attr.index) then
          return true
        end
      end
    end
    return false
  end
  
  function views:IsSubAttrToMaxValue(index)
    local uid = data.trinketUid
    local trinket = ItemDataUtils.GetItemByUid(uid)
    for _, attr in pairs(trinket.attrs) do
      if not attr or attr.index ~= index then
      else
        local val = attr.val
        local attrId = attr.attrId
        local maxValue = AwakerTrinketDataUtils.GetTrinketSubAttrMaxValue(attrId)
        if val >= maxValue then
          return true
        end
      end
    end
    return false
  end
  
  function views:GetTrinketConversionConfirmGiveUpLevel()
    do return DT.GetConstant end
    return DT.GetConstant, "TrinketRefineGiveUpConfirm"
  end
  
  function views:IsTrinketConversionMatEnough()
    local consumeMaterials = data.trinketConversionMatCost
    for k, chosenData in pairs(consumeMaterials) do
      local itemData = ItemDataUtils.GetItemByTid(chosenData.tid)
      if not itemData or chosenData.num > itemData.num then
        return false
      end
    end
    return true
  end
  
  function views:IsTrinketConversionBaseMatEnough()
    local consumeMaterials = data.trinketConversionBaseMatCost
    for k, chosenData in pairs(consumeMaterials) do
      local itemData = ItemDataUtils.GetItemByTid(chosenData.tid)
      if not itemData or chosenData.num > itemData.num then
        return false
      end
    end
    return true
  end
  
  function views:IsTrinketConversionLockMatEnough()
    local consumeMaterials = data.trinketConversionLockMatCost
    for k, chosenData in pairs(consumeMaterials) do
      local itemData = ItemDataUtils.GetItemByTid(chosenData.tid)
      if not itemData or chosenData.num > itemData.num then
        return false
      end
    end
    return true
  end
  
  function views:IsTrinketConversionMoneyEnough()
    local consumeMoney = data.trinketConversionMoneyCost
    local ownedMoney = ItemDataUtils.GetItemNum(self:GetConversionCurrencyType())
    if consumeMoney > ownedMoney then
      return false
    end
    return true
  end
  
  function views:GetAutoTrainMaxTimes()
    local times = DT.GetConstant("TrinketAutoRefineMaxNum") or 100
    local pools = self:GetAutoRefineMaterialPools()
    local params = self:GetAutoRefineCostParams()
    local lockedNum = self:GetCurTrinketRefineLockNum()
    local supply = self:IsAutoSupply()
    local moneyCost = data.trinketConversionMoneyCost
    if moneyCost and moneyCost > 0 then
      local ownedMoney = ItemDataUtils.GetItemNum(self:GetConversionCurrencyType())
      local moneyLimit = math.floor(ownedMoney / moneyCost)
      times = math.min(times, moneyLimit)
    end
    local sealEquiv = pools.seal + (pools.chipOther + pools.chipSuitSwap) * params.chipSeal + pools.featherSwap * params.featherSeal
    if lockedNum <= 0 then
      local matLimit = math.floor(sealEquiv / params.sealPerRun)
      times = math.min(times, matLimit)
    elseif 1 == lockedNum then
      local matLimit = math.floor(sealEquiv / params.sealPerRun)
      times = math.min(times, matLimit)
      if supply then
        local lockLimit = math.floor((pools.chipSuit + pools.feather * params.featherSeal) / params.lockChipPerRun)
        times = math.min(times, lockLimit)
      else
        local lockLimit = math.floor(pools.chipSuit / params.lockChipPerRun)
        times = math.min(times, lockLimit)
      end
    else
      if params.lockFeatherPerRun > 0 then
        local lockLimit = math.floor(pools.feather / params.lockFeatherPerRun)
        times = math.min(times, lockLimit)
      end
      local matLimit = math.floor(sealEquiv / params.sealPerRun)
      times = math.min(times, matLimit)
    end
    return times
  end
  
  return views
end

local function createTrinketStrengthenModelActions(data)
  local actions = {}
  
  function actions:SetStrengthedType(st)
    data.strengthedType = st
    data.updateGradeType = CommonDefine.TrinketUpgradeType.One
  end
  
  function actions:SetTrinketUid(trinketUid)
    data.trinketUid = trinketUid or 0
  end
  
  function actions:SetUpgradeType(t)
    data.updateGradeType = t
  end
  
  function actions:RefreshExchangePlanVersion()
    data.exchangePlanVersion = data.exchangePlanVersion + 1
  end
  
  function actions:ChooseMaterial(uid, num)
    local itemData = data:GetItemData(uid)
    if not itemData then
      return false
    end
    local itemType = data:GetItemType(itemData.tid)
    if itemType ~= ItemType.Trinket and itemType ~= ItemType.Weapon and not self:IsTrinketExpItem(uid) then
      Logger.Info("选中的不是可用于强化的材料道具: ", itemData.tid)
      return
    end
    local curMat = self:GetUpgradeMaterial(uid)
    if not num or not self:IsTrinketExpItem(uid) then
      num = 1
    end
    if not curMat then
      if #data.upgradeMaterials >= CommonDefine.MaxTrinketUpgradeMatSlotsNum then
        Alert.Show(10705)
        return
      end
      table.insert(data.upgradeMaterials, {uid = uid, num = num})
    else
      if not self:IsTrinketExpItem(uid) then
        num = -1
      end
      local newNum = curMat.num + num
      if newNum < 0 then
        newNum = 0
      elseif newNum > ItemDataUtils.GetItemNum(itemData.tid) then
        newNum = ItemDataUtils.GetItemNum(itemData.tid)
      end
      if newNum <= 0 then
        for i = 1, #data.upgradeMaterials do
          if data.upgradeMaterials[i].uid == uid then
            table.remove(data.upgradeMaterials, i)
            break
          end
        end
      else
        for i = 1, #data.upgradeMaterials do
          if data.upgradeMaterials[i].uid == uid then
            data.upgradeMaterials[i] = {uid = uid, num = newNum}
            break
          end
        end
      end
    end
  end
  
  function actions:OpenNotEnoughExchange(count)
    local _, exchangeUnlock = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.Exchange, 0)
    if not exchangeUnlock then
      Alert.ShowStr(LT.Text("TrinketStrengCostItemNotEnoughTips"))
      return
    end
    local exchangePlan = AlchemyExchangeExtModel.Instance:ClearExchangePlan()
    local canExchange, costList, targetList, chipReqList, refineReqList
    if not exchangePlan then
      canExchange = false
    else
      canExchange, costList, targetList, chipReqList, refineReqList = ItemAlchemyUtils.GetTrinketExchangeList(exchangePlan, count)
      print("merge alc openview", canExchange, table.tostring(costList), table.tostring(targetList), table.tostring(chipReqList), table.tostring(refineReqList))
    end
    if canExchange then
      ItemAlchemyUtils.OpenTrinketView(costList, targetList, chipReqList, refineReqList)
    else
      Alert.Show(10719, nil, function()
        local replaceData = DT.Constant.TrinketRefineMaterialReplace.Data
        local costItemId = replaceData[1]
        local costItemNum = replaceData[2]
        local exchangdItemId = replaceData[3]
        local shopItemData = {
          buyCount = 0,
          price = costItemNum,
          itemTid = exchangdItemId,
          itemList = {exchangdItemId, 1}
        }
        UIManager.Instance:Reopen(Urls.MainShopSingleBuyConfirmPanel, {
          itemId = costItemId,
          shopItemData = shopItemData,
          maxNum = 10,
          currencyList = {},
          customConfirmClick = function(num)
            EventMgr.Instance.OpenReqMask:Dispatch()
            ProtoManager.Instance:ReqServer("GameRequest", "OnItemExchange", function(svrData)
              Logger.Info(">>>>>> 洗练道具兑换请求成功:", table.tostring(svrData))
            end, function(svrData)
              Logger.Info(">>>>>> 洗练道具兑换失败:", table.tostring(svrData))
            end, num, "TrinketRefineMaterialReplace")
          end
        })
      end)
    end
  end
  
  function actions:ReqUpgradeTrinket(cb)
    local targetUid = data.trinketUid
    if not targetUid or 0 == targetUid then
      Alert.Show(10513)
      return
    end
    local targetItemData = ItemDataUtils.GetItemByUid(targetUid)
    local needMoney = data.trinketUpgradeNeedMoney
    local ownedMoney = ItemDataUtils.GetItemNum(self:GetUpgradeCurrencyType())
    if needMoney > ownedMoney then
      Alert.Show(10474)
      return
    end
    
    local function DoSendUpgrade()
      local freshCostItem = data.trinketUpgradeCostItem
      if 0 == freshCostItem.num then
        Logger.Info(">>>>>>> 升级消耗为0，取消请求")
        return
      end
      local freshOwnNum = ItemDataUtils.GetItemNum(freshCostItem.tid)
      if freshOwnNum < freshCostItem.num then
        Logger.Info(">>>>>>> 千面印章不足，取消升级")
        return
      end
      local itemData = ItemDataUtils.GetItemByTid(freshCostItem.tid)
      if not itemData then
        return
      end
      local uids = {
        {
          uid = itemData.uid,
          num = freshCostItem.num
        }
      }
      EventMgr.Instance.OpenReqMask:Dispatch()
      local toLevel = data.trinketUpgradeLevel
      ProtoManager.Instance:ReqServer("TrinketRequest", "OnUpgradeTrinket", function(svrData)
        Logger.Info(">>>>>>> 强化饰品请求成功:", table.tostring(svrData))
        targetItemData.level = svrData.level
        targetItemData.exp = svrData.exp
        for _, attr in pairs(targetItemData.attrs) do
          if 1 == attr.index then
            attr.val = data:GetTrinketMainAttrValue(toLevel, attr.attrId)
            break
          end
        end
        GlobalDispatcher:Dispatch(NotifyId.OnTrinketUpdategraded, targetUid)
        EventMgr.Instance.OnTrinketLevelRefresh:Dispatch()
        if cb then
          cb(svrData)
        end
      end, function(svrData)
        Logger.Info(">>>>>>> 强化饰品请求失败:", table.tostring(svrData))
      end, targetUid, uids)
    end
    
    local costItem = data.trinketUpgradeCostItem
    local ownItemnum = ItemDataUtils.GetItemNum(costItem.tid)
    if ownItemnum < costItem.num then
      local lackCount = costItem.num - ownItemnum
      local isMaxType = data.updateGradeType == CommonDefine.TrinketUpgradeType.Max
      if isMaxType then
        local exchangePlan = AlchemyExchangeExtModel.Instance:ClearExchangePlan()
        if not exchangePlan or not next(exchangePlan) then
          self:OpenNotEnoughExchange(lackCount)
          return
        end
        local canExchange, costList, targetList, chipReqList, refineReqList = ItemAlchemyUtils.GetTrinketExchangeList(exchangePlan, lackCount)
        if canExchange then
          AwakerPopupExchangeTipView.OpenThisView(costList, targetList, 0, function()
            ItemAlchemyUtils.ReqTrinketExchange(chipReqList, refineReqList, function()
              Logger.Info(">>>>>>> 自动兑换成功，继续发送升级请求")
              DoSendUpgrade()
            end)
          end)
        else
          Logger.Info(">>>>>>> 置换材料不足，无法自动兑换")
          self:OpenNotEnoughExchange(lackCount)
        end
      else
        self:OpenNotEnoughExchange(lackCount)
      end
      return
    end
    DoSendUpgrade()
  end
  
  function actions:LockConversionAttr(uid, locked)
    data.lockConversionEntires[uid] = locked
  end
  
  function actions:ClearSubConversionAttrs()
    local uid = data.trinketUid
    if not uid or 0 == uid then
      return
    end
    local trinket = ItemDataUtils.GetItemByUid(uid)
    if not trinket then
      return
    end
    trinket.trainAttrs = {}
  end
  
  function actions:SetSubConversionAttrs(newAttrs)
    local uid = data.trinketUid
    if not uid or 0 == uid then
      return
    end
    local trinket = ItemDataUtils.GetItemByUid(uid)
    if not trinket then
      return
    end
    trinket.trainAttrs = {}
    for k, v in pairs(newAttrs) do
      trinket.trainAttrs[k] = v
    end
  end
  
  function actions:ReqTrinketConversion(cb)
    local targetUid = data.trinketUid
    
    local function DoReqTrinketConversion()
      local atrrsLock = {}
      for k, v in pairs(data.lockConversionEntires) do
        if v then
          atrrsLock[k] = true
        end
      end
      EventMgr.Instance.OpenReqMask:Dispatch()
      ProtoManager.Instance:ReqServer("TrinketRequest", "OnTrainingTrinket", function(svrData)
        Logger.Info(">>>>>> 洗练请求成功:", table.tostring(svrData))
        self:SetSubConversionAttrs(svrData.attrs)
        EventMgr.Instance.TrinketConversionAnim:Dispatch()
        if cb then
          cb(svrData)
        end
      end, function(svrData)
        Logger.Info(">>>>>> 洗练请求失败:", table.tostring(svrData))
      end, targetUid, atrrsLock, self:IsAutoSupply())
    end
    
    if not data:IsTrinketConversionMoneyEnough() then
      Alert.Show(10707)
      return
    end
    local isBaseMatEnough = data:IsTrinketConversionBaseMatEnough()
    local isLockMatEnough = data:IsTrinketConversionLockMatEnough()
    if not isLockMatEnough and not isBaseMatEnough then
      Alert.Show(10707)
      return
    end
    if isLockMatEnough and not isBaseMatEnough then
      local lackCount = 0
      local consumeMaterials = data.trinketConversionBaseMatCost
      for _, chosenData in pairs(consumeMaterials) do
        local itemData = ItemDataUtils.GetItemByTid(chosenData.tid)
        local haveCount = itemData and itemData.num or 0
        if not itemData or haveCount < chosenData.num then
          lackCount = math.max(lackCount, chosenData.num - haveCount)
        end
      end
      self:OpenNotEnoughExchange(lackCount)
      return
    end
    local conversionAttrs = data:GetSubConversionAttrs()
    if conversionAttrs then
      local valIndex = data:GetTrinketConversionConfirmGiveUpLevel()
      for _, v in pairs(conversionAttrs) do
        if valIndex <= math.ceil(v.valIndex / 2) then
          Alert.Show(20095, nil, DoReqTrinketConversion)
          return
        end
      end
    end
    DoReqTrinketConversion()
  end
  
  function actions:ReqTrinketConfirmTraining(cb)
    local targetUid = data.trinketUid
    
    local function DoReqTrinketConfirmTraining()
      EventMgr.Instance.OpenReqMask:Dispatch()
      ProtoManager.Instance:ReqServer("TrinketRequest", "OnTrinketConfirmTraining", function(svrData)
        Logger.Info(">>>>>> 确认 洗练请求成功:", table.tostring(svrData))
        self:ClearSubConversionAttrs()
        EventMgr.Instance.TrinketConfirmAnim:Dispatch()
        GlobalDispatcher:Dispatch(NotifyId.OnTrinketConversioned, targetUid)
        if cb then
          cb(svrData)
        end
      end, function(svrData)
        Logger.Info(">>>>>> 确认 洗练请求失败:", table.tostring(svrData))
      end, targetUid)
    end
    
    local conversionAttrs = data:GetSubConversionAttrs()
    if conversionAttrs then
      for _, v in pairs(conversionAttrs) do
        if data:IsSubAttrToMaxValue(v.uid) then
          Alert.Show(20094, nil, DoReqTrinketConfirmTraining)
          return
        end
      end
    end
    DoReqTrinketConfirmTraining()
  end
  
  function actions:ReqAutoTrinketConversion(maxTimes, chooseList, cb)
    local targetUid = data.trinketUid
    local atrrsLock = {}
    for k, v in pairs(data.lockConversionEntires) do
      if v then
        atrrsLock[k] = true
      end
    end
    EventMgr.Instance.OpenReqMask:Dispatch()
    local reReqPending = true
    ProtoManager.Instance:ReqServer("TrinketRequest", "OnAutoTrainingTrinket", function(svrData)
      for k, v in pairs(svrData) do
        Logger.Info("OnAutoTrainingTrinket Successful:", k, table.tostring(v))
      end
      if cb then
        cb(svrData)
      end
    end, function(svrData, errCode)
      Logger.Info("OnAutoTrainingTrinket failed:", table.tostring(svrData))
      if errCode and 0 == errCode.code then
        if reReqPending then
          reReqPending = false
          return
        end
      elseif errCode then
        ErrorMsg.ShowErrCodeTips(errCode, svrData)
      end
      if cb then
        cb(nil)
      end
    end, targetUid, atrrsLock, self:IsAutoSupply(), maxTimes, chooseList)
  end
  
  return actions
end

local function onSetup(binder, model)
end

local TrinketStrengthenModel = Vue.model("TrinketStrengthenModel", createTrinketStrengthenModelState):views(createTrinketStrengthenModelViews):actions(createTrinketStrengthenModelActions):setup(onSetup)
return TrinketStrengthenModel
