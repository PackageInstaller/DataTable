local this = class("worldMapEffectTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getConfig()
  return self.data
end

function this:getPosition(tpl)
  return tpl.position
end

function this:getWorldId(tpl)
  return tpl.worldId
end

function this:getOpenCondi(tpl)
  return tpl.openCondi
end

function this:getCloseCondi(tpl)
  return tpl.closeCondi
end

function this:getEffect(tpl)
  return tpl.effect
end

function this:getMiniEffect(tpl)
  return tpl.miniEffect
end

function this:getWorldEffectsId(worldId)
  local ids = {}
  for id, tpl in pairs(self.data) do
    if tpl.worldId == worldId then
      table.insert(ids, id)
    end
  end
  return ids
end

return this
