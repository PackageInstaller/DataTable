local this = {}
local _screenPosToUI = Unity.RectTransformUtility.ScreenPointToLocalPointInRectangle
local sConcat = string.concat
local _formationTpl = L_GameTpl:getFormationTpl()
local _petTpl = L_GameTpl:getPetTpl()
local _elementTpl = L_GameTpl:getElementTypeTpl()
local _heroTpl = L_GameTpl:getHeroTpl()
local _tmpOffsetPosVector3 = C_Vector3(0, 0, 0)
local _tmpVector = C_Vector3(0, 0, 0)
local _tmpFormationVec = C_Vector3(0, 0, 0)
local _tmpVec2 = C_Vector2(0, 0)
local _tmpVec3 = C_Vector3(0, 0, 0)
local PetCamNameBase = "camPet"
local SelectEffectPath = "Effect/Common/Teamentry/pre_formationselect.prefab"

function this:loadFormationScene(obj)
  if self.runtimeData and self.runtimeData.formationScene then
    C_UISceneManager.SetSceneVisible()
    self.runtimeData.formationScene:ActiveTrans(true)
    C_CameraManager.mainCamera:GetComponent(typeof(C_CinemachineBrain)):ManualUpdate()
    return
  end
  local curSceneId = AzurWorldInstance.CurWorldId
  local formationScene = L_GameTpl:getWorldCityTpl():getFormationScene(curSceneId)
  local scenePath = L_CommonUtil.getMultiPlatformScenePath(sConcat("Program/UIScene/Formations/pre_formation_ui_", formationScene, ".prefab"))
  C_UISceneManager.SetSceneVisible()
  self.runtimeData = require("ui.manager.formation.formationRuntimeData").new(L_CommonUtil.isValid(obj) and obj or L_ResPool:syncGameObject(scenePath))
  local sceneTrans = self.runtimeData.formationScene.transform
  sceneTrans:SetParent(C_LuaUtility.GetRootNode())
  L_Vector3.setPos(sceneTrans, C_UIMgr.SceneLoadDefaultPosition)
  L_Vector3.setRot(sceneTrans, L_Vector3.zero)
  self:setCameraActive(L_FormationConst.FormationCamName.Overlook)
  C_CameraManager.mainCamera:GetComponent(typeof(C_CinemachineBrain)):ManualUpdate()
end

function this:setSceneArtActive(active)
  if self.runtimeData and L_CommonUtil.isValid(self.runtimeData.formationScene) then
    if active then
      self.runtimeData.formationScene:SetActive(active)
    else
      self.runtimeData.formationScene:SetActive(active)
    end
    C_CameraManager.mainCamera:GetComponent(typeof(C_CinemachineBrain)):ManualUpdate()
  end
  C_UISceneManager.SetSceneVisible()
end

function this:removeFormationScene()
  L_TimerManager:clearTimer(self)
  if self.runtimeData then
    self.runtimeData:destroy()
  end
  if self._petFlashActiveJob then
    co.stop(self._petFlashActiveJob)
    self._petFlashActiveJob = nil
  end
  self.runtimeData = nil
  C_UISceneManager.SetSceneVisible()
  self:stopFlashSound()
end

function this:switchToOverlook(callback)
  if self:inSwitching() then
    return
  end
  self:setEditStatus(L_FormationConst.FormationEditStatus.Switching)
  local fromCamName = L_FormationConst.FormationCamName.EditHero
  local toCamName = L_FormationConst.FormationCamName.Overlook
  local durTime = self:getCamDurationTime(fromCamName, toCamName)
  self:setCameraActive(toCamName)
  self:setFocusIndex()
  L_TimerManager:newOrResetTimer(self, "switchToOverlook", function()
    self:setEditStatus(L_FormationConst.FormationEditStatus.Overlook)
    for i = 1, L_FormationConst.FormationPosNum do
      self:setHeroIk(i, true)
    end
    if callback then
      callback()
    end
  end, durTime)
  self:_refreshPointVisible()
end

function this:switchToEditHero()
  if self:inSwitching() then
    return
  end
  local camNameBase = PetCamNameBase
  local fromCamName = self:getEditStatus() == L_FormationConst.FormationEditStatus.EditPet and string.concat(camNameBase, self:getFocusIndex()) or L_FormationConst.FormationCamName.Overlook
  local toCamName = L_FormationConst.FormationCamName.EditHero
  local durTime = self:getCamDurationTime(fromCamName, toCamName)
  self:setCameraActive(toCamName)
  self:setEditStatus(L_FormationConst.FormationEditStatus.Switching)
  L_TimerManager:newOrResetTimer(self, "switchToEditHero", function()
    self:setEditStatus(L_FormationConst.FormationEditStatus.EditHero)
    self:setFocusEffect(self:getFocusIndex())
    for i = 1, L_FormationConst.FormationPosNum do
      self:setHeroIk(i, true)
    end
  end, durTime)
  self:_refreshPointVisible()
end

function this:switchToEditPet(index, callback, needCachePos)
  if self:inSwitching() then
    return
  end
  self:setFocusEffect()
  self:setEditStatus(L_FormationConst.FormationEditStatus.Switching)
  local fromCamName = L_FormationConst.FormationCamName.EditHero
  local toCamName = string.concat(PetCamNameBase, index)
  local durTime = self:getCamDurationTime(fromCamName, toCamName)
  self:setCameraTarget(toCamName, index, needCachePos)
  self:setCameraActive(toCamName)
  L_TimerManager:newOrResetTimer(self, "focusPet", function()
    self:setEditStatus(L_FormationConst.FormationEditStatus.EditPet)
    self:setFocusIndex(index)
    self:setHeroIk(index, true)
    if callback then
      callback()
    end
  end, durTime)
  self:_refreshPointVisible(index)
end

function this:revertFormationScene()
  local editStatus = self:getEditStatus()
  if editStatus == L_FormationConst.FormationEditStatus.Overlook then
    self:switchToOverlook()
  elseif editStatus == L_FormationConst.FormationEditStatus.EditHero then
    self:switchToEditHero()
  elseif editStatus == L_FormationConst.FormationEditStatus.EditPet then
    self:switchToEditPet(self:getFocusIndex(), nil, true)
  end
  self:setNeedRevertFormationScene(false)
end

function this:setNeedRevertFormationScene(needRevert)
  self.runtimeData.needRevertFormationScene = needRevert
end

function this:getNeedRevertFormationScene()
  return self.runtimeData.needRevertFormationScene
end

function this:setPetSwitchStatus(bool)
  self.runtimeData.isPetStatus = bool
end

function this:getPetSwitchStatus()
  return self.runtimeData.isPetStatus
end

