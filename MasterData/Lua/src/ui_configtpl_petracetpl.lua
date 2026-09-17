local this = class("petRaceTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getRaceType(tpl)
  return L_Config:provider(tpl.raceType)
end

function this:getID(tpl)
  return tpl.ID
end

return this
