local this = class("rogueEntryTimelineControl", require("ui.manager.hero.timeline.timelineControl"))

function this:ctor()
  self._timelineState = require("ui.pages.rogue.timeline.rogueEntryTimelineState").new()
  self._timelinePrefabHandle = require("ui.pages.rogue.timeline.rogueEntryTimelinePrefabHandle").new(false, true)
  self._timelinePrefabHandle._camera = C_CameraManager.mainCamera
  self._timelineSceneHandle = require("ui.pages.rogue.timeline.rogueEntryTimelineSceneHandle").new(self._timelinePrefabHandle)
  self._timelineAssetHandle = require("ui.manager.hero.timeline.timelineAssetHandle").new()
  self._timelineActorHandle = require("ui.pages.rogue.timeline.rogueEntryTimelineActorHandle").new(self._timelinePrefabHandle)
  self._timelineState.control = self
  self._timelinePrefabHandle.control = self
  self._timelineAssetHandle.control = self
  self._timelineName = nil
  self._loadingTimelineName = nil
  self._state = L_Const.RogueEntryTimelineState.None
  self.assetActive = true
  self._timelineAssetName = self._timelineState.timelineAssetName.None
  self._timelinePrefabHandle.timelinePlayedHandle = handler(self, self.timelinePlayedHandle)
  self._timelinePrefabHandle.timelineStopHandle = handler(self, self.timelineStopHandle)
  self._timelinePrefabHandle.timelineLoadedHandle = handler(self, self.timelineLoadedHandle)
  self._timelinePrefabHandle.timelineCustomEventHandle = handler(self, self.timelineCustomEventHandle)
  self._timelineAssetHandle.loadTimelineAssetFinishHandle = handler(self, self.loadTimelineAssetFinishHandle)
  self.timelineCustomEvent = nil
  self.onPlayTimelineAssetHandle = nil
  self.loopNumber = 0
  self.randomLoopNumber = 0
  self.randomActionId = 0
  self.isLoopState = false
end

function this:timelineCustomEventHandle(str1, str2, str3)
  if self.timelineCustomEvent then
    self.timelineCustomEvent(str1, str2, str3)
  end
end

function this:getTimelineAssetName(state)
  local timelineAssetName
  if state == L_Const.RogueEntryTimelineState.Start then
    timelineAssetName = self._timelineState.timelineAssetName.UIRogue_Start
  elseif state == L_Const.RogueEntryTimelineState.Loop then
    timelineAssetName = self._timelineState.timelineAssetName.UIRogue_loop
  elseif state == L_Const.RogueEntryTimelineState.Action1 then
    timelineAssetName = self._timelineState.timelineAssetName.UIRogue_loop_action01
  elseif state == L_Const.RogueEntryTimelineState.Action2 then
    timelineAssetName = self._timelineState.timelineAssetName.UIRogue_loop_action02
  end
  return timelineAssetName
end

function this:onCustomTimeineEventHandle(str1, str2, str3)
  if self.customEventHandle then
    self.customEventHandle(str1, str2, str3)
  end
end

function this:tryChangNextTimelineState(timelineAssetName)
  self._timelineAssetHandle:loadTimelineAsset(self._timelinePrefabHandle:getTimelineName(), timelineAssetName)
end

function this:loadTimelineAsset(timelineAssetName)
  self.onPlayTimelineAssetHandle = nil
  self._timelinePrefabHandle:loadTimelinePrefab(timelineAssetName)
end

function this:getFilePath(timelineName)
  local lowerName = string.lower(timelineName)
  local path = "" .. timelineName .. "/pre_ui_timelineAsset.prefab"
  return path
end

function this:dispose()
  if self._timelineState then
    self._timelineState:dispose()
  end
  self._timelineState = nil
  if self._timelineSceneHandle then
    self._timelineSceneHandle:dispose()
  end
  self._timelineSceneHandle = nil
  if self._timelinePrefabHandle then
    self._timelinePrefabHandle:dispose()
  end
  self._timelinePrefabHandle = nil
  self.onPlayTimelineAssetHandle = nil
  self.super.dispose(self)
  if self.transaction then
    self.transaction:dispose()
    self.transaction = nil
  end
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
  self.assetActive = isActive
  self._timelinePrefabHandle:setAssetsActive(isActive)
end

function this:playTimelineState(state, isForce, isInit)
  self._state = state
  isForce = true
  if isForce then
    local timelineAssetName
    if isInit and state == L_Const.RogueEntryTimelineState.Start then
      timelineAssetName = self._timelineState.timelineAssetName.UIRogue_Start
    end
    if timelineAssetName == nil then
      timelineAssetName = self._timelineState.timelineAssetName.UIRogue_loop
    end
    self:tryChangNextTimelineState(timelineAssetName)
  end
end

function this:getCamera()
  return self._timelinePrefabHandle._camera
end

function this:sceneNpcLoadAiBehaviorByState(unitId, state)
  self._timelineSceneHandle:sceneNpcLoadAiBehaviorByState(unitId, state)
end

