_class("SMazeMapHistoryEventpoint", Object)
SMazeMapHistoryEventpoint = SMazeMapHistoryEventpoint

function SMazeMapHistoryEventpoint:Constructor(cfg, root)
  self._resReqs = {}
  self._cfg = cfg
  self._cfgEventPoint = Cfg.cfg_season_map_eventpoint[cfg.ID]
  if not self._cfgEventPoint then
    Log.error("SMazeMapHistoryEventpoint cfg_season_map_eventpoint 无法找到ID ", cfg.ID)
    return
  end
  self:_InitPR()
  self._status = self._cfg.Status
  local modelName = self._cfgEventPoint.ModelRes[self._status]
  if not modelName then
    Log.error("SMazeMapHistoryEventpoint cfg_season_map_eventpoint modelName is null , id = " .. self._cfg.ID .. "  status = " .. self._status)
    return
  end
  local go = self:_LoadPrefab(modelName)
  self._transform = go.transform
  self._animation = go:GetComponent(typeof(UnityEngine.Animation))
  if root then
    self._transform:SetParent(root.transform)
  end
  self._transform.position = Vector3(self._position.x, self._position.y, self._position.z)
  self._transform.rotation = self._rotation
  self._transform.localScale = Vector3(self._cfgEventPoint.Scale, self._cfgEventPoint.Scale, self._cfgEventPoint.Scale)
  local animationEffect = self._cfgEventPoint["AnimationEffect" .. self._status]
  if animationEffect then
    local anim = animationEffect.anim
    local holder = animationEffect.holder
    local effectName = animationEffect.effect
    self:PlayAnimation(anim)
    if effectName then
      local bone = self:GetBoneNode(holder)
      local effectGO = self:_LoadPrefab(effectName)
      effectGO:SetActive(true)
      effectGO.transform:SetParent(bone)
      effectGO.transform.localPosition = Vector3.zero
      effectGO.transform.localRotation = Quaternion.Euler(0, 0, 0)
    end
  end
end

function SMazeMapHistoryEventpoint:_InitPR()
  self._position = Vector3.zero
  self._rotation = Quaternion.Euler(0, 0, 0)
  if self._cfgEventPoint.Position then
    self._position = Vector3(self._cfgEventPoint.Position[1], self._cfgEventPoint.Position[2], self._cfgEventPoint.Position[3])
  end
  if self._cfgEventPoint.Rotation then
    self._rotation = Quaternion.Euler(self._cfgEventPoint.Rotation[1], self._cfgEventPoint.Rotation[2], self._cfgEventPoint.Rotation[3])
  end
end

function SMazeMapHistoryEventpoint:GetBoneNode(boneName)
  if not boneName then
    return self._transform
  else
    local boneTransform = GameObjectHelper.FindChild(self._transform, boneName)
    if boneTransform then
      return boneTransform
    end
    return self._transform
  end
end

function SMazeMapHistoryEventpoint:PlayAnimation(name)
  if not self._animation or not name then
    return
  end
  local animationState = self._animation:get_Item(name)
  if animationState then
    Log.info("SMazeMapHistoryEventpointMgr animation ", self._id, " aniName = ", name)
    self._animation:Play(animationState.name)
  end
  return animationState
end

function SMazeMapHistoryEventpoint:Dispose()
  for key, req in pairs(self._resReqs) do
    req:Dispose()
  end
  self._resReqs = nil
end

function SMazeMapHistoryEventpoint:_LoadPrefab(name)
  local req = ResourceManager:GetInstance():SyncLoadAsset(name, LoadType.GameObject)
  req.Obj:SetActive(true)
  table.insert(self._resReqs, req)
  return req.Obj
end
