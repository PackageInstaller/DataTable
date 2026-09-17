local this = class("petLearingEnumTpl")

function this:init(config)
  self.data = config
  self.enumData = {}
  for i, v in pairs(config) do
    if self.enumData[v.attributeEnum] == nil then
      self.enumData[v.attributeEnum] = v
    end
  end
end

function this:getAllTpl()
  return self.data
end

function this:getTplById(id)
  return self.data[id]
end

function this:getTplByEnumId(EnumId)
  return self.enumData[EnumId]
end

function this:getEnum(tpl)
  return L_Config:provider(tpl.attribute)
end

function this:getId(tpl)
  return tpl.id
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getEnumNum(tpl)
  return tpl.attributeEnum
end

function this:getAllEnum(needSort)
  if needSort then
    local sortData = {}
    for i, v in pairs(self.data) do
      table.insert(sortData, v)
    end
    table.sort(sortData, function(a, b)
      return a.order < b.order
    end)
    return sortData
  end
  return self.data
end

function this:getIcon(tpl)
  return tpl.icon
end

function this:getShiningIcon(tpl)
  return tpl.icon2
end

function this:getOrder(tpl)
  return tpl.order
end

function this:getNewIcon(tpl)
  return tpl.newIcon
end

function this:getIconColor(tpl)
  return tpl.color
end

return this
