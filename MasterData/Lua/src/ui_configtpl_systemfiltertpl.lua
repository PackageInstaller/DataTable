local this = class("systemFilterTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getFilterConfig(tpl)
  return tpl.filterConfig
end

function this:getGroupName(tpl, index)
  return L_Config:provider(tpl.groupName[index])
end

function this:getFilterComponents(tpl)
  return tpl.filterComponents
end

function this:getSortType(tpl)
  return tpl.sortType
end

function this:getSortPicks(tpl)
  return tpl.sortPicks
end

function this:getSolidSortKey(tpl)
  return tpl.solidSortKey
end

function this:getSubSortKey(tpl)
  return tpl.subSortKey
end

function this:getSortComponents(tpl)
  return tpl.sortComponents
end

function this:getInterfaceName(tpl)
  return tpl.interfaceName
end

function this:getIsReverseOpen(tpl)
  return tpl.isReverseOpen == 1
end

function this:getIsAllConcluded(tpl)
  return tpl.isAllConcluded
end

function this:getSortPicksLimit(tpl)
  return tpl.sortPicksLimit
end

return this