function this:inSwitching()
  return self.runtimeData.editStatus == L_FormationConst.FormationEditStatus.Switching
end

function this:setEditStatus(status)
  self.runtimeData.editStatus = status
  C_UIMgr.gamepadConfigMap:UpdateVirtualCursorVisibility()
end

function this:getEditStatus()
  return self.runtimeData and self.runtimeData.editStatus
end

function this:setFocusIndex(index)
  self.runtimeData.focusIndex = index
  self:setFocusEffect(index)
end

function this:getFocusIndex()
  return self.runtimeData.focusIndex or 1
end

function this:setFocusEffect(index, toEditStatus)
  for i, go in pairs(self.runtimeData.focusEffect) do
    go:ActiveTrans(false)
  end
  local editStatus = toEditStatus or self:getEditStatus()
  if editStatus == L_FormationConst.FormationEditStatus.EditHero and not math.isEmpty(index) then
    if not L_CommonUtil.isValid(self.runtimeData.focusEffect[index]) then
      local obj = L_ResPool:syncGameObject(SelectEffectPath)
      self.runtimeData.focusEffect[index] = obj
      self.runtimeData.focusEffect[index]:ActiveTrans(false)
      obj.transform:SetParent(self.runtimeData.selectEffectPoint[index])
      L_Vector3.setLocalPos(obj.transform, L_Vector3.zero)
      L_Vector3.setLocalRot(obj.transform, L_Vector3.zero)
    end
    self.runtimeData.focusEffect[index]:ActiveTrans(true)
  end
end

function this:_refreshPointVisible(visiblePlace)
  for i = 1, L_FormationConst.FormationPosNum do
    local visible = true
    if visiblePlace then
      visible = visiblePlace == i
    end
    self.runtimeData.heroPoints[i].gameObject:ActiveTrans(visible)
    self.runtimeData.petPoints[i].gameObject:ActiveTrans(visible)
    if not visible then
      local hero = self:_getInPlaceRole(i, L_Const.roleType.hero)
      if not table.isEmpty(hero) then
        local tpl = _heroTpl:getTplById(hero.configId)
        local elementId = _heroTpl:getElement(tpl)
        self:_recycleEffectModel(elementId)
      end
    end
  end
end

function this:loadHeroModelAtPlace(heroId, posIndex, isSync)
  if math.isEmpty(heroId) then
    self:removeHeroModelAtPlace(posIndex)
    return
  end
  for idx, v in pairs(self.runtimeData.placeHeroes) do
    if v.heroId == heroId and idx ~= posIndex then
      self:removeHeroModelAtPlace(idx)
    end
  end
  local curHero = self:_getInPlaceRole(posIndex, L_Const.roleType.hero)
  if not table.isEmpty(curHero) and curHero.guid == heroId then
    self:_recycleEffectModel(posIndex)
    return
  end
  self:removeHeroModelAtPlace(posIndex)
  local pointTrans = self.runtimeData.heroPoints[posIndex]
  local heroObj, entity = self:_fetchHeroModel(heroId)
  self:countLfuCache(heroId)
  local heroTrans = heroObj.transform
  heroTrans:SetParent(pointTrans)
  L_Vector3.setLocalPos(heroTrans, L_Vector3.zero)
  local heroServerData = L_HeroStore:getHero(heroId)
  local heroConfigId = L_HeroStore:getHeroConfigId(heroServerData)
  local unitId = L_GameUtil.getUnitIdByRole(heroConfigId, L_Const.roleType.hero)
  local rot = L_Vector3.zero
  if unitId then
    rot = _formationTpl:getFormationRotation(_formationTpl:getTplById(unitId), posIndex)
  end
  L_Vector3.setLocalRot(heroTrans, rot)
  heroObj:SetActive(true)
  self.runtimeData.placeHeroes[posIndex] = {
    heroId = heroId,
    obj = heroObj,
    entity = entity,
    configId = heroConfigId,
    guid = heroId,
    unitId = unitId
  }
  
  local function endDo()
    if entity ~= nil and entity.playableAnimator ~= nil then
      entity.playableAnimator:Play("FormationIdle")
    end
  end
  
  self:setHeroIk(posIndex, true)
  if isSync then
    self:setHeroAdmission(posIndex, endDo)
  else
    endDo()
  end
end

function this:loadHeroModelAtPlaceAsync(heroId, posIndex, isSync, callback)
  if math.isEmpty(heroId) then
    self:removeHeroModelAtPlace(posIndex)
    callback()
    return
  end
  for idx, v in pairs(self.runtimeData.placeHeroes) do
    if v.heroId == heroId and idx ~= posIndex then
      self:removeHeroModelAtPlace(idx)
    end
  end
  local curHero = self:_getInPlaceRole(posIndex, L_Const.roleType.hero)
  if not table.isEmpty(curHero) and curHero.guid == heroId then
    self:_recycleEffectModel(posIndex)
    callback()
    return
  end
  self:removeHeroModelAtPlace(posIndex)
  local pointTrans = self.runtimeData.heroPoints[posIndex]
  local tempHeroId = heroId
  local heroServerData = L_HeroStore:getHero(heroId)
  local heroConfigId = L_HeroStore:getHeroConfigId(heroServerData)
  local clothingId = AzurWorld.heroMgr:GetUsingClothingId(heroId, heroConfigId)
  
  local function getEntityEnd(uiHero)
    local entity = uiHero
    if entity == nil then
      if callback then
        callback()
      end
      return
    end
    if self.runtimeData == nil then
      C_MJLog.LogInfo(string.format("编队UI角色entity创建完成时界面已关闭，销毁角色 heroConfigId:%d", heroConfigId), C_ELogModule.FormationUI)
      C_EntityManager.ClearUIHeroEntityByConfigId(heroConfigId, entity.entityId)
      return
    end
    for idx, v in pairs(self.runtimeData.placeHeroes) do
      if v.heroId == heroId and idx == posIndex then
        C_MJLog.LogInfo(string.format("编队UI角色 重复加载了同一个位置的角色，销毁角色 heroConfigId:%d", heroConfigId), C_ELogModule.FormationUI)
        C_EntityManager.ClearUIHeroEntityByConfigId(heroConfigId, entity.entityId)
        callback()
        return
      end
    end
    self:countLfuCache(tempHeroId)
    local heroTrans = entity.gameObject.transform
    local heroObj = entity.gameObject
    heroObj.name = "hero_" .. tostring(heroId)
    heroTrans:SetParent(pointTrans)
    L_Vector3.setLocalPos(heroTrans, L_Vector3.zero)
    local unitId = L_GameUtil.getUnitIdByRole(clothingId, L_Const.roleType.hero)
    local rot = L_Vector3.zero
    if unitId then
      rot = _formationTpl:getFormationRotation(_formationTpl:getTplById(unitId), posIndex)
    end
    L_Vector3.setLocalRot(heroTrans, rot)
    heroObj:SetActive(true)
    self.runtimeData.placeHeroes[posIndex] = {
      heroId = heroId,
      obj = heroObj,
      entity = entity,
      configId = heroConfigId,
      guid = heroId,
      unitId = unitId
    }
    
    local function endDo()
      if entity ~= nil and entity.playableAnimator ~= nil then
        entity.playableAnimator:Play("FormationIdle")
      end
    end
    
    self:setHeroIk(posIndex, true)
    if isSync then
      self:setHeroAdmission(posIndex, endDo)
    else
      endDo()
    end
    if callback then
      callback()
    end
  end
  
  if self.runtimeData.heroEntityCache[heroId] then
    local entity = self.runtimeData.heroEntityCache[heroId]
    entity.playableAnimator:Play("FormationIdle")
    self.runtimeData.heroEntityCache[heroId] = nil
    getEntityEnd(entity)
  else
    C_MJLog.LogInfo(string.format("开始异步加载编队UI角色 heroConfigId:%d", heroConfigId), C_ELogModule.FormationUI)
    local eid = L_EntityManager:generateUIHeroEntity(heroConfigId, function(uiHero)
      if uiHero ~= nil and self.runtimeData ~= nil then
        local entityID = uiHero.entityId
        table.removeWith(self.runtimeData.loadingEntityId, function(i)
          return i == entityID
        end)
        C_MJLog.LogInfo(string.format("编队UI角色entity创建完成 heroConfigId:%d entityId:%d", heroConfigId, uiHero.entityId), C_ELogModule.FormationUI)
      end
      getEntityEnd(uiHero)
    end, L_PlayerStore:getPlayerId(), C_AnimatorControllerType.UIPreview, C_EEntityEntranceType.Formation, clothingId)
    if eid == -1 then
      callback()
    else
      table.insert(self.runtimeData.loadingEntityId, eid)
    end
  end
