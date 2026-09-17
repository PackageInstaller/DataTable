local this = class("petTimelineController")
local unitTpl = L_GameTpl:getUnitTpl()
local petInfoTpl = L_GameTpl:getPetTpl()
local petRankTpl = L_GameTpl:getPetRankTpl()
local _randomKiboExpression = {5, 9}
local _defaultExpressionIdx = 1

function this:ctor()
  self._timelinePrefabHandle = require("ui.pages.pet.timeline.petTimelinePrefabHandle").new(true, true)
  self._petAvatarHandle = require("ui.pages.pet.timeline.petEvoAvatarHandle").new(self._timelinePrefabHandle)
  self._timelinePrefabHandle.timelineStopHandle = handler(self, self.timelineStopHandle)
  
  function self._timelinePrefabHandle.getRealActorEntityHandle(remarkName, actorName)
    if actorName == "pet_1" then
      return self._petAvatarHandle:getAvatar(self.pet1)
    elseif actorName == "pet_2" then
      return self._petAvatarHandle:getAvatar(self.pet2)
    end
    return nil
  end
  
  self.loadErrorFunc = nil
  self.startPlayFunc = nil
  self.clipAudioEvents = nil
  self._clipAudioWraps = nil
  self._isDispose = false
  self._isTimelineStarted = false
  self._hasLoadFailure = false
end

function this:dispose()
  if self._petAvatarHandle then
    self._petAvatarHandle:dispose()
  end
  self._petAvatarHandle = nil
  if self._timelinePrefabHandle then
    self._timelinePrefabHandle:dispose()
  end
  self._timelinePrefabHandle = nil
  self.loadErrorFunc = nil
  self.startPlayFunc = nil
  if self._startPlayCo then
    co.stop(self._startPlayCo)
    self._startPlayCo = nil
  end
  self:stopClipAudioEvents()
  if self._expressionCo then
    co.stop(self._expressionCo)
    self._expressionCo = nil
  end
  self._isDispose = true
  self.petData = nil
end

function this:getCamera()
  return self._timelinePrefabHandle._camera
end

function this:setPetVisible(isVisible)
  if self._petAvatarHandle then
    self._petAvatarHandle:setAvatarVisible(isVisible)
  end
end

function this:timelineStopHandle(timelineName)
  if self._timelinePrefabHandle:getTimelineName() ~= timelineName then
    return
  end
  local state = self._timelinePrefabHandle:getTimelineState(self._timelinePrefabHandle._timelineName)
  if state == nil then
    return
  end
  state.director.time = state.loopTime + 0.01
  state.director:Evaluate()
  state.director:Play()
end

function this:getIsLoop()
  local state = self._timelinePrefabHandle:getTimelineState(self._timelinePrefabHandle._timelineName)
  if state == nil then
    return true
  end
  return state.director.time >= (state.loopTime or 0)
end

function this:resetPlayState()
  self:stopClipAudioEvents()
  self._isTimelineStarted = false
  self._hasLoadFailure = false
end

function this:prepareTimelineState(timelineAsset, petData)
  if self._isDispose then
    return nil
  end
  self.petData = petData
  self.pet1 = petData.pet1
  self.pet2 = petData.pet2
  self._timelinePrefabHandle:loadTimelinePrefab(timelineAsset)
  local state = self._timelinePrefabHandle:getTimelineState(self._timelinePrefabHandle._timelineName)
  if state == nil then
    if self.loadErrorFunc then
      self.loadErrorFunc()
    end
    return
  end
  self._timelinePrefabHandle:prepareTimelineState(self._timelinePrefabHandle._timelineName)
  return state
end

function this:preloadTimelineState(timelineAsset, petData)
  local state = self:prepareTimelineState(timelineAsset, petData)
  if state == nil then
    return
  end
  self:setPetVisible(false)
  self._petAvatarHandle:loadUnitPrefab(self.pet1, petData.pet1Rot, petData.pet1Scale, nil, petData.isSpecial, petData.isFlash, petData.starColorId)
  self._petAvatarHandle:loadUnitPrefab(self.pet2, petData.pet2Rot, petData.pet2Scale, nil, petData.isSpecial, petData.isFlash, petData.starColorId)
end

function this:playTimelineState(timelineAsset, petData, loopFrame)
  self:resetPlayState()
  local state = self:prepareTimelineState(timelineAsset, petData)
  if state == nil then
    return
  end
  self:setPetVisible(false)
  self._petAvatarHandle:loadUnitPrefab(self.pet1, petData.pet1Rot, petData.pet1Scale, handler(self, self.onAvatarLoadFinished), petData.isSpecial, petData.isFlash, petData.starColorId)
  self._petAvatarHandle:loadUnitPrefab(self.pet2, petData.pet2Rot, petData.pet2Scale, handler(self, self.onAvatarLoadFinished), petData.isSpecial, petData.isFlash, petData.starColorId)
  self:onLoadCalback()
end

function this:onAvatarLoadFinished(petId, isSuccess)
  if self._isDispose then
    return
  end
  if not isSuccess then
    self._hasLoadFailure = true
  end
  self:onLoadCalback()
end

