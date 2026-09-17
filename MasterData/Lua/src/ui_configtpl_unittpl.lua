local this = class("unitTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getWalkSpeed(tpl)
  return tpl.walkSpeed
end

function this:getModelSpeed(tpl)
  return tpl.modelSpeed
end

function this:getFastSpeed(tpl)
  return tpl.speedRunSpeed
end

function this:getYLock(tpl)
  return tpl.yLock
end

function this:getSpStopStartFrame(tpl)
  return tpl.spStopStartFrame
end

function this:getColliderId(tpl)
  return tpl.colliderId
end

function this:getColliderList(tpl)
  return nil
end

function this:getColliderHeightById(id)
  local tpl = self:getTplById(id)
  if tpl then
    return self:getColliderHeight(tpl)
  end
end

function this:getColliderHeight(tpl)
  local height = tpl.bloodBarPos[2]
  return height
end

function this:getBloodBarNodeById(id)
  local tpl = self:getTplById(id)
  if tpl then
    return self:getBloodBarNode(tpl)
  else
    return string.empty
  end
end

function this:getBloodBarNode(tpl)
  return tpl.bloodBarNode
end

function this:getId(tpl)
  return tpl.id
end

function this:getFallowCamShift(tpl)
  return tpl.fallowCamShift
end

function this:getSwimmingFollowCamShift(tpl)
  return tpl.swimmingFollowCamShift
end

function this:getFollowFace(tpl)
  return tpl.focusCamShift
end

function this:getFloatingTextRange(tpl)
  return tpl.floatingTextRange
end

function this:getStepStartTime(tpl)
  return tpl.stepStartTime
end

function this:getEffectScale(tpl)
  return tpl.effectScale
end

function this:getPhotoPose(tpl)
  return tpl.photoPose
end

function this:getPhotoExpr(tpl)
  return tpl.photoExpr
end

function this:getAnimatorConfig(tpl, index)
  return tpl.animatorConfig[index]
end

function this:getRootMotionPath(tpl)
  local path = self:getAnimatorConfig(tpl)
  return path
end

function this:getSpecialParm(tpl)
  return tpl.specialParm
end

function this:getModel(tpl, index, isSpecial)
  local hash = tpl.model[index]
  if not isSpecial or isSpecial == 0 then
  elseif tpl.specialParm then
    local replaceStr = tpl.specialParm[isSpecial]
    hash = string.gsub(hash, ".prefab", "_" .. replaceStr .. ".prefab")
  end
  local path = L_Config:getPathByHash(hash)
  return path
end

function this:getUnitModel(tpl)
  return self:getModel(tpl, L_Const.avatarModelIndex.UnitModel)
end

function this:getPetIcon(tpl)
  local petIcon = L_Config:getPathByHash(tpl.petIcon)
  if string.isEmpty(petIcon) then
    return "UI/Atlas/Item/tex_icon_pet_default.png"
  end
  return petIcon
end

function this:getAnimId(tpl)
  local animId = tpl.animId
  return animId
end

function this:getPetModelScale(tpl)
  return tpl.petModelScale[1]
end

function this:getModelScale(tpl)
  return tpl.modelScale[1] or 1
end

return this
