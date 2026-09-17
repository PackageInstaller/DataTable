local this = class("entrustTimelineControl", require("ui.manager.hero.timeline.timelineControl"))

function this:ctor()
  self._timelineState = require("ui.pages.entrustTask.timeline.entrustTimelineState").new()
  self._timelinePrefabHandle = require("ui.pages.entrustTask.timeline.entrustTimelinePrefabHandle").new(false, true)
  self._timelinePrefabHandle._camera = C_CameraManager.mainCamera
  self._timelineAssetHandle = require("ui.manager.hero.timeline.timelineAssetHandle").new()
  self._timelineActorHandle = require("ui.pages.entrustTask.timeline.entrustTimelineActorHandle").new(self._timelinePrefabHandle)
  self._timelineSceneHandle = require("ui.pages.entrustTask.timeline.entrustTimelineSceneHandle").new(self._timelinePrefabHandle)
  self._timelineState.control = self
  self._timelinePrefabHandle.control = self
  self._timelineAssetHandle.control = self
  self._timelineName = nil
  self._loadingTimelineName = nil
  self._state = L_Const.EntrustTimelineState.None
  self.assetActive = true
  self._timelineAssetName = self._timelineState.timelineAssetName.None
  self._timelinePrefabHandle.timelinePlayedHandle = handler(self, self.timelinePlayedHandle)
  self._timelinePrefabHandle.timelineStopHandle = handler(self, self.timelineStopHandle)
  self._timelinePrefabHandle.timelineLoadedHandle = handler(self, self.timelineLoadedHandle)
  self._timelinePrefabHandle.timelineCustomEventHandle = handler(self, self.timelineCustomEventHandle)
  self._timelineAssetHandle.loadTimelineAssetFinishHandle = handler(self, self.loadTimelineAssetFinishHandle)
  self.timelineCustomEvent = nil
  self.onPlayTimelineAssetHandle = nil
end

function this:timelineCustomEventHandle(str1, str2, str3)
  if self.timelineCustomEvent then
    self.timelineCustomEvent(str1, str2, str3)
  end
end

function this:setTimeLineState(state)
  if self._timelineState then
    self._timelineState:dispose()
  end
  self._timelineState = state
end

function this:getTimelineAssetName(state)
  if self._timelineState.getTimelineAssetName then
    return self._timelineState:getTimelineAssetName(state)
  end
  local timelineAssetName
  if state == L_Const.EntrustTimelineState.Main then
    timelineAssetName = self._timelineState.timelineAssetName.UIMain_Start
  elseif state == L_Const.EntrustTimelineState.Select then
    timelineAssetName = self._timelineState.timelineAssetName.UIMain_To_Select
  elseif state == L_Const.EntrustTimelineState.None then
    timelineAssetName = self._timelineState.timelineAssetName.UIMain_To_None
    return timelineAssetName
  end
end

function this:onCustomTimeineEventHandle(str1, str2, str3)
  if self.customEventHandle then
    self.customEventHandle(str1, str2, str3)
  end
end

function this:tryChangNextTimelineState(timelineAssetName)
  if timelineAssetName == self._timelineState.timelineAssetName.None then
    return
  end
  self._timelineAssetHandle:loadTimelineAsset(self._timelinePrefabHandle:getTimelineName(), timelineAssetName)
end

function this:loadTimelineAsset(timelineAssetName)
  self._timelinePrefabHandle:setRootName(timelineName)
  self.onPlayTimelineAssetHandle = nil
  self._timelinePrefabHandle:loadTimelinePrefab(timelineAssetName)
end

function this:getFilePath(timelineName)
  local lowerName = string.lower(timelineName)
  local path = "Timeline/UI/entrust/" .. timelineName .. "/pre_entrustcamera_" .. lowerName .. ".prefab"
  local path = "" .. timelineName .. "/pre_ui_timelineAsset.prefab"
  return path
end

