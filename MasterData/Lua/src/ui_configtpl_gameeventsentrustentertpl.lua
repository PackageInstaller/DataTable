local this = class("gameEventsEntrustEnterTpl")

function this:init(config)
  self.data = config
end

function this:getEventEntrusts()
  return self.data
end

function this:getTplById(id)
  return self.data[id]
end

function this:getButtonIcon(tpl)
  return tpl.buttonIcon
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getArtName(tpl)
  return tpl.artName
end

function this:getGameEventId(tpl)
  return tpl.gameEventId
end

function this:getId(tpl)
  return tpl.id
end

return this
