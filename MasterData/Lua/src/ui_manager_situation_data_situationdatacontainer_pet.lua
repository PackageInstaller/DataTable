local this = class("situationDataContainer_pet", require("ui.manager.situation.data.situationDataContainer"))
local _photoTpl = L_GameTpl:getPhotographParamTpl()

function this:define()
  self.dataType = L_Const.situationDataType.pet
end

function this:initData(param)
  self.data = require("ui.manager.situation.data.situationData_pet").new()
  self.data.petGuid = param.petGuid
  self.data.petConfigId = param.petConfigId
  self.data.pos = param.pos
  self.data.rot = param.rot
  self.data.actionId = param.actionId
  self.data.faceId = param.faceId
  self.data.actionTime = param.actionTime
  self.data.specialParam = param.specialParam
  self.data.flashParam = param.flashParam
  self.data.skinId = param.skinId
  self.data.starColorId = param.starColorId
end

function this:load(sceneData)
  self.sceneData = sceneData
  self:createPet()
end

function this:release()
  if not self.petEntity and self.entityId then
    C_EntityManager.RemoveEntityWithEntityId(self.entityId)
  end
  if self.petEntity then
    L_SituationManager:recyclePetEntity(self.data.petGuid, self.petEntity)
  end
  self.pet = {}
  self.petEntity = nil
  self.animator = nil
  self.entityId = nil
end

function this:createPet()
  local entityId = L_SituationManager:createPetEntity(self.data.petGuid, self.data.petConfigId, self.data.specialParam, self.data.flashParam, self.data.skinId, self.data.starColorId, function(entity)
    self:petLoadEnd(entity)
  end)
  if entityId then
    self.entityId = entityId
  end
end

function this:petLoadEnd(entity)
  local entity = entity
  local obj = entity.gameObject
  entity.gameObject.transform:SetParent(self.sceneData.petRoot)
  local trans = obj.transform
  L_Vector3.setLocalPos(trans, self.data.pos)
  L_Vector3.setLocalRot(trans, self.data.rot)
  self.pet = {
    petEntity = entity,
    obj = obj,
    configId = self.data.petConfigId
  }
  self.petEntity = entity
  self.petObj = obj
  self:stopAnimator()
  self:setAction(self.data.actionId, self.data.actionTime)
  self:setFace(self.data.faceId)
end

function this:stopAnimator()
  if self.petEntity then
    self.animator = self.petEntity:getAnimatorComponent(true)
    self.stateComponent = self.petEntity:getStateComponent(true)
    self.animator:setSpeed(0)
  end
end

function this:setAction(actionId, time)
  self.data.actionId = actionId
  self.data.actionTime = time
  if not self.animator then
    return
  end
  local animName = _photoTpl:getTplById(actionId).param
  self.stateComponent:doSingleAction(animName, true, function()
  end, true, time, true, actionId, true)
  self.animator:setSpeed(0)
  local state = self.animator:getState(animName)
  local animLen = self.animator.animator:GetAnimatorStateLength(animName)
  local dt = (time - math.min(state.normalizedTime, 1)) * animLen
  C_MediaPackUtility.AnimatorTimelineEvaluate(self.petEntity.csEntity, dt)
  C_MediaPackUtility.ChangeEffectSpeed(self.petEntity.csEntity, 0, false)
end

function this:setFace(faceId)
  self.data.faceId = faceId
  self:playFace(faceId)
end

function this:playFace(faceId)
  local tpl = _photoTpl:getTplById(faceId)
  local faceIndex = _photoTpl:getParam(tpl)
  self.petEntity:playExpression(faceIndex)
end

function this:setLocalPosition(v3)
  local localPos = v3
  if self.petEntity and self.petEntity.gameObject then
    L_Vector3.setLocalPos(self.petEntity.gameObject.transform, localPos)
  end
  self.data.pos = L_Vector3.new(localPos.x, localPos.y, localPos.z)
end

function this:setRotation(v3)
  if self.petEntity and self.petEntity.gameObject then
    L_Vector3.setRot(self.petEntity.gameObject.transform, v3)
  end
  self.data.rot = L_Vector3.new(v3.x, v3.y, v3.z)
end

return this
