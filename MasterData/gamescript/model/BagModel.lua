local ItemType = CommonDefine.ItemType
local ItemSubType = CommonDefine.ItemSubType
local tableInsert = table.insert
local tableSort = table.sort
local QualitySortID = CommonDefine.QualitySortID
local TrinketFilterState = CommonDefine.TrinketFilterState

local function createBagModelState()
  local state = {}
  
  local function defaultSort(a, b)
    local aCfg = DT.Item[a.tid]
    local bCfg = DT.Item[b.tid]
    local aQualitySortWeight = QualitySortID[aCfg.Quality]
    local bQualitySortWeight = QualitySortID[bCfg.Quality]
    local aBaseSort = aCfg.BaseSortID
    local bBaseSort = bCfg.BaseSortID
    if aQualitySortWeight == bQualitySortWeight then
      return aBaseSort < bBaseSort
    end
    return aQualitySortWeight > bQualitySortWeight
  end
  
  function state.itemBagData()
    return DataCenter.itemData.BagItemData
  end
  
  function state.weaponList()
    local list = {}
    local tmp = {}
    for _, v in pairs(state.itemBagData) do
      if not v then
      else
        local config = state:GetItemConfig(v.tid)
        if config.Type == ItemType.Weapon then
          tableInsert(tmp, v)
        end
      end
    end
    tmp = AwakerTrinketDataUtils.WeaponSort(tmp, state.weaponSortType, state.weaponSortOrder)
    for _, v in ipairs(tmp) do
      local itemData = {
        tid = v.tid,
        uid = v.uid
      }
      tableInsert(list, itemData)
    end
    return list
  end
  
  function state.ownAnyItems()
    local currShowType = state.currShowType
    local list
    if currShowType == ItemType.Weapon then
      list = state:GetWeaponList()
    elseif currShowType == ItemType.Trinket then
      list = state:GetTrinketList()
    elseif currShowType == ItemType.Special then
      list = state:GetSpecialList()
    elseif currShowType == ItemType.Material then
      list = state:GetMaterialList()
    end
    return list and #list > 0
  end
  
  function state.trinketList()
    local list = {}
    for _, v in pairs(state.itemBagData) do
      if not v then
      else
        local config = state:GetItemConfig(v.tid)
        if config.Type == ItemType.Trinket then
          local pos = ItemDataUtils.GetTrinketPosIndex(v)
          local mainAttr = AwakerTrinketDataUtils.GetMainAttr(v.uid)
          local subAttrs = AwakerTrinketDataUtils.GetSubAttrs(v.uid)
          local isSuitFilter = state:IsSuitFilter(v.suitId)
          local isPartFilter = state:IsPartFilter(pos)
          local isMainAttrFilter = state:IsMainAttrFilter(mainAttr.attrId)
          local isSubAttrFilter = state:IsSubAttrsFilter(subAttrs)
          if not (isSubAttrFilter and isSuitFilter and isPartFilter) or not isMainAttrFilter then
          else
            local itemData = {
              tid = v.tid,
              uid = v.uid
            }
            tableInsert(list, itemData)
          end
        end
      end
    end
    list = AwakerTrinketDataUtils.Sort(list, state.trinketSortType, state.trinketSortOrder)
    return list
  end
  
  function state.existesTrinks()
    for _, v in pairs(state.itemBagData) do
      if not v then
      else
        local config = state:GetItemConfig(v.tid)
        if config.Type == ItemType.Trinket then
          return true
        end
      end
    end
  end
  
  function state.materialList()
    local list = {}
    for _, v in pairs(state.itemBagData) do
      if not v then
      else
        local config = state:GetItemConfig(v.tid)
        if config.Type == ItemType.Material then
          local itemData = {
            tid = v.tid,
            uid = v.uid
          }
          tableInsert(list, itemData)
        end
      end
    end
    tableSort(list, defaultSort)
    return list
  end
  
  function state.specialList()
    local list = {}
    for _, v in pairs(state.itemBagData) do
      if not v then
      else
        local config = state:GetItemConfig(v.tid)
        if config.Type == ItemType.Special and config.SubType ~= ItemSubType.PlayerAvatar then
          local itemData = {
            tid = v.tid,
            uid = v.uid
          }
          tableInsert(list, itemData)
        end
      end
    end
    tableSort(list, defaultSort)
    return list
  end
  
  function state.weaponSortTypeList()
    local ret = {}
    local weaponSortData = AwakerTrinketDataUtils.GetWeaponSortDataTable()
    for index, data in pairs(weaponSortData) do
      local name = data.name
      if not name then
        for _, config in pairs(DT.ActorAttrType) do
          if config.Name == data.attrName then
            name = config.Text
            break
          end
        end
      end
      table.insert(ret, {type = index, name = name})
    end
    return ret
  end
  
  state.weaponSortType = CommonDefine.AwakerWeaponSortType.Quality
  state.weaponSortOrder = CommonDefine.SortOrder.Descend
  state.isShowWeaponFilter = false
  state.trinketSortType = CommonDefine.AwakerTrinketSortType.CompletionRate
  state.trinketSortOrder = CommonDefine.SortOrder.Descend
  
  function state.trinketSortTypeList()
    local ret = {}
    local trinketSortList = AwakerTrinketDataUtils.GetSortDataTable()
    for index, data in pairs(trinketSortList) do
      local name = data.name
      if not name then
        for _, config in pairs(DT.ActorAttrType) do
          if config.Name == data.attrName then
            name = config.Text
            break
          end
        end
      end
      table.insert(ret, {type = index, name = name})
    end
    return ret
  end
  
  state.isShowTrinketFilter = false
  state.isShowTrinketSortFilter = false
  state.currShowType = ItemType.Weapon
  
  function state.maxItemNum()
    local currShowType = state.currShowType
    local limitList = state:GetItemPageMaxNum()
    if currShowType == ItemType.Weapon then
      return limitList[1]
    elseif currShowType == ItemType.Trinket then
      return limitList[2]
    elseif currShowType == ItemType.Material then
      return limitList[3]
    elseif currShowType == ItemType.Special then
      return limitList[4]
    end
    Logger.Info("意料之外的道具类型分页:", currShowType)
    return 999
  end
  
  state.filterMainAttrs = {}
  state.filterSubAttrs = {}
  state.filterParts = {}
  
  local function _filterSuits()
    local suits = {}
    local suitNumMap = ItemDataUtils.GetTrinketSuitNumMap()
    for suitId, _ in pairs(suitNumMap) do
      if 0 == suitId then
      elseif ItemDataUtils.TrinketShowTimeMatch(suitId) then
        tableInsert(suits, suitId)
      end
    end
    tableSort(suits, function(a, b)
      return a < b
    end)
    return suits
  end
  
  function state.filterSuits()
    do return end
    return _filterSuits, nil
  end
  
  local suits = _filterSuits()
  local suitsMap = {}
  for i = 1, #suits do
    suitsMap[suits[i]] = TrinketFilterState.FilterDefault
  end
  state.filterSuitsMap = suitsMap
  for i = 1, CommonDefine.MaxEquipTrinketsNum do
    state.filterParts[i] = TrinketFilterState.FilterDefault
  end
  local showAttrIds = AwakerDataUtils.GetSortedAttrIds(CommonDefine.AttrShowType.TrinketShow)
  for i = 1, #showAttrIds do
    state.filterMainAttrs[showAttrIds[i]] = TrinketFilterState.FilterDefault
    state.filterSubAttrs[showAttrIds[i]] = TrinketFilterState.FilterDefault
  end
  
  function state.trinketFilterHaved()
    local showHavedAttrIds = AwakerDataUtils.GetSortedAttrIds(CommonDefine.AttrShowType.TrinketShow)
    for i = 1, #showHavedAttrIds do
      local hasMainAttr = state.filterMainAttrs[showHavedAttrIds[i]] ~= TrinketFilterState.FilterDefault
      local hasSubAttr = state.filterSubAttrs[showHavedAttrIds[i]] ~= TrinketFilterState.FilterDefault
      if hasMainAttr or hasSubAttr then
        return true
      end
    end
    if not state.selectPos or 0 == state.selectPos then
      for i = 1, CommonDefine.MaxEquipTrinketsNum do
        if state.filterParts[i] ~= TrinketFilterState.FilterDefault then
          return true
        end
      end
    end
    for suitId, st in pairs(state.filterSuitsMap) do
      if st ~= TrinketFilterState.FilterDefault then
        return true
      end
    end
    return false
  end
  
  function state.specificOnceRedItemTypeMap()
    local specificItemList = DT.GetOriginalConstant("BagOnceReddotItemList")
    if not specificItemList or table.next(specificItemList) == nil then
      return {}
    end
    local map = {}
    for _, tid in ipairs(specificItemList) do
      local config = ItemDataUtils.GetItemConfig(tid)
      if not config then
      else
        if not map[config.Type] then
          map[config.Type] = {}
        end
        table.insert(map[config.Type], tid)
      end
    end
    return map
  end
  
  return state
