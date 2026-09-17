local this = class("situationManager")
local _scenePrefabPath = "Program/UIScene/Situation/pre_SituationScene.prefab"

function this:ctor()
  self.guidIndex = 1
  self.curSolution = nil
  self._undoNotify = handler(self, self.onUndoSystemChanged)
  self.situationTabTpl = L_GameTpl:getSituationTabTpl()
  self.countLimit = {}
  for i, v in pairs(self.situationTabTpl.data) do
    self.countLimit[self.situationTabTpl:getTabId(v)] = self.situationTabTpl:getNumber(v)
  end
  self.rangeLimit = 10
end

function this:getGuid()
  local r = self.guidIndex
  self.guidIndex = self.guidIndex + 1
  return r
end

function this:loadScene(stampRoot)
  local sceneObj = L_ResPool:syncGameObject(_scenePrefabPath, C_LuaUtility.GetRootNode())
  local sceneObjTrans = sceneObj.transform
  L_Vector3.setPos(sceneObjTrans, C_UIMgr.SceneLoadDefaultPosition)
  local sceneData = {
    camera = sceneObjTrans:Find("camera"):GetComponent(typeof(C_CinemachineVirtualCamera)),
    heroRoot = sceneObjTrans:Find("HeroRoot"),
    petRoot = sceneObjTrans:Find("PetRoot"),
    objRoot = sceneObjTrans:Find("ObjRoot"),
    lookAtRoot = sceneObjTrans:Find("lookAtPos"),
    envRoot = sceneObjTrans:Find("EnvRoot"),
    stampRoot = stampRoot
  }
  return sceneData, sceneObj
end

function this:enterEdit(solution)
  self:createUndoSystem()
  if not self.curSolution or self.curSolution ~= solution then
  end
  self.curSolution = solution
  solution:record()
end

function this:exitEdit()
  self.loadingCount = 0
  local hasUndo = false
  if self.undoSystem then
    hasUndo = self.undoSystem:hasUndo()
  end
  self:clearUndoSystem()
  if self.curSolution then
    self.curSolution:resetCamera()
    self.curSolution:revert()
    self.curSolution = nil
  end
end

function this:createUndoSystem()
  self:clearUndoSystem()
  if not self.undoSystem then
    local sys = require("modules.common.undo.undoSystem").new({
      maxCount = 10,
      name = "situationUndoSystem"
    })
    self.undoSystem = sys
    sys:bindNotify(self._undoNotify)
  end
end

function this:clearUndoSystem()
  if self.undoSystem then
    self.undoSystem:clear()
  end
end

function this:onUndoSystemChanged()
  L_SituationStore:call(L_SituationStore.event.undoCountChanged)
end

function this:undo()
  if self.undoSystem then
    self.undoSystem:undo()
  end
end

function this:redo()
  if self.undoSystem then
    self.undoSystem:redo()
  end
end

function this:shallow_copy(orig)
  local copy = {}
  for k, v in pairs(orig) do
    copy[k] = v
  end
  return copy
end

function this:createHeroEntity(configId, callBack, playerId, clothingId)
  self.allHeroEntity = self.allHeroEntity or {}
  self.allEntityId = self.allEntityId or {}
  local cache = self:getHeroEntityCache(configId)
  if cache then
    if callBack then
      callBack(cache)
    end
    return nil
  end
  playerId = playerId or L_PlayerStore:getPlayerId()
  L_SituationManager:changeLoadingCount(1)
  local entityId = L_EntityManager:generateUIHeroEntity(configId, function(entity)
    L_SituationManager:changeLoadingCount(-1)
    if entity.csEntity == nil then
      print("情境角色加载回调csentity为nil")
      return
    end
    self.allHeroEntity[configId] = entity
    if callBack then
      callBack(entity)
    end
  end, playerId, nil, C_EEntityEntranceType.Situation, clothingId)
  if entityId == -1 then
    L_SituationManager:changeLoadingCount(-1)
    errorf(string.format("情境角色重复创建 configId:%s", tostring(configId)))
    return nil
  end
  table.insert(self.allEntityId, entityId)
  return entityId
end

function this:getHeroEntityCache(configId)
  self.heroEntityCache = self.heroEntityCache or {}
  if self.heroEntityCache[configId] then
    local entity = self.heroEntityCache[configId]
    entity:setActive(true)
    self.heroEntityCache[configId] = nil
    return entity
  end
  return nil
