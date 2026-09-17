local this = class("petHouseTimelineControl")

function this:ctor()
  self._clipMap = {}
  self._timelineState = require("ui.manager.pet.timeline.petHouseTimelineState").new()
  self._timelinePrefabHandle = require("ui.manager.pet.timeline.petHouseTimelinePrefabHandle").new(false, true)
  self._timelineSceneHandle = require("ui.manager.pet.timeline.petHouseTimelineSceneHandle").new(self._timelinePrefabHandle)
  self._petAvatarHandle = require("ui.pages.pet.timeline.petAvatarHandle").new(self._timelinePrefabHandle)
  self._timelinePrefabHandle:resetCamera(true)
  self._timelineState.control = self
  self._timelinePrefabHandle.control = self
  self._timelineName = nil
  self._state = L_Const.petTimelineState.Main
  self.assetActive = true
  self._timelineAssetName = self._timelineState.timelineAssetName.None
  self._timelinePrefabHandle.timelinePlayedHandle = handler(self, self.timelinePlayedHandle)
  self._timelinePrefabHandle.timelineStopHandle = handler(self, self.timelineStopHandle)
  self._timelinePrefabHandle.timelineLoadedHandle = handler(self, self.loadTimelineAssetFinishHandle)
  self.onPlayTimelineAssetHandle = nil
  self.onPlayEndTimelineAssetHandle = nil
  self.petBreed1Str = "PetBreed1"
  self.petBreed2Str = "PetBreed2"
end

function this:timelinePlayedHandle(timelineName, director)
  if self._timelineState == nil then
    return
  end
  if self.onPlayTimelineAssetHandle then
    self.onPlayTimelineAssetHandle(director, timelineName)
  end
end

function this:timelineStopHandle(timelineName)
  if self._timelineState == nil then
    return
  end
  if self._timelinePrefabHandle:getTimelineName() ~= timelineName then
    return
  end
  if self._timelineState:getState(timelineName) then
    local assetName = self._timelineState:getNextStateTransitionAssetName(timelineName, self._state)
    if not string.isEmpty(assetName) then
      self:tryChangNextTimelineState(assetName)
    end
  end
  if self.onPlayEndTimelineAssetHandle then
    self.onPlayEndTimelineAssetHandle()
  end
end

function this:loadTimelineAssetFinishHandle(timelineAssetName)
  if self._timelineState == nil then
    return
  end
  if self._timelineState:getState(timelineAssetName) then
    self._state = self._timelineState:getState(timelineAssetName)
  end
  self._timelineAssetName = timelineAssetName
  if self.onPlayTimelineAssetHandle then
    self.onPlayTimelineAssetHandle()
  end
  self._timelinePrefabHandle:playTimelineAsset(timelineAssetName)
end

function this:tryChangNextTimelineState(timelineAssetName)
  self:loadTimelineAsset(timelineAssetName)
end

function this:loadTimelineAsset(timelineAssetName)
  self.onPlayTimelineAssetHandle = nil
  self._timelinePrefabHandle:loadTimelinePrefab(timelineAssetName)
end

function this:loadEggHatchTimeline()
  local timeName = "pre_egghatch"
  self.onPlayTimelineAssetHandle = nil
  self._timelinePrefabHandle:loadEggHatchPrefab("pre_egghatch")
  local state = self._timelinePrefabHandle:getTimelineState(timeName)
  if state then
    local dynamicBinds = {}
    for i, v in pairs(state.actorPlayerInfos) do
      if v.name == "egg" then
        local egg = self._timelineSceneHandle:getHatchEggPrefab()
        if egg then
          local bindInfo = require("ui.manager.hero.timeline.petTimelineDynamicBindInfo").new()
          bindInfo:setGameObject(egg)
          dynamicBinds[v.actorPath] = bindInfo
        end
      end
    end
    self._timelinePrefabHandle:bindMainPlayerByPrefab(timeName, dynamicBinds)
    self._timelinePrefabHandle:bindMainPlayer(timeName, dynamicBinds)
  end
