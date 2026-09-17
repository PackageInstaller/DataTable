local this = class("timelineControl")

function this:ctor()
  self._timelineState = require("ui.manager.hero.timeline.timelineState").new()
  self._timelinePrefabHandle = require("ui.manager.hero.timeline.heroTimelinePrefabHandle").new(false, true)
  self._timelinePrefabHandle._camera = C_CameraManager.mainCamera
  self._timelineAssetHandle = require("ui.manager.hero.timeline.timelineAssetHandle").new()
  self._timelineActorHandle = require("ui.manager.hero.timeline.timelineActorHandle").new(self._timelinePrefabHandle)
  self._timelineSceneHandle = require("ui.manager.hero.timeline.timelineSceneHandle").new(self._timelinePrefabHandle)
  self._timelineState.control = self
  self._timelinePrefabHandle.control = self
  self._timelineAssetHandle.control = self
  self._timelineName = nil
  self._loadingTimelineName = nil
  self._state = L_Const.heroTimelineState.None
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

function this:timelineStopHandle(timelineName)
  if self._timelineState == nil or self:isLoading() then
    return
  end
  if self._timelinePrefabHandle:getTimelineName() ~= timelineName then
    return
  end
  local assetName = self._timelineState:getNextStateTransitionAssetName(self._timelineAssetName, self._state)
  self:tryChangNextTimelineState(assetName)
end

function this:timelineLoadedHandle(timelineName, state)
end

function this:timelineCustomEventHandle(str1, str2, str3)
  print("ddda" .. str1)
  if self.timelineCustomEvent then
    self.timelineCustomEvent(str1, str2, str3)
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
  local nextAssetName = self._timelineState.timelineNextClipMap[timelineAssetName]
  if self._state ~= L_Const.heroTimelineState.None and nextAssetName and nextAssetName ~= timelineAssetName then
    self._timelineAssetHandle:loadOneTimeLineAsset(timelineName, nextAssetName, L_Const.emptyFunction)
  end
end

function this:tryChangNextTimelineState(timelineAssetName)
  self._timelineAssetHandle:loadTimelineAsset(self._timelinePrefabHandle:getTimelineName(), timelineAssetName)
end

function this:dispose()
  print("timeline control dispose")
  if self._timelineState then
    self._timelineState:dispose()
  end
  self._timelineState = nil
  if self._timelineActorHandle then
    self._timelineActorHandle:dispose()
  end
  self._timelineActorHandle = nil
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
end

function this:asyncDestroyTimeLineAssets(timelineName, sceneName, heroId)
  if self:isLoading() then
    return
  end
  self._timelineAssetHandle:disposeTimeAsset(timelineName)
  self._timelinePrefabHandle:dispose()
  self._timelineSceneHandle:clearMap()
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

function this:setAssetsActive(isActive, exceptCamera)
  self.assetActive = isActive
  if self._timelinePrefabHandle then
    self._timelinePrefabHandle:setAssetsActive(self.assetActive, exceptCamera)
  end
end

function this:getTimelineAssetName(state)
  local timelineAssetName
  if state == L_Const.heroTimelineState.Select then
    timelineAssetName = self._timelineState.timelineAssetName.UISelect_Start
  elseif state == L_Const.heroTimelineState.Detail then
    timelineAssetName = self._timelineState.timelineAssetName.UIDetail_Start
  elseif state == L_Const.heroTimelineState.Equip then
    timelineAssetName = self._timelineState.timelineAssetName.UIDetail_To_Equip
  elseif state == L_Const.heroTimelineState.Skill then
    timelineAssetName = self._timelineState.timelineAssetName.UIDetail_To_Skill
  end
  return timelineAssetName
end

function this:checkPlayTimelineState(state, showHero, lastShowHero)
  if showHero and self._state ~= L_Const.heroTimelineState.None then
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

function this:stopTimeline()
  if self._timelinePrefabHandle ~= nil then
    self._timelinePrefabHandle:stopTimeline()
  end
end

function this:replayTimeline()
  if self._timelinePrefabHandle ~= nil then
    self._timelinePrefabHandle:replayTimeline()
  end
end

function this:playTimelineState(state, isForce, isInit)
  self._state = state
  isForce = true
  if isForce then
    local timelineAssetName
    if isInit then
      timelineAssetName = self:getTimelineAssetName(state)
    end
    if timelineAssetName == nil then
      timelineAssetName = self._timelineState:getNextStateTransitionAssetName(self._timelineAssetName, self._state)
    end
    if timelineAssetName == self._timelineAssetHandle._curTimelineAssetName then
    else
      self:tryChangNextTimelineState(timelineAssetName)
    end
  end
end

function this:replayTimeline()
  self._timelinePrefabHandle:replayTimeline()
end

