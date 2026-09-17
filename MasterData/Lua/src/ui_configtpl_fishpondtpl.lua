local this = class("fishPondTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getDescription(tpl)
  return L_Config:provider(tpl.description)
end

function this:getId(tpl)
  return tpl.id
end

function this:getFishPondName(tpl)
  return L_Config:provider(tpl.fishPondName)
end

function this:getFishGroup(tpl)
  return tpl.fishGroup
end

function this:getFishGroupTime(tpl)
  return tpl.fishGroupTime
end

function this:getCameraAngleVer(tpl)
  return tpl.cameraAngle
end

function this:getCameraDistance(tpl)
  return tpl.cameraDistance
end

function this:getCameraAngleHor(tpl)
  return tpl.cameraHeight
end

function this:getWorldMapObjId(tpl)
  return tpl.worldMapObject
end

function this:getInteractiveObject(tpl)
  return tpl.interactiveObject
end

return this