end

function this:loadBreedPetTimeline(dynamicBinds)
  local timeName = "pre_petbreed"
  self.onPlayTimelineAssetHandle = nil
  self._timelinePrefabHandle:loadBreedPetPrefab(timeName)
  local state = self._timelinePrefabHandle:getTimelineState(timeName)
  if state then
    local dynamicBinds2 = {}
    for i, v in pairs(state.actorPlayerInfos) do
      if dynamicBinds[v.name] then
        dynamicBinds2[v.actorPath] = dynamicBinds[v.name]
      end
    end
    self._timelinePrefabHandle:bindMainPlayerByPrefab(timeName, dynamicBinds2)
    self._timelinePrefabHandle:bindMainPlayer(timeName, dynamicBinds2)
  end
end

function this:disableEggHatchPrefab()
  self._timelinePrefabHandle:disableEggHatchPrefab()
end

function this:disableBreedPetPrefab()
  self._timelinePrefabHandle:disableBreedPetPrefab()
end

function this:getFilePath(timelineName)
  local lowerName = string.lower(timelineName)
  local path = "Timeline/UI/PetHouse/" .. timelineName .. "/pre_pethousecamera_" .. lowerName .. ".prefab"
  return path
end

function this:dispose()
  if self._petAvatarHandle then
    self._petAvatarHandle:dispose()
  end
  self._petAvatarHandle = nil
  if self._timelineState then
    self._timelineState:dispose()
  end
  self._timelineState = nil
  if self._timelineSceneHandle then
    self._timelineSceneHandle:dispose()
  end
  self._timelineSceneHandle = nil
  if self._timelinePrefabHandle then
    self._timelinePrefabHandle:resetCamera(false)
    self._timelinePrefabHandle:dispose()
  end
  self._timelinePrefabHandle = nil
  self.onPlayTimelineAssetHandle = nil
end

function this:getIsStartAni()
  return self._timelineState:getIsStartAni(self._timelineAssetName)
end

function this:isTranstion()
  return self._timelineState:getIsTransition(self._timelineAssetName)
end

function this:getState()
  return self._timelineState:getState(self._timelineAssetName)
end

function this:setAssetsActive(isActive)
  self._timelineSceneHandle:setAssetsActive(isActive)
end

function this:playTimelineState(state, isForce, isInit)
  self._state = state
  isForce = true
  if isForce then
    local timelineAssetName
    if isInit then
      if state == L_Const.petTimelineState.Main then
        timelineAssetName = self._timelineState.timelineAssetName.MainLoop
      elseif state == L_Const.petTimelineState.Breed then
        timelineAssetName = self._timelineState.timelineAssetName.BreedLoop
      elseif state == L_Const.petTimelineState.EggHouse then
        timelineAssetName = self._timelineState.timelineAssetName.EggHouseLoop
      elseif state == L_Const.petTimelineState.Shop then
        timelineAssetName = self._timelineState.timelineAssetName.ShopLoop
      end
    end
    if timelineAssetName == nil then
      timelineAssetName = self._timelineState:getNextStateTransitionAssetName(self._timelineAssetName, self._state)
    end
    if timelineAssetName == nil then
    else
      self:tryChangNextTimelineState(timelineAssetName)
    end
  end
end

function this:loadTimelinePrefab(name)
  self._timelineName = name
  self._state = self._timelineState:getState(name)
  self.onPlayTimelineAssetHandle = nil
  self._timelinePrefabHandle:loadTimelinePrefab(name)
end

function this:getCamera()
  return self._timelinePrefabHandle._camera
end

function this:sceneNpcLoadAiBehaviorByState(unitId, state)
  self._timelineSceneHandle:sceneNpcLoadAiBehaviorByState(unitId, state)
end

return this