end

local function createBagModelViews(data)
  local views = {}
  
  function views:GetItemConfig(tid)
    if not tid then
      Logger.Info("Error parameter: nil")
      return
    end
    local config = DT.Item[tid]
    assert(nil ~= config, "找不到道具配置: " .. tostring(tid))
    return config
  end
  
  function views:GetItemPageMaxNum()
    local limitList = DT.GetOriginalConstant("BagCapacity")
    if not limitList then
      Logger.Info("找不到容量配置!")
      return {
        999,
        999,
        999,
        999
      }
    end
    return limitList
  end
  
  function views:GetWeaponList()
    return data.weaponList
  end
  
  function views:GetTrinketList()
    return data.trinketList
  end
  
  function views:GetMaterialList()
    return data.materialList
  end
  
  function views:GetSpecialList()
    return data.specialList
  end
  
  function views:GetItemTypeNameCn()
    local itemType = data.currShowType
    local typeNameCn = string.format("Bag%sTitle", itemType)
    do return LT.Text end
    return LT.Text, typeNameCn
  end
  
  function views:GetItemTypeNameEn()
    local itemType = data.currShowType
    local typeNameEn = string.format("Bag%sEnTitle", itemType)
    do return LT.Text end
    return LT.Text, typeNameEn
  end
  
  function views:GetEmptyTips()
    local name = self:GetItemTypeNameCn()
    local tips = LT.Textf("BagEmptyTitle", name)
    return tips
  end
  
  function views:GetWeaponSortTypeName()
    do return AwakerTrinketDataUtils.GetWeaponSortTypeName end
    return AwakerTrinketDataUtils.GetWeaponSortTypeName, data.weaponSortType
  end
  
  function views:GetWeaponSortOrderName()
    local key = "ActorString_Sort_Ascend"
    if data.weaponSortOrder == CommonDefine.SortOrder.Descend then
      key = "ActorString_Sort_Descend"
    end
    do return LT.Text end
    return LT.Text, key
  end
  
  function views:GetTrinketSortTypeName()
    do return AwakerTrinketDataUtils.GetSortTypeName end
    return AwakerTrinketDataUtils.GetSortTypeName, data.trinketSortType
  end
  
  function views:GetTrinketSortOrderName()
    local key = "ActorString_Sort_Ascend"
    if data.trinketSortOrder == CommonDefine.SortOrder.Descend then
      key = "ActorString_Sort_Descend"
    end
    do return LT.Text end
    return LT.Text, key
  end
  
  function views:GetEmptySourceTips()
    local currShowType = data.currShowType
    local sourceTips = string.format("Bag%sEmptyDesc", currShowType)
    do return LT.Text end
    return LT.Text, sourceTips
  end
  
  function views:GetSuitName(suitId)
    do return AwakerTrinketDataUtils.GetSuitName end
    return AwakerTrinketDataUtils.GetSuitName, suitId
  end
  
  function views:GetSuitIcon(suitId)
    do return AwakerTrinketDataUtils.GetSuitIcon end
    return AwakerTrinketDataUtils.GetSuitIcon, suitId
  end
  
  function views:GetSuitItemNum(suitId)
    do return AwakerTrinketDataUtils.GetSuitItemNum end
    return AwakerTrinketDataUtils.GetSuitItemNum, suitId
  end
  
  function views:IsSuitFilter(suitId)
    return data.filterSuitsMap[suitId] ~= TrinketFilterState.FilterExclude
  end
  
  function views:IsPartFilter(part)
    return data.filterParts[part] ~= TrinketFilterState.FilterExclude
  end
  
  function views:IsMainAttrFilter(attrId)
    return data.filterMainAttrs[attrId] ~= TrinketFilterState.FilterExclude
  end
  
  function views:IsSubAttrsFilter(subAttrs)
    local isAllDefault = true
    for k, v in pairs(data.filterSubAttrs) do
      if v ~= TrinketFilterState.FilterDefault then
        isAllDefault = false
      end
    end
    if isAllDefault then
      return true
    end
    for k, v in pairs(data.filterSubAttrs) do
      if v == TrinketFilterState.FilterExclude then
        for i = 1, #subAttrs do
          if subAttrs[i].attrId == k then
            return false
          end
        end
      end
    end
    local hitedFilterInclude = false
    for k, v in pairs(data.filterSubAttrs) do
      if v == TrinketFilterState.FilterInclude then
        hitedFilterInclude = true
        if 0 == #subAttrs then
          return false
        end
        for i = 1, #subAttrs do
          if subAttrs[i].attrId == k then
            return true
          end
        end
      end
    end
    if hitedFilterInclude then
      return false
    end
    return true
  end
  
  function views:HasSpecificOnceRedItem(itemType)
    local itemList = data.specificOnceRedItemTypeMap[itemType]
    return itemList and #itemList > 0
  end
  
  return views
