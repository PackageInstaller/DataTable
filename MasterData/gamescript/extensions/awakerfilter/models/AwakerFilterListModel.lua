local AwakerFilterListModel = NewClass("AwakerFilterListModel", BaseModel)
local SchoolAll = 0
local LimitSchoolNum = CommonDefine.AwakerFilterLimitSchoolNum or 2
local MutualExclusionGroups = CommonDefine.AwakerFilterMutualExclusionGroups or {}
local UnableSelectReason = CommonDefine.AwakerFilterUnableSelectReason or {}

function AwakerFilterListModel:OnReset()
  self.filterType = nil
  self._school2AwakerListMap = nil
  self.filterDataMap = {}
  self:ClearSelectedState()
end

function AwakerFilterListModel:OnInit()
  self:OnReset()
  EventMgr.Instance.OnDayRefresh:RegisterEvent(function()
    self._school2AwakerListMap = nil
    self._cachedDisplayList = nil
  end)
end

function AwakerFilterListModel:ClearSelectedState()
  self.selectedAwakerList = {}
  self.selectedAwakerMap = {}
  self.selectedAwakerStampMap = {}
  self.selectedSchool = SchoolAll
  self.selectedType = CommonDefine.SelectType.All
  self.hasSwitchedSchoolOnce = false
  self._cachedDisplayList = nil
end

function AwakerFilterListModel:_GetSchool2AwakerListMap()
  if not self._school2AwakerListMap then
    self._school2AwakerListMap = self:_GetWholeMap()
  end
  return self._school2AwakerListMap
end

function AwakerFilterListModel:GetAllSchoolAwakerList()
  return self:_GetSchool2AwakerListMap()[self.selectedSchool]
end

function AwakerFilterListModel:RefreshCachedDisplayList()
  self._cachedDisplayList = self:GetDisplayAwakerList()
end

function AwakerFilterListModel:GetCachedDisplayList()
  return self._cachedDisplayList or self:GetDisplayAwakerList()
end

function AwakerFilterListModel:GetDisplayAwakerList()
  local school2AwakerListMap = self:_GetSchool2AwakerListMap()
  local curSchoolList = school2AwakerListMap[self.selectedSchool] or {}
  if self.selectedSchool == SchoolAll and not self.hasSwitchedSchoolOnce then
    return curSchoolList
  end
  local allAwakerList = school2AwakerListMap[SchoolAll] or {}
  local allIndexMap = {}
  for idx, awakerTid in ipairs(allAwakerList) do
    allIndexMap[awakerTid] = idx
  end
  local showMap = {}
  local ret = {}
  for _, awakerTid in ipairs(curSchoolList) do
    if not showMap[awakerTid] then
      showMap[awakerTid] = true
      table.insert(ret, awakerTid)
    end
  end
  for _, awakerTid in ipairs(self.selectedAwakerList or {}) do
    if allIndexMap[awakerTid] and not showMap[awakerTid] then
      showMap[awakerTid] = true
      table.insert(ret, awakerTid)
    end
  end
  local needTopSelected = self.hasSwitchedSchoolOnce
  if not needTopSelected then
    return ret
  end
  table.sort(ret, function(a, b)
    local isASelected = self.selectedAwakerMap[a]
    local isBSelected = self.selectedAwakerMap[b]
    if isASelected ~= isBSelected then
      return isASelected
    end
    local aStamp = self.selectedAwakerStampMap[a] or 0
    local bStamp = self.selectedAwakerStampMap[b] or 0
    if aStamp ~= bStamp then
      if 0 == aStamp or 0 == bStamp then
        return 0 ~= aStamp
      end
      if 0 ~= aStamp and 0 ~= bStamp and not isASelected and not isBSelected then
        return aStamp > bStamp
      end
      if 0 ~= aStamp and 0 ~= bStamp and isASelected and isBSelected then
        return aStamp < bStamp
      end
    end
    return (allIndexMap[a] or math.maxinteger) < (allIndexMap[b] or math.maxinteger)
  end)
  return ret
