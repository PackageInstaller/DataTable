local this = class("systemFiltertypeTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getFilterTable(tpl)
  return tpl.filterTable
end

function this:getFilterKey(tpl)
  return tpl.filterKey
end

function this:getFilterTypeName(tpl)
  return L_Config:provider(tpl.filterTypeName)
end

function this:getId(tpl)
  return tpl.id
end

function this:getFilterName(tpl)
  return tpl.filterName
end

function this:getFilterContent(tpl)
  return tpl.filterContent
end

function this:getMemo(tpl)
  return tpl.memo
end

function this:getIconDisplay(tpl)
  return tpl.iconDisplay
end

function this:getMaskType(tpl)
  return tpl.maskType
end

return this