end

function this:removeHeroModelAtPlace(posIndex)
  local v = self.runtimeData.placeHeroes[posIndex]
  if v then
    self:_recycleHeroModel(posIndex, v.obj)
    self.runtimeData.placeHeroes[posIndex] = nil
  end
end

function this:_getInPlaceRole(posIndex, roleType)
  local placeData
  if roleType == L_Const.roleType.hero then
    placeData = self.runtimeData.placeHeroes
  elseif roleType == L_Const.roleType.pet then
    placeData = self.runtimeData.placePets
  end
  return placeData[posIndex] or {}
end

function this:_fetchHeroModel(heroId)
  local heroServerData = L_HeroStore:getHero(heroId)
  local heroConfigId = L_HeroStore:getHeroConfigId(heroServerData)
  local isPlayerHero = false
  local unitId = L_GameUtil.getUnitIdByRole(heroConfigId, L_Const.roleType.hero)
  local heroModelPath = ""
  if unitId then
    heroModelPath = L_GameUtil.getAvatarModelPathByUnitId(unitId, L_Const.avatarModelIndex.UnitModel)
    isPlayerHero = heroServerData.type == L_Const.HeroType.HT_MAIN
  end
  local obj, entity
  if self.runtimeData.heroEntityCache[heroId] then
    entity = self.runtimeData.heroEntityCache[heroId]
    return entity.gameObject, entity
  else
    obj = C_UIMgr.uiLoader:Spawn(heroModelPath)
    obj.name = sConcat("hero_", heroId)
  end
  local needAnimaList = {
    "FormationIdle",
    "FormationAdmission"
  }
  local entity = L_EntityManager:generateSimpleHero(heroConfigId, obj, isPlayerHero, nil, needAnimaList, C_EEntityEntranceType.Formation)
  if entity.biologyData then
    entity.biologyData.magicaClothActive = false
  end
  entity.playableAnimator:Play("FormationIdle")
  return obj, entity
end

function this:_fetchHeroModelAsync(heroId, callback)
  local heroServerData = L_HeroStore:getHero(heroId)
  local heroConfigId = L_HeroStore:getHeroConfigId(heroServerData)
  local isPlayerHero = false
  local unitId = L_GameUtil.getUnitIdByRole(heroConfigId, L_Const.roleType.hero)
  local heroModelPath = ""
  if unitId then
    heroModelPath = L_GameUtil.getAvatarModelPathByUnitId(unitId, L_Const.avatarModelIndex.UnitModel)
    isPlayerHero = heroServerData.type == L_Const.HeroType.HT_MAIN
  end
  local entity
  if self.runtimeData.heroEntityCache[heroId] then
    entity = self.runtimeData.heroEntityCache[heroId]
    entity.playableAnimator:Play("FormationIdle")
    callback(entity, entity.gameObject)
  else
    C_MJLog.LogInfo(string.format("开始异步加载编队UI角色Prefab heroConfigId:%d path:%s", heroConfigId, heroModelPath), C_ELogModule.FormationUI)
    local id = C_UIMgr.uiLoader:SpawnAsync(heroModelPath, function(uid, obj)
      if not L_CommonUtil.isValid(obj) then
        callback(nil, nil)
        errorf("cant load asset from " .. heroModelPath)
        return
      end
      obj.name = sConcat("hero_", heroId)
      obj:SetActive(false)
      C_MJLog.LogInfo(string.format("开始异步加载编队UI角色Entity heroConfigId:%d path:%s", heroConfigId, heroModelPath), C_ELogModule.FormationUI)
      local needAnimaList = {
        "FormationIdle",
        "FormationAdmission"
      }
      L_EntityManager:generateSimpleHeroAsync(heroConfigId, obj, isPlayerHero, nil, function(heroEntity)
        entity = heroEntity
        if not L_CommonUtil.isValid(obj) or self.runtimeData == nil then
          C_MJLog.LogInfo(string.format("编队UI角色entity创建完成时界面已关闭，销毁角色 heroConfigId:%d", heroConfigId), C_ELogModule.FormationUI)
          C_PrefabManager:RecycleByLoader(obj)
          entity:onDestroy()
          callback(nil, nil)
          return
        end
        C_MJLog.LogInfo(string.format("编队UI角色entity创建完成 heroConfigId:%d entityId:%d", heroConfigId, entity.entityId), C_ELogModule.FormationUI)
        obj:SetActive(true)
        if heroEntity.biologyData then
          heroEntity.biologyData.magicaClothActive = false
        end
        heroEntity.playableAnimator:Play("FormationIdle")
        callback(entity, entity.gameObject)
      end, needAnimaList, C_EEntityEntranceType.Formation)
    end, nil, true, C_EAssetOperationModule.Lua, C_AssetLoadPriority.GetPriority(C_AssetLoadPriority.UI_Page))
    table.insert(self.runtimeData.heroPrefabIds, id)
  end
