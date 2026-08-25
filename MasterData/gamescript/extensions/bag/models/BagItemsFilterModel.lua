local BagItemsFilterModel = NewClass("BagItemsFilterModel", BaseModel)
local TrinketFilterState = CommonDefine.TrinketFilterState

function BagItemsFilterModel:OnInit()
end

function BagItemsFilterModel:OnReset()
  self.filterMainAttrs = {}
  self.filterSubAttrs = {}
  self.filterParts = {}
  self.filterSuitsMap = {}
  self.lockTrinketPos = 0
  self.trinketSortType = CommonDefine.AwakerTrinketSortType.CompletionRate
  self.trinketSortOrder = CommonDefine.SortOrder.Descend
  self.weaponSortType = CommonDefine.AwakerWeaponSortType.School
  self.weaponSortOrder = CommonDefine.SortOrder.Descend
end

function BagItemsFilterModel:InitFilters()
  table.clear(self.filterMainAttrs)
  table.clear(self.filterSubAttrs)
  table.clear(self.filterParts)
  table.clear(self.filterSuitsMap)
  local allSuitsId = self:GetAllSuitIds()
  for i = 1, #allSuitsId do
    self.filterSuitsMap[allSuitsId[i]] = TrinketFilterState.FilterDefault
  end
  for i = 1, CommonDefine.MaxEquipTrinketsNum do
    self.filterParts[i] = TrinketFilterState.FilterDefault
  end
  local showAttrIds = AwakerDataUtils.GetSortedAttrIds(CommonDefine.AttrShowType.TrinketShow)
  for i = 1, #showAttrIds do
    self.filterMainAttrs[showAttrIds[i]] = TrinketFilterState.FilterDefault
    self.filterSubAttrs[showAttrIds[i]] = TrinketFilterState.FilterDefault
  end
  self.trinketSortType = CommonDefine.AwakerTrinketSortType.CompletionRate
  self.trinketSortOrder = CommonDefine.SortOrder.Descend
  self.weaponSortType = CommonDefine.AwakerWeaponSortType.School
  self.weaponSortOrder = CommonDefine.SortOrder.Descend
end

function BagItemsFilterModel:ResetFilters()
  self:InitFilters()
  self:LocalNotify(NotifyId.OnTrinketFiltersChanged)
end

function BagItemsFilterModel:IsExistedTrinketFilter()
  local showAttrIds = AwakerDataUtils.GetSortedAttrIds(CommonDefine.AttrShowType.TrinketShow)
  for i = 1, #showAttrIds do
    local hasMainAttr = self.filterMainAttrs[showAttrIds[i]] ~= TrinketFilterState.FilterDefault
    local hasSubAttr = self.filterSubAttrs[showAttrIds[i]] ~= TrinketFilterState.FilterDefault
    if hasMainAttr or hasSubAttr then
      return true
    end
  end
  if 0 == self.lockTrinketPos then
    for i = 1, CommonDefine.MaxEquipTrinketsNum do
      if self.filterParts[i] ~= TrinketFilterState.FilterDefault then
        return true
      end
    end
  end
  for _, st in pairs(self.filterSuitsMap) do
    if st ~= TrinketFilterState.FilterDefault then
      return true
    end
  end
  return false
end

function BagItemsFilterModel:IsFilter(data)
  local pos = ItemDataUtils.GetTrinketPosIndex(data)
  local isPartFilter = self:IsPartFilter(pos)
  if not isPartFilter then
    return false
  end
  local isSuitFilter = self:IsSuitFilter(data.suitId)
  if not isSuitFilter then
    return false
  end
  local mainAttr = AwakerTrinketDataUtils.GetMainAttr(data.uid)
  if not mainAttr then
    return false
  end
  local isMainAttrFilter = self:IsMainAttrFilter(mainAttr.attrId)
  if not isMainAttrFilter then
    return false
  end
  local subAttrs = AwakerTrinketDataUtils.GetSubAttrs(data.uid)
  local isSubAttrFilter = self:IsSubAttrsFilter(subAttrs)
  if not isSubAttrFilter then
    return false
  end
  return true
end

function BagItemsFilterModel:IsSuitFilter(suitId)
  return self.filterSuitsMap[suitId] ~= TrinketFilterState.FilterExclude
end

function BagItemsFilterModel:IsPartFilter(part)
  return self.filterParts[part] ~= TrinketFilterState.FilterExclude
end

function BagItemsFilterModel:IsMainAttrFilter(attrId)
  return self.filterMainAttrs[attrId] ~= TrinketFilterState.FilterExclude
end

function BagItemsFilterModel:IsSubAttrsFilter(subAttrs)
  local isAllDefault = true
  for k, v in pairs(self.filterSubAttrs) do
    if v ~= TrinketFilterState.FilterDefault then
      isAllDefault = false
    end
  end
  if isAllDefault then
    return true
  end
  for k, v in pairs(self.filterSubAttrs) do
    if v == TrinketFilterState.FilterExclude then
      for i = 1, #subAttrs do
        if subAttrs[i].attrId == k then
          return false
        end
      end
    end
  end
  local hitedFilterInclude = false
  for k, v in pairs(self.filterSubAttrs) do
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