function this:bindMainPlayer()
  do return end
  local state = self._timelinePrefabHandle:getTimelineState(self._timelinePrefabHandle._timelineName)
  local hero = self._timelineActorHandle:getCurHero()
  if state and hero then
    local bindingPath = state.mainBindingName
    if not string.isEmpty(bindingPath) then
      local paths = string.split(bindingPath, "/")
      local path = ""
      for i, v in ipairs(paths) do
        if i ~= #paths then
          if i == 1 then
            path = v
          else
            path = path .. "/" .. v
          end
        end
      end
      local parent = state.transform:Find(path, true)
      if parent == nil then
        return
      end
      local heroTrans = hero:getGameObject().transform
      local reset = heroTrans.parent ~= parent
      heroTrans.parent = parent
      if reset then
        L_Vector3.setLocalPos(heroTrans.transform, L_Vector3.getTemp())
        L_Vector3.setLocalRot(heroTrans.transform, L_Vector3.getTemp())
      end
    end
  end
end

function this:timelinePlayedHandle(timelineName)
  if self._timelineState == nil then
    return
  end
  if self._timelinePrefabHandle:getTimelineName() ~= timelineName then
    return
  end
  self:bindMainPlayer()
end

function this:timelineLoadedHandle(timelineName)
end

function this:timelineStopHandle(timelineName)
  if self._timelineState == nil then
    return
  end
  if self._timelinePrefabHandle:getTimelineName() ~= timelineName then
    return
  end
  local nextAssetName
  if self._timelineAssetName == self._timelineState.timelineAssetName.UIRogue_Start then
    self.randomLoopNumber = math.random(2, 5)
    self.randomActionId = math.random(1, 2)
  end
  nextAssetName = self._timelineState:getNextStateTransitionAssetName(self._timelineAssetName, self._state, self.loopNumber > self.randomLoopNumber, self.randomActionId)
  if nextAssetName == self._timelineState.timelineAssetName.UIRogue_loop then
    self:tryChangNextTimelineState(nextAssetName)
    self.loopNumber = self.loopNumber + 1
  else
    self:tryChangNextTimelineState(nextAssetName)
    self.randomActionId = math.random(1, 2)
    self.loopNumber = 0
  end
end

function this:loadTimelineAssetFinishHandle(timelineName, timelineAssetName, timelineAsset)
  if self._timelineState == nil then
    return
  end
  if self._timelinePrefabHandle:getTimelineName() ~= timelineName then
    return
  end
  self._timelinePrefabHandle:setAssetsActive(self.assetActive)
  self._timelineAssetName = timelineAssetName
  if self.onPlayTimelineAssetHandle then
    self.onPlayTimelineAssetHandle()
  end
  local hero = self._timelineActorHandle:getCurHero()
  self._timelinePrefabHandle:playTimelineAsset(timelineAsset, hero)
end

function this:checkPlayTimelineState(state, showHero, lastShowHero)
  if showHero then
    if self._state ~= state or self._timelineAssetHandle._curTimelineName ~= self._timelineName then
      self:playTimelineState(state, not self:isTranstion(), false)
    else
      if not lastShowHero then
        self:replayTimeline()
      else
      end
    end
  end
end

function this:replayTimeline()
  self._timelinePrefabHandle:replayTimeline()
end

function this:asyncLoadTimelineAssets(timelineName, timelineAssetName, sceneName, heroId, isFirstInit, onPreloadEnd, onAllLoaded, clothingId)
  local function onUnitPrefabLoaded()
    print("onUnitPrefabLoaded begin")
    
    if self._loadingTimelineName ~= timelineName then
      return
    end
    self._timelineSceneHandle:loadScenePrefab(sceneName)
    self:loadTimelinePrefab(timelineName)
    self._loadingTimelineName = nil
    self:setSceneTime()
    if onAllLoaded then
      onAllLoaded()
    end
    Timer.once(0.167, function()
      L_LoadingManager:closeLoading()
    end, self)
  end
  
  local function onPreLoadTimeAssetLoaded()
    print("onPreLoadTimeAssetLoaded INNER begin")
    if self._loadingTimelineName ~= timelineName then
      return
    end
    if onPreloadEnd then
      onPreloadEnd()
    end
    if heroId ~= self._timelineActorHandle._heroId then
      self._timelineAssetHandle._curTimelineAssetName = nil
    end
    self._timelineActorHandle:loadUnitPrefab(heroId, onUnitPrefabLoaded, clothingId)
  end
  
  print("asyncLoadTimelineAssets really begin")
  self._loadingTimelineName = timelineName
  if timelineAssetName ~= nil then
    print("loadTimelineAsset begin")
    self._timelineAssetHandle:loadTimelineAsset(timelineName, timelineAssetName, onPreLoadTimeAssetLoaded)
  else
    print("onPreLoadTimeAssetLoaded begin")
    onPreLoadTimeAssetLoaded()
  end
end

function this:setSceneActive(isActive)
  self._timelineSceneHandle:setSceneActive(isActive)
end

function this:loadTimelinePrefab(name)
  self._timelineName = name
  self._state = L_Const.RogueEntryTimelineState.UIRogue_Start
  self._timelinePrefabHandle:loadTimelinePrefab(name)
  self:bindMainPlayer()
end

function this:setCustomAvatarData(avatarData)
  self._timelineActorHandle.customAvatarData = avatarData
end

function this:getCurHeroPrefab()
  local hero = self._timelineActorHandle:getCurHero()
  return hero
end

function this:setSceneTime()
  local curSenceTime = C_GameTime:GetSceneTimeOfDay()
  local senceTime = 0
  if 600 < curSenceTime and curSenceTime < 1800 then
    senceTime = 1600
  else
    senceTime = 2200
  end
  self._timelineSceneHandle:setSceneTime(senceTime, 0)
end

return this
