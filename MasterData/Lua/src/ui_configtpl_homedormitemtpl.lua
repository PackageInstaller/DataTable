local this = class("homeDormItemTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getAllTpl()
  return self.data
end

function this:getName(tpl)
  return tpl.name
end

function this:getIcon(tpl)
  return tpl.icon
end

function this:getRarity(tpl)
  return tpl.rarity
end

function this:getDesc(tpl)
  return tpl.itemDesc
end

function this:getSpecialDesc(tpl)
  return tpl.itemDesc
end

function this:getWayList(tpl)
  local res = {}
  return res
end

return this
