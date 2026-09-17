local this = class("timelineActorHandle")

function this:ctor(_timelinePrefabHandle)
  self._timelinePrefabHandle = _timelinePrefabHandle
  self._unitPrefabMap = {}
  self._unitInsIDMap = {}
  self._heroId = nil
  self._heroLoadHandle = nil
end

function this:dispose()
  self._timelinePrefabHandle = nil
  if self._heroLoadHandle then
    C_PrefabManager:Destroy(self._heroLoadHandle)
    self._heroLoadHandle = nil
  end
  if self.avatarCtrl then
    AzurWorld.avatarMgr:ReleaseAvatarController(self.avatarCtrl)
    self.avatarCtrl = nil
  end
  if self._unitPrefabMap then
    for i, v in pairs(self._unitPrefabMap) do
      C_PrefabManager:RecycleByLoader(v.actor)
      self._unitPrefabMap[i] = nil
    end
  end
  if self._unitInsIDMap then
    for i, v in pairs(self._unitInsIDMap) do
      C_PrefabManager:RecycleByLoader(v)
      self._unitInsIDMap[i] = nil
    end
  end
  self._heroId = nil
end

function this:checkIsSelfHero(heroId)
  local heroClothingTpl = L_GameTpl:getHeroClothingTpl()
  local unitId = heroClothingTpl:getUnitId(heroClothingTpl:getTplById(heroId))
  local gameConstTpl = L_GameTpl:getGameConstTpl()
  local maleUnit = gameConstTpl:getData("AVATAR_UNIT_ID_MALE", L_Const.GameTplType.int)
  local femaleUnit = gameConstTpl:getData("AVATAR_UNIT_ID_FEMALE", L_Const.GameTplType.int)
  return unitId == maleUnit or unitId == femaleUnit
end

function this:disposeHeroAsset(lastName, curName)
  local isLowMemoryDevice = true
  for i, v in pairs(self._unitPrefabMap) do
    local isNeedClear = false
    if isLowMemoryDevice then
      isNeedClear = i ~= curName
    else
      isNeedClear = i ~= lastName and i ~= curName
    end
    if isNeedClear then
      C_PrefabManager:RecycleByLoader(v.actor)
      self._unitPrefabMap[i] = nil
      if self:checkIsSelfHero(i) and self.avatarCtrl then
        AzurWorld.avatarMgr:ReleaseAvatarController(self.avatarCtrl)
        self.avatarCtrl = nil
      end
    end
  end
  for i, v in pairs(self._unitInsIDMap) do
    local isNeedClear = false
    if isLowMemoryDevice then
      isNeedClear = i ~= curName
    else
      isNeedClear = i ~= lastName and i ~= curName
    end
    if isNeedClear then
      C_PrefabManager:RecycleByLoader(v)
      self._unitInsIDMap[i] = nil
      if self:checkIsSelfHero(i) and self.avatarCtrl then
        AzurWorld.avatarMgr:ReleaseAvatarController(self.avatarCtrl)
        self.avatarCtrl = nil
      end
    end
  end
end

function this:getCurHero()
  return self._unitPrefabMap[self._heroId]
end