function this:onLoadCalback()
  if self._isDispose then
    return
  end
  if self._isTimelineStarted then
    return
  end
  local avatar1 = self._petAvatarHandle:getAvatar(self.pet1)
  local avatar2 = self._petAvatarHandle:getAvatar(self.pet2)
  if avatar1 == nil or avatar2 == nil then
    local pet1Status = self._petAvatarHandle:getLoadStatus(self.pet1)
    local pet2Status = self._petAvatarHandle:getLoadStatus(self.pet2)
    if pet1Status == "failed" or pet2Status == "failed" then
      self._hasLoadFailure = true
      errorf("pagePetEvo prepare display failed, pet1Status = " .. tostring(pet1Status) .. ", pet2Status = " .. tostring(pet2Status))
      if self.loadErrorFunc then
        self.loadErrorFunc()
      end
    end
    return
  end
  local tpl = petRankTpl:getTplById(self.pet1)
  local evoPre = petRankTpl:getEvolutionPre(tpl)
  local evoAfter = petRankTpl:getEvolutionAfterStart(tpl)
  local evoPreStrs = string.split(evoPre, "|")
  local evoAfterStrs = string.split(evoAfter, "|")
  printf("inori", evoPreStrs, evoAfterStrs)
  avatar1:setAnimId(evoPreStrs[1])
  avatar2:setAnimId(evoAfterStrs[1])
  
  function avatar1.onFixGetAniname(aniName)
    return evoPreStrs[2]
  end
  
  function avatar2.onFixGetAniname(aniName)
    if aniName == "EvolutionAfter_Start" then
      return evoAfterStrs[2]
    else
      return evoAfterStrs[3]
    end
  end
  
  self._timelinePrefabHandle:playTimelineAsset(self._timelinePrefabHandle._timelineName)
  self._isTimelineStarted = true
  if self.startPlayFunc then
    self._startPlayCo = co.start(self.startPlayFunc)
  end
  local audioEvents = self.clipAudioEvents
  if audioEvents ~= nil then
    local state = self._timelinePrefabHandle:getTimelineState(self._timelinePrefabHandle._timelineName)
    local list = state.timelineBindDatas
    if list.Count < 2 then
      return
    end
    local director = list[1].transform:GetComponent(typeof(CS.UnityEngine.Playables.PlayableDirector))
    local playableTimeline = director.playableAsset
    self._audioCo = co.start(function()
      self:playClipAudioEvent(audioEvents.EvolutionPre)
      co.wait(state.loopTime or 5)
      self:playClipAudioEvent(audioEvents.EvolutionAfter_Loop)
    end)
  end
end

function this:playClipAudioEvent(clipAudioEvent)
  if clipAudioEvent == nil then
    return
  end
  if type(clipAudioEvent) == "table" then
    if clipAudioEvent.audioEvent then
      self:addClipAudioWrap(L_AudioUtil.playSound(clipAudioEvent.audioEvent))
    end
    if clipAudioEvent.bgmEvent then
      self:addClipAudioWrap(L_AudioUtil.playSound(clipAudioEvent.bgmEvent))
    end
  else
    self:addClipAudioWrap(L_AudioUtil.playSound(clipAudioEvent))
  end
end

function this:addClipAudioWrap(audioWrap)
  if audioWrap == nil then
    return
  end
  self._clipAudioWraps = self._clipAudioWraps or {}
  table.insert(self._clipAudioWraps, audioWrap)
end

function this:stopClipAudioEvents()
  if self._audioCo then
    co.stop(self._audioCo)
    self._audioCo = nil
  end
  if self._clipAudioWraps then
    for _, audioWrap in ipairs(self._clipAudioWraps) do
      L_AudioUtil.stopSound(audioWrap)
    end
    self._clipAudioWraps = nil
  end
end

function this:playPetShowExpression()
  if self._isDispose or self._petAvatarHandle == nil then
    return
  end
  local avatar2 = self._petAvatarHandle:getAvatar(self.pet2)
  if avatar2 == nil then
    return
  end
  self:petShowExpression(avatar2:getGameObject())
end

function this:petShowExpression(pet2Obj)
  local randomIndex = math.random(1, #_randomKiboExpression)
  local randomExpression = _randomKiboExpression[randomIndex]
  local modelControl = pet2Obj:GetComponent(typeof(C_ModelControl))
  if modelControl == nil then
    return
  end
  self.expression = modelControl:GetComponentByType(typeof(CS.KiboExpression))
  if not self.expression then
    error("奇波缺少KiboExpression组件")
    return
  end
  self.expression.LockExpression = false
  self.expression:SetEye(randomExpression)
  self.expression:SetMouth(randomExpression)
  self.expression.LockExpression = true
  local playtime = tonumber(L_GameConstTpl:getValue("kibo_evolution_emotion_playtime", true)) or 3
  if self._expressionCo then
    co.stop(self._expressionCo)
  end
  self._expressionCo = co.start(function()
    co.wait(playtime)
    if self._isDispose then
      return
    end
    if self.expression then
      self.expression.LockExpression = false
      self.expression:SetEye(_defaultExpressionIdx)
      self.expression:SetMouth(_defaultExpressionIdx)
    end
  end)
end

return this
