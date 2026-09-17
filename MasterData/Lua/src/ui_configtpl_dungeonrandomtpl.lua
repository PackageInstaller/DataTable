local this = class("dungeonRandomTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getDungeonRandomName(tpl)
  return tpl.dungeonRandomName
end

function this:getId(tpl)
  return tpl.id
end

function this:getPathTemplate(tpl)
  return tpl.pathTemplate
end

function this:getPosition(tpl)
  local p = tpl.position
  return {
    x = p[1],
    y = p[2],
    z = p[3]
  }
end

function this:getRotation(tpl)
  local p = tpl.position
  return {
    x = p[4],
    y = p[5],
    z = p[6]
  }
end

function this:getPathPrefab(tpl)
  return tpl.pathPrefab
end

function this:getMainDungeon(tpl)
  return tpl.mainDungeon
end

function this:getPathGroup(tpl)
  return tpl.pathGroup[2]
end

function this:getRoadEnd(tpl)
  return tpl.pathGroup[1][2]
end

function this:getBossRoomDir(tpl)
  return tpl.bossRoomDir
end

function this:getBossRoomPrefab(tpl)
  return tpl.bossRoomPrefab
end

function this:getKeysInStr()
  local keys = {}
  for key, _ in pairs(self.data) do
    table.insert(keys, tostring(key))
  end
  return table.concat(keys, ", ")
end

return this
