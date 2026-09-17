local this = class("dungeonExpTpl")

function this:init(config)
  self.data = config
  self.doorId2Tpl = {}
  for _, tpl in pairs(self.data) do
    local doorId = tpl.doorId
    self.doorId2Tpl[doorId] = tpl
  end
end

function this:getTplById(id)
  return self.data[id]
end

function this:getTplList()
  return self.data
end

function this:getDungeonName(tpl)
  return tpl.name
end

function this:getDungeonDropDesc(tpl)
  return tpl.drop
end

function this:getDungeonIntroduce(tpl)
  return tpl.introduce
end

function this:getDungeonDoorId(tpl)
  return tpl.doorId
end

function this:getTplByDoorId(doorId)
  return self.doorId2Tpl[doorId]
end

function this:getDungeonIcon(tpl)
  return tpl.dungeonItem
end

function this:getDungeonCard(tpl)
  return tpl.dungeonCard
end

return this
