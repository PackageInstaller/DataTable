local UINAthDecomposeFilter = class("UINAthDecomposeFilter", UIBaseNode)
local base = UIBaseNode
local UINAthDcmpFilterGroup = require("Game.Arithmetic.Decompose.Filter.UINAthDcmpFilterGroup")
local UINAthDcmpFilterBasicGroup = require("Game.Arithmetic.Decompose.Filter.GroupItem.UINAthDcmpFilterBasicGroup")
local UINAthDcmpFilterDynamicGroup = require("Game.Arithmetic.Decompose.Filter.GroupItem.UINAthDcmpFilterDynamicGroup")
local UINAthDcmpFilterDynamicTitleGroup = require("Game.Arithmetic.Decompose.Filter.GroupItem.UINAthDcmpFilterDynamicTitleGroup")
local AthDcmpFilterUtil = require("Game.Arithmetic.Decompose.Filter.AthDcmpFilterUtil")
local itemNumPerLine = 3

function UINAthDecomposeFilter:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.groupItemDic = {}
  self.ui.scrollRect.onInstantiateItem = BindCallback(self, self.__OnNewItem)
  self.ui.scrollRect.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.ui.scrollRect.onReturnItem = BindCallback(self, self.__OnReturnItem)
  self.basicGroupItem = UINAthDcmpFilterBasicGroup.New()
  self.basicGroupItem:Init(self.ui.baseGroup)
  self.basicGroupItem:InitAthDcmpFilterBasicGroup(BindCallback(self, self._OnSelectBasicFilter))
  self.dyncItemPool = UIItemPool.New(UINAthDcmpFilterDynamicGroup, self.ui.dynamicGroup, false)
  self.dyncTitleItemPool = UIItemPool.New(UINAthDcmpFilterDynamicTitleGroup, self.ui.dynamicTitleGroup, false)
  self.ui.prefabHolder.gameObject:SetActive(false)
  self._GetItemFunc = BindCallback(self, self.GetAthDecomposeFilterGroupItem)
  self._RecycleItemFunc = BindCallback(self, self._ReturnGroupItem)
  self._IsAthDecomposeFilterSelectBasic = BindCallback(self, self.IsAthDecomposeFilterSelectBasic)
  self._IsSelectFunc = BindCallback(self, self._IsSelect)
  self.__onAthDataUpdate = BindCallback(self, self._OnAthDataUpdate)
  MsgCenter:AddListener(eMsgEventId.OnAthDataUpdate, self.__onAthDataUpdate)
end

function UINAthDecomposeFilter:SetAthDecomposeFilterFunc(changeFilterFunc)
  self.changeFilterFunc = changeFilterFunc
end

function UINAthDecomposeFilter:InitAthDecomposeFilter(ignoreInstalled)
  self.ignoreInstalled = ignoreInstalled
  self.basicGroupItem:ResetAthDcmpFilterBasicGroup()
  self.selectedFilterDic = {}
  self:_UpdOriginAthDataList()
  self:_UpdFilterAll()
end

function UINAthDecomposeFilter:_UpdOriginAthDataList()
  self.athDataListOrigin = PlayerDataCenter.allAthData:GetAllAthList(nil, self.ignoreInstalled)
end

function UINAthDecomposeFilter:_InitData()
  self.scrollDataList = {}
  table.insert(self.scrollDataList, {
    groupType = AthDcmpFilterUtil.FilterGroupType.Basic
  })
end

local function GetAttrInfo(attrId)
  local attrCfg = ConfigData.attribute[attrId]
  local isPercent = attrCfg.num_type == 2
  local showAttrId = attrId
  if attrCfg.merge_attribute ~= 0 then
    showAttrId = attrCfg.merge_attribute
    attrCfg = ConfigData.attribute[showAttrId]
  end
  local priority = attrCfg.attribute_priority
  priority = priority == 0 and CommonUtil.UInt32Max or priority
  return priority, isPercent, showAttrId
end

function UINAthDecomposeFilter:_RemoveInvalidFilter(filterType, valueDic)
  local selectDic = self.selectedFilterDic[filterType]
  if selectDic == nil then
    return
  end
  for filterValue, v in pairs(selectDic) do
    if valueDic[filterValue] == nil then
      self:_ChangeSelect(filterType, filterValue, false)
    end
  end
end

