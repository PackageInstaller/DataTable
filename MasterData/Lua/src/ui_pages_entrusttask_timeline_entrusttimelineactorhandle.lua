local this = class("entrustTimelineActorHandle")

function this:ctor(_timelinePrefabHandle)
  self._timelinePrefabHandle = _timelinePrefabHandle
  self._unitPrefabMap = {}
  self._heroId = nil
end

function this:ctor(_timelinePrefabHandle)
  self._timelinePrefabHandle = _timelinePrefabHandle
  self._unitPrefabMap = {}
  self._heroId = nil
  self.isDispose = false
  self._asyncLoadHandles = {}
end

function this:dispose()
  self.isDispose = true
  if self._asyncLoadHandles then
    for instanceId, _ in pairs(self._asyncLoadHandles) do
      C_PrefabManager:RecycleByLoader(instanceId)
    end
    self._asyncLoadHandles = nil
  end
  if self.avatarCtrl then
    AzurWorld.avatarMgr:ReleaseAvatarController(self.avatarCtrl)
    self.avatarCtrl = nil
  end
  if self._unitPrefabMap then
    for i, v in pairs(self._unitPrefabMap) do
      if v and v.actor then
        C_PrefabManager:RecycleByLoader(v.actor)
      end
    end
    self._unitPrefabMap = nil
  end
end

function this:getCurHero()
  return self._unitPrefabMap[self._heroId]
end

function this:asyncloadActorPrefab(heroId, actorPrefabLoadedCallback, clothingId)
  local function hideLastActorPrefab()
    L_GameTimer.once(0.1, function()
      if actorPrefabLoadedCallback ~= nil then
        actorPrefabLoadedCallback()
      end
    end, self)
  end
  
  self._heroId = heroId
  if self._unitPrefabMap[heroId] then
    self._unitPrefabMap[self._heroId]:getGameObject():ActiveTrans(true)
    hideLastActorPrefab()
  else
    local heroClothingTpl = L_GameTpl:getHeroClothingTpl()
    local clothing = heroClothingTpl:getTplById(clothingId)
    local unitId = heroClothingTpl:getUnitId(clothing)
    local gameConstTpl = L_GameTpl:getGameConstTpl()
    local maleUnit = tonumber(gameConstTpl:getData("AVATAR_UNIT_ID_MALE", L_Const.GameTplType.int))
    local femaleUnit = tonumber(gameConstTpl:getData("AVATAR_UNIT_ID_FEMALE", L_Const.GameTplType.int))
    local isSelfRole = unitId == maleUnit or unitId == femaleUnit
    local avatarModelPath
    if isSelfRole then
      local avatarData = self:getAvatarData()
      avatarModelPath = L_GameUtil.getMainHeroPath(avatarData and avatarData.Sex)
    else
      local unitTpl = L_GameTpl:getUnitTpl()
      local tpl = unitTpl:getTplById(unitId)
      avatarModelPath = unitTpl:getModel(tpl, L_Const.avatarModelIndex.UnitModel)
    end
    print("======================================loadactor begin base", avatarModelPath)
    local objID = C_UIMgr.uiLoader:SpawnAsync(avatarModelPath, function(id, obj)
      if self.isDispose then
        print("======================================loadactor callback after dispose, destroying orphan object.", avatarModelPath)
        if obj then
          C_PrefabManager:RecycleByLoader(obj)
        end
        return
      end
      if self._asyncLoadHandles then
        self._asyncLoadHandles[id] = nil
      end
      print("======================================loadactor end base", avatarModelPath)
      self:InitialLoaded(obj, isSelfRole, hideLastActorPrefab)
    end, self._timelinePrefabHandle:getRoot().transform, true, C_EAssetOperationModule.Lua, C_AssetLoadPriority.GetPriority(C_AssetLoadPriority.UI_Page))
    if objID then
      self._asyncLoadHandles[objID] = true
    end
  end
end

