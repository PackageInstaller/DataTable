local this = class("taskItemTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getCanUse(tpl)
  return tpl.canUse
end

function this:getUseType(tpl)
  return tpl.useType
end

function this:getBagType(tpl)
  return tpl.bagType
end

function this:getExistNum(tpl)
  return tpl.existNum
end

function this:getExistType(tpl)
  return tpl.existType
end

function this:getIcon(tpl)
  return tpl.icon
end

function this:getMaxNum(tpl)
  return tpl.maxNum
end

function this:getStackNum(tpl)
  return tpl.stackNum
end

function this:getId(tpl)
  return tpl.id
end

function this:getTag(tpl)
  local res = {}
  for i, v in ipairs(tpl.tag) do
    table.insert(res, L_Config:provider(v))
  end
  return res
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getRarity(tpl)
  return tpl.rarity
end

function this:getInBag(tpl)
  return tpl.inBag == 1
end

function this:getSpecialDesc(tpl)
  return L_Config:provider(tpl.specialDesc)
end

function this:getDesc(tpl)
  return L_Config:provider(tpl.desc)
end

return this