end

function this:recycleHeroEntity(configId, entity)
  if not entity then
    return
  end
  do
    local stateComponent = entity:getStateComponent(false)
    if stateComponent then
      stateComponent:reset()
      stateComponent:onDestroy()
    end
    entity:setActive(false)
    if entity.csEntity then
      C_EntityManager.ClearUIHeroEntityByConfigId(configId, entity.csEntity.entity.data.entityId)
      entity:onDestroy()
    end
    self.allHeroEntity[configId] = nil
    return
  end
  local stateComponent = entity:getStateComponent(true)
  stateComponent:reset()
  stateComponent:onDestroy()
  C_EntityManager.ClearUIHeroEntityByConfigId(configId, entity.csEntity.entity.data.entityId)
  entity:onDestroy()
  entity:setActive(false)
  self.allHeroEntity = self.allHeroEntity or {}
  self.allHeroEntity[configId] = nil
  self.heroEntityCache = self.heroEntityCache or {}
  self.heroEntityCache[configId] = entity
end

function this:releaseAll()
  for i, v in pairs(self.allHeroEntity or {}) do
    local stateComponent = v:getStateComponent(false)
    if stateComponent and stateComponent.stateMachine then
      stateComponent.stateMachine:reset()
      stateComponent.stateMachine:destroy()
    end
    local animatorComponent = v:getAnimatorComponent(false)
    if animatorComponent then
      animatorComponent:setSpeed(1)
    end
    v:onDestroy()
  end
  for i, v in pairs(self.allPetEntity or {}) do
    v:onDestroy()
  end
  self.allHeroEntity = {}
  self.heroEntityCache = {}
  self.allPetEntity = {}
  self.petEntityCache = {}
  for i, v in pairs(self.allEntityId) do
    C_EntityManager.RemoveEntityWithEntityId(v)
  end
  self.allEntityId = {}
  C_EntityManager.ClearUIHeroEntity()
  self.loadingCount = 0
  if self._coverTexCache then
    for id, tex in pairs(self._coverTexCache) do
      if tex and L_CommonUtil.isValid(tex) then
        tex:ReleaseTexture()
      end
    end
    self._coverTexCache = nil
  end
end

function this:getHeroContainer(configId)
  for i, v in pairs(self.curSolution.heroContainers) do
    if v.data.heroConfigId == configId then
      return v
    end
  end
  return nil
end

function this:getPetContainer(petGuid)
  for i, v in pairs(self.curSolution.petContainers) do
    if v.data.petGuid == petGuid then
      return v
    end
  end
  return nil
end

function this:hasHero(configId)
  if not self.curSolution then
    return false
  end
  if L_GameUtil.isDefaultHero(configId) then
    return true
  end
  for i, v in pairs(self.curSolution.heroContainers) do
    if v.data.heroConfigId == configId then
      return true
    end
  end
  return false
end

function this:getObjContainer(guid)
  for i, v in pairs(self.curSolution.objContainers) do
    if v.guid == guid then
      return v
    end
  end
  return nil
end

function this:hasObj(guid)
  if not self.curSolution then
    return false
  end
  for i, v in pairs(self.curSolution.objContainers) do
    if v.guid == guid then
      return true
    end
  end
  return false
end

function this:createPetEntity(guid, configId, specialParam, flashParam, skinId, starColorId, callBack)
  self.allPetEntity = self.allPetEntity or {}
  self.allEntityId = self.allEntityId or {}
  local cache = self:getPetEntityCache(guid)
  if cache then
    if callBack then
      callBack(cache)
    end
    return nil
  end
  local petItem = require(L_R.store .. "pet.data.petItem").new()
  petItem.guid = guid
  petItem.id = configId
  petItem.color = specialParam
  petItem.special = flashParam and L_Const.PetSpecialType.PST_FLASH or L_Const.PetSpecialType.PST_NORMAL
  petItem.petId = configId
  petItem.wear_skin_id = skinId
  petItem.colorMatId = starColorId
  L_SituationManager:changeLoadingCount(1)
  local entityId = L_EntityManager:generatePhotoPetEntity(petItem, function(entity)
    L_SituationManager:changeLoadingCount(-1)
    entity:activeUINode(false)
    self.allPetEntity[guid] = entity
    if callBack then
      callBack(entity)
    end
  end, true, C_EEntityEntranceType.SituationPet)
  table.insert(self.allEntityId, entityId)
  return entityId