function this:loadUnitPrefab(heroId, onLoaded, clothingId)
  local lastPrefabMap = self._unitPrefabMap[self._heroId]
  
  local function afterLoaded()
    if self.isDispose then
      return
    end
    if lastPrefabMap and lastPrefabMap ~= self._unitPrefabMap[self._heroId] then
      lastPrefabMap:getGameObject():ActiveTrans(false)
    end
    if onLoaded ~= nil then
      onLoaded()
    end
  end
  
  self._heroId = heroId
  if self._unitPrefabMap[heroId] then
    afterLoaded()
  else
    local heroClothingTpl = L_GameTpl:getHeroClothingTpl()
    local clothing = heroClothingTpl:getTplById(clothingId)
    local unitId = heroClothingTpl:getUnitId(clothing)
    local gameConstTpl = L_GameTpl:getGameConstTpl()
    local maleUnit = tonumber(gameConstTpl:getData("AVATAR_UNIT_ID_MALE", L_Const.GameTplType.int))
    local femaleUnit = tonumber(gameConstTpl:getData("AVATAR_UNIT_ID_FEMALE", L_Const.GameTplType.int))
    local isSelfRole = unitId == maleUnit or unitId == femaleUnit
    local avatarModelPath
    if isSelfRole then
      local avatarData = self:getAvatarData()
      avatarModelPath = L_GameUtil.getMainHeroPath(avatarData and avatarData.Sex)
    else
      local unitTpl = L_GameTpl:getUnitTpl()
      local tpl = unitTpl:getTplById(unitId)
      avatarModelPath = unitTpl:getModel(tpl, L_Const.avatarModelIndex.UnitModel)
    end
    local obj = C_UIMgr.uiLoader:Spawn(avatarModelPath, self._timelinePrefabHandle:getRoot().transform)
    L_Vector3.setLocalPos(obj.transform, L_Vector3.getTemp())
    L_Vector3.setLocalRot(obj.transform, L_Vector3.getTemp())
    local comps = obj:GetComponentsInChildren(typeof(CS.UnityEngine.Animations.RotationConstraint), true)
    for i = 0, comps.Length - 1 do
      comps[i].enabled = false
    end
    local worldAnimator = L_CommonUtil.getModComponent(typeof(C_PlayableAnimator), obj)
    local groundIk = L_CommonUtil.getModComponent(typeof(C_GrounderIK), obj)
    if groundIk then
      groundIk.enabled = false
      for i = 0, groundIk.legs.Length - 1 do
        groundIk.legs[i].enabled = false
      end
    end
    local biologyData = L_CommonUtil.getModComponent(typeof(C_BiologyAvatar), obj)
    if biologyData then
      biologyData.isSync = true
      biologyData:SetTheoryShadowLodLv(0)
      biologyData:UsePreviewLodLevelByInt(C_EntityManager.GetUIEntityLodLevelInt(C_EEntityEntranceType.Entrust))
    end
    local rootObj = worldAnimator.gameObject
    Unity.GameObject.Destroy(worldAnimator)
    worldAnimator = rootObj:AddComponent(typeof(C_PlayableAnimator))
    worldAnimator.cullingMode = C_AnimatorCullingMode.AlwaysAnimate
    if isSelfRole then
      local avatarData = self:getAvatarData()
      if avatarData then
        local modelCtrl = obj:GetComponent(typeof(C_ModelControl))
        self.avatarCtrl = AzurWorld.avatarMgr:SetAvatar(modelCtrl, avatarData)
      end
    else
    end
    local actorInfo = require("ui.pages.entrustTask.timeline.entrustHeroTimelineDynamicBindInfo").new()
    actorInfo:setGameObject(obj)
    actorInfo:setHeroId(heroId)
    L_Vector3.setLocalPos(obj.transform, L_Vector3.getTemp(10000, 10000, 10000))
    self._unitPrefabMap[heroId] = actorInfo
    local magicaAnimWeight = obj:GetComponentInChildren(typeof(CS.MagicaAnimWeight))
    if magicaAnimWeight then
      magicaAnimWeight:MagicaSwitchOff()
    end
    self._timelinePrefabHandle:schedulerCheckHeroLoadStatus(actorInfo, afterLoaded)
    self:refreshPosRot(obj)
  end
  local unitPrefabGo = self._unitPrefabMap[self._heroId]:getGameObject()
  unitPrefabGo:ActiveTrans(true)
end