function UINAthDecomposeFilter:_ChangeDynamicData(athDataList)
  local mainAttriIdDic = {}
  local mainAttriIdList = {}
  local suitIdDic = {}
  local suitIdList = {}
  for k, athData in ipairs(athDataList) do
    local suitId = athData:GetAthSuit()
    if suitIdDic[suitId] == nil then
      suitIdDic[suitId] = true
      table.insert(suitIdList, suitId)
    end
    local mainAttrId = athData:GetAthMainAttrId(true)
    if mainAttriIdDic[mainAttrId] == nil then
      mainAttriIdDic[mainAttrId] = true
      table.insert(mainAttriIdList, mainAttrId)
    end
  end
  self:_RemoveInvalidFilter(AthDcmpFilterUtil.FilterType.Suit, suitIdDic)
  self:_RemoveInvalidFilter(AthDcmpFilterUtil.FilterType.MainAttri, mainAttriIdDic)
  table.sort(mainAttriIdList, function(attrIdA, attrIdB)
    local priorityA, isPercentA, showAttrIdA = GetAttrInfo(attrIdA)
    local priorityB, isPercentB, showAttrIdB = GetAttrInfo(attrIdB)
    if priorityA ~= priorityB then
      return priorityA < priorityB
    end
    if showAttrIdA ~= showAttrIdB then
      return showAttrIdA < showAttrIdB
    end
    if isPercentA ~= isPercentB then
      return isPercentB
    end
    return attrIdA < attrIdB
  end)
  table.sort(suitIdList, function(suitIdA, suitIdB)
    local suitCfgListA = ConfigData.ath_suit[suitIdA]
    local maxSuitNumA = suitCfgListA == nil and 0 or suitCfgListA[#suitCfgListA].num
    local suitCfgListB = ConfigData.ath_suit[suitIdB]
    local maxSuitNumB = suitCfgListB == nil and 0 or suitCfgListB[#suitCfgListB].num
    if maxSuitNumA ~= maxSuitNumB then
      return maxSuitNumA < maxSuitNumB
    end
    return suitIdA < suitIdB
  end)
  table.insert(self.scrollDataList, {
    groupType = AthDcmpFilterUtil.FilterGroupType.Title,
    tileIdx = 0,
    isEmpty = table.IsEmptyTable(suitIdList)
  })
  local groupData
  local groupNum = -1
  local allNum = math.ceil(#suitIdList / itemNumPerLine)
  for k, suitId in ipairs(suitIdList) do
    local curGroupNum = math.ceil(k / itemNumPerLine)
    if groupNum < curGroupNum then
      groupNum = curGroupNum
      groupData = {
        groupType = AthDcmpFilterUtil.FilterGroupType.Dynamic,
        filterType = AthDcmpFilterUtil.FilterType.Suit,
        filterValueList = {},
        isSelectFunc = self._IsSelectFunc,
        isLast = allNum == curGroupNum
      }
      table.insert(self.scrollDataList, groupData)
    end
    table.insert(groupData.filterValueList, suitId)
  end
  table.insert(self.scrollDataList, {
    groupType = AthDcmpFilterUtil.FilterGroupType.Title,
    tileIdx = 1,
    isEmpty = table.IsEmptyTable(mainAttriIdList)
  })
  groupData = nil
  groupNum = -1
  allNum = math.ceil(#mainAttriIdList / itemNumPerLine)
  for k, mainAttriId in ipairs(mainAttriIdList) do
    local curGroupNum = math.ceil(k / itemNumPerLine)
    if groupNum < curGroupNum then
      groupNum = curGroupNum
      groupData = {
        groupType = AthDcmpFilterUtil.FilterGroupType.Dynamic,
        filterType = AthDcmpFilterUtil.FilterType.MainAttri,
        filterValueList = {},
        isSelectFunc = self._IsSelectFunc,
        isLast = allNum == curGroupNum
      }
      table.insert(self.scrollDataList, groupData)
    end
    table.insert(groupData.filterValueList, mainAttriId)
  end
end

function UINAthDecomposeFilter:_RefillList(isRfill)
  self.ui.scrollRect.totalCount = #self.scrollDataList
  if isRfill then
    self.ui.scrollRect:RefillCells()
  else
    self.ui.scrollRect:RefreshCells()
  end
end

function UINAthDecomposeFilter:__OnNewItem(go)
  local item = UINAthDcmpFilterGroup.New()
  item:Init(go)
  item:SetAthDcmpFilterGroupFunc(self._GetItemFunc, self._RecycleItemFunc, self._IsAthDecomposeFilterSelectBasic)
  self.groupItemDic[go] = item
end

function UINAthDecomposeFilter:__OnChangeItem(go, index)
  local item = self.groupItemDic[go]
  if item == nil then
    error("Can't find item by gameObject")
    return
  end
  local scrollData = self.scrollDataList[index + 1]
  if scrollData == nil then
    error("Cant get scrollData by index : " .. tostring(index))
    return
  end
  item:InitAthDcmpFilterGroup(scrollData)
end

function UINAthDecomposeFilter:IsAthDecomposeFilterSelectBasic()
  for filterType = 1, AthDcmpFilterUtil.FilterTypeBaseMax do
    local selectDic = self.selectedFilterDic[filterType]
    if selectDic ~= nil and not table.IsEmptyTable(selectDic) then
      return true
    end
  end
  return false
end

local GetGroupItemFuncDic = {
  [AthDcmpFilterUtil.FilterGroupType.Basic] = function(self, scrollData)
    return self.basicGroupItem
  end,
  [AthDcmpFilterUtil.FilterGroupType.Title] = function(self, scrollData)
    local item = self.dyncTitleItemPool:GetOne()
    return item
  end,
  [AthDcmpFilterUtil.FilterGroupType.Dynamic] = function(self, scrollData)
    self._OnSelectDyncFilterFunc = self._OnSelectDyncFilterFunc or BindCallback(self, self._OnSelectDyncFilter)
    local item = self.dyncItemPool:GetOne()
    item:SetAthDcmpFilterDynamicGroupFunc(self._OnSelectDyncFilterFunc)
    return item
  end
}

function UINAthDecomposeFilter:GetAthDecomposeFilterGroupItem(scrollData)
  local getGroupItemFunc = GetGroupItemFuncDic[scrollData.groupType]
  if getGroupItemFunc == nil then
    error("Cant get getGroupItemFunc, groupType = " .. tostring(scrollData.groupType))
    return
  end
  return getGroupItemFunc(self, scrollData)
end

local ReturnGroupItemFuncDic = {
  [AthDcmpFilterUtil.FilterGroupType.Basic] = function(self, item)
  end,
  [AthDcmpFilterUtil.FilterGroupType.Title] = function(self, item)
    self.dyncTitleItemPool:HideOne(item)
  end,
  [AthDcmpFilterUtil.FilterGroupType.Dynamic] = function(self, item)
    self.dyncItemPool:HideOne(item)
  end
}

function UINAthDecomposeFilter:__OnReturnItem(go)
  local groupItem = self.groupItemDic[go]
  groupItem:RecycleAthDcmpFilterGroup()
end

function UINAthDecomposeFilter:_ReturnGroupItem(scrollData, groupItem)
  groupItem.transform:SetParent(self.ui.prefabHolder)
  local returnFunc = ReturnGroupItemFuncDic[scrollData.groupType]
  if returnFunc == nil then
    error("Cant get returnFunc, groupType = " .. tostring(scrollData.groupType))
    return
  end
  returnFunc(self, groupItem)
end

function UINAthDecomposeFilter:_FilterBasicFunc(athData)
  for filterType = 1, AthDcmpFilterUtil.FilterTypeBaseMax do
    local selectedDic = self.selectedFilterDic[filterType]
    local filterFunc = AthDcmpFilterUtil.FilterFunc[filterType]
    if selectedDic ~= nil and not table.IsEmptyTable(selectedDic) and filterFunc(athData, selectedDic) == false then
      return false
    end
  end
  return true
end

function UINAthDecomposeFilter:_FilterAllFunc(athData)
  for filterType = 1, AthDcmpFilterUtil.FilterType.Max - 1 do
    local selectedDic = self.selectedFilterDic[filterType]
    local filterFunc = AthDcmpFilterUtil.FilterFunc[filterType]
    if selectedDic ~= nil and not table.IsEmptyTable(selectedDic) and filterFunc(athData, selectedDic) == false then
      return false
    end
  end
  return true
end

function UINAthDecomposeFilter:_ChangeSelect(filterType, filterValue, isOn)
  local selectedDic = self.selectedFilterDic[filterType] or {}
  self.selectedFilterDic[filterType] = selectedDic
  if isOn then
    selectedDic[filterValue] = true
  else
    selectedDic[filterValue] = nil
  end
end

function UINAthDecomposeFilter:_IsSelect(filterType, filterValue)
  local selectedDic = self.selectedFilterDic[filterType]
  if selectedDic == nil then
    return false
  end
  return selectedDic[filterValue] ~= nil
end

function UINAthDecomposeFilter:_OnSelectBasicFilter(filterType, filterValue, isOn)
  self:_ChangeSelect(filterType, filterValue, isOn)
  self:_UpdFilterAll(true, true)
end

function UINAthDecomposeFilter:_UpdFilterAll(triggerChangeFilter, isClickFilter)
  local selectedBasic = self:IsAthDecomposeFilterSelectBasic()
  local athDataList = {}
  for k, athData in ipairs(self.athDataListOrigin) do
    if self:_FilterBasicFunc(athData) then
      table.insert(athDataList, athData)
    end
  end
  self:_InitData()
  self:_ChangeDynamicData(selectedBasic and athDataList or table.emptytable)
  self:_RefillList(not selectedBasic)
  if triggerChangeFilter then
    self:_ChangeFilter(selectedBasic, isClickFilter)
  end
end

function UINAthDecomposeFilter:_OnSelectDyncFilter(filterType, filterValue, isOn)
  self:_ChangeSelect(filterType, filterValue, isOn)
  self:_ChangeFilter(true, true)
end

function UINAthDecomposeFilter:_ChangeFilter(isSelectedBasic, isClickFilter)
  local filterFunc
  if isSelectedBasic then
    function filterFunc(athData)
      return self:_FilterAllFunc(athData)
    end
  end
  self.changeFilterFunc(filterFunc, isClickFilter)
end

function UINAthDecomposeFilter:_OnAthDataUpdate()
  self:_UpdOriginAthDataList()
  self:_UpdFilterAll(true)
end

function UINAthDecomposeFilter:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.OnAthDataUpdate, self.__onAthDataUpdate)
  for k, v in pairs(self.groupItemDic) do
    v:Delete()
  end
  self.basicGroupItem:Delete()
  self.dyncItemPool:DeleteAll()
  self.dyncTitleItemPool:DeleteAll()
  base.OnDelete(self)
end

return UINAthDecomposeFilter
