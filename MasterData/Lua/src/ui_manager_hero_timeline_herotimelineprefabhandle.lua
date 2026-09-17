local this = class("heroTimelinePrefabHandle", require("ui.manager.hero.timeline.timelinePrefabHandle"))

function this:ctor(createCamera, isUI)
  self._lastBindTimelineName = nil
  self._lastBindHeroId = nil
  self._lastTimelineAssetName = nil
  this.super.ctor(self, createCamera, isUI)
end

function this:dispose()
  self:clearLoadHeroSchedulerId()
  this.super.dispose(self)
end

function this:getTimelineStateComponent(prefab)
  return prefab:GetComponent(typeof(CS.Gameplay.Tools.TimelineSplitTool.TimelineHeroState))
end

function this:setAssetsActive(isActive, exceptCamera)
  local state = self._timelineStateMap[self._timelineName]
  if state then
    local trans = state.transform
    for i = 0, trans.childCount - 1 do
      local childTrans = trans:GetChild(i)
      local child = childTrans.gameObject
      if exceptCamera then
        if child.name == "[assets]" then
          for j = 1, childTrans.childCount - 1 do
            childTrans:GetChild(j):ActiveTrans(isActive)
          end
        elseif child.name ~= "[sequence]" then
          child:ActiveTrans(isActive)
        end
      elseif child.name ~= "[sequence]" then
        child:ActiveTrans(isActive)
      end
    end
  end
end

function this:getFilePath(timelineName)
  local path = timelineName .. "/pre_ui_timelineAsset.prefab"
  return path
end

function this:disposeTimelineAsset(lastName, curName)
  for i, v in pairs(self._prefabMap) do
    if i ~= lastName and i ~= curName then
      C_PrefabManager:RecycleByLoader(v)
      self._prefabMap[i] = nil
      self._timelineStateMap[i] = nil
    end
  end
end

function this:loadTimelinePrefab(timelineName)
  self:setRootName(timelineName)
  if self._timelineName == timelineName then
    return
  end
  if self._prefabMap[self._timelineName] then
    self._prefabMap[self._timelineName]:ActiveTrans(false)
  end
  local prefab
  if self._prefabMap[timelineName] then
    prefab = self._prefabMap[timelineName]
  else
    local prefabPath = self:getFilePath(timelineName)
    prefab = C_UIMgr.uiLoader:Spawn(prefabPath, self._root.transform)
    self:disposeTimelineAsset(self._timelineName, timelineName)
  end
  L_Vector3.setLocalPos(prefab.transform, L_Vector3.getTemp())
  L_Vector3.setRot(prefab.transform, L_Vector3.getTemp())
  self:loadTimelinePrefabFinish(timelineName, prefab)
end

function this:asyncloadTimelinePrefab(timelineName, TimelinePrefabLoadedCallback)
  self:setRootName(timelineName)
  if self._timelineName == timelineName then
    TimelinePrefabLoadedCallback()
    return
  end
  local prefab
  if self._prefabMap[timelineName] then
    if self._prefabMap[self._timelineName] then
      self._prefabMap[self._timelineName]:ActiveTrans(false)
    end
    prefab = self._prefabMap[timelineName]
    self:loadTimelinePrefabFinish(timelineName, prefab)
    TimelinePrefabLoadedCallback()
  else
    local prefabPath = self:getFilePath(timelineName)
    C_UIMgr.uiLoader:SpawnAsync(prefabPath, function(instanceId, obj)
      if self._prefabMap[self._timelineName] then
        self._prefabMap[self._timelineName]:ActiveTrans(false)
      end
      self:disposeTimelineAsset(self._timelineName, timelineName)
      prefab = obj
      L_Vector3.setLocalPos(prefab.transform, L_Vector3.getTemp())
      L_Vector3.setRot(prefab.transform, L_Vector3.getTemp())
      self:loadTimelinePrefabFinish(timelineName, prefab)
      TimelinePrefabLoadedCallback()
    end, self._root.transform, true, C_EAssetOperationModule.Lua, C_AssetLoadPriority.GetPriority(C_AssetLoadPriority.UI_Page))
  end
end

function this:schedulerCheckHeroLoadStatus(actorInfo, onLoaded)
  self:clearLoadHeroSchedulerId()
  C_MJLog.LogDebug("多人测试，obj schedulerCheckHeroLoadStatus", C_ELogModule.Home)
  if onLoaded ~= nil then
    self._schedulerId = Timer.repeated(0.01, function()
      if self:checkHeroIsLoadFinish(actorInfo) then
        self:clearLoadHeroSchedulerId()
        C_MJLog.LogDebug("多人测试，obj onLoaded", C_ELogModule.Home)
        onLoaded()
      end
    end)
  end
end

function this:clearLoadHeroSchedulerId()
  if self._schedulerId then
    Timer.remove(self._schedulerId)
    self._schedulerId = nil
  end
end

function this:checkHeroIsLoadFinish(actorInfo)
  local go = actorInfo:getGameObject()
  if go == nil then
    return false
  end
  local biologyData = L_CommonUtil.getModComponent(typeof(C_BiologyAvatar), go)
  if biologyData == nil then
    return false
  end
  local haveValue = false
  local partList = biologyData:GetListPart()
  for i, v in pairs(partList) do
    haveValue = true
    if not v.isLoaded then
      return false
    end
  end
  if haveValue then
    return true
  end
  return false
end

function this:playTimelineAsset(timelineAsset, hero)
  local state = self._timelineStateMap[self._timelineName]
  if state then
    if self._lastBindTimelineName ~= self._timelineName or self._lastBindHeroId ~= hero.heroId or self._lastTimelineAssetName ~= timelineAsset.name then
      state.director.playableAsset = timelineAsset
      for _, v in pairs(state.timelineBindDatas) do
        v:QuickBind()
      end
      local dynamicBinds = {}
      local actorInfo = state:GetActorPlayerInfoByActorPath(state.mainBindingName)
      if actorInfo then
        dynamicBinds[actorInfo.actorPath] = hero
      end
      self:bindMainPlayerByPrefab(self._timelineName, dynamicBinds)
      self:bindMainPlayer(self._timelineName, dynamicBinds)
      state.director:SetGenericBinding()
      local cam01 = state.transform:Find("[assets]/cam_G/cam_R/cam01")
      if cam01 then
        cam01:GetComponent(typeof(C_CinemachineVirtualCamera)).Priority = 1000
      end
      self._lastBindHeroId = hero.heroId
      self._lastBindTimelineName = self._timelineName
      self._lastTimelineAssetName = timelineAsset.name
    end
    if self._camera then
      state:SetCamera(self._camera)
    end
    if self:checkHeroIsLoadFinish(hero) then
      state.director:Play()
    else
      errorf("hero 没有加载完成")
    end
  end
end

function this:setCamera(camera)
  self._camera = camera
end

return this