end

function AwakerFilterListModel:GetCurrentSelectList()
  return self.selectedAwakerList
end

function AwakerFilterListModel:GetCurrentSelectedSchool()
  return self.selectedSchool
end

function AwakerFilterListModel:GetCurrentSelectedType()
  return self.selectedType
end

function AwakerFilterListModel:GetCurrentSelectedAwakerCount()
  return #self.selectedAwakerList
end

function AwakerFilterListModel:GetFilterType()
  return self.filterType
end

function AwakerFilterListModel:SetFilterType(filterType)
  self.filterType = filterType
  self:ClearSelectedState()
end

function AwakerFilterListModel:GetFilterData(filterType)
  return self.filterDataMap[filterType]
end

function AwakerFilterListModel:ClearFilterData(filterType)
  self.filterDataMap[filterType] = nil
  if self.filterType == filterType then
    self:ClearSelectedState()
  end
end

function AwakerFilterListModel:GetAwakerListBySchool(school)
  return self:_GetSchool2AwakerListMap()[school] or {}
end

function AwakerFilterListModel:ApplySelectionState(selectedSchool, selectedAwakerList, selectedType, hasSwitchedSchoolOnce)
  self.selectedSchool = selectedSchool or SchoolAll
  self:SetSelectedAwakerList(selectedAwakerList)
  self.selectedType = selectedType or CommonDefine.SelectType.All
  if nil == hasSwitchedSchoolOnce then
    self.hasSwitchedSchoolOnce = self.selectedSchool ~= SchoolAll
  else
    self.hasSwitchedSchoolOnce = hasSwitchedSchoolOnce
  end
end

function AwakerFilterListModel:InitSelectionStateByFilterType(filterType)
  if filterType == CommonDefine.AwakerFilterType.DailyChallengeRank then
    self:ApplySelectionState(SchoolAll, {}, CommonDefine.SelectType.None)
  else
    self:ApplySelectionState(SchoolAll, self:_GetSchool2AwakerListMap()[SchoolAll], CommonDefine.SelectType.All)
  end
end

function AwakerFilterListModel:SaveCurrentSelectionState(filterType)
  self.filterDataMap[filterType] = {
    selectedAwakerList = table.clone(self.selectedAwakerList),
    selectedSchool = self.selectedSchool,
    selectedType = self.selectedType,
    hasSwitchedSchoolOnce = self.hasSwitchedSchoolOnce
  }
end

function AwakerFilterListModel:SetSelectedSchool(school)
  self.selectedSchool = school
end

function AwakerFilterListModel:SetHasSwitchedSchoolOnce(hasSwitchedSchoolOnce)
  self.hasSwitchedSchoolOnce = hasSwitchedSchoolOnce and true or false
end

function AwakerFilterListModel:SetSelectedAwakerList(selectedAwakerList)
  self.selectedAwakerList = table.clone(selectedAwakerList or {})
  self.selectedAwakerMap = {}
  for _, awakerTid in ipairs(self.selectedAwakerList) do
    self.selectedAwakerMap[awakerTid] = true
  end
end

function AwakerFilterListModel:SetSelectedType(selectType)
  self.selectedType = selectType
end

function AwakerFilterListModel:ToggleAwakerInSelectedList(awakerTid)
  if self.selectedAwakerMap[awakerTid] then
    table.removeByValue(self.selectedAwakerList, awakerTid)
    self.selectedAwakerMap[awakerTid] = nil
    return false
  end
  table.insert(self.selectedAwakerList, awakerTid)
  self.selectedAwakerMap[awakerTid] = true
  self.selectedAwakerStampMap[awakerTid] = TimeUtils.GetServerTime()
  return true
end

function AwakerFilterListModel:ClearUnselectedAwakerStamp()
  for awakerTid, stamp in pairs(self.selectedAwakerStampMap) do
    if not self.selectedAwakerMap[awakerTid] then
      self.selectedAwakerStampMap[awakerTid] = nil
    end
  end
