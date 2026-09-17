local this = class("kiboDuelPvpTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getMap(tpl)
  return tpl.art
end

return this
