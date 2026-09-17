local this = class("homeBuffCountTpl")

function this:init(config)
  self.data = config
  self._type2Confs = {}
  for _, conf in pairs(config) do
    self._type2Confs[conf.type] = self._type2Confs[conf.type] or {}
    table.insert(self._type2Confs[conf.type], conf)
  end
  for _, tpls in pairs(self._type2Confs) do
    table.sort(tpls, function(a, b)
      return a.id < b.id
    end)
  end
end

function this:getTplById(id)
  return self.data[id]
end

function this:getDescKey(tpl)
  return tpl.desc
end

function this:getBuffId(tpl)
  return tpl.buffId
end

function this:getId(tpl)
  return tpl.id
end

function this:getCondition(tpl)
  return tpl.condition
end

function this:getTplsByType(type)
  return self._type2Confs[type] or {}
end

return this
