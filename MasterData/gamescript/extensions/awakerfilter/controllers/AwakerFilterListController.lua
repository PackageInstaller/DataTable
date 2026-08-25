local AwakerFilterListController = NewClass("AwakerFilterListController", BaseController)
local UnableSelectReason = CommonDefine.AwakerFilterUnableSelectReason or {}
local _CopyRecordsPrefix = "CopyRecords_"
AwakerFilterListController.Instance = nil

function AwakerFilterListController:OnInit()
  if not AwakerFilterListController.Instance then
    AwakerFilterListController.Instance = self
  end
end

function AwakerFilterListController:OnReset()
  self._model = AwakerFilterListModel.Instance
end

function AwakerFilterListController:ResetEditingFromSaved()
  local model = self._model
  local filterType = model and model:GetFilterType()
  if not model or not filterType then
    return
  end
  local data = model:GetFilterData(filterType)
  if not data then
    return
  end
  AwakerFilterListModel.Instance:ApplySelectionState(data.selectedSchool, data.selectedAwakerList, data.selectedType, data.hasSwitchedSchoolOnce)
end

function AwakerFilterListController:SetFilterType(filterType)
  local model = self._model
  if model:GetFilterType() == filterType then
    return
  end
  model:SetFilterType(filterType)
  local filterData = model:GetFilterData(filterType)
  if filterData then
    model:ApplySelectionState(filterData.selectedSchool, filterData.selectedAwakerList, filterData.selectedType, filterData.hasSwitchedSchoolOnce)
  else
    self:_InitDataSource(filterType)
  end
end

function AwakerFilterListController:_InitDataSource(filterType)
  local model = self._model
  if filterType == CommonDefine.AwakerFilterType.CopyRecords then
    model:ApplySelectionState(0, {}, CommonDefine.SelectType.None)
  else
    model:InitSelectionStateByFilterType(filterType)
  end
  model:SaveCurrentSelectionState(filterType)
end

function AwakerFilterListController:GetCopyRecordsFilterAwakerMap()
  local model = self._model
  local total = model:GetTotalAwakerCount()
  local filterData = model:GetFilterData(CommonDefine.AwakerFilterType.CopyRecords)
  if not filterData then
    return nil
  end
  local list = filterData.selectedAwakerList
  if not list or 0 == #list or #list == total then
    return nil
  end
  local awakerMap = {}
  for _, tid in ipairs(list) do
    awakerMap[tid] = 1
  end
  return awakerMap
end

function AwakerFilterListController:SelectSchool(school)
  local model = self._model
  if model:GetCurrentSelectedSchool() == school then
    return
  end
  model:SetHasSwitchedSchoolOnce(true)
  model:SetSelectedSchool(school)
  self:CalculateSelectedType()
end

function AwakerFilterListController:ToggleAwaker(awakerTid)
  local model = self._model
  if not awakerTid or not model:GetFilterType() then
    return false
  end
  local selectedAwakerList = model:GetCurrentSelectList()
  if not table.contains(selectedAwakerList, awakerTid) then
    local maxCount = model:GetFilterMaxAwakerCount()
    if maxCount <= #selectedAwakerList then
      Alert.ShowWithParams("FilterMaxAwakerCountTips", {maxCount})
      return false
    end
    local unableSelectReason = model:GetAwakerUnableSelectReason(awakerTid)
    if unableSelectReason == (UnableSelectReason.SchoolConflict or "school_conflict") then
      Alert.Show("SchoolConflictTips")
      return false
    elseif unableSelectReason == (UnableSelectReason.MutualConflict or "mutual_conflict") then
      Alert.Show("FilterAwakerUnableSelect")
      return false
    end
  end
  model:ToggleAwakerInSelectedList(awakerTid)
  self:CalculateSelectedType()
  model:Notify(NotifyId.OnAwakerFilterListChange, model:GetFilterType())
  do return model.IsAwakerSelected, model end
  return model.IsAwakerSelected, model, awakerTid, model:GetFilterType()
end