end

function this:countLfuCache(heroId)
  local excludeList = {}
  for k, v in pairs(self.runtimeData.placeHeroes) do
    excludeList[v.heroId] = true
  end
  self.runtimeData.heroLfuCache:SetExcludes(excludeList)
  local evicted = self.runtimeData.heroLfuCache:Use(heroId)
  if evicted ~= nil then
    local entity = self.runtimeData.heroEntityDicLfu[evicted]
    if entity ~= nil then
      C_MJLog.LogInfo(string.format("编队UI角色entity销毁 entityId:%d", entity.entityId), C_ELogModule.FormationUI)
      local heroServerData = L_HeroStore:getHero(evicted)
      local heroConfigId = L_HeroStore:getHeroConfigId(heroServerData)
      C_EntityManager.ClearUIHeroEntityByConfigId(heroConfigId, entity.entityId)
      self.runtimeData.heroEntityCache[evicted] = nil
      self.runtimeData.heroEntityDicLfu[evicted] = nil
      self.runtimeData.heroLfuCache:Remove(evicted)
    else
      self.runtimeData.heroLfuCache:DebugPrint()
      C_MJLog.LogInfo(string.format("没找到要销毁的角色:%d", evicted), C_ELogModule.FormationUI)
    end
  end
end

function this:_recycleHeroModel(posIndex, heroObj)
  local hero = self.runtimeData.placeHeroes[posIndex]
  if not hero then
    return
  end
  self:_recycleEffectModel(posIndex)
  if hero.entity ~= nil then
    local ikComponent = hero.entity:getComponent(L_EcsConst.componentType.ikComponent, false)
    if ikComponent then
      ikComponent:disableIK()
    end
  end
  if self.runtimeData.isLowMemory then
    if hero.entity ~= nil then
      C_EntityManager.ClearUIHeroEntityByConfigId(hero.configId, hero.entity.entityId)
    end
    self.runtimeData.heroEntityCache[hero.heroId] = nil
    self.runtimeData.heroEntityDicLfu[hero.heroId] = nil
    self.runtimeData.heroLfuCache:Remove(hero.heroId)
    return
  end
  heroObj:SetActive(false)
  local heroTrans = heroObj.transform
  heroTrans:SetParent(self.runtimeData.modelCache)
  L_Vector3.setLocalPos(heroTrans, L_Vector3.zero)
  L_Vector3.setLocalRot(heroTrans, L_Vector3.zero)
  self.runtimeData.heroEntityCache[hero.heroId] = hero.entity
  self.runtimeData.heroEntityDicLfu[hero.heroId] = hero.entity
end

function this:loadPetModelAtPlace(petGuid, posIndex)
  if math.isEmpty(petGuid) then
    self:removePetModelAtPlace(posIndex)
    return
  else
    local curPlacePet = self:_getInPlaceRole(posIndex, L_Const.roleType.pet)
    if curPlacePet.guid == petGuid then
      local oldConfigId = self.runtimeData.placePets[posIndex].configId
      local serverData = L_PetStore:getPetItem(petGuid)
      if oldConfigId == serverData.id then
        return
      else
        self:removePetModelAtPlace(posIndex)
        if L_CommonUtil.isValid(self.runtimeData.petCache[petGuid]) then
          C_GameObject.Destroy(self.runtimeData.petCache[petGuid])
          self.runtimeData.petCache[petGuid] = nil
        end
      end
    end
  end
  for idx, v in pairs(self.runtimeData.placePets) do
    if v.petGuid == petGuid and idx ~= posIndex then
      self:removePetModelAtPlace(idx)
    end
  end
  self:removePetModelAtPlace(posIndex)
  local pointTrans
  pointTrans = self.runtimeData.petPoints[posIndex]
  local petData = L_PetStore:getPetItem(petGuid)
  if not petData then
    return
  end
  local petInfoCfgId = petData.id
  local petObj, entity
  if self.runtimeData.placePets[posIndex] then
    petObj = self.runtimeData.placePets[posIndex].obj
    entity = self.runtimeData.placePets[posIndex].entity
  else
    petObj, entity = self:_fetchPetModel(petGuid)
  end
  petObj.transform:SetParent(pointTrans)
  local unitId = L_GameUtil.getUnitIdByRole(petInfoCfgId, L_Const.roleType.pet)
  local tpl = _formationTpl:getTplById(unitId)
  local scale = _formationTpl:getFormationScale(tpl)
  L_Vector3.setSize(petObj.transform, scale)
  local pos = _formationTpl:getFormationPositionOffset(tpl, posIndex)
  L_Vector3.setLocalPos(petObj.transform, pos)
  local rot = L_Vector3.zero
  if unitId then
    rot = _formationTpl:getFormationRotation(_formationTpl:getTplById(unitId), posIndex)
  end
  L_Vector3.setLocalRot(petObj.transform, rot)
  petObj:ActiveTrans(true)
  self.runtimeData.placePets[posIndex] = {
    petGuid = petGuid,
    obj = petObj,
    configId = petInfoCfgId,
    entity = entity,
    guid = petGuid,
    unitId = unitId
  }
  self:_setPetFlashEft(posIndex, petData:hasFlashGene(), petObj)
  if self:getEditStatus() == L_FormationConst.FormationEditStatus.EditPet then
    local toCamName = string.concat(PetCamNameBase, posIndex)
    self:setCameraTarget(toCamName, posIndex)
  end
end

