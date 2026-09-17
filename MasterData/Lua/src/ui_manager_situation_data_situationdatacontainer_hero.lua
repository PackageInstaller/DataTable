local this = class("situationDataContainer_hero", require("ui.manager.situation.data.situationDataContainer"))
local _photoTpl = L_GameTpl:getPhotographParamTpl()

function this:define()
  self.dataType = L_Const.situationDataType.hero
  self.playerId = nil
end

function this:initData(param)
  self.data = require("ui.manager.situation.data.situationData_hero").new()
  self.data.heroConfigId = param.heroConfigId
  self.data.clothingId = param.clothingId
  self.data.pos = param.pos
  self.data.rot = param.rot
  self.data.actionId = param.actionId
  self.data.faceId = param.faceId
  self.data.actionTime = param.actionTime
end

function this:load(sceneData)
  self.sceneData = sceneData
  self.data.heroConfigId = L_GameUtil.normalizeHeroConfigId(self.data.heroConfigId, self.playerId)
  self.entityConfigId = self.data.heroConfigId
  self:createHero()
end

function this:release()
  local entityConfigId = self.entityConfigId or self.data.heroConfigId
  if not self.heroEntity and self.entityId then
    C_EntityManager.ClearUIHeroEntityByConfigId(entityConfigId, self.entityId)
  end
  if self.heroEntity then
    L_SituationManager:recycleHeroEntity(entityConfigId, self.hero.heroEntity)
  end
  self.hero = {}
  self.heroEntity = nil
  if self.expressionCtrl then
    self.expressionCtrl:destroy()
    self.expressionCtrl = nil
  end
  self.animator = nil
  self.entityId = nil
end

function this:createHero()
  local clothingId = self.data.clothingId
  if self.playerId == L_PlayerStore:getPlayerId() then
    clothingId = AzurWorld.heroMgr:GetUsingClothingId(0, self.data.heroConfigId)
    self.data.clothingId = clothingId
  end
  local entityId = L_SituationManager:createHeroEntity(self.data.heroConfigId, function(entity)
    self:heroLoadEnd(entity)
  end, self.playerId, clothingId)
  if entityId then
    self.entityId = entityId
  end
end

function this:heroLoadEnd(entity)
  local entity = entity
  local obj = entity.gameObject
  entity.gameObject.transform:SetParent(self.sceneData.heroRoot)
  local heroTrans = obj.transform
  L_Vector3.setLocalPos(heroTrans, self.data.pos)
  L_Vector3.setLocalRot(heroTrans, self.data.rot)
  self.hero = {
    heroEntity = entity,
    obj = obj,
    configId = self.data.heroConfigId
  }
  self.heroEntity = entity
  self.heroObj = obj
  self:stopAnimator()
  self:setAction(self.data.actionId, self.data.actionTime)
  self:setFace(self.data.faceId)
end

function this:createHero1()
  local heroConfigId = self.data.heroConfigId
  local isPlayerHero = heroConfigId == L_GameUtil.getDefaultHeroId(L_Const.sexType.male) or heroConfigId == L_GameUtil.getDefaultHeroId(L_Const.sexType.female)
  if isPlayerHero then
    local mainGuid = L_HeroStore:getDefaultHeroGuid()
    local heroInfo = L_HeroStore:getHero(mainGuid)
    heroConfigId = heroInfo.configId
  end
  local cache = L_SituationManager:getHeroEntityCache(heroConfigId)
  local entity, obj
  if cache then
    entity = cache
    obj = cache.gameObject
  else
    local unitId = L_GameUtil.getUnitIdByRole(self.data.clothingId or heroConfigId, L_Const.roleType.hero)
    local heroModelPath = ""
    if unitId then
      heroModelPath = L_GameUtil.getAvatarModelPathByUnitId(unitId, L_Const.avatarModelIndex.UnitModel)
    end
    obj = C_UIMgr.uiLoader:Spawn(heroModelPath)
    obj.name = string.concat("hero_", heroConfigId)
    obj:SetActive(true)
    obj.transform:SetParent(self.sceneData.heroRoot)
    entity = L_EntityManager:generateSimpleHero(heroConfigId, obj, isPlayerHero, L_Const.avatarAnimatorConfigIndex.world, nil, C_EEntityEntranceType.SituationDataContainer)
    if entity.biologyData then
      entity.biologyData.magicaClothActive = false
    end
  end
  local heroTrans = obj.transform
  L_Vector3.setLocalPos(heroTrans, self.data.pos)
  L_Vector3.setLocalRot(heroTrans, self.data.rot)
  self.hero = {
    heroEntity = entity,
    obj = obj,
    configId = heroConfigId
  }
  self.heroEntity = entity
  self.heroObj = obj
  self:stopAnimator()
  self:setAction(self.data.actionId, self.data.actionTime)
  self:setFace(self.data.faceId)
end

function this:stopAnimator()
  if self.heroEntity and self.heroEntity.csEntity ~= nil then
    self.animator = self.heroEntity:getAnimatorComponent(true)
    self.stateComponent = self.heroEntity:getStateComponent(true)
    self.animator:setSpeed(0)
  end
end

function this:setAction(actionId, time, stopCommand)
  self.data.actionId = actionId
  self.data.actionTime = time
  if not self.animator then
    return
  end
  if stopCommand then
    return
  end
  local animName = _photoTpl:getTplById(actionId).param
  local running = self.animator.animator:GetCurrentAnimatorStateInfo(0).name
  if animName ~= running then
    self.stateComponent:doSingleAction(animName, true, function()
    end, true, time, true, actionId, true)
  end
  self.animator:setSpeed(0)
  local state = self.animator:getState(animName)
  local animLen = self.animator.animator:GetAnimatorStateLength(animName)
  local dt = (time - math.min(state.normalizedTime, 1)) * animLen
  C_MediaPackUtility.ChangeEffectSpeed(self.heroEntity.csEntity, 1, true)
  C_MediaPackUtility.AnimatorTimelineEvaluate(self.heroEntity.csEntity, dt)
  C_MediaPackUtility.ChangeEffectSpeed(self.heroEntity.csEntity, 0, false)
end

function this:setFace(faceId)
  self.data.faceId = faceId
  self:playFace(faceId)
end

function this:playFace(faceId)
  if not self.expressionCtrl then
    self.expressionCtrl = require("ui.pages.photo.photoExpressionController").new()
    self.expressionCtrl:setTarget(self.heroEntity and self.heroEntity.csEntity or nil)
  end
  if faceId == L_Const.photoParam.defaultFace then
    self.expressionCtrl:stop()
  else
    local tpl = _photoTpl:getTplById(faceId)
    local param = _photoTpl:getParam(tpl)
    local animNames = string.split(param, "|")
    self.expressionCtrl:play(animNames[2], false)
  end
end

function this:setLocalPosition(v3)
  local localPos = v3
  if self.heroEntity and self.heroEntity.gameObject then
    L_Vector3.setLocalPos(self.heroEntity.gameObject.transform, localPos)
  end
  self.data.pos = L_Vector3.new(localPos.x, localPos.y, localPos.z)
end

function this:setRotation(v3)
  if self.heroEntity and self.heroEntity.gameObject then
    L_Vector3.setRot(self.heroEntity.gameObject.transform, v3)
  end
  self.data.rot = L_Vector3.new(v3.x, v3.y, v3.z)
end

return this
