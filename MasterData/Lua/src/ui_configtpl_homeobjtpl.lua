local this = class("homeObjTpl")

function this:init(cfg)
  self.config = cfg
end

function this:getTplById(id)
  return self.config[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getObjName(tpl)
  return tpl.objName
end

function this:getObjResouce(tpl)
  return tpl.objResouce
end

function this:getObjPath(tpl)
  return tpl.objResouce .. ".prefab"
end

function this:getObjIcon(tpl)
  return tpl.objIcon
end

function this:getObjDesc(tpl)
  return tpl.objDesc
end

function this:getObjSize(tpl)
  return tpl.objSize
end

function this:getHomeItemSize(tpl)
  if table.isEmpty(tpl.homeItemSize) then
    return
  end
  local vector2 = C_Vector2(tpl.homeItemSize[1], tpl.homeItemSize[2])
  return vector2
end

function this:getObjOffset(tpl)
  if table.isEmpty(tpl.objOffset) then
    return C_Vector2.zero
  end
  local vector2 = C_Vector2(tpl.objOffset[1], tpl.objOffset[2])
  return vector2
end

function this:getObjNameOffset(tpl)
  if table.isEmpty(tpl.objNameOffset) then
    return {
      0,
      1.65,
      0
    }
  end
  return tpl.objNameOffset
end

function this:getWidth(tpl)
  if table.isEmpty(tpl.homeItemSize) then
    return
  end
  return tpl.homeItemSize[1]
end

function this:getHeight(tpl)
  if table.isEmpty(tpl.homeItemSize) then
    return
  end
  return tpl.homeItemSize[2]
end

function this:getPetAreaInfo(tpl)
  if table.isEmpty(tpl.petAreaSize) then
    return 0, 0, 0, 0, 0
  end
  return tpl.petAreaSize[1], tpl.petAreaSize[2], tpl.petAreaSize[3], tpl.petAreaSize[4], tpl.petAreaSize[5]
end

function this:getBuildingLens(tpl)
  return tpl.buildingLens
end

return this
