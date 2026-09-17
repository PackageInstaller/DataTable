local this = class("rogueEntryTimelinePrefabHandle", require("ui.manager.hero.timeline.timelinePrefabHandle"))
local TimelineSpliteHelper = CS.Gameplay.Tools.TimelineSplitTool.TimelineSpliteHelper

function this:ctor(createCamera, isUI)
  self._lastBindTimelineName = nil
  self._lastBindHeroId = nil
  self._lastTimelineAssetName = nil
  self._clipMap = {}
  self._clipHandleMap = {}
  self._dictStringDictStringListObj = {}
  self.prefabPos = nil
  self.prefabRot = nil
  this.super.ctor(self, createCamera, isUI)
end

function this:dispose()
  if self._clipMap then
    for i, v in pairs(self._clipMap) do
      for _i, _v in pairs(v) do
        C_LuaUtility.ReleaseTimelineAsset(_v)
        v[_i] = nil
      end
      self._clipMap[i] = nil
    end
    self._clipMap = nil
  end
  if self._clipHandleMap then
    for i, v in pairs(self._clipHandleMap) do
      for _i, _v in pairs(v) do
        if _v then
          C_LuaUtility.DestroyTimelineAsset(_v)
        end
      end
    end
    self._clipHandleMap = nil
  end
  if self._dictStringDictStringListObj then
    for k, v in pairs(self._dictStringDictStringListObj) do
      if v then
        for i = 0, v.Count - 1 do
          CS.Azur.Gameplay.Core.Asset.AssetManager.Instance:DestroyNewAsset(v[i])
        end
        v:Clear()
      end
    end
    self._dictStringDictStringListObj = nil
  end
  self.isDispose = true
  this.super.dispose(self)
  self:clearLoadHeroSchedulerId()
  self._timelineStateMap = {}
end

function this:getTimelineStateComponent(prefab)
  return prefab:GetComponent(typeof(CS.Gameplay.Tools.TimelineSplitTool.TimelineHeroState))
end

function this:setAssetsActive(isActive)
  local state = self._timelineStateMap[self._timelineName]
  if state then
    local trans = state.transform
    for i = 0, trans.childCount - 1 do
      local child = trans:GetChild(i).gameObject
      if child.name ~= "[sequence]" then
        child:ActiveTrans(isActive)
      end
    end
  end
end

function this:setPrefabActive(isActive)
  local state = self._timelineStateMap[self._timelineName]
  if state then
    local trans = state.transform
    trans:ActiveTrans(isActive)
  end
end

function this:getFilePath(timelineName)
  local path = timelineName .. "/pre_ui_timelineAsset.prefab"
  return path
end

function this:loadTimelinePrefab(timelineName)
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
    prefab = L_ResPool:syncGameObject(prefabPath)
    prefab.transform.parent = self._root.transform
  end
  L_Vector3.setLocalPos(prefab.transform, L_Vector3.getTemp(-50.17, 16.08, -97.91))
  L_Vector3.setRot(prefab.transform, L_Vector3.getTemp())
  self:loadTimelinePrefabFinish(timelineName, prefab)
end

function this:IsTimelineInPool(timelineName)
  if self._prefabMap[timelineName] then
    return true
  else
    return false
  end
end

function this:loadTimelinePrefabAsync(timelineName, onLoaded)
  if self._timelineName == timelineName then
    return
  end
  
  local function onResourceLoaded(id, prefab)
    if self.isDispose then
      return
    end
    prefab.transform.parent = self._root.transform
    if self.prefabPos then
      L_Vector3.setLocalPos(prefab.transform, L_Vector3.getTemp(-50.17, 16.08, -97.91))
      self.prefabPos = nil
    else
      L_Vector3.setLocalPos(prefab.transform, L_Vector3.getTemp())
    end
    if self.prefabRot then
      L_Vector3.setRot(prefab.transform, L_Vector3.getTemp(self.prefabRot.x, self.prefabRot.y, self.prefabRot.z))
      self.prefabRot = nil
    else
      L_Vector3.setRot(prefab.transform, L_Vector3.getTemp())
    end
    self:loadTimelinePrefabFinish(timelineName, prefab)
    if onLoaded then
      onLoaded()
    end
  end
  
  if self._prefabMap[self._timelineName] then
    self._prefabMap[self._timelineName]:ActiveTrans(false)
  end
  local prefab
  if self._prefabMap[timelineName] then
    prefab = self._prefabMap[timelineName]
  else
    local prefabPath = self:getFilePath(timelineName)
    prefab = L_ResPool:asyncGameObject(prefabPath, onResourceLoaded)
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

function this:schedulerCheckHeroLoadStatus(actorInfo, onLoaded)
  self:clearLoadHeroSchedulerId()
  if onLoaded ~= nil then
    self._schedulerId = Timer.repeated(0.01, function()
      if self:checkHeroIsLoadFinish(actorInfo) then
        self:clearLoadHeroSchedulerId()
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
  local partDict = biologyData:GetListPart()
  if partDict == nil then
    return false
  end
  local haveValue = false
  for i, v in pairs(partDict) do
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
      state:RegisterReceiverFromActor(hero.actor)
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

function this:loadTimelineAsset(timelineName, timelineAssetName, customCallback)
  local clipPath = self:getTimelineFilePath(timelineName, timelineAssetName)
  self._clipMap[timelineName] = self._clipMap[timelineName] or {}
  self._clipHandleMap[timelineName] = self._clipHandleMap[timelineName] or {}
  local timelineAsset = self._clipMap[timelineName][timelineAssetName]
  if timelineAsset then
    if customCallback then
      customCallback(timelineName, timelineAssetName, timelineAsset)
    else
      self:loadTimelineAssetFinish(timelineName, timelineAssetName, timelineAsset)
    end
    return
  end
  local handle
  handle = C_LuaUtility.LoadTimelineAsset(clipPath, function(_timelineAsset)
    if self.control == nil then
      return
    end
    if self._clipMap == nil then
      return
    end
    local TimelineUtility = CS.Lens.Gameplay.Tools.TimelineExtensions.TimelineUtility
    local tempList = CS.System.Collections.Generic.List(CS.UnityEngine.Object)()
    TimelineUtility.InstantiateSubAssets(_timelineAsset, {
      typeof(CS.UnityEngine.Timeline.AvatarAnimationTrack)
    }, nil, tempList)
    self._clipMap[timelineName][timelineAssetName] = _timelineAsset
    if self._dictStringDictStringListObj[clipPath] then
      self._dictStringDictStringListObj[clipPath]:AddRange(tempList)
    else
      self._dictStringDictStringListObj[clipPath] = tempList
    end
    if customCallback then
      customCallback(timelineName, timelineAssetName, _timelineAsset)
    else
      self:loadTimelineAssetFinish(timelineName, timelineAssetName, _timelineAsset)
    end
  end)
  self._clipHandleMap[timelineName][timelineAssetName] = handle
end

function this:getTimelineFilePath(timelineName, timelineAssetName)
  local path = timelineName .. "/timeline_" .. timelineAssetName .. ".playable"
  return path
end

return this