end

function AwakerFilterListModel:RecalculateSelectedType()
  local selectType = CommonDefine.SelectType.Part
  if 0 == #self.selectedAwakerList then
    selectType = CommonDefine.SelectType.None
  elseif #self.selectedAwakerList == self:GetTotalAwakerCount() then
    selectType = CommonDefine.SelectType.All
  end
  self.selectedType = selectType
  return selectType
end

function AwakerFilterListModel:FilterSelectedAwakerListBySchool(school)
  if school == SchoolAll then
    return
  end
  local preSelectMap = {}
  for _, awakerTid in ipairs(self.selectedAwakerList) do
    preSelectMap[awakerTid] = true
  end
  local curSchoolAwakerList = self:_GetSchool2AwakerListMap()[school] or {}
  local selectedAwakerList = {}
  for _, awakerTid in ipairs(curSchoolAwakerList) do
    if preSelectMap[awakerTid] then
      table.insert(selectedAwakerList, awakerTid)
    end
  end
  self:SetSelectedAwakerList(selectedAwakerList)
end

function AwakerFilterListModel:GetSelectedAwakerCount()
  local curSchoolAwakerList = self:_GetSchool2AwakerListMap()[self.selectedSchool]
  local selectedAwakerCount = 0
  for _, awakerTid in ipairs(curSchoolAwakerList) do
    if self.selectedAwakerMap[awakerTid] then
      selectedAwakerCount = selectedAwakerCount + 1
    end
  end
  return selectedAwakerCount
end

function AwakerFilterListModel:GetDisplaySelectedAwakerCount()
  local displayList = self:GetCachedDisplayList() or {}
  local selectedCount = 0
  for _, awakerTid in ipairs(displayList) do
    if self.selectedAwakerMap[awakerTid] then
      selectedCount = selectedCount + 1
    end
  end
  return selectedCount
end

function AwakerFilterListModel:GetAllSelectAwakerCount()
  local curSchoolAwakerList = self:_GetSchool2AwakerListMap()[self.selectedSchool]
  local selectedAwakerCount = self:GetSelectedAwakerCount()
  return #curSchoolAwakerList, selectedAwakerCount
end

function AwakerFilterListModel:GetTotalAwakerCount()
  return #self:_GetSchool2AwakerListMap()[SchoolAll]
end

function AwakerFilterListModel:IsAwakerSelected(awakerTid)
  return self.selectedAwakerMap[awakerTid] == true
end

function AwakerFilterListModel:GetSelectedSchoolMap()
  local selectedSchoolMap = {}
  for _, awakerTid in ipairs(self.selectedAwakerList or {}) do
    local awakerCfg = DT.AwakerConfig[awakerTid]
    local schoolId = awakerCfg and awakerCfg.School
    if schoolId and schoolId ~= SchoolAll then
      selectedSchoolMap[schoolId] = true
    end
  end
  return selectedSchoolMap
end

function AwakerFilterListModel:GetSelectedSchoolCount()
  local selectedSchoolMap = self:GetSelectedSchoolMap()
  local count = 0
  for _ in pairs(selectedSchoolMap) do
    count = count + 1
  end
  return count
end

function AwakerFilterListModel:IsAwakerSchoolConflict(awakerTid)
  if self:IsAwakerSelected(awakerTid) then
    return false
  end
  local awakerCfg = DT.AwakerConfig[awakerTid]
  local awakerSchool = awakerCfg and awakerCfg.School
  if not awakerSchool or awakerSchool == SchoolAll then
    return false
  end
  local selectedSchoolMap = self:GetSelectedSchoolMap()
  if selectedSchoolMap[awakerSchool] then
    return false
  end
  return self:GetSelectedSchoolCount() >= LimitSchoolNum
end

function AwakerFilterListModel:CanSelectAwakerBySchoolLimit(awakerTid)
  return not self:IsAwakerSchoolConflict(awakerTid)
end

