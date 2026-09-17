local this = class("sortFilter")
local _systemSorttypeTpl = L_GameTpl:getSystemSorttypeTpl()
local _systemUnlockTpl = L_GameTpl:getSystemUnlockTpl()
local _systemFilterTpl = L_GameTpl:getSystemFilterTpl()

function this:ctor(systemId, sortCallback, filterCallback)
  self.systemId = systemId
  self.sortKeyList = self:_getDefaultSortKeyListBySystemId()
  self.filterKeyDic = self:_getDefaultFilterKeyDicBySystemId()
  self.isSortReverse = false
  
  function self.sortCallback(sortKeyList, isReverse)
    self.sortKeyList = sortKeyList
    self.isSortReverse = isReverse
    if sortCallback then
      sortCallback()
    end
  end
  
  function self.filterCallback(filterKeyDic)
    self.filterKeyDic = filterKeyDic
    if filterCallback then
      filterCallback()
    end
  end
end

function this:bindModule(moduleSortFilter)
  moduleSortFilter:setData(self)
end

function this:resetSortFiter(moduleSortFilter)
  self.sortKeyList = self:_getDefaultSortKeyListBySystemId()
  self.filterKeyDic = self:_getDefaultFilterKeyDicBySystemId()
  self.isSortReverse = false
  moduleSortFilter:setData(self)
end

function this:sortFilterList(list)
  for i, cell in pairs(list) do
    if not table.isEmpty(self.sortKeyList) then
      table.merge(cell, L_SortFilterManager:getSortKey(cell.itemType, self.sortKeyList, cell.itemId, cell.guid))
    end
    if not table.isEmpty(self.filterKeyDic) then
      table.merge(cell, L_SortFilterManager:getFilterKey(cell.itemType, self.filterKeyDic, cell.itemId, cell.guid))
    end
  end
  self:_multipleFilterByTypeDic(list)
  self:_multipleSortByTypeList(list)
end

function this:sortList(list)
  for i, cell in pairs(list) do
    if not table.isEmpty(self.sortKeyList) then
      table.merge(cell, L_SortFilterManager:getSortKey(cell.itemType, self.sortKeyList, cell.itemId, cell.guid))
    end
  end
  self:_multipleSortByTypeList(list)
end

function this:filterList(list)
  for i, cell in pairs(list) do
    if not table.isEmpty(self.filterKeyDic) then
      table.merge(cell, L_SortFilterManager:getFilterKey(cell.itemType, self.filterKeyDic, cell.itemId, cell.guid))
    end
  end
  self:_multipleFilterByTypeDic(list)
end

function this:_multipleSortByTypeList(list)
  if table.isEmpty(self.sortKeyList) then
    return
  end
  local sortKeyList = {}
  local constSortKeySet = {}
  if self.isSortReverse then
    constSortKeySet = L_SortFilterManager:getConstSortKeySet(self.systemId)
  end
  for i, type in ipairs(self.sortKeyList) do
    local tpl_sortType = _systemSorttypeTpl:getTplById(type)
    local keyType, keyPara = table.unpack(_systemSorttypeTpl:getSortPara(tpl_sortType))
    local isAsc = _systemSorttypeTpl:getIsAscending(tpl_sortType)
    if self.isSortReverse and not constSortKeySet[type] then
      isAsc = not isAsc
    end
    local key = isAsc and "-" or ""
    local sortTypeName = self:getSortTypeKeyName(keyType)
    if keyType == L_SortFilterConst.SortType.EquipBattleInfo then
      key = string.concat(key, sortTypeName, keyPara)
    else
      key = string.concat(key, sortTypeName)
    end
    table.insert(sortKeyList, key)
  end
  L_CommonUtil.multipleSortByKey(list, sortKeyList)
end

function this:_multipleFilterByTypeDic(list)
  if table.isEmpty(self.filterKeyDic) then
    return
  end
  if self.filterKeyDic[L_SortFilterConst.FilterType.All] then
    return
  end
  for typeId, idList in pairs(self.filterKeyDic) do
    if table.isEmpty(idList) then
      self.filterKeyDic[typeId] = nil
    end
  end
  local count = #list
  for i = count, 1, -1 do
    local item = list[i]
    if item ~= nil then
      local success = true
      for typeId, idList in pairs(self.filterKeyDic) do
        local keyName = self:getFilterTypeKeyName(typeId)
        if keyName and success then
          success = item[keyName]
        end
        if not success then
          break
        end
      end
      if not success then
        table.remove(list, i)
      end
    end
  end
end

function this:_getDefaultSortKeyListBySystemId()
  local tpl_sys = _systemUnlockTpl:getTplById(self.systemId)
  local sortFilterId = _systemUnlockTpl:getFilterConfig(tpl_sys)
  if math.isEmpty(sortFilterId) then
    error(string.format("系统%s没配排序筛选组件", self.systemId))
    return
  end
  local tpl_sortFilter = _systemFilterTpl:getTplById(sortFilterId)
  local sortComponent = _systemFilterTpl:getSortComponents(tpl_sortFilter)
  local sortTypeData = _systemFilterTpl:getSortType(tpl_sortFilter)
  local res = {}
  local solidSortKey = _systemFilterTpl:getSolidSortKey(tpl_sortFilter)
  table.fill(res, solidSortKey)
  if sortComponent == L_SortFilterConst.SortFilterStyle.Dropdown then
    if sortTypeData and sortTypeData[1] then
      local groupData = sortTypeData[1]
      if groupData and groupData[1] then
        table.insert(res, groupData[1])
      end
    end
  elseif sortComponent == L_SortFilterConst.SortFilterStyle.Bar or sortComponent == L_SortFilterConst.SortFilterStyle.Button then
    local defaultSortPicks = _systemFilterTpl:getSortPicks(tpl_sortFilter) or {}
    local sortPicksLimit = _systemFilterTpl:getSortPicksLimit(tpl_sortFilter)
    for i, sortKey in ipairs(defaultSortPicks) do
      if i <= sortPicksLimit then
        table.insert(res, sortKey)
      end
    end
  end
  local subSortKey = _systemFilterTpl:getSubSortKey(tpl_sortFilter)
  return table.fill(res, subSortKey)
end

function this:_getDefaultFilterKeyDicBySystemId()
  local tpl_sys = _systemUnlockTpl:getTplById(self.systemId)
  local tpl_sortFilter = _systemFilterTpl:getTplById(_systemUnlockTpl:getFilterConfig(tpl_sys))
  local filterComponent = _systemFilterTpl:getFilterComponents(tpl_sortFilter)
  if filterComponent == L_SortFilterConst.SortFilterStyle.Dropdown then
    return {
      [L_SortFilterConst.FilterType.All] = L_SortFilterConst.FilterId.All
    }
  elseif filterComponent == L_SortFilterConst.SortFilterStyle.Bar or filterComponent == L_SortFilterConst.SortFilterStyle.Button then
    return {}
  end
end

function this:getFilterTypeKeyName(filterTypeId)
  return L_SortFilterConst.FilterTypeKeyName[filterTypeId]
end

function this:getSortTypeKeyName(sortTypeId)
  return L_SortFilterConst.SortTypeKeyName[sortTypeId]
end

return this