function this:asyncLoadTimelineAssets(timelineName, timelineAssetName, sceneName, heroId, isFirstInit, onPreloadEnd, onAllLoaded, lodlv, clothingId)
  local function onUnitPrefabLoaded()
    print("onUnitPrefabLoaded begin")
    
    if self._loadingTimelineName ~= timelineName then
      return
    end
    if not string.isEmpty(sceneName) then
      self._timelineSceneHandle:loadScenePrefab(sceneName)
    end
    self:loadTimelinePrefab(timelineName)
    self._loadingTimelineName = nil
    if onAllLoaded then
      onAllLoaded()
    end
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
    self._timelineActorHandle:loadUnitPrefab(heroId, onUnitPrefabLoaded, lodlv, nil, clothingId)
  end
  
  print("asyncLoadTimelineAssets really begin")
  self._loadingTimelineName = timelineName
  if isFirstInit then
    print("loadScenePrefab begin")
    self._timelineSceneHandle:loadScenePrefab(sceneName)
  end
  if timelineAssetName ~= nil then
    print("loadTimelineAsset begin")
    self._timelineAssetHandle:loadTimelineAsset(timelineName, timelineAssetName, onPreLoadTimeAssetLoaded)
  else
    print("onPreLoadTimeAssetLoaded begin")
    onPreLoadTimeAssetLoaded()
  end
end

function this:loadTimelinePrefab(name)
  self._timelineName = name
  self._state = L_Const.heroTimelineState.Detail
  self._timelinePrefabHandle:loadTimelinePrefab(name)
  self:bindMainPlayer()
end

function this:isLoading()
  return not string.isEmpty(self._loadingTimelineName)
end

function this:setHeroAnimAlways()
  local hero = self._timelineActorHandle:getCurHero()
  if hero == nil then
    return
  end
  local heroObj = hero:getGameObject()
  local com = heroObj.transform:GetChild(0):GetComponent(typeof(C_PlayableAnimator))
  local alwaysAnimate = C_AnimatorCullingMode.AlwaysAnimate
  if com then
    com.cullingMode = alwaysAnimate
  else
    local anim = heroObj:GetComponentsInChildren(typeof(C_PlayableAnimator))
    for i = 0, anim.Length - 1 do
      anim[i].cullingMode = alwaysAnimate
    end
  end
end

function this:asyncLoadTimelineAssetsNew(timelineName, timelineAssetName, sceneName, heroId, isFirstInit, onPreloadEnd, onAllLoaded, playerId, clothingId)
  C_MJLog.LogDebug("多人测试，obj brefore isLoading", C_ELogModule.Home)
  if self:isLoading() then
    return
  end
  C_MJLog.LogDebug("多人测试，obj after isLoading", C_ELogModule.Home)
  local lastPrefabMap
  if self._timelineActorHandle._heroId then
    lastPrefabMap = self._timelineActorHandle._unitPrefabMap[self._timelineActorHandle._heroId]
  end
  
  local function onActorPrefabLoaded()
    C_MJLog.LogDebug("多人测试，obj start onActorPrefabLoaded", C_ELogModule.Home)
    if self._loadingTimelineName ~= timelineName then
      return
    end
    C_MJLog.LogDebug("多人测试，obj after onActorPrefabLoaded", C_ELogModule.Home)
    self._timelineSceneHandle:asyncscenePrefab(sceneName, function(obj)
      self._timelineSceneHandle:changeScene(sceneName)
      if lastPrefabMap then
        lastPrefabMap:getGameObject():ActiveTrans(false)
      end
      self:setHeroAnimAlways()
      self:loadTimelinePrefab(timelineName)
      self._loadingTimelineName = nil
      if onAllLoaded then
        onAllLoaded(obj)
      end
    end)
  end
  
  local function onPreLoadTimeAssetLoaded()
    if self._loadingTimelineName ~= timelineName then
      return
    end
    if onPreloadEnd then
      onPreloadEnd()
    end
    if heroId ~= self._timelineActorHandle._heroId then
      self._timelineAssetHandle._curTimelineAssetName = nil
    end
    self._timelineActorHandle:asyncloadActorPrefab(heroId, onActorPrefabLoaded, playerId, clothingId)
  end
  
  self._loadingTimelineName = timelineName
  if timelineAssetName ~= nil then
    self._timelineAssetHandle:loadTimelineAsset(timelineName, timelineAssetName, onPreLoadTimeAssetLoaded)
  else
    onPreLoadTimeAssetLoaded()
  end
end

