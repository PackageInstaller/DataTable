local this = class("kiboDuelMapTpl")

function this:init(config)
  self.data = config
end

function this:getData()
  return self.data
end

function this:getTplById(id)
  return self.data[id]
end

function this:getWorldBorthPos(tpl)
  return tpl.worldBorthPos
end

function this:getKiboTower(tpl)
  return tpl.kiboTower
end

function this:getNpcPos(tpl)
  return tpl.npcPos
end

function this:getWorldAreaId(tpl)
  return tpl.worldAreaId
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getMapPic(tpl)
  return tpl.mapPic
end

function this:getPrefabID(tpl)
  return tpl.prefabID
end

function this:getArt(tpl)
  return tpl.art
end

function this:getId(tpl)
  return tpl.id
end

function this:getWorldBorthPos2(tpl)
  return tpl.worldBorthPos2
end

function this:getDuelPosGroup(tpl)
  return tpl.duelPosGroup
end

function this:getCollisionID(tpl)
  return tpl.collisionID
end

function this:getDuelArea(tpl)
  return tpl.duelArea
end

function this:getNeutralArea(tpl)
  return tpl.neutralArea
end

function this:getCameraAnglePlane(tpl)
  return tpl.cameraAnglePlane
end

return this