end

local function createBagModelActions(data)
  local actions = {}
  
  function actions:SetCurrShowType(itemType)
    if not itemType then
      return
    end
    data.currShowType = itemType
  end
  
  function actions:SetWeaponSortType(weaponSortType)
    if not weaponSortType then
      return
    end
    data.weaponSortType = weaponSortType
  end
  
  function actions:SetTrinketSortType(trinketSortType)
    if not trinketSortType then
      return
    end
    data.trinketSortType = trinketSortType
  end
  
  function actions:SetIsShowWeaponFilter(val)
    data.isShowWeaponFilter = val
  end
  
  function actions:SetIsShowTrinketFilter(val)
    data.isShowTrinketFilter = val
  end
  
  function actions:SetIsShowTrinketSortFilter(val)
    data.isShowTrinketSortFilter = val
  end
  
  function actions:SetWeaponSortOrder(order)
    data.weaponSortOrder = order
  end
  
  function actions:SetTrinketSortOrder(order)
    data.trinketSortOrder = order
  end
  
  function actions:SetSuitsFilter(suits)
    table.clear(data.filterSuitsMap)
    for k, v in pairs(suits) do
      data.filterSuitsMap[k] = v
    end
    self:HandleFiltersSelected(data.filterSuitsMap)
  end
  
  function actions:SetMainAttrsFilter(mainAttrs)
    table.clear(data.filterMainAttrs)
    for k, v in pairs(mainAttrs) do
      data.filterMainAttrs[k] = v
    end
    self:HandleFiltersSelected(data.filterMainAttrs)
  end
  
  function actions:SetSubAttrsFilter(subAttrs)
    table.clear(data.filterSubAttrs)
    for k, v in pairs(subAttrs) do
      data.filterSubAttrs[k] = v
    end
    self:HandleSubAttrFiltersSelected(data.filterSubAttrs)
  end
  
  function actions:SetPartsFilter(filterParts)
    table.clear(data.filterParts)
    for k, v in pairs(filterParts) do
      data.filterParts[k] = v
    end
    self:HandleFiltersSelected(data.filterParts)
  end
  
  function actions:CancelSuit(suitId)
    data.filterSuitsMap[suitId] = TrinketFilterState.FilterExclude
    self:HandleFiltersSelected(data.filterSuitsMap)
  end
  
  function actions:CancelMainAttr(attrId)
    data.filterMainAttrs[attrId] = TrinketFilterState.FilterExclude
    self:HandleFiltersSelected(data.filterMainAttrs)
  end
  
  function actions:CancelSubAttr(attrId)
    data.filterSubAttrs[attrId] = TrinketFilterState.FilterDefault
    self:HandleSubAttrFiltersSelected(data.filterSubAttrs)
  end
  
  function actions:SetPartFilter(part, state)
    data.filterParts[part] = state
    self:HandleFiltersSelected(data.filterParts)
  end
  
  function actions:ResetFilters()
    table.clear(data.filterMainAttrs)
    table.clear(data.filterSubAttrs)
    table.clear(data.filterParts)
    table.clear(data.filterSuitsMap)
    local suits = data.filterSuits
    for i = 1, #suits do
      data.filterSuitsMap[suits[i]] = TrinketFilterState.FilterDefault
    end
    for i = 1, CommonDefine.MaxEquipTrinketsNum do
      data.filterParts[i] = TrinketFilterState.FilterDefault
    end
    local showAttrIds = AwakerDataUtils.GetSortedAttrIds(CommonDefine.AttrShowType.TrinketShow)
    for i = 1, #showAttrIds do
      data.filterMainAttrs[showAttrIds[i]] = TrinketFilterState.FilterDefault
      data.filterSubAttrs[showAttrIds[i]] = TrinketFilterState.FilterDefault
    end
  end
  
  function actions:HandleFiltersSelected(filters)
    local existedInclude
    for k, v in pairs(filters) do
      if v == TrinketFilterState.FilterInclude then
        existedInclude = true
        break
      end
    end
    if not existedInclude then
      for k, v in pairs(filters) do
        filters[k] = TrinketFilterState.FilterDefault
      end
    else
      for k, v in pairs(filters) do
        if v ~= TrinketFilterState.FilterInclude then
          filters[k] = TrinketFilterState.FilterExclude
        end
      end
    end
  end
  
  function actions:HandleSubAttrFiltersSelected(filters)
    local isAllExclude = true
    for k, v in pairs(filters) do
      if v ~= TrinketFilterState.FilterExclude then
        isAllExclude = false
        break
      end
    end
    if isAllExclude then
      for k, v in pairs(filters) do
        filters[k] = TrinketFilterState.FilterDefault
      end
    end
  end
  
  return actions
end

local function onSetup(_, _)
end

local BagModel = Vue.model("BagModel", createBagModelState):views(createBagModelViews):actions(createBagModelActions):setup(onSetup)
return BagModel