end

function this:getPetEntityCache(guid)
  self.petEntityCache = self.petEntityCache or {}
  if self.petEntityCache[guid] then
    local entity = self.petEntityCache[guid]
    if entity.gameObject and not entity.gameObject:IsNull() then
      entity.gameObject:SetActive(true)
    end
    self.petEntityCache[guid] = nil
    return entity
  end
  return nil
end

function this:recyclePetEntity(guid, entity)
  if not entity then
    return
  end
  self.petEntityCache = self.petEntityCache or {}
  if self.petEntityCache[guid] then
    if entity.csEntity and entity.csEntity.entity.data then
      C_EntityManager.RemoveEntityWithEntityId(entity.csEntity.entity.data.entityId)
    end
    entity:onDestroy()
    return
  end
  if entity.gameObject then
    entity.gameObject:SetActive(false)
  end
  if entity.csEntity and entity.csEntity.entity.data then
    C_EntityManager.RemoveEntityWithEntityId(entity.csEntity.entity.data.entityId)
  end
  entity:onDestroy()
end

function this:hasPet(guid)
  if not self.curSolution then
    return false
  end
  for i, v in pairs(self.curSolution.petContainers) do
    if v.data.petGuid == guid then
      return true
    end
  end
  return false
end

function this:getStampContainer(guid)
  for i, v in pairs(self.curSolution.stampContainers) do
    if v.guid == guid then
      return v
    end
  end
  return nil
end

function this:hasStamp(guid)
  if not self.curSolution then
    return false
  end
  for i, v in pairs(self.curSolution.stampContainers) do
    if v.guid == guid then
      return true
    end
  end
  return false
end

function this:hasUndoCount()
  return self.undoSystem and self.undoSystem:hasUndo()
end

function this:hasRedoCount()
  return self.undoSystem and self.undoSystem:hasRedo()
end

function this:createHeroContainer(param)
  local container = require("ui.manager.situation.data.situationDataContainer_hero").new(param)
  return container
end

function this:createObjContainer(param)
  local container = require("ui.manager.situation.data.situationDataContainer_obj").new(param)
  return container
end

function this:createPetContainer(param)
  local container = require("ui.manager.situation.data.situationDataContainer_pet").new(param)
  return container
end

function this:createStampContainer(param)
  local container = require("ui.manager.situation.data.situationDataContainer_stamp").new(param)
  return container
end

function this:addCreateHeroCommand(param)
  local configId = param.heroConfigId
  for i, v in pairs(self.curSolution.heroContainers) do
    if v.data.heroConfigId == configId then
      print("不能创建重复英雄")
      return
    end
  end
  local curCount = self:getCount(L_Const.situationGroup.hero)
  local max = self.countLimit[L_Const.situationGroup.hero]
  if curCount >= max then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("situation_hero_limit"))
    return
  end
  local command = require("ui.manager.situation.action.situationCommand_createHero").new(param, self.curSolution)
  self.undoSystem:execute(command)
end

function this:addRemoveHeroCommand(param)
  if not self:hasHero(param.heroConfigId) then
    return
  end
  local configId = param.heroConfigId
  if configId == L_GameUtil.getDefaultHeroId(L_Const.sexType.male) or configId == L_GameUtil.getDefaultHeroId(L_Const.sexType.female) then
    error("不能删除默认英雄")
    return
  end
  local command = require("ui.manager.situation.action.situationCommand_removeHero").new(param, self.curSolution)
  self.undoSystem:execute(command)
end

function this:addRotateHeroCommand(param)
  if not self:hasHero(param.heroConfigId) then
    return
  end
  local command = require("ui.manager.situation.action.situationCommand_rotateHero").new(param, self.curSolution)
  self.undoSystem:execute(command)
end

function this:addMoveHeroCommand(param)
  if not self:hasHero(param.heroConfigId) then
    return
  end
  local command = require("ui.manager.situation.action.situationCommand_moveHero").new(param, self.curSolution)
  self.undoSystem:execute(command)
end

function this:addSetHeroActionCommand(param)
  if not self:hasHero(param.heroConfigId) then
    return
  end
  local command = require("ui.manager.situation.action.situationCommand_setHeroAction").new(param, self.curSolution)
  self.undoSystem:execute(command)
end

function this:addSetHeroFaceCommand(param)
  if not self:hasHero(param.heroConfigId) then
    return
  end
  local command = require("ui.manager.situation.action.situationCommand_setHeroFace").new(param, self.curSolution)
  self.undoSystem:execute(command)