function this:loadPetModelAtPlaceAsync(petGuid, posIndex, callback)
  if math.isEmpty(petGuid) then
    self:removePetModelAtPlace(posIndex)
    if callback then
      callback()
    end
    return
  else
    local curPlacePet = self:_getInPlaceRole(posIndex, L_Const.roleType.pet)
    if curPlacePet.guid == petGuid then
      local oldConfigId = self.runtimeData.placePets[posIndex].configId
      local serverData = L_PetStore:getPetItem(petGuid)
      if oldConfigId == serverData.id then
        if callback then
          callback()
        end
        return
      else
        self:removePetModelAtPlace(posIndex)
        if L_CommonUtil.isValid(self.runtimeData.petCache[petGuid]) then
          C_GameObject.Destroy(self.runtimeData.petCache[petGuid])
          self.runtimeData.petCache[petGuid] = nil
        end
      end
    end
  end
  for idx, v in pairs(self.runtimeData.placePets) do
    if v.petGuid == petGuid and idx ~= posIndex then
      self:removePetModelAtPlace(idx)
    end
  end
  self:removePetModelAtPlace(posIndex)
  local pointTrans
  pointTrans = self.runtimeData.petPoints[posIndex]
  local petData = L_PetStore:getPetItem(petGuid)
  if not petData then
    if callback then
      callback()
    end
    return
  end
  local petInfoCfgId = petData.id
  local petObj, entity
  if self.runtimeData.placePets[posIndex] then
    petObj = self.runtimeData.placePets[posIndex].obj
    entity = self.runtimeData.placePets[posIndex].entity
  else
    self:_fetchPetModelAsync(petGuid, function(entity, petObj)
      self:removePetModelAtPlace(posIndex)
      petObj.transform:SetParent(pointTrans)
      local unitId = L_GameUtil.getUnitIdByRole(petInfoCfgId, L_Const.roleType.pet)
      local tpl = _formationTpl:getTplById(unitId)
      if tpl == nil then
        error("formationTpl内缺少unitid:" .. unitId .. "联系@佳冰加一下")
        tpl = _formationTpl:getTplById(200181)
      end
      if tpl ~= nil then
        local scale = _formationTpl:getFormationScale(tpl)
        L_Vector3.setSize(petObj.transform, scale)
        local pos = _formationTpl:getFormationPositionOffset(tpl, posIndex)
        L_Vector3.setLocalPos(petObj.transform, pos)
        local rot = L_Vector3.zero
        if unitId then
          rot = _formationTpl:getFormationRotation(tpl, posIndex)
        end
        L_Vector3.setLocalRot(petObj.transform, rot)
      end
      petObj:ActiveTrans(true)
      self.runtimeData.placePets[posIndex] = {
        petGuid = petGuid,
        obj = petObj,
        configId = petInfoCfgId,
        entity = entity,
        guid = petGuid,
        unitId = unitId
      }
      self:_setPetFlashEft(posIndex, petData:hasFlashGene(), petObj)
      if self:getEditStatus() == L_FormationConst.FormationEditStatus.EditPet then
        local toCamName = string.concat(PetCamNameBase, posIndex)
        self:setCameraTarget(toCamName, posIndex)
      end
      if callback then
        callback()
      end
    end)
    return
  end
  petObj.transform:SetParent(pointTrans)
  local unitId = L_GameUtil.getUnitIdByRole(petInfoCfgId, L_Const.roleType.pet)
  local tpl = _formationTpl:getTplById(unitId)
  local scale = _formationTpl:getFormationScale(tpl)
  L_Vector3.setSize(petObj.transform, scale)
  local pos = _formationTpl:getFormationPositionOffset(tpl, posIndex)
  L_Vector3.setLocalPos(petObj.transform, pos)
  local rot = L_Vector3.zero
  if unitId then
    rot = _formationTpl:getFormationRotation(_formationTpl:getTplById(unitId), posIndex)
  end
  L_Vector3.setLocalRot(petObj.transform, rot)
  petObj:ActiveTrans(true)
  self.runtimeData.placePets[posIndex] = {
    petGuid = petGuid,
    obj = petObj,
    configId = petInfoCfgId,
    entity = entity,
    guid = petGuid,
    unitId = unitId
  }
  self:_setPetFlashEft(posIndex, petData:hasFlashGene(), petObj)
  if self:getEditStatus() == L_FormationConst.FormationEditStatus.EditPet then
    local toCamName = string.concat(PetCamNameBase, posIndex)
    self:setCameraTarget(toCamName, posIndex)
  end
  if callback then
    callback()
  end
end

function this:removePetModelAtPlace(posIndex)
  if math.isEmpty(posIndex) then
    return
  end
  local v = self.runtimeData.placePets[posIndex]
  if v then
    self:_recyclePetModel(posIndex, v.obj)
    self.runtimeData.placePets[posIndex] = nil
  end
  self:_setPetFlashEft(posIndex, false)
end

function this:_fetchPetModel(petGuid)
  local petData = L_PetStore:getPetItem(petGuid)
  if not petData then
    return
  end
  local petInfoCfgId = petData.id
  local tpl = _petTpl:getTplById(petInfoCfgId)
  local unitId = _petTpl:getUnitID(tpl)
  local path, previewPetData = self:_getPetPreviewResInfo(petInfoCfgId, petData:isSpecialPet(), petData:getSkinInfo())
  local obj
  if self.runtimeData.petCache[petGuid] then
    obj = self.runtimeData.petCache[petGuid]
  else
    obj = L_ResPool:syncGameObject(path)
  end
  local animator = L_CommonUtil.getModComponent(typeof(C_PlayableAnimator), obj)
  animator.cullingMode = C_AnimatorCullingMode.AlwaysAnimate
  animator.updateMode = C_PlayableAnimator.UpdateMode.LateUpdate
  animator.rootMotionController.selfApplyRootMotion = true
  self:_setPetStarColor(petData.colorMatId, obj)
  obj.name = sConcat("pet_", petGuid)
  local needAnimaList = {"Idle"}
  local entity = L_EntityManager:generatePreviewPet(petGuid, obj, previewPetData, needAnimaList, nil, nil, C_EEntityEntranceType.FormationPet)
  entity.playableAnimator:Play("Idle")
  return obj, entity
end

