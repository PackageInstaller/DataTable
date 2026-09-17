local this = class("sortFilterManager")
table.merge(this, require("ui.manager.sortFilter.sortFilterManager_sortKeyGetFunc"))
table.merge(this, require("ui.manager.sortFilter.sortFilterManager_filterKeyGetFunc"))
local _systemUnlockTpl = L_GameTpl:getSystemUnlockTpl()
local _systemFilterTpl = L_GameTpl:getSystemFilterTpl()
local _systemFiltertypeTpl = L_GameTpl:getSystemFiltertypeTpl()

function this:createSortFilter(systemId, sortCallback, filterCallback)
  return require("ui.manager.sortFilter.sortFilter").new(systemId, sortCallback, filterCallback)
end

function this:getAllFilterContentTplByType(typeId)
  local tpl_filterType = _systemFiltertypeTpl:getTplById(typeId)
  local filterContent = _systemFiltertypeTpl:getFilterContent(tpl_filterType)
  local res = {}
  if table.isEmpty(filterContent) then
    res = L_Config:getConfigDirectly(_systemFiltertypeTpl:getFilterTable(tpl_filterType))
  else
    for __, v in ipairs(filterContent) do
      local config = L_Config:getConfigDirectly(_systemFiltertypeTpl:getFilterTable(tpl_filterType), v)
      table.insert(res, config)
    end
  end
  return res
end

function this:getNotDefaultFirstSortKey(systemId, sortKeyList)
  local tpl_system = _systemUnlockTpl:getTplById(systemId)
  local sortFilterId = _systemUnlockTpl:getFilterConfig(tpl_system)
  local tpl_sortFilter = _systemFilterTpl:getTplById(sortFilterId)
  local solidSortKey = _systemFilterTpl:getSolidSortKey(tpl_sortFilter)
  return sortKeyList[#solidSortKey + 1]
end

function this:getConstSortKeyNum(systemId)
  local solidSortKeyNum, subSortKeyNum = 0, 0
  local tpl_system = _systemUnlockTpl:getTplById(systemId)
  local sortFilterId = _systemUnlockTpl:getFilterConfig(tpl_system)
  local tpl_sortFilter = _systemFilterTpl:getTplById(sortFilterId)
  local solidSortKey = _systemFilterTpl:getSolidSortKey(tpl_sortFilter)
  local subSortKey = _systemFilterTpl:getSubSortKey(tpl_sortFilter)
  solidSortKeyNum = solidSortKey and #solidSortKey or 0
  subSortKeyNum = subSortKey and #subSortKey or 0
  return solidSortKeyNum, subSortKeyNum
end

function this:getConstSortKeySet(systemId)
  local result = {}
  local tpl_system = _systemUnlockTpl:getTplById(systemId)
  local sortFilterId = _systemUnlockTpl:getFilterConfig(tpl_system)
  local tpl_sortFilter = _systemFilterTpl:getTplById(sortFilterId)
  local solidSortKey = _systemFilterTpl:getSolidSortKey(tpl_sortFilter) or {}
  local subSortKey = _systemFilterTpl:getSubSortKey(tpl_sortFilter) or {}
  for __, v in ipairs(solidSortKey) do
    result[v] = true
  end
  for __, v in ipairs(subSortKey) do
    result[v] = true
  end
  return result
end

return this
