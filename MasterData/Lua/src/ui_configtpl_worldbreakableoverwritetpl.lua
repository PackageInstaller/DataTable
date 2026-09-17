local this = class("worldBreakableOverwriteTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getTrackHud(tpl)
  return tpl.trackHud
end

return this