function BagItemsFilterModel:SetSuitsFilter(suits)
  table.clear(self.filterSuitsMap)
  for k, v in pairs(suits) do
    self.filterSuitsMap[k] = v
  end
  self:HandleFiltersSelected(self.filterSuitsMap)
  self:LocalNotify(NotifyId.OnTrinketFiltersChanged)
end

function BagItemsFilterModel:SetMainAttrsFilter(mainAttrs)
  table.clear(self.filterMainAttrs)
  for k, v in pairs(mainAttrs) do
    self.filterMainAttrs[k] = v
  end
  self:HandleFiltersSelected(self.filterMainAttrs)
  self:LocalNotify(NotifyId.OnTrinketFiltersChanged)
end

function BagItemsFilterModel:SetSubAttrsFilter(subAttrs)
  table.clear(self.filterSubAttrs)
  for k, v in pairs(subAttrs) do
    self.filterSubAttrs[k] = v
  end
  self:HandleSubAttrFiltersSelected(self.filterSubAttrs)
  self:LocalNotify(NotifyId.OnTrinketFiltersChanged)
end

function BagItemsFilterModel:SetPartsFilter(filterParts)
  table.clear(self.filterParts)
  for k, v in pairs(filterParts) do
    self.filterParts[k] = v
  end
  self:HandleFiltersSelected(self.filterParts)
  self:LocalNotify(NotifyId.OnTrinketFiltersChanged)
end

function BagItemsFilterModel:CancelSuit(suitId)
  self.filterSuitsMap[suitId] = TrinketFilterState.FilterExclude
  self:HandleFiltersSelected(self.filterSuitsMap)
  self:LocalNotify(NotifyId.OnTrinketFiltersChanged)
end

function BagItemsFilterModel:CancelMainAttr(attrId)
  self.filterMainAttrs[attrId] = TrinketFilterState.FilterExclude
  self:HandleFiltersSelected(self.filterMainAttrs)
  self:LocalNotify(NotifyId.OnTrinketFiltersChanged)
end

function BagItemsFilterModel:CancelSubAttr(attrId)
  self.filterSubAttrs[attrId] = TrinketFilterState.FilterDefault
  self:HandleSubAttrFiltersSelected(self.filterSubAttrs)
  self:LocalNotify(NotifyId.OnTrinketFiltersChanged)
end

function BagItemsFilterModel:SetPartFilter(part, state)
  self.filterParts[part] = state
  self:HandleFiltersSelected(self.filterParts)
  self:LocalNotify(NotifyId.OnTrinketFiltersChanged)
end

function BagItemsFilterModel:HandleFiltersSelected(filters)
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

function BagItemsFilterModel:HandleSubAttrFiltersSelected(filters)
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

function BagItemsFilterModel:GetAllSuitIds()
  local suits = {}
  local suitNumMap = ItemDataUtils.GetTrinketSuitNumMap()
  for suitId, _ in pairs(suitNumMap) do
    if 0 == suitId then
    elseif ItemDataUtils.TrinketShowTimeMatch(suitId) then
      table.insert(suits, suitId)
    end
  end
  table.sort(suits, function(a, b)
    return a < b
  end)
  return suits
end

function BagItemsFilterModel:_GetListExemptUid()
  return nil
end

function BagItemsFilterModel:GetVisibleSuitItemNum(suitId)
  local num = 0
  local exemptUid = self:_GetListExemptUid()
  local trinkets = BagExtModel.Instance:GetAllTrinketDataList()
  for i = 1, #trinkets do
    local trinket = trinkets[i]
    if trinket.suitId == suitId and AwakerTrinketDataUtils.IsTrinketVisibleInList(trinket.uid, exemptUid) then
      num = num + 1
    end
  end
  return num
end

function BagItemsFilterModel:GetTrinketSortTypeList()
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

function BagItemsFilterModel:GetWeaponSortTypeList()
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

function BagItemsFilterModel:SetTrinketSortType(trinketSortType)
  if not trinketSortType or self.trinketSortType == trinketSortType then
    return
  end
  self.trinketSortType = trinketSortType
  self:LocalNotify(NotifyId.OnTrinketSortTypeChanged)
end

function BagItemsFilterModel:GetTrinketSortType()
  return self.trinketSortType
end

function BagItemsFilterModel:GetTrinketSortTypeName()
  do return AwakerTrinketDataUtils.GetSortTypeName end
  return AwakerTrinketDataUtils.GetSortTypeName, self.trinketSortType
end

function BagItemsFilterModel:SetTrinketSortOrder(order)
  if not order or self.trinketSortOrder == order then
    return
  end
  self.trinketSortOrder = order
  self:LocalNotify(NotifyId.OnTrinketSortOrderChanged)
end

function BagItemsFilterModel:SetWeaponSortType(sortType)
  if not sortType or self.weaponSortType == sortType then
    return
  end
  self.weaponSortType = sortType
  self:LocalNotify(NotifyId.OnWeaponSortTypeChanged)
end

function BagItemsFilterModel:GetWeaponSortTypeName()
  do return AwakerTrinketDataUtils.GetWeaponSortTypeName end
  return AwakerTrinketDataUtils.GetWeaponSortTypeName, self.weaponSortType
end

function BagItemsFilterModel:SetWeaponSortOrder(order)
  if not order or self.weaponSortOrder == order then
    return
  end
  self.weaponSortOrder = order
  self:LocalNotify(NotifyId.OnWeaponSortOrderChanged)
end

return BagItemsFilterModel