function this:_fetchPetModelAsync(petGuid, callback)
  local petData = L_PetStore:getPetItem(petGuid)
  if not petData then
    return
  end
  local petInfoCfgId = petData.id
  local tpl = _petTpl:getTplById(petInfoCfgId)
  local unitId = _petTpl:getUnitID(tpl)
  local path, previewPetData = self:_getPetPreviewResInfo(petInfoCfgId, petData:isSpecialPet(), petData:getSkinInfo())
  local obj, entity
  if self.runtimeData.petCache[petGuid] then
    obj = self.runtimeData.petCache[petGuid]
    local animator = L_CommonUtil.getModComponent(typeof(C_PlayableAnimator), obj)
    animator.cullingMode = C_AnimatorCullingMode.AlwaysAnimate
    animator.updateMode = C_PlayableAnimator.UpdateMode.LateUpdate
    animator.rootMotionController.selfApplyRootMotion = true
    self:_setPetStarColor(petData.colorMatId, obj)
    obj.name = sConcat("pet_", petGuid)
    local needAnimaList = {"Idle"}
    entity = L_EntityManager:generatePreviewPet(petGuid, obj, previewPetData, needAnimaList, nil, nil, C_EEntityEntranceType.FormationPet)
    entity.playableAnimator:Play("Idle")
    if callback then
      callback(entity, obj)
    end
  else
    C_MJLog.LogInfo(string.format("开始异步加载编队UI奇波Prefab petConfigId:%d", unitId), C_ELogModule.FormationUI)
    local id = C_UIMgr.uiLoader:SpawnAsync(path, function(uid, obj)
      if not L_CommonUtil.isValid(obj) then
        if callback then
          callback(nil, nil)
        end
        errorf("cant load asset from " .. path)
        return
      end
      obj.name = sConcat("pet_", petGuid)
      obj:SetActive(false)
      local needAnimaList = {"Idle"}
      L_EntityManager:generatePreviewPetAsync(petGuid, obj, previewPetData, function(petEntity)
        entity = petEntity
        if not L_CommonUtil.isValid(obj) or self.runtimeData == nil then
          C_PrefabManager:RecycleByLoader(obj)
          entity:onDestroy()
          callback(nil, nil)
          error("page is destroy: petFormation")
          return
        end
        obj:SetActive(true)
        local animator = L_CommonUtil.getModComponent(typeof(C_PlayableAnimator), obj)
        animator.cullingMode = C_AnimatorCullingMode.AlwaysAnimate
        animator.updateMode = C_PlayableAnimator.UpdateMode.LateUpdate
        animator.rootMotionController.selfApplyRootMotion = true
        self:_setPetStarColor(petData.colorMatId, obj)
        obj.name = sConcat("pet_", petGuid)
        entity.playableAnimator:Play("Idle")
        if callback then
          callback(entity, obj)
        end
      end, needAnimaList, C_EEntityEntranceType.FormationPet)
    end, nil, true, C_EAssetOperationModule.Lua, C_AssetLoadPriority.GetPriority(C_AssetLoadPriority.UI_Page))
    table.insert(self.runtimeData.petPrefabIds, id)
  end
end

function this:_setPetStarColor(starColorId, petObj)
  local biologyData = L_CommonUtil.getModComponent(typeof(C_BiologyAvatar), petObj)
  if biologyData then
    biologyData:SetStarColor(starColorId and starColorId or 0)
  end
end

local function _getPetSkinSuffix(petSkinInfo, key)
  if petSkinInfo == nil then
    return nil
  end
  local suffix = petSkinInfo[key]
  if string.isEmpty(suffix) then
    return nil
  end
  return suffix
end

local function _appendAssetSuffix(path, suffix)
  if string.isEmpty(path) or string.isEmpty(suffix) then
    return path
  end
  local newPath, replaceCount = string.gsub(path, "(%.[^%.]+)$", "_" .. suffix .. "%1", 1)
  if replaceCount == 0 then
    newPath = path .. "_" .. suffix
  end
  return newPath
end

function this:_getPetPreviewResInfo(petConfigId, isSpecial, petSkinInfo)
  local tpl = _petTpl:getTplById(petConfigId)
  local unitId = _petTpl:getUnitID(tpl)
  local unitTpl = L_GameTpl:getUnitTpl()
  local unit = unitTpl:getTplById(unitId)
  local path = L_GameUtil.getAvatarModelPathByUnitId(unitId, L_Const.avatarModelIndex.UnitModel)
  if isSpecial and isSpecial ~= 0 then
    local specialParm = unitTpl:getSpecialParm(unit)
    local replaceStr = specialParm and specialParm[isSpecial]
    if replaceStr then
      path = _appendAssetSuffix(path, replaceStr)
    end
  end
  local unitSuffix = _getPetSkinSuffix(petSkinInfo, "unitSuffix")
  if unitSuffix then
    path = _appendAssetSuffix(path, unitSuffix)
  end
  local previewPetData
  local animatorSuffix = _getPetSkinSuffix(petSkinInfo, "animatorSuffix")
  if animatorSuffix then
    local animatorConfigPath = L_GameUtil.getAnimatorControllerPathByUnitId(unitId, L_Const.avatarAnimatorConfigIndex.uiPreview)
    animatorConfigPath = _appendAssetSuffix(animatorConfigPath, animatorSuffix)
    if not string.isEmpty(animatorConfigPath) then
      previewPetData = {id = petConfigId, animatorConfigPath = animatorConfigPath}
    end
  end
  return path, previewPetData
end

function this:_recyclePetModel(posIndex, petObj)
  local pet = self.runtimeData.placePets[posIndex]
  if not pet then
    return
  end
  if self.runtimeData.isLowMemory then
    pet.entity:onDestroy()
    C_PrefabManager:RecycleByLoader(petObj)
    self.runtimeData.petCache[pet.petGuid] = nil
    return
  end
  pet.entity:onDestroy()
  petObj:SetActive(false)
  local petTrans = petObj.transform
  petTrans:SetParent(self.runtimeData.modelCache)
  L_Vector3.setLocalPos(petTrans, L_Vector3.one)
  L_Vector3.setLocalRot(petTrans, L_Vector3.zero)
  self.runtimeData.petCache[pet.petGuid] = petObj
end

function this:_setPetFlashEft(posIndex, bShow, petObj)
  if not bShow then
    if self.runtimeData.petFlashObj[posIndex] then
      L_CommonUtil.setObjActive(self.runtimeData.petFlashObj[posIndex], false)
      self.runtimeData.petFlashObj[posIndex].transform:SetParent(self.runtimeData.modelCache)
    end
    local hasAnyFlash = false
    for i, flashObj in pairs(self.runtimeData.petFlashObj) do
      if i ~= posIndex and L_CommonUtil.isValid(flashObj) and flashObj.activeSelf then
        hasAnyFlash = true
        break
      end
    end
    if not hasAnyFlash then
      self:stopFlashSound()
    end
    return
  end
  local obj
  if self.runtimeData.petFlashObj[posIndex] then
    obj = self.runtimeData.petFlashObj[posIndex]
  else
    local mediaPackTpl = L_GameTpl:getMediaPackTplTpl()
    local petFlashKey = L_GameTpl:getGameConstTpl():getData("PET_FLASH_EFFECT_PATH_PAGE", L_Const.GameTplType.string)
    local path = mediaPackTpl:getPath(mediaPackTpl:getTplByKey(petFlashKey))
    obj = L_ResPool:syncGameObject(path)
  end
  L_CommonUtil.setObjActive(obj, false)
  local EffectMaterialHelperCom = obj.transform:GetComponentInChildren(typeof(CS.EffectMaterialHelper))
  if EffectMaterialHelperCom then
    EffectMaterialHelperCom.characterRoot = petObj
  end
  local ImmuneBuffHelperCom = obj.transform:GetComponentInChildren(typeof(CS.ImmuneBuffHelper))
  if ImmuneBuffHelperCom then
    ImmuneBuffHelperCom.characterRoot = petObj
  end
  local BindMeshEffectCom = obj.transform:GetComponentInChildren(typeof(CS.Lens.Gameplay.Modules.BigWorld.BindMeshEffect))
  if BindMeshEffectCom then
    BindMeshEffectCom:BindMeshBody(petObj)
  end
  obj.transform:SetParent(petObj.transform)
  self._petFlashActiveJob = co.start(function()
    co.step(5)
    L_CommonUtil.setObjActive(obj, true)
  end)
  L_Vector3.setLocalPos(obj.transform, L_Vector3.zero)
  L_Vector3.setLocalRot(obj.transform, L_Vector3.zero)
  L_Vector3.setSize(obj.transform, 1)
  self:playFlashSound()
  self.runtimeData.petFlashObj[posIndex] = obj
