local this = class("systemSorttypeTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getMemo(tpl)
  return tpl.memo
end

function this:getSortPara(tpl)
  return tpl.sortPara
end

function this:getIsAscending(tpl)
  return tpl.isAscending == 1
end

function this:getId(tpl)
  return tpl.id
end

function this:getSortTypeName(tpl)
  return L_Config:provider(tpl.sortTypeName)
end

function this:getIcon(tpl)
  return tpl.optionIcon
end

function this:getMaskType(tpl)
  return tpl.maskType
end

return this