end

function this:addCreateObjCommand(param)
  local curCount = self:getCount(L_Const.situationGroup.obj)
  local max = self.countLimit[L_Const.situationGroup.obj]
  if curCount >= max then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("situation_objects_limit"))
    return
  end
  local command = require("ui.manager.situation.action.situationCommand_createObj").new(param, self.curSolution)
  self.undoSystem:execute(command)
end

function this:addRemoveObjCommand(param)
  if not self:hasObj(param.guid) then
    return
  end
  local command = require("ui.manager.situation.action.situationCommand_removeObj").new(param, self.curSolution)
  self.undoSystem:execute(command)
end

function this:addMoveObjCommand(param)
  if not self:hasObj(param.guid) then
    return
  end
  local command = require("ui.manager.situation.action.situationCommand_moveObj").new(param, self.curSolution)
  self.undoSystem:execute(command)
end

function this:addRotateObjCommand(param)
  if not self:hasObj(param.guid) then
    return
  end
  local command = require("ui.manager.situation.action.situationCommand_rotateObj").new(param, self.curSolution)
  self.undoSystem:execute(command)
end

function this:addCreatePetCommand(param)
  local petGuid = param.petGuid
  for i, v in pairs(self.curSolution.petContainers) do
    if v.data.petGuid == petGuid then
      print("不能创建重复奇波")
      return
    end
  end
  local curCount = self:getCount(L_Const.situationGroup.pet)
  local max = self.countLimit[L_Const.situationGroup.pet]
  if curCount >= max then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("situation_pet_limit"))
    return
  end
  local command = require("ui.manager.situation.action.situationCommand_createPet").new(param, self.curSolution)
  self.undoSystem:execute(command)
end

function this:addRemovePetCommand(param)
  if not self:hasPet(param.petGuid) then
    return
  end
  local command = require("ui.manager.situation.action.situationCommand_removePet").new(param, self.curSolution)
  self.undoSystem:execute(command)
end

function this:addMovePetCommand(param)
  if not self:hasPet(param.petGuid) then
    return
  end
  local command = require("ui.manager.situation.action.situationCommand_movePet").new(param, self.curSolution)
  self.undoSystem:execute(command)
end

function this:addRotatePetCommand(param)
  if not self:hasPet(param.petGuid) then
    return
  end
  local command = require("ui.manager.situation.action.situationCommand_rotatePet").new(param, self.curSolution)
  self.undoSystem:execute(command)
end

function this:addSetPetActionCommand(param)
  if not self:hasPet(param.petGuid) then
    return
  end
  local command = require("ui.manager.situation.action.situationCommand_setPetAction").new(param, self.curSolution)
  self.undoSystem:execute(command)
end

function this:addSetPetFaceCommand(param)
  if not self:hasPet(param.petGuid) then
    return
  end
  local command = require("ui.manager.situation.action.situationCommand_setPetFace").new(param, self.curSolution)
  self.undoSystem:execute(command)
end

function this:addCreateStampCommand(param)
  local curCount = self:getCount(L_Const.situationGroup.stamp)
  local max = self.countLimit[L_Const.situationGroup.stamp]
  if curCount >= max then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("situation_pic_limit"))
    return
  end
  L_AudioUtil.playSound("Play_SFX_System_UI_Situation_Sticker_On")
  local command = require("ui.manager.situation.action.situationCommand_createStamp").new(param, self.curSolution)
  self.undoSystem:execute(command)
end

function this:addRemoveStampCommand(param)
  if not self:hasStamp(param.guid) then
    return
  end
  local command = require("ui.manager.situation.action.situationCommand_removeStamp").new(param, self.curSolution)
  self.undoSystem:execute(command)
end

function this:addMoveStampCommand(param)
  if not self:hasStamp(param.guid) then
    return
  end
  local command = require("ui.manager.situation.action.situationCommand_moveStamp").new(param, self.curSolution)
  self.undoSystem:execute(command)
end

function this:addScaleStampCommand(param)
  if not self:hasStamp(param.guid) then
    return
  end
  local command = require("ui.manager.situation.action.situationCommand_scaleStamp").new(param, self.curSolution)
  self.undoSystem:execute(command)
end