function this:InitialLoaded(obj, isSelfRole, funcLoaded)
  local comps = obj:GetComponentsInChildren(typeof(CS.UnityEngine.Animations.RotationConstraint), true)
  for i = 0, comps.Length - 1 do
    comps[i].enabled = false
  end
  local worldAnimator = L_CommonUtil.getModComponent(typeof(C_PlayableAnimator), obj)
  local groundIk = L_CommonUtil.getModComponent(typeof(C_GrounderIK), obj)
  if groundIk then
    groundIk.enabled = false
    for i = 0, groundIk.legs.Length - 1 do
      groundIk.legs[i].enabled = false
    end
  end
  local biologyData = L_CommonUtil.getModComponent(typeof(C_BiologyAvatar), obj)
  if biologyData then
    biologyData.isSync = true
    biologyData:SetTheoryShadowLodLv(0)
    biologyData:UsePreviewLodLevelByInt(C_EntityManager.GetUIEntityLodLevelInt(C_EEntityEntranceType.Entrust))
  end
  local rootObj = worldAnimator.gameObject
  Unity.GameObject.Destroy(worldAnimator)
  worldAnimator = rootObj:AddComponent(typeof(C_PlayableAnimator))
  worldAnimator.cullingMode = C_AnimatorCullingMode.AlwaysAnimate
  if isSelfRole then
    local avatarData = self:getAvatarData()
    if avatarData then
      local modelCtrl = obj:GetComponent(typeof(C_ModelControl))
      self.avatarCtrl = AzurWorld.avatarMgr:SetAvatar(modelCtrl, avatarData)
    end
  end
  local actorInfo = require("ui.pages.entrustTask.timeline.entrustHeroTimelineDynamicBindInfo").new()
  actorInfo:setGameObject(obj)
  actorInfo:setHeroId(self._heroId)
  self:refreshPosRot(obj)
  self._unitPrefabMap[self._heroId] = actorInfo
  local magicaAnimWeight = obj:GetComponentInChildren(typeof(CS.MagicaAnimWeight))
  if magicaAnimWeight then
    magicaAnimWeight:MagicaSwitchOff()
  end
  self._unitPrefabMap[self._heroId]:getGameObject():ActiveTrans(true)
  self._timelinePrefabHandle:schedulerCheckHeroLoadStatus(actorInfo, funcLoaded)
end

function this:refreshPosRot(obj)
  L_Vector3.setLocalPos(obj.transform, L_Vector3.getTemp(10000, 10000, 10000))
  if self.prefabPos then
    L_Vector3.setLocalPos(obj.transform, L_Vector3.getTemp(self.prefabPos.x, self.prefabPos.y, self.prefabPos.z))
    self.prefabPos = nil
  else
    L_Vector3.setLocalPos(obj.transform, L_Vector3.getTemp())
  end
  if self.prefabRot then
    L_Vector3.setRot(obj.transform, L_Vector3.getTemp(self.prefabRot.x, self.prefabRot.y, self.prefabRot.z))
    self.prefabRot = nil
  else
    L_Vector3.setRot(obj.transform, L_Vector3.getTemp())
  end
end

function this:getAvatarData()
  if not self.customAvatarData then
    self.customAvatarData = L_ModStore:getPlayerModData()
  end
  return self.customAvatarData
end

function this:setActorActive(isActive)
  if self._unitPrefabMap[self._heroId] then
    self._unitPrefabMap[self._heroId]:getGameObject():ActiveTrans(isActive)
  end
end

function this:setPrefabPos(pos)
  self.prefabPos = {
    x = pos.x or nil,
    y = pos.y or nil,
    z = pos.z or nil
  }
end

function this:setPrefabRot(pos)
  self.prefabRot = {
    x = pos.x or nil,
    y = pos.y or nil,
    z = pos.z or nil
  }
end

function this:setPrefabTrans(pos, rot)
  if self._unitPrefabMap and self._unitPrefabMap[self._heroId] and self._unitPrefabMap[self._heroId]:getGameObject() then
    local trans = self._unitPrefabMap[self._heroId]:getGameObject().transform
    trans.localPosition = L_Vector3.getTemp(pos.x, pos.y, pos.z)
    local eulerAngles = L_Vector3.new(rot.x, rot.y, rot.z)
    trans.localRotation = Unity.Quaternion.Euler(eulerAngles)
  end
end

return this