function this:loadUnitPrefab(heroId, onLoaded, lodLv, playerId, clothingId)
  local lastPrefabMap = self._unitPrefabMap[self._heroId]
  
  local function afterLoaded()
    if lastPrefabMap and lastPrefabMap ~= self._unitPrefabMap[self._heroId] then
      lastPrefabMap:getGameObject():ActiveTrans(false)
    end
    if onLoaded ~= nil then
      onLoaded()
    end
  end
  
  self:disposeHeroAsset(self._heroId, heroId)
  self._heroId = heroId
  if self._unitPrefabMap[heroId] then
    afterLoaded()
  else
    local heroClothingTpl = L_GameTpl:getHeroClothingTpl()
    local clothing = heroClothingTpl:getTplById(clothingId)
    local unitId = heroClothingTpl:getUnitId(clothing)
    local gameConstTpl = L_GameTpl:getGameConstTpl()
    local maleUnit = gameConstTpl:getData("AVATAR_UNIT_ID_MALE", L_Const.GameTplType.int)
    local femaleUnit = gameConstTpl:getData("AVATAR_UNIT_ID_FEMALE", L_Const.GameTplType.int)
    local isSelfRole = unitId == maleUnit or unitId == femaleUnit
    local sex = L_Const.sexType.male
    if unitId == maleUnit then
      sex = L_Const.sexType.male
    elseif unitId == femaleUnit then
      sex = L_Const.sexType.female
    end
    local avatarModelPath
    if isSelfRole then
      local avatarData = self:getAvatarData()
      avatarModelPath = L_GameUtil.getMainHeroPath(sex)
    else
      local unitTpl = L_GameTpl:getUnitTpl()
      local tpl = unitTpl:getTplById(unitId)
      avatarModelPath = unitTpl:getModel(tpl, L_Const.avatarModelIndex.UnitModel)
    end
    local obj = C_UIMgr.uiLoader:Spawn(avatarModelPath)
    obj.transform:SetParent(self._timelinePrefabHandle:getRoot().transform)
    L_Vector3.setLocalPos(obj.transform, L_Vector3.getTemp())
    L_Vector3.setLocalRot(obj.transform, L_Vector3.getTemp())
    local comps = obj:GetComponentsInChildren(typeof(CS.UnityEngine.Animations.RotationConstraint), true)
    for i = 0, comps.Length - 1 do
      comps[i].enabled = false
    end
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
      biologyData:UsePreviewLodLevelByInt()
    end
    if isSelfRole then
      local avatarData
      if playerId ~= nil and playerId ~= 0 then
        avatarData = self:getPlayerAvatarData(playerId)
      else
        avatarData = self:getAvatarData()
      end
      if avatarData then
        local modelCtrl = obj:GetComponent(typeof(C_ModelControl))
        self.avatarCtrl = AzurWorld.avatarMgr:SetAvatar(modelCtrl, avatarData, C_AnimatorControllerType.Hero)
      end
    else
    end
    local actorInfo = require("ui.manager.hero.timeline.heroTimelineDynamicBindInfo").new()
    actorInfo:setGameObject(obj)
    actorInfo:setHeroId(heroId)
    L_Vector3.setLocalPos(obj.transform, L_Vector3.getTemp(10000, 10000, 10000))
    self._unitPrefabMap[heroId] = actorInfo
    local magicaAnimWeight = obj:GetComponentInChildren(typeof(CS.MagicaAnimWeight))
    if magicaAnimWeight then
      magicaAnimWeight:MagicaSwitchOff()
    end
    self._timelinePrefabHandle:schedulerCheckHeroLoadStatus(actorInfo, afterLoaded)
  end
  self._unitPrefabMap[self._heroId]:getGameObject():ActiveTrans(true)
end

function this:getAvatarData()
  if not self.customAvatarData then
    self.customAvatarData = L_ModStore:getPlayerModData()
  end
  return self.customAvatarData
end

function this:getPlayerAvatarData(player_id)
  return C_FriendToLuaManager.GetAvatarData(player_id)
end