end

function this:setFormationHudScreenPos(hud)
  if self.runtimeData == nil then
    return
  end
  if math.isEmpty(hud:getGuid()) then
    return
  end
  if hud._configId == nil then
    return
  end
  local roleType = hud:getRoleType()
  local obj
  if roleType == L_Const.roleType.hero then
    local place = self.runtimeData.placeHeroes[hud:getIndex()]
    obj = place and place.obj
  else
    local place = self.runtimeData.placePets[hud:getIndex()]
    obj = place and place.obj
  end
  if not L_CommonUtil.isValid(obj) then
    hud:setActive(false)
    return
  end
  hud:setActive(obj.activeInHierarchy)
  local unitId = hud:getUnitId()
  local tpl_formation = _formationTpl:getTplById(unitId)
  local colliderRadius, colliderHeight = 0.5, 1.6
  if tpl_formation ~= nil then
    colliderRadius, colliderHeight = _formationTpl:getFormationColliderRef(tpl_formation, _tmpFormationVec)
  end
  if self._isGm then
    local collider = obj:PickComponent(typeof(CS.UnityEngine.CapsuleCollider))
    _tmpFormationVec = collider.center
    colliderRadius = collider.radius
    colliderHeight = collider.height
  end
  local basePos = _tmpFormationVec
  _tmpOffsetPosVector3.y = colliderHeight / 2
  local offsetPos = _tmpOffsetPosVector3
  _tmpVec3.x = basePos.x + offsetPos.x
  _tmpVec3.y = basePos.y + offsetPos.y
  _tmpVec3.z = basePos.z + offsetPos.z
  local scenePos = obj.transform:TransformPoint(_tmpVec3)
  local screenPos = C_CameraManager.mainCamera:WorldToScreenPoint(scenePos)
  _tmpVec2.x = screenPos.x
  _tmpVec2.y = screenPos.y
  local v2 = C_Vector2(screenPos.x, screenPos.y)
  local hudRect = hud:getSelfRect()
  local parent = hudRect.parent
  local _, uiPos = _screenPosToUI(parent, _tmpVec2, C_CameraManager.uiCamera)
  L_Vector3.setAnchored(hudRect, uiPos)
  local index = hud:getIndex()
  local btngroup = hud:getBtnGroup()
  local btngroupRevert = hud:getBtnGroup(true)
  local ishero = hud.bind.roleType == L_Const.roleType.hero
  local offsetBtn
  local offset = 0
  if index == 1 then
    offset = self:calOffsetX(index, not ishero, colliderRadius)
    hud:setRevertBtn(not ishero)
  elseif index == 2 then
    offset = self:calOffsetX(index, not ishero, colliderRadius)
    hud:setRevertBtn(not ishero)
  elseif index == 3 then
    offset = self:calOffsetX(index, ishero, colliderRadius)
    hud:setRevertBtn(ishero)
  end
  _tmpVector.x = offset
  _tmpVector.y = self:calOffsetY(colliderHeight)
  offsetBtn = _tmpVector
  _tmpVec3.x = basePos.x + offsetBtn.x
  _tmpVec3.y = basePos.y + offsetBtn.y
  _tmpVec3.z = basePos.z + offsetBtn.z
  basePos.x = basePos.x + offsetBtn.x
  local scenePosBtn = obj.transform:TransformPoint(_tmpVec3)
  local screenPosBtn = C_CameraManager.mainCamera:WorldToScreenPoint(scenePosBtn)
  _tmpVec2.x = screenPosBtn.x
  _tmpVec2.y = screenPosBtn.y
  local _, uiPosBtn = _screenPosToUI(hudRect, _tmpVec2, C_CameraManager.uiCamera)
  L_Vector3.setAnchored(btngroup, uiPosBtn)
  L_Vector3.setAnchored(btngroupRevert, uiPosBtn)
  if self:getEditStatus() == L_FormationConst.FormationEditStatus.EditPet and hud:getAlpha() then
    hud:setAlpha(1)
    hud:checkDownBtn(self:getEditStatus())
  end
end

function this:calOffsetX(index, bRevert, colliderRadius)
  local offset = 0
  if index == 1 then
    if bRevert then
      offset = 0.1 * colliderRadius
    else
      offset = -0.4 * colliderRadius
    end
  elseif index == 2 then
    if bRevert then
      offset = 0.4 * colliderRadius
    else
      offset = -0.4 * colliderRadius
    end
  elseif index == 3 then
    if bRevert then
      offset = 0.3 * colliderRadius
    else
      offset = -0.5 * colliderRadius
    end
  end
  return offset
end

function this:calOffsetY(colliderHeight)
  local offset = 0
  local isSwitchPet = L_FormationManager:getPetSwitchStatus()
  if isSwitchPet then
    offset = -0.1 * colliderHeight
  end
  return offset
end

function this:getPlacePos(posIndex, roleType)
  if roleType == L_Const.roleType.hero then
    return L_Vector3.getPos(self.runtimeData.heroPoints[posIndex])
  elseif roleType == L_Const.roleType.pet then
    return L_Vector3.getPos(self.runtimeData.petPoints[posIndex])
  end
end

function this:setHeroIk(posIndex, isOpen)
  if self:inSwitching() then
    return
  end
  local hero = self:_getInPlaceRole(posIndex, L_Const.roleType.hero)
  if table.isEmpty(hero) then
    return
  end
  local entity = hero.entity
  local ikComponent = entity:getComponent(L_EcsConst.componentType.ikComponent, true)
  if isOpen then
    local camName
    if self:getEditStatus() == L_FormationConst.FormationEditStatus.Overlook then
      camName = L_FormationConst.FormationCamName.Overlook
    elseif self:getEditStatus() == L_FormationConst.FormationEditStatus.EditHero then
      camName = L_FormationConst.FormationCamName.EditHero
    elseif self:getEditStatus() == L_FormationConst.FormationEditStatus.EditPet then
      camName = string.concat(PetCamNameBase, posIndex)
    end
    local trans = self.runtimeData.cameraNodeData[camName].obj.transform
    ikComponent:enableIK(trans)
    ikComponent:setIKDistance(8)
  else
    ikComponent:disableIK()
  end