function AwakerFilterListModel:IsAwakerMutualConflict(awakerTid)
  if self:IsAwakerSelected(awakerTid) then
    return false
  end
  for _, group in ipairs(MutualExclusionGroups) do
    local inGroup = false
    for _, tid in ipairs(group or {}) do
      if tid == awakerTid then
        inGroup = true
        break
      end
    end
    if inGroup then
      for _, tid in ipairs(group or {}) do
        if tid ~= awakerTid and self.selectedAwakerMap[tid] then
          return true
        end
      end
      return false
    end
  end
  return false
end

function AwakerFilterListModel:IsAwakerUnableSelect(awakerTid)
  return self:IsAwakerSchoolConflict(awakerTid) or self:IsAwakerMutualConflict(awakerTid)
end

function AwakerFilterListModel:GetAwakerUnableSelectReason(awakerTid)
  if self:IsAwakerSchoolConflict(awakerTid) then
    return UnableSelectReason.SchoolConflict or "school_conflict"
  end
  if self:IsAwakerMutualConflict(awakerTid) then
    return UnableSelectReason.MutualConflict or "mutual_conflict"
  end
  return nil
end

function AwakerFilterListModel:IsFilterAwaker()
  local allAwakerCount, selectedAwakerCount = self:GetAllSelectAwakerCount()
  return allAwakerCount ~= selectedAwakerCount
end

function AwakerFilterListModel:GetSelectListFilterSchool()
  if 0 == self.selectedSchool then
    return self.selectedAwakerList
  end
  local ret = {}
  local curSchoolAwakerList = self:_GetSchool2AwakerListMap()[self.selectedSchool]
  for _, awakerTid in ipairs(curSchoolAwakerList) do
    if self.selectedAwakerMap[awakerTid] then
      table.insert(ret, awakerTid)
    end
  end
  return ret
end

local qualitySortFeq = {
  UR = 1,
  Orange = 2,
  Purple = 3
}
local SchoolSortFeq = {
  1,
  3,
  4,
  2
}

function AwakerFilterListModel:_GetWholeMap()
  local now = TimeUtils.GetServerTime()
  local school2AwakerListMap = {}
  local allAwakerList = {}
  for awakerTid, awakerCfg in pairs(DT.AwakerConfig) do
    if not awakerCfg.OpenDate or now >= awakerCfg.OpenDate then
      school2AwakerListMap[awakerCfg.School] = school2AwakerListMap[awakerCfg.School] or {}
      table.insert(school2AwakerListMap[awakerCfg.School], awakerTid)
      table.insert(allAwakerList, awakerTid)
    end
  end
  school2AwakerListMap[SchoolAll] = allAwakerList
  
  local function sortFunc(a, b)
    local aCfg = DT.AwakerConfig[a]
    local bCfg = DT.AwakerConfig[b]
    local aQual = qualitySortFeq[aCfg.Quality]
    local bQual = qualitySortFeq[bCfg.Quality]
    if aQual ~= bQual then
      return aQual < bQual
    end
    local aSch = SchoolSortFeq[aCfg.School]
    local bSch = SchoolSortFeq[bCfg.School]
    if aSch ~= bSch then
      return aSch < bSch
    end
    local aOpenT = aCfg.OpenDate or 0
    local bOpenT = bCfg.OpenDate or 0
    if aOpenT ~= bOpenT then
      return aOpenT > bOpenT
    end
    return aCfg.BaseSortID > bCfg.BaseSortID
  end
  
  for _, awakerList in pairs(school2AwakerListMap) do
    table.sort(awakerList, sortFunc)
  end
  return school2AwakerListMap
end

function AwakerFilterListModel:GetSchoolAwakerCount(school)
  return #self:_GetSchool2AwakerListMap()[school]
end

function AwakerFilterListModel:GetFilterMaxAwakerCount()
  do return DT.GetOriginalConstant, "FilterMaxAwakerCount" end
  return DT.GetOriginalConstant, "FilterMaxAwakerCount", CommonDefine.TeamAwakerCount
end

return AwakerFilterListModel