function this:addChangeEnvCommand(param)
  if self.curSolution.envContainer.data.configId == param.curEnvId then
    return
  end
  local command = require("ui.manager.situation.action.situationCommand_changeEnv").new(param, self.curSolution)
  self.undoSystem:execute(command)
end

function this:changeCameraTargetPos(v3, onlyData)
  self.curSolution.cameraContainer:setTargetPos(v3, onlyData)
end

function this:changeCameraPos(v3)
  self.curSolution.cameraContainer:setCameraPos(v3)
end

function this:getCount(type, solution)
  solution = solution or L_SituationManager.curSolution
  if solution == nil then
    return 0
  end
  if type == L_Const.situationGroup.hero then
    local count = 0
    for k, v in pairs(solution.heroContainers) do
      count = count + 1
    end
    return count
  elseif type == L_Const.situationGroup.obj then
    local count = 0
    for k, v in pairs(solution.objContainers) do
      count = count + 1
    end
    return count
  elseif type == L_Const.situationGroup.pet then
    local count = 0
    for k, v in pairs(solution.petContainers) do
      count = count + 1
    end
    return count
  elseif type == L_Const.situationGroup.env then
  elseif type == L_Const.situationGroup.stamp then
    local count = 0
    for k, v in pairs(solution.stampContainers) do
      count = count + 1
    end
    return count
  end
  return 0
end

function this:limitPos(pos)
  local x = math.clamp(pos.x, -self.rangeLimit, self.rangeLimit)
  local z = math.clamp(pos.z, -self.rangeLimit, self.rangeLimit)
  return L_Vector3.new(x, 0, z)
end

function this:checkPosInLimit(pos)
  if pos.x > self.rangeLimit or pos.x < -self.rangeLimit or pos.z > self.rangeLimit or pos.z < -self.rangeLimit then
    return false
  end
  return true
end

function this:changeLoadingCount(sub)
  self.loadingCount = self.loadingCount or 0
  self.loadingCount = self.loadingCount + sub
  L_SituationStore:call(L_SituationStore.event.loadingCountChanged, self.loadingCount)
end

function this:getLookPos()
  local pos = self.curSolution.cameraContainer.sceneData.lookAtRoot.localPosition
  return L_Vector3.new(pos.x, 0, pos.z)
end

function this:uploadCover(tex, situationId, callback)
  local path = L_PhotoStore.path.situationCoverSavePath
  local playerId = L_PlayerStore:getPlayerId()
  local name = string.format("%s_%s_%s", situationId, playerId, tostring(C_HttpManager.ConvertDataTime()))
  local imgFilePath = path .. tostring(playerId) .. "/" .. name
  imgFilePath = imgFilePath .. ".png"
  local uploadKey = {
    L_PhotoStore.path.situationCoverCDNPath,
    name
  }
  local texData = Unity.ImageConversion.EncodeToPNG(tex)
  uploadKey = table.concat(uploadKey)
  
  local function _onSuccess(key)
    C_PhotoManager.SaveTexture2DByPath(imgFilePath, tex, false)
    L_SituationStore:req_changeCover(situationId, name, function()
      if callback then
        callback(true, key)
      end
      self._coverTexCache = self._coverTexCache or {}
      local old = self._coverTexCache[situationId]
      self._coverTexCache[situationId] = tex
      L_SituationStore:call(L_SituationStore.event.coverChanged, situationId, tex)
      if old and old ~= tex and L_CommonUtil.isValid(old) then
        old:ReleaseTexture()
      end
    end)
  end
  
  local function _onFail(message)
    if L_CommonUtil.isValid(tex) then
      tex:ReleaseTexture()
    end
    if callback then
      callback(false, message)
    end
  end
  
  C_CDNManager.TransferUploadBytes(texData, uploadKey, _onSuccess, _onFail)
end

function this:getCoverTex(solutionId, callback)
  local solution = L_SituationStore:getSolutionInfo(solutionId)
  if solution and not string.isEmpty(solution.coverName) then
    local localPath = L_PhotoStore.path.situationCoverSavePath .. tostring(L_PlayerStore:getPlayerId()) .. "/"
    L_PhotoManager:loadCdnTex(solution.coverName, localPath, L_PhotoStore.path.situationCoverCDNPath, function(tex)
      if callback and tex then
        callback(tex)
      else
        C_PhotoManager.ReleaseTexture(tex)
      end
    end)
  end
end

function this:toSolutionLocalPos(w3)
  return self.curSolution:toLocalPos(w3)
end

return this
