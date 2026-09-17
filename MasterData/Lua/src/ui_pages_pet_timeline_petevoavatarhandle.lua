local this = class("petEvoAvatarHandle")
local petInfoTpl = L_GameTpl:getPetTpl()

function this:ctor(_timelinePrefabHandle)
  self._timelinePrefabHandle = _timelinePrefabHandle
  self._unitPrefabMap = {}
  self._loadStatusMap = {}
  self._pendingCallbackMap = {}
  self._isAvatarVisible = false
  self.petFlashObj = nil
  self._handleList = {}
  self._isDispose = false
end

function this:dispose()
  self._isDispose = true
  for i, v in pairs(self._handleList) do
    C_LuaUtility.DestroyObject(v)
    self._handleList[i] = nil
  end
  self._handleList = nil
  for i, v in pairs(self._unitPrefabMap) do
    self._unitPrefabMap[i] = nil
  end
  if self._petFlashActiveJob then
    co.stop(self._petFlashActiveJob)
    self._petFlashActiveJob = nil
  end
  self._unitPrefabMap = nil
  self._loadStatusMap = nil
  self._pendingCallbackMap = nil
  if L_CommonUtil.isValid(self.petFlashObj) then
    C_GameObject.Destroy(self.petFlashObj)
  end
  self.petFlashObj = nil
end

function this:getAvatar(avatarId)
  return self._unitPrefabMap and self._unitPrefabMap[avatarId]
end

function this:getLoadStatus(avatarId)
  return self._loadStatusMap and self._loadStatusMap[avatarId]
end

function this:_applyAvatarVisible(go)
  if not L_CommonUtil.isValid(go) then
    return
  end
  L_CommonUtil.setObjActive(go, self._isAvatarVisible)
end

function this:setAvatarVisible(isVisible)
  self._isAvatarVisible = isVisible
  if self._unitPrefabMap == nil then
    return
  end
  for _, actorInfo in pairs(self._unitPrefabMap) do
    local go = actorInfo and actorInfo:getGameObject()
    self:_applyAvatarVisible(go)
  end
end

function this:_addPendingCallback(petId, callback)
  if callback == nil then
    return
  end
  self._pendingCallbackMap[petId] = self._pendingCallbackMap[petId] or {}
  table.insert(self._pendingCallbackMap[petId], callback)
end

function this:_invokePendingCallbacks(petId, isSuccess)
  local callbackList = self._pendingCallbackMap[petId]
  if callbackList == nil then
    return
  end
  self._pendingCallbackMap[petId] = nil
  for _, callback in ipairs(callbackList) do
    callback(petId, isSuccess)
  end
end

function this:loadUnitPrefab(petId, rot, scale, callback, isSpecial, isFlash, starColorId)
  if self._isDispose then
    return
  end
  self:_addPendingCallback(petId, callback)
  local loadStatus = self._loadStatusMap[petId]
  if loadStatus == "loaded" and self._unitPrefabMap[petId] then
    self:_setPetFlashEft(isFlash, self._unitPrefabMap[petId]:getGameObject())
    local safeStarColorId = starColorId and starColorId or 0
    self:_setPetStarColor(safeStarColorId, self._unitPrefabMap[petId]:getGameObject())
    self:_applyAvatarVisible(self._unitPrefabMap[petId]:getGameObject())
    self:_invokePendingCallbacks(petId, true)
    return
  end
  if loadStatus == "loading" then
    return
  end
  if loadStatus == "failed" then
    self:_invokePendingCallbacks(petId, false)
    return
  end
  self._loadStatusMap[petId] = "loading"
  local tpl = petInfoTpl:getTplById(petId)
  if tpl == nil then
    self._loadStatusMap[petId] = "failed"
    errorf("pagePetEvo load pet prefab failed, pet tpl is nil, petId = " .. tostring(petId))
    self:_invokePendingCallbacks(petId, false)
    return
  end
  local unitID = petInfoTpl:getUnitID(tpl)
  if not unitID then
    self._loadStatusMap[petId] = "failed"
    errorf("pagePetEvo load pet prefab failed, unit id is nil, petId = " .. tostring(petId))
    self:_invokePendingCallbacks(petId, false)
    return
  end
  local unitTpl = L_GameTpl:getUnitTpl()
  local path = unitTpl:getModel(unitTpl:getTplById(unitID), 1, isSpecial)
  if string.isEmpty(path) then
    self._loadStatusMap[petId] = "failed"
    errorf("pagePetEvo load pet prefab failed, model path is empty, petId = " .. tostring(petId))
    self:_invokePendingCallbacks(petId, false)
    return
  end
  local objHandle = C_LuaUtility.InstantiateAsync(path, function(go)
    if self._isDispose then
      return
    end
    if go == nil then
      self._loadStatusMap[petId] = "failed"
      errorf("pagePetEvo instantiate pet prefab failed, petId = " .. tostring(petId) .. ", path = " .. tostring(path))
      self:_invokePendingCallbacks(petId, false)
      return
    end
    local obj = go
    local modelCtrl1 = go:GetComponent(typeof(C_ModelControl))
    local biodata = modelCtrl1.transform:GetChild(0):GetComponent(typeof(C_BiologyAvatar))
    biodata.isSync = true
    obj.transform:SetParent(self._timelinePrefabHandle:getRoot().transform)
    L_Vector3.setLocalPos(obj.transform, L_Vector3.getTemp())
    L_Vector3.setLocalRot(obj.transform, L_Vector3.getTemp(rot[1], rot[2], rot[3]))
    L_Vector3.setScale(obj.transform, L_Vector3.getTemp(scale / 10000, scale / 10000, scale / 10000))
    local biologyData = L_CommonUtil.getModComponent(typeof(C_BiologyAvatar), obj)
    if biologyData then
      biologyData:UsePreviewLodLevelByInt(0)
    end
    local worldAnimator = L_CommonUtil.getModComponent(typeof(C_PlayableAnimator), obj)
    worldAnimator.cullingMode = C_AnimatorCullingMode.AlwaysAnimate
    worldAnimator.applyRootMotion = false
    local actorInfo = require("ui.manager.hero.timeline.petTimelineDynamicBindInfo").new()
    actorInfo:setGameObject(go)
    actorInfo:setPetID(petId)
    self._unitPrefabMap[petId] = actorInfo
    self._loadStatusMap[petId] = "loaded"
    self:_setPetFlashEft(isFlash, go)
    local safeStarColorId = starColorId and starColorId or 0
    self:_setPetStarColor(safeStarColorId, go)
    self:_applyAvatarVisible(go)
    self:_invokePendingCallbacks(petId, true)
  end)
  self._handleList[petId] = objHandle
end

function this:_setPetFlashEft(bShow, petObj)
  if not bShow then
    if self.petFlashObj then
      L_CommonUtil.setObjActive(self.petFlashObj, false)
    end
    return
  end
  local obj
  if self.petFlashObj then
    obj = self.petFlashObj
  else
    local mediaPackTpl = L_GameTpl:getMediaPackTplTpl()
    local petFlashKey = L_GameTpl:getGameConstTpl():getData("PET_FLASH_EFFECT_PATH_PAGE", L_Const.GameTplType.string)
    local path = mediaPackTpl:getPath(mediaPackTpl:getTplByKey(petFlashKey))
    obj = L_ResPool:syncGameObject(path)
  end
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
  self.petFlashObj = obj
end

function this:_setPetStarColor(starColorId, petObj)
  local biologyData = L_CommonUtil.getModComponent(typeof(C_BiologyAvatar), petObj)
  if biologyData then
    biologyData:SetStarColor(starColorId and starColorId or 0)
  end
end

return this