function this:asyncLoadTimelineAssetsList(timelineName, timelineAssetNameList, sceneName, heroId, isFirstInit, onPreloadEnd, onAllLoaded, targetTimeLine, clothingId)
  if self:isLoading() then
    return
  end
  printf("=====================================new")
  
  local function onActorPrefabLoaded()
    self._loadingTimelineName = nil
    self:setHeroAnimAlways()
    self:setAssetsActive(true, true)
    self._timelinePrefabHandle:replayTimeline()
    if onAllLoaded then
      onAllLoaded()
    end
  end
  
  local function onTimelinePrefabLoaded()
    self:setAssetsActive(false, true)
    self._timelineSceneHandle:changeScene(sceneName)
    self._timelineActorHandle:asyncloadActorPrefab(heroId, onActorPrefabLoaded, nil, clothingId)
  end
  
  local function onScenePrefabLoaded()
    if self._loadingTimelineName ~= timelineName then
      return
    end
    self._timelinePrefabHandle:stopTimeline()
    self:asyncloadTimelinePrefab(timelineName, onTimelinePrefabLoaded)
  end
  
  local function onPreLoadTimeAssetLoaded()
    if self._loadingTimelineName ~= timelineName then
      return
    end
    if onPreloadEnd then
      onPreloadEnd()
    end
    if heroId ~= self._timelineActorHandle._heroId then
      self._timelineAssetHandle._curTimelineAssetName = nil
    end
    printf("==============================================load 场景begin")
    self._timelineSceneHandle:asyncscenePrefab(sceneName, onScenePrefabLoaded)
  end
  
  self._loadingTimelineName = timelineName
  if timelineAssetNameList ~= nil then
    self._timelineAssetHandle:loadTimelineAssetList(timelineName, timelineAssetNameList, onPreLoadTimeAssetLoaded, targetTimeLine)
  end
end

function this:asyncloadTimelinePrefab(name, TimelinePrefabLoadedCallback)
  self._timelineName = name
  self._state = L_Const.heroTimelineState.Detail
  self._timelinePrefabHandle:asyncloadTimelinePrefab(name, TimelinePrefabLoadedCallback)
  self:bindMainPlayer()
end

function this:getCamera()
  return self._timelinePrefabHandle._camera
end

function this:setCamera(camera)
  self._timelinePrefabHandle:setCamera(camera)
end

function this:asyncLoadNestPosTimelineAssetsList(heroId, Pos, callback, characterPos, characterRot, clothingId)
  local clothing = L_GameTpl:getHeroClothingTpl():getTplById(clothingId)
  local path = L_Config:getPathByHash(clothing.uiperform)
  local state = L_Const.heroTimelineState.Detail
  local stateList = {
    L_Const.heroTimelineState.Detail,
    L_Const.heroTimelineState.Equip,
    L_Const.heroTimelineState.Skill
  }
  local timelineAssetNameList = {}
  for k, v in pairs(stateList) do
    table.insert(timelineAssetNameList, self:getTimelineAssetName(v))
  end
  local timelineAssetName = self:getTimelineAssetName(state)
  
  local function onPreLoadTimeAssetLoaded(_timelineName, timelineAssetName, _timelineAsset)
    self._timelineActorHandle:asyncloadActorPrefab(heroId, function()
      self:loadTimelinePrefab(path)
      self:setAssetsActive(true)
      self:playTimelineState(state, true, true)
      local obj = self._timelineActorHandle:getCurHero():getGameObject()
      L_Vector3.setPos(obj.transform.parent.parent.parent, Pos)
      L_Vector3.setLocalPos(obj.transform, characterPos)
      L_Vector3.setLocalRot(obj.transform, characterRot)
      self:addNestFakeLight()
      if callback ~= nil then
        callback()
      end
    end, nil, clothingId)
  end
  
  if timelineAssetNameList ~= nil then
    self._timelineAssetHandle:loadTimelineAssetList(path, timelineAssetNameList, onPreLoadTimeAssetLoaded, timelineAssetName)
  end
end

function this:addNestFakeLight()
  local obj = self._timelineActorHandle:getCurHero():getGameObject().transform
  local model = obj:GetChild(0)
  local modelControl = obj:GetComponent(typeof(C_ModelControl))
  if model == nil or modelControl == nil then
    return
  end
  local splineTrans = modelControl:GetTransByName("Spine")
  local go_fakeLight = Unity.GameObject("fakeLightRoot")
  CS.UnityEngine.Object.DontDestroyOnLoad(go_fakeLight)
  go_fakeLight.transform:SetParent(splineTrans)
  local _fakeLight = go_fakeLight:AddComponent(typeof(C_CharacterFakeLightDir))
  local eulerAngles = L_Vector3.new(90, 0, 0)
  go_fakeLight.transform.localPosition = L_Vector3.zero
  go_fakeLight.transform.localRotation = Unity.Quaternion.Euler(eulerAngles)
  go_fakeLight.transform.localScale = L_Vector3.zero
  _fakeLight.isGlobal = false
  _fakeLight:SetCharacterList(model.gameObject)
end

function this:getCurTimePrefab()
  return self._timelinePrefabHandle
end

function this:setCustomAvatarData(avatarData)
  self._timelineActorHandle.customAvatarData = avatarData
end

function this:getCurHeroPrefab()
  local hero = self._timelineActorHandle:getCurHero()
  return hero
end

function this:hideCurScene()
  self._loadingTimelineName = nil
  self._timelinePrefabHandle:getRoot():ActiveTrans(false)
end

function this:showCurScene()
  self._timelinePrefabHandle:getRoot():ActiveTrans(true)
end

return this