function this:dispose()
  self.isDispose = true
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
  if self._timelineAssetHandle then
    self._timelineAssetHandle:dispose()
  end
  self._timelineAssetHandle = nil
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
    if isInit then
      if state == L_Const.EntrustTimelineState.Main then
        timelineAssetName = self._timelineState.timelineAssetName.UIMain_Loop
      else
        timelineAssetName = self._timelineState.timelineAssetName.None
      end
    end
    if self._timelineState ~= nil and (timelineAssetName == nil or timelineAssetName == self._timelineState.timelineAssetName.None) then
      timelineAssetName = self._timelineState:getNextStateTransitionAssetName(self._timelineAssetName, self._state)
    end
    if not timelineAssetName then
      return
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
  local assetName = self._timelineState:getNextStateTransitionAssetName(self._timelineAssetName, self._state)
  self:tryChangNextTimelineState(assetName)
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

function this:asyncLoadTimelineAssetsNew(timelineName, timelineAssetName, sceneName, heroId, isFirstInit, onPreloadEnd, onAllLoaded, prefabPos, prefabRot, senceTime, notSetScenceTime, clothingId)
  local function onAllResourceLoaded()
    self:bindMainPlayer()
    
    self._loadingTimelineName = nil
    if self.transaction then
      self.transaction:dispose()
      self.transaction = nil
    end
    if onAllLoaded then
      onAllLoaded()
    end
    if notSetScenceTime then
    else
      self._timelineSceneHandle:setSceneTime(senceTime, 0)
    end
  end
  
  self.transaction = require("ui.pages.entrustTask.transaction.transaction").new(onAllResourceLoaded)
  self.transaction:Declare({
    self._timelineSceneHandle,
    self._timelineActorHandle,
    self._timelinePrefabHandle,
    self._timelineAssetHandle
  })
  
  local function loadScenePrefab()
    print("开始加载场景")
    if self.isDispose or self._timelineSceneHandle == nil then
      return
    end
    if self._loadingTimelineName ~= timelineName then
      return
    end
    self._timelineSceneHandle:loadScenePrefabAsync(sceneName, self.transaction:GetCallback(self._timelineSceneHandle))
  end
  
  local function loadUnitPrefab()
    if self.isDispose or self._timelineActorHandle == nil then
      return
    end
    if self._loadingTimelineName ~= timelineName then
      return
    end
    if heroId ~= self._timelineActorHandle._heroId then
      self._timelineAssetHandle._curTimelineAssetName = nil
    end
    if prefabPos then
      self._timelineActorHandle:setPrefabPos(prefabPos)
    end
    if prefabRot then
      self._timelineActorHandle:setPrefabRot(prefabRot)
    end
    print("开始加载角色")
    self._timelineActorHandle:asyncloadActorPrefab(heroId, self.transaction:GetCallback(self._timelineActorHandle), clothingId)
  end
  
  local function loadTimelineAsset()
    self._timelineAssetHandle:loadTimelineAsset(timelineName, timelineAssetName, self.transaction:GetCallback(self._timelineAssetHandle))
  end
  
  local function loadTimelinePrefab()
    if self.isDispose or self._timelinePrefabHandle == nil then
      return
    end
    self._timelineName = timelineName
    self._state = L_Const.EntrustTimelineState.Main
    if prefabPos then
      self._timelinePrefabHandle:setPrefabPos(prefabPos)
    end
    if prefabRot then
      self._timelinePrefabHandle:setPrefabRot(prefabRot)
    end
    print("开始加载timeline预制体")
    local func = self.transaction:GetCallback(self._timelinePrefabHandle)
    self._timelinePrefabHandle:loadTimelinePrefabAsync(timelineName, function()
      if self.isDispose or self.transaction == nil then
        return
      end
      func()
      func()
      loadTimelineAsset()
    end)
  end
  
  self._loadingTimelineName = timelineName
  loadUnitPrefab()
  loadScenePrefab()
  loadTimelinePrefab()
end

