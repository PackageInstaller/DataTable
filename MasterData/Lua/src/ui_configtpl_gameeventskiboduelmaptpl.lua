local this = class("gameEventsKiboDuelMapTpl")

function this:init(config)
  self.data = config
end

function this:getData()
  return self.data
end

function this:getTplById(id)
  return self.data[id]
end

function this:getDesc(tpl)
  return L_Config:provider(tpl.desc)
end

function this:getId(tpl)
  return tpl.id
end

function this:getIcon(tpl)
  return tpl.icon
end

function this:getGameEventId(tpl)
  return tpl.gameEventId
end

return this
