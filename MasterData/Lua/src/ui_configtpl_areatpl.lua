local this = class("areaTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getAreaId(tpl)
  return tpl.areaId
end

function this:getAreaName(tpl)
  return L_Config:provider(tpl.areaName)
end

function this:getIcon(tpl)
  local icon = L_Config:getPathByHash(tpl.icon)
  return icon
end

function this:getUnlockCondition(tpl)
  return tpl.unlockCondition
end

function this:getCoordinate(tpl)
  return tpl.coordinate
end

function this:getMapExpand(tpl)
  return tpl.mapExpand
end

function this:getMapResource(tpl)
  local resource = L_Config:getPathByHash(tpl.mapResource)
  if string.isEmpty(resource) then
    return "UI/Texture/AreaMap/tex_areamap_bg_xysg.png"
  end
  return resource
end

function this:getSortId(tpl)
  return tpl.sortID
end

function this:getWorldAreaId(tpl)
  return tpl.worldAreaId
end

function this:getSceneId(tpl)
  return tpl.sceneId
end

function this:getConfig()
  return self.data
end

return this