function this:loadTimelineAssetsSync(timelineName, timelineAssetName, sceneName, heroId, onPreloadEnd, onAllLoaded, prefabPos, prefabRot, senceTime, notSetSceneTime, clothingId)
  if self.isDispose then
    return
  end
  self._timelinePrefabHandle:setRootName(timelineName)
  self._timelineName = timelineName
  self._state = L_Const.EntrustTimelineState.Main
  self._loadingTimelineName = nil
  if sceneName and self._timelineSceneHandle then
    self._timelineSceneHandle:loadScenePrefab(sceneName)
  end
  if timelineName and self._timelinePrefabHandle then
    if prefabPos then
      self._timelinePrefabHandle:setPrefabPos(prefabPos)
    end
    if prefabRot then
      self._timelinePrefabHandle:setPrefabRot(prefabRot)
    end
    self._timelinePrefabHandle:loadTimelinePrefab(timelineName)
  end
  if onPreloadEnd then
    onPreloadEnd()
  end
  
  local function finishAll()
    if not notSetSceneTime and senceTime ~= nil and self._timelineSceneHandle then
      self._timelineSceneHandle:setSceneTime(senceTime, 0)
    end
    if onAllLoaded then
      onAllLoaded()
    end
  end
  
  local function onLoadTimelineAssetFinish()
    if heroId and self._timelineActorHandle then
      if prefabPos then
        self._timelineActorHandle:setPrefabPos(prefabPos)
      end
      if prefabRot then
        self._timelineActorHandle:setPrefabRot(prefabRot)
      end
      self._timelineActorHandle:loadUnitPrefab(heroId, finishAll, clothingId)
    else
      finishAll()
    end
  end
  
  self._timelineAssetHandle:loadTimelineAsset(timelineName, timelineAssetName, onLoadTimelineAssetFinish)
end

function this:setSceneTime(sceneTime)
  if sceneTime == nil then
    return
  end
  self._timelineSceneHandle:setSceneTime(sceneTime, 0)
end

function this:loadTimelinePrefab(name)
  self._timelineName = name
  self._state = L_Const.EntrustTimelineState.Main
  self._timelinePrefabHandle:loadTimelinePrefab(name)
  self:bindMainPlayer()
end

function this:loadScene(sceneName, callBcak)
  local function onAllResourceLoaded()
    if self.transaction then
      self.transaction:dispose()
      
      self.transaction = nil
    end
    if callBcak then
      callBcak()
    end
  end
  
  self.transaction = require("ui.pages.entrustTask.transaction.transaction").new(onAllResourceLoaded)
  self._timelineSceneHandle:loadScenePrefabAsync(sceneName, self.transaction:GetCallback(self._timelineSceneHandle))
end

function this:loadSceneNew(sceneName, callBcak)
  self._timelineSceneHandle:loadScenePrefabAsync(sceneName, callBcak)
end

function this:unloadScene(sceneName)
  self._timelineSceneHandle:disPoseSingle(sceneName)
end

function this:setSceneActiveByName(name, isActive)
  if self._timelineSceneHandle == nil then
    return
  end
  self._timelineSceneHandle:setSceneActiveByName(name, isActive)
end

function this:isSceneActive(name)
  if self._timelineSceneHandle == nil then
    return true
  end
  return self._timelineSceneHandle:isSceneActive(name)
end

function this:setActorPosition(pos)
  self._timelineActorHandle:setPrefabPos(pos)
  self._timelinePrefabHandle:setPrefabPos(pos)
end

function this:setCustomAvatarData(avatarData)
  self._timelineActorHandle.customAvatarData = avatarData
end

function this:getCurHeroPrefab()
  local hero = self._timelineActorHandle:getCurHero()
  return hero
end

function this:setSceneActive(isActive)
  self._timelineSceneHandle:setSceneActive(isActive)
end

function this:setActorActive(isActive)
  self._timelineActorHandle:setActorActive(isActive)
end

function this:setTimelineActive(isActive)
  self:setSceneActive(isActive)
  self:setActorActive(isActive)
end

function this:setActorTrans(pos, rot)
  if self._timelineActorHandle then
    self._timelineActorHandle:setPrefabTrans(pos, rot)
    print("设置角色位置")
  end
end

function this:setTimeLineTrans(pos, rot)
  if self._timelinePrefabHandle then
    self._timelinePrefabHandle:setTimelineTrans(pos, rot)
  end
end

function this:setCameraTimelineActive(isActive)
  if self._timelinePrefabHandle then
    self._timelinePrefabHandle:setCameraTimelineActive(isActive)
  end
end

function this:setStateWithoutPlay(state, timelineAssetsName)
  if state then
    self._state = state
  end
  if timelineAssetsName then
    self._timelineAssetName = timelineAssetsName
  end
end

return this
