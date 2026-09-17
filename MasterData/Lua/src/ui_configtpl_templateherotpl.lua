local this = class("templateHeroTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getType(tpl)
  return tpl.type
end

function this:getAscension(tpl)
  return tpl.ascension
end

function this:getBaseAttribute(tpl)
  return tpl.baseAttribute
end

function this:getBaseAttributeByRankAndLevel(rank, level)
  local id = level
  local tpl = self:getTplById(id)
  if not tpl then
    errorf("template_hero缺少ID: " .. id .. "的配置， level: " .. level)
    tpl = self:getTplById(1)
  end
  return tpl.baseAttribute
end

function this:getLevel(tpl)
  return tpl.level
end

return this