end

function this:setHeroAdmission(posIndex, callback)
  local hero = self:_getInPlaceRole(posIndex, L_Const.roleType.hero)
  if table.isEmpty(hero) then
    return
  end
  local entity = hero.entity
  local animator = L_CommonUtil.getModComponent(typeof(C_PlayableAnimator), entity:getGameObject())
  animator:CrossFade("FormationAdmission", 0, -1, 0, 0)
  if callback then
    local aniState = animator:GetState("FormationAdmission")
    if aniState then
      L_TimerManager:newOrResetTimer(self, "hero_ani_callback" .. tostring(posIndex), callback, aniState.length)
    else
      callback()
    end
  end
  self:_fetchEffectModel(posIndex)
end

function this:_fetchEffectModel(posIndex)
  local hero = self:_getInPlaceRole(posIndex, L_Const.roleType.hero)
  if table.isEmpty(hero) then
    return
  end
  self:_recycleEffectModel(posIndex)
  local tpl = _heroTpl:getTplById(hero.configId)
  local elementId = _heroTpl:getElement(tpl)
  local tpl_ele = _elementTpl:getTplById(elementId)
  local path = _elementTpl:getAdmissioneffects(tpl_ele)
  local effectObj = L_ResPool:syncGameObject(path)
  effectObj.transform:SetParent(hero.obj.transform:GetChild(0))
  L_Vector3.setLocalPos(effectObj.transform, L_Vector3.zero)
  effectObj:ActiveTrans(true)
  self.runtimeData.admissionEffectMap[posIndex] = effectObj
end

function this:_recycleEffectModel(posIndex)
  if L_CommonUtil.isValid(self.runtimeData.admissionEffectMap[posIndex]) then
    C_GameObject.Destroy(self.runtimeData.admissionEffectMap[posIndex])
  end
end

function this:setCameraActive(camName)
  for name, cameraData in pairs(self.runtimeData.cameraNodeData) do
    cameraData.obj:ActiveTrans(name == camName)
    if name == camName then
      cameraData.camera.enabled = true
    end
  end
end

function this:setCameraTarget(camName, index, useCache)
  local placeData = self:_getInPlaceRole(index, L_Const.roleType.pet)
  local scenePos
  local targetObj = self.runtimeData.cameraNodeData[camName].targetObj
  if table.isEmpty(placeData) then
    scenePos = self:_getCamHeroTarget(camName, index)
  else
    scenePos = self:_getCamPetTarget(index)
  end
  if useCache and self.cacheCameraPos then
    scenePos = self.cacheCameraPos
  end
  L_Vector3.setPos(targetObj.transform, scenePos)
  self.cacheCameraPos = scenePos
end

function this:switchPetCamera(flag)
  local curPosIndex = self:getFocusIndex()
  if table.isEmpty(self:_getInPlaceRole(curPosIndex, L_Const.roleType.pet)) then
    return
  end
  local camName = string.concat(PetCamNameBase, curPosIndex)
  local scenePos
  if flag then
    scenePos = self:_getCamHeroTarget(camName, curPosIndex)
  else
    scenePos = self:_getCamPetTarget(curPosIndex)
  end
  local targetObj = self.runtimeData.cameraNodeData[camName].targetObj
  L_Vector3.setPos(targetObj.transform, scenePos)
end

function this:resetPetCamera()
  local curPosIndex = self:getFocusIndex()
  local camName = string.concat(PetCamNameBase, curPosIndex)
  local scenePos = self:_getCamHeroTarget(camName, curPosIndex)
  local targetObj = self.runtimeData.cameraNodeData[camName].targetObj
  L_Vector3.setPos(targetObj.transform, scenePos)
end

function this:_getCamHeroTarget(camName, index)
  local result = L_FormationConst.FormationCamTargetDefaultPos[camName]
  local placeData_hero = self:_getInPlaceRole(index, L_Const.roleType.hero)
  if not table.isEmpty(placeData_hero) then
    local unitId = placeData_hero.unitId
    local tpl_formation = _formationTpl:getTplById(unitId)
    local colliderCenter, colliderRadius, colliderHeight = _formationTpl:getFormationCollider(tpl_formation)
    local basePos = colliderCenter
    local offsetPos = L_Vector3.new(0, colliderHeight / 8, 0)
    local localPos = basePos + offsetPos
    local scenePos_hero = placeData_hero.obj.transform:TransformPoint(localPos)
    result = L_Vector3.new(result.x, scenePos_hero.y, result.z)
  end
  return result
end

function this:_getCamPetTarget(index)
  local placeData = self:_getInPlaceRole(index, L_Const.roleType.pet)
  local tpl_formation = _formationTpl:getTplById(placeData.unitId)
  local colliderCenter = _formationTpl:getFormationCollider(tpl_formation)
  local localPos = colliderCenter
  return placeData.obj.transform:TransformPoint(localPos)
end

function this:getCamDurationTime(from, to)
  local tmp = self.runtimeData.cameraDurationMap[from] or {}
  return tmp[to] or 0
end

function this:setPosTranslucent(isTranslucent)
  local goldColor = C_Color(1, 0.8, 0, 1)
  for i, v in pairs(self.runtimeData.placeHeroes) do
    local characterTransHelper = v.obj:PickComponent(typeof(C_CharacterTransHelper))
    if isTranslucent and i == self:getFocusIndex() then
      characterTransHelper:SetFormationFadeByParam(true, 1, goldColor, 1)
    else
      characterTransHelper:SetFormationFadeByParam(false, 1, C_Color(0, 0, 0, 1), 0)
    end
  end
  for i, v in pairs(self.runtimeData.placePets) do
    local characterTransHelper = v.obj:PickComponent(typeof(C_CharacterTransHelper))
    if isTranslucent and i == self:getFocusIndex() then
      characterTransHelper:SetFormationFadeByParam(true, 1, goldColor, 1)
    else
      characterTransHelper:SetFormationFadeByParam(false, 1, C_Color(0, 0, 0, 1), 0)
    end
  end
end

function this:setRuntimeFormationType(type)
  self.runtimeData.formationType = type
end

function this:setRuntimeFormationIndex(index)
  self.runtimeData.formationIndex = index
end

function this:getRuntimeFormationType()
  return self.runtimeData and self.runtimeData.formationType
end

function this:getRuntimeFormationIndex()
  return self.runtimeData and self.runtimeData.formationIndex
end

function this:playFlashSound()
end

function this:stopFlashSound()
end

return this