function this:asyncloadActorPrefab(heroId, actorPrefabLoadedCallback, playerId, clothingId)
  C_MJLog.LogDebug("多人测试，obj start asyncloadActorPrefab", C_ELogModule.Home)
  
  local function hideLastActorPrefab()
    if actorPrefabLoadedCallback ~= nil then
      actorPrefabLoadedCallback()
    end
  end
  
  self:disposeHeroAsset(self._heroId, heroId)
  self._heroId = heroId
  if self._unitInsIDMap[heroId] then
    C_MJLog.LogDebug("多人测试，obj asyncloadActorPrefab have", C_ELogModule.Home)
    hideLastActorPrefab()
    self._unitPrefabMap[self._heroId].actor:ActiveTrans(true)
  else
    local heroClothingTpl = L_GameTpl:getHeroClothingTpl()
    local clothing = heroClothingTpl:getTplById(clothingId)
    local unitId = heroClothingTpl:getUnitId(clothing)
    local gameConstTpl = L_GameTpl:getGameConstTpl()
    local maleUnit = gameConstTpl:getData("AVATAR_UNIT_ID_MALE", L_Const.GameTplType.int)
    local femaleUnit = gameConstTpl:getData("AVATAR_UNIT_ID_FEMALE", L_Const.GameTplType.int)
    local isSelfRole = unitId == maleUnit or unitId == femaleUnit
    local sex = L_Const.sexType.male
    if unitId == maleUnit then
      sex = L_Const.sexType.male
    elseif unitId == femaleUnit then
      sex = L_Const.sexType.female
    end
    local avatarModelPath
    if isSelfRole then
      local avatarData = self:getAvatarData()
      avatarModelPath = L_GameUtil.getMainHeroPath(sex)
    else
      local unitTpl = L_GameTpl:getUnitTpl()
      local tpl = unitTpl:getTplById(unitId)
      avatarModelPath = unitTpl:getModel(tpl, L_Const.avatarModelIndex.UnitModel)
    end
    C_MJLog.LogDebug("多人测试，obj asyncloadActorPrefab = " .. avatarModelPath, C_ELogModule.Home)
    self._heroLoadHandle = C_UIMgr.uiLoader:SpawnAsync(avatarModelPath, function(id, obj)
      self:InitialLoaded(id, obj, isSelfRole, hideLastActorPrefab, sex, playerId)
    end, self._timelinePrefabHandle:getRoot().transform, true, C_EAssetOperationModule.Lua, C_AssetLoadPriority.GetPriority(C_AssetLoadPriority.UI_Page))
  end
end

function this:InitialLoaded(insID, obj, isSelfRole, funcLoaded, realSex, playerId)
  local comps = obj:GetComponentsInChildren(typeof(CS.UnityEngine.Animations.RotationConstraint), true)
  for i = 0, comps.Length - 1 do
    comps[i].enabled = false
  end
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
    biologyData:UsePreviewLodLevelByInt()
  end
  if isSelfRole then
    local avatarData
    if playerId ~= nil and playerId ~= 0 then
      avatarData = self:getPlayerAvatarData(playerId)
    else
      avatarData = self:getAvatarData()
    end
    if avatarData then
      if avatarData.Sex == realSex then
        local modelCtrl = obj:GetComponent(typeof(C_ModelControl))
        self.avatarCtrl = AzurWorld.avatarMgr:SetAvatar(modelCtrl, avatarData, C_AnimatorControllerType.Hero)
      else
        local defaultData = L_ModStore:getDefaultData(realSex)
        if defaultData then
          local modelCtrl = obj:GetComponent(typeof(C_ModelControl))
          self.avatarCtrl = AzurWorld.avatarMgr:SetAvatar(modelCtrl, defaultData, C_AnimatorControllerType.Hero)
        end
      end
    end
  end
  local actorInfo = require("ui.manager.hero.timeline.heroTimelineDynamicBindInfo").new()
  actorInfo:setGameObject(obj)
  actorInfo:setHeroId(self._heroId)
  L_Vector3.setLocalPos(obj.transform, L_Vector3.getTemp(10000, 10000, 10000))
  self._unitPrefabMap[self._heroId] = actorInfo
  self._unitInsIDMap[self._heroId] = insID
  local magicaAnimWeight = obj:GetComponentInChildren(typeof(CS.MagicaAnimWeight))
  if magicaAnimWeight then
    magicaAnimWeight:MagicaSwitchOff()
  end
  self._timelinePrefabHandle:schedulerCheckHeroLoadStatus(actorInfo, funcLoaded)
  obj:ActiveTrans(true)
end

return this