function AwakerFilterListController:ToggleSelectAll()
  local model = self._model
  local displayList = model:GetCachedDisplayList() or {}
  local displayAwakerMap = {}
  for _, awakerTid in ipairs(displayList) do
    displayAwakerMap[awakerTid] = true
  end
  local isOff = model:GetDisplaySelectedAwakerCount() > 0
  print("------------------toggle select all, isOff = ", isOff)
  if isOff then
    local selectedAwakerList = model:GetCurrentSelectList() or {}
    local keepAwakerList = {}
    for _, awakerTid in ipairs(selectedAwakerList) do
      if not displayAwakerMap[awakerTid] then
        table.insert(keepAwakerList, awakerTid)
      end
    end
    print("-----------------is off and awaker list", table.tostring(keepAwakerList))
    model:SetSelectedAwakerList(keepAwakerList)
  else
    local maxCount = model:GetFilterMaxAwakerCount()
    local limitSchoolNum = CommonDefine.AwakerFilterLimitSchoolNum or 2
    local selectedAwakerList = table.clone(model:GetCurrentSelectList() or {})
    local selectedAwakerMap = table.reverseKV(selectedAwakerList)
    local selectedSchoolMap = model:GetSelectedSchoolMap()
    local selectedSchoolCount = model:GetSelectedSchoolCount()
    for _, awakerTid in ipairs(displayList) do
      if maxCount <= #selectedAwakerList then
        break
      end
      if not selectedAwakerMap[awakerTid] then
        local awakerCfg = DT.AwakerConfig[awakerTid]
        local awakerSchool = awakerCfg and awakerCfg.School
        local canSelect = awakerSchool and (selectedSchoolMap[awakerSchool] or limitSchoolNum > selectedSchoolCount)
        if canSelect then
          if not selectedSchoolMap[awakerSchool] then
            selectedSchoolMap[awakerSchool] = true
            selectedSchoolCount = selectedSchoolCount + 1
          end
          table.insert(selectedAwakerList, awakerTid)
          selectedAwakerMap[awakerTid] = true
        end
      end
    end
    model:SetSelectedAwakerList(selectedAwakerList)
  end
  self:CalculateSelectedType()
  model:Notify(NotifyId.OnAwakerFilterListChange, model:GetFilterType())
end

function AwakerFilterListController:CalculateSelectedType()
  local model = self._model
  model:RecalculateSelectedType()
end

function AwakerFilterListController:SaveFilter()
  local model = self._model
  local filterType = model:GetFilterType()
  model:SaveCurrentSelectionState(filterType)
  model:Notify(NotifyId.OnSaveAwakerFilter, filterType)
end

function AwakerFilterListController:ClearFilterData(filterType)
  local model = self._model
  if not model or not filterType then
    return
  end
  model:ClearFilterData(filterType)
  if filterType == CommonDefine.AwakerFilterType.CopyRecords then
    local mainKey = CommonDefine.ClientDataMainKey.AwakerFilter
    local subTbl = ClientDataUtils.GetSubTable(mainKey) or {}
    local toDel = {}
    for k in pairs(subTbl) do
      if k == _CopyRecordsPrefix .. "school" or k == _CopyRecordsPrefix .. "type" or string.match(k, "^" .. _CopyRecordsPrefix .. "tid_%d+$") then
        table.insert(toDel, k)
      end
    end
    if #toDel > 0 then
      ClientDataUtils.DelSubKeys(mainKey, toDel, true)
      ClientDataUtils.ReqSaveClientData(mainKey)
    end
  end
end

function AwakerFilterListController:GetDailyChallengeRankFilterAwakerMap()
  local model = self._model
  if not model then
    return nil
  end
  local total = model:GetTotalAwakerCount()
  local data = model:GetFilterData(CommonDefine.AwakerFilterType.DailyChallengeRank)
  if not data then
    return nil
  end
  local list = data.selectedAwakerList
  if not list or 0 == #list or #list == total then
    return nil
  end
  local awakerMap = {}
  for _, tid in ipairs(list) do
    awakerMap[tid] = 1
  end
  return awakerMap
end

return AwakerFilterListController
