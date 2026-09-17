local this = class("formationTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id] or self.data[999999]
end

function this:getFormationPositionOffset(tpl, index)
  local list = tpl.formationPositionOffset[index]
  return L_Vector3.new(list[1], list[2], list[3])
end

function this:getName(tpl)
  return tpl.name
end

function this:getUnitID(tpl)
  return tpl.unitID
end

function this:getFormationScale(tpl)
  return tpl.formationScale / 10000
end

function this:getFormationRotation(tpl, index)
  local offset = tpl.formationRotation[index]
  return L_Vector3.new(offset[1], offset[2], offset[3])
end

function this:getFormationCollider(tpl)
  local collider = tpl.formationCollider
  if table.isEmpty(collider) then
    collider = self.data[999999].collider
  end
  return C_Vector3(collider[1], collider[2], collider[3]), collider[4], collider[5]
end

function this:getFormationColliderRef(tpl, vec)
  local collider = tpl.formationCollider
  if table.isEmpty(collider) then
    collider = self.data[999999].collider
  end
  vec.x = collider[1]
  vec.y = collider[2]
  vec.z = collider[3]
  return collider[4], collider[5]
end

return this
