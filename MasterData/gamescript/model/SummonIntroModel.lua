local SummonIntroPage = CommonDefine.SummonIntroPage

local function createData(poolId, schoolEn)
  local data = {}
  data.poolCfg = DT.Summon[poolId]
  data.schoolEn = schoolEn
  data.currPage = SummonIntroPage.UP
  return data
end

local function createViews(data)
  local views = {}
  
  function views:GetCurrPage()
    return data.currPage
  end
  
  function views:GetUpPageActiveState()
    return false
  end
  
  function views:GetUpPageInfoList()
    local infoList = {}
    local poolCfg = data.poolCfg
    if poolCfg.ShowCorrect then
      data:_TryInsertInfo(infoList, "Summon_LongDesc_Text2", poolCfg.ShowCorrect[1], poolCfg.CorrectedAwardSSR)
      data:_TryInsertInfo(infoList, "Summon_LongDesc_Text3", poolCfg.ShowCorrect[2], poolCfg.CorrectedAwardSR)
    end
    return infoList
  end
  
  function views:_TryInsertInfo(infoList, titleID, show, dropID)
    if 1 ~= show then
      return
    end
    local tidList = {}
    local dropCfg = DT.Drop[dropID]
    for _, drop in ipairs(dropCfg.data_list) do
      table.insert(tidList, drop.DropItem)
    end
    table.insert(infoList, {
      title = LT.Text(titleID),
      tidList = tidList
    })
  end
  
  function views:GetDetail()
    return {
      title_1 = data.poolCfg.Title,
      name_1 = data.poolCfg.Name,
      desc_1 = data.poolCfg.LongDesc1,
      title_2 = "SummonRulesTitle",
      desc_2 = data.poolCfg.LongDesc2,
      SummonType = data.poolCfg.Type
    }
  end
  
  function views:GetInventoryDict()
    local inventoryDict = {}
    local poolCfg = data.poolCfg
    local rateMap = self:_GetDropRateMap()
    if poolCfg.SSRAward then
      inventoryDict.SSR = {
        title = LT.Text(poolCfg.RateListTextSSR),
        desc = LT.Text("Summon_RateList_Text2"),
        cells = data:_TryInsertInventory(poolCfg.SSRAward, rateMap)
      }
    end
    if poolCfg.SRAward then
      inventoryDict.SR = {
        title = LT.Text(poolCfg.RateListTextSR),
        desc = LT.Text("Summon_RateList_Text2"),
        cells = data:_TryInsertInventory(poolCfg.SRAward, rateMap)
      }
    end
    if poolCfg.RAward then
      inventoryDict.R = {
        title = LT.Text(poolCfg.RateListTextR),
        desc = LT.Text("Summon_RateList_Text2"),
        cells = data:_TryInsertInventory(poolCfg.RAward, rateMap)
      }
    end
    return inventoryDict
  end
  
  function views:GetPoolRateList()
    local poolCfg = data.poolCfg
    if table.contains({
      cd.SummonPoolType.OpenServerPool,
      cd.SummonPoolType.NewbiePool
    }, poolCfg.Type) then
      return {
        0,
        100,
        100,
        100
      }
    end
    local dropRateKey = SummonCfgUtils.GetSummonDropRateKey(data.poolCfg.ID, data.schoolEn)
    print("[SummonIntroModel] dropRateKey", dropRateKey)
    local dropRateList = DT.GetOriginalConstant(dropRateKey, {})
    local rateListKey = dropRateList[1]
    local rateList = DT.GetOriginalConstant(rateListKey)
    assert(rateList, "唤醒概率展示错误没有配置: " .. dropRateKey)
    return rateList
  end
  
  function views:_GetNormalWeaponDropRateMap(rateList, upItemList, normalItemList)
    local rateMap = {}
    local poolCfg = data.poolCfg
    if 0 == #upItemList then
      do return self.__GetNormalWeaponNoLimitDropRateMap, self, normalItemList end
      return self.__GetNormalWeaponNoLimitDropRateMap, self, normalItemList, poolCfg, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
    end
    local selectWeaponTid = SummonDataUtils.GetChooseUpMapByType(poolCfg.Type)
    local selectWeaponRate = rateList[1]
    local rateSkip = selectWeaponTid and 0 or selectWeaponRate
    local upRate = rateList[2] / #upItemList
    for _, tid in ipairs(upItemList) do
      rateMap[tid] = upRate
    end
    local normalRate = (rateList[3] + rateSkip) / #normalItemList
    for _, tid in ipairs(normalItemList) do
      rateMap[tid] = normalRate
    end
    local srWeaponRateDict = {}
    DropCfgUtils.GetProbabilityPercentInfoList(poolCfg.SRAward, rateList[4], srWeaponRateDict)
    for tid, srRate in pairs(srWeaponRateDict) do
      rateMap[tid] = srRate
    end
    local rWeaponRateDict = {}
    DropCfgUtils.GetProbabilityPercentInfoList(poolCfg.RAward, rateList[5], rWeaponRateDict)
    for tid, rRate in pairs(rWeaponRateDict) do
      rateMap[tid] = rRate
    end
    if selectWeaponTid then
      rateMap[selectWeaponTid] = selectWeaponRate + (rateMap[selectWeaponTid] or 0)
    end
    return rateMap
  end
  
  function views:_GetDropRateMap()
    local rateMap = {}
    local poolCfg = data.poolCfg
    local poolType = poolCfg.Type
    if poolType == cd.SummonPoolType.LuckyBag or poolType == cd.SummonPoolType.TripleLuckyBag then
      do return SummonDataUtils.GetLuckyBagPoolRateMap end
      return SummonDataUtils.GetLuckyBagPoolRateMap, poolCfg.ID, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
    end
    if poolType == cd.SummonPoolType.CategorySelect then
      do return SummonCategorySelectDataUtils.GetDropRateMap end
      return SummonCategorySelectDataUtils.GetDropRateMap, poolCfg.ID, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
    end
    local rateList = views:GetPoolRateList()
    local upItemList, normalItemList
    local cells = self:_TryInsertInventory(poolCfg.SSRAward, {})
    if cells then
      upItemList, normalItemList = {}, {}
      for _, cellInfo in ipairs(cells) do
        if cellInfo.tid then
          if not cellInfo.showTagType or 0 == cellInfo.showTagType then
            table.insert(normalItemList, cellInfo.tid)
          elseif cellInfo.showTagType then
            if poolType == cd.SummonPoolType.NormalWeapon or poolType == cd.SummonPoolType.NormalAwaker then
              if 2 == cellInfo.showTagType then
                table.insert(upItemList, cellInfo.tid)
              end
            elseif 1 == cellInfo.showTagType then
              table.insert(upItemList, cellInfo.tid)
            end
          end
        end
      end
    else
      upItemList, normalItemList = SummonDataUtils.GetUpAndNormalList(poolCfg.ID)
    end
    if poolCfg.Type == cd.SummonPoolType.MixPool or poolCfg.Type == cd.SummonPoolType.MultiAwakerWeapon then
      local awakerList, weaponList = {}, {}
      for _, tid in ipairs(normalItemList) do
        if ItemDataUtils.GetItemType(tid) == cd.ItemType.AwakerItem then
          table.insert(awakerList, tid)
        else
          table.insert(weaponList, tid)
        end
      end
      upItemList, normalItemList = awakerList, weaponList
    end
    if poolType == cd.SummonPoolType.NormalWeapon then
      do return self._GetNormalWeaponDropRateMap, self, rateList, upItemList end
      return self._GetNormalWeaponDropRateMap, self, rateList, upItemList, normalItemList, ipairs(normalItemList)
    end
    local selectWeaponTid = SummonDataUtils.GetChooseUpMapByType(data.poolCfg.Type)
    local selectWeaponRate
    local rateSkip = 0
    local rateIndex = 1
    local upRate = #upItemList > 0 and (rateList[rateIndex] + rateSkip) / #upItemList or 0
    if 0 == #upItemList then
      rateSkip = rateList[rateIndex] + rateSkip
    else
      rateSkip = 0
    end
    for _, tid in ipairs(upItemList) do
      rateMap[tid] = upRate
    end
    rateIndex = rateIndex + 1
    local normalRate = (rateList[rateIndex] + rateSkip) / #normalItemList
    for _, tid in ipairs(normalItemList) do
      rateMap[tid] = normalRate
    end
    rateIndex = rateIndex + 1
    local srWeaponRateDict = {}
    DropCfgUtils.GetProbabilityPercentInfoList(poolCfg.SRAward, rateList[rateIndex], srWeaponRateDict)
    for tid, srRate in pairs(srWeaponRateDict) do
      rateMap[tid] = srRate
    end
    rateIndex = rateIndex + 1
    local rWeaponRateDict = {}
    DropCfgUtils.GetProbabilityPercentInfoList(poolCfg.RAward, rateList[rateIndex], rWeaponRateDict)
    for tid, rRate in pairs(rWeaponRateDict) do
      rateMap[tid] = rRate
    end
    if selectWeaponTid then
      rateMap[selectWeaponTid] = selectWeaponRate + (rateMap[selectWeaponTid] or 0)
    end
    return rateMap
  end
  
  function views:__GetNormalWeaponNoLimitDropRateMap(normalList, poolCfg)
    local rateMap = {}
    local rateList = DT.GetOriginalConstant("CommonSummonWeaponProbability2")
    local selectWeaponTid = SummonDataUtils.GetChooseUpMapByType(data.poolCfg.Type)
    local selectRate, normalRate, totalSRRate, totalRRate = table.unpack(rateList)
    if selectWeaponTid then
      rateMap[selectWeaponTid] = selectRate
    else
      normalRate = normalRate + selectRate
    end
    local singleNormalRate = normalRate / #normalList
    for _, tid in ipairs(normalList) do
      rateMap[tid] = singleNormalRate
    end
    local srWeaponRateDict = {}
    DropCfgUtils.GetProbabilityPercentInfoList(poolCfg.SRAward, totalSRRate, srWeaponRateDict)
    for tid, srRate in pairs(srWeaponRateDict) do
      rateMap[tid] = srRate
    end
    local rWeaponRateDict = {}
    DropCfgUtils.GetProbabilityPercentInfoList(poolCfg.RAward, totalRRate, rWeaponRateDict)
    for tid, rRate in pairs(rWeaponRateDict) do
      rateMap[tid] = rRate
    end
    return rateMap
  end
  
  function views:_TryInsertCategorySelectInventory(_, rateMap)
    local poolId = data.poolCfg.ID
    local cells = {}
    local itemTidList = SummonCategorySelectDataUtils.GetSsrRateDisplayItemTidList(poolId)
    for i = 1, #itemTidList do
      local tid = SummonCategorySelectDataUtils.GetListItemTid(itemTidList, i)
      local itemRate = rateMap[tid]
      if itemRate and itemRate > 0 then
        table.insert(cells, {
          text = string.format("%.2f%%", itemRate + 1.0E-4),
          showTagType = 0,
          tid = tid
        })
      end
    end
    return cells
  end
  
  function views:_TryInsertInventory(dropID, rateMap)
    if not dropID then
      return
    end
    local poolCfg = data.poolCfg
    if SummonDataUtils.IsCategorySelectPool(poolCfg.ID) and dropID == poolCfg.SSRAward then
      do return data._TryInsertCategorySelectInventory, data, dropID end
      return data._TryInsertCategorySelectInventory, data, dropID, rateMap, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
    end
    local itemTidList = {}
    data:_GatherItemTids(itemTidList, dropID)
    local showTagItems = {}
    if poolCfg and poolCfg.ShowCorrect then
      for i = 2, #poolCfg.ShowCorrect do
        table.insert(showTagItems, poolCfg.ShowCorrect[i])
      end
    end
    local chooseUpSSRItemTid = SummonDataUtils.GetChooseUpSSRItemTid(poolCfg.Type, poolCfg.ID) or 0
    local chooseUpWeaponTid = SummonDataUtils.GetChooseUpSSRWeaponTid(poolCfg.Type, poolCfg.ID) or 0
    local targetDropTid = data:_GetLimitDropItemList(dropID)
    local limitItemTidList = targetDropTid and DropDataUtils.GetDropItemTids(targetDropTid) or {}
    local limitItemMap = table.reverseKV(limitItemTidList)
    local cells = {}
    local isFilterChooseUpPool = poolCfg.Type == cd.SummonPoolType.ChooseUp and 0 ~= (chooseUpSSRItemTid or 0)
    for _, tid in ipairs(itemTidList) do
      local showTagType = data:_GetItemShowTag(tid, limitItemMap)
      local isUp = 1 == showTagType
      if isFilterChooseUpPool and limitItemMap[tid] and tid ~= chooseUpSSRItemTid and tid ~= chooseUpWeaponTid then
      elseif isUp and SummonDataUtils.IsExcludeFromWishList(data.poolCfg.ID, tid) then
      else
        local rate = (rateMap[tid] or 0) + 1.0E-4
        if isUp then
          local insertPos = 1
          if tid == chooseUpSSRItemTid then
            chooseUpSSRItemTid = -1
          elseif tid == chooseUpWeaponTid and -1 == chooseUpSSRItemTid then
            insertPos = 2
          end
          table.insert(cells, insertPos, {
            text = string.format("%.2f%%", rate),
            showTagType = showTagType,
            tid = tid
          })
        else
          table.insert(cells, {
            text = string.format("%.2f%%", rate),
            showTagType = showTagType,
            tid = tid
          })
        end
      end
    end
    return cells
  end
  
  function views:_GetItemShowTag(tid, limitMap)
    if not tid then
      return
    end
    if data.poolCfg.Type == CommonDefine.SummonPoolType.ChooseUp then
      local upItemTidList = {
        SummonDataUtils.GetChooseUpSSRItemTid(data.poolCfg.Type, data.poolCfg.ID),
        SummonDataUtils.GetChooseUpSSRWeaponTid(data.poolCfg.Type, data.poolCfg.ID)
      }
      if table.contains(upItemTidList, tid) then
        return 1
      end
      if limitMap and limitMap[tid] then
        return 1
      end
    end
    local selectWeaponTid = SummonDataUtils.GetChooseUpMapByType(data.poolCfg.Type)
    if selectWeaponTid == tid then
      return 1
    end
    if SummonDataUtils.IsWishPool(data.poolCfg.ID) and SummonDataUtils.IsInWishConfigList(data.poolCfg.ID, tid) then
      return 1
    end
    if SummonDataUtils.IsCategorySelectPool(data.poolCfg.ID) then
      return 0
    end
    local poolCfg = data.poolCfg
    if poolCfg and poolCfg.ShowCorrect and table.contains(poolCfg.ShowCorrect, tid) then
      return poolCfg.ShowCorrect[1]
    end
    return 0
  end
  
  function views:_GatherItemTids(tidList, dropID)
    local dropCfg = DT.Drop[dropID]
    local serverTime = TimeUtils.GetServerTime()
    if dropCfg then
      for _, drop in ipairs(dropCfg.data_list) do
        if drop.DropType == CommonDefine.DropType.Item then
          if not drop.StartDropTime or serverTime >= drop.StartDropTime then
            table.insert(tidList, drop.DropItem)
          end
        elseif drop.DropType == CommonDefine.DropType.Drop then
          data:_GatherItemTids(tidList, drop.DropItem)
        end
      end
    end
  end
  
  function views:_GetLimitDropItemList(dropID)
    local dropCfgs = DT.Drop[dropID]
    local targetDropTid
    local minRate = math.maxinteger
    for _, dropCfg in ipairs(dropCfgs.data_list) do
      if dropCfg.DropType ~= CommonDefine.DropType.Drop then
      elseif minRate > dropCfg.WeightOrRate then
        targetDropTid = dropCfg.DropItem
        minRate = dropCfg.WeightOrRate
      end
    end
    return targetDropTid
  end
  
  return views
end

local function createActions(data)
  local actions = {}
  
  function actions:InitCurrPage()
    data.currPage = SummonIntroPage.DETAIL
  end
  
  function actions:SetCurrPage(page)
    data.currPage = page
  end
  
  return actions
end

local function onSetup(_, _)
end

local SummonIntroModel = Vue.model("SummonIntroModel", createData):views(createViews):actions(createActions):setup(onSetup)
return SummonIntroModel
