local this = class("entrustStore", G_BaseStore)
this.event = {
  entrustTaskGroupFolder = "entrustTaskGroupFolder",
  entrustLevelSelect = "entrustLevelSelect",
  entrustInfoRefresh = "entrustInfoRefresh",
  entrustRewardRefresh = "entrustRewardRefresh",
  entrustTrainRefresh = "entrustTrainRefresh",
  entrustEnter = "entrustEnter",
  entrustReturnToMain = "entrustReturnToMain",
  entrustEnterDetail = "entrustEnterDetail",
  entrustMultiCoopInfoRefresh = "entrustMultiCoopInfoRefresh",
  entrustMultiCoopRewardRefresh = "entrustMultiCoopRewardRefresh",
  entrustKiboInfoRefresh = "entrustKiboInfoRefresh"
}
this:importPartialClass(require(L_R.store .. "entrust.entrustState"))
this:importPartialClass(require(L_R.store .. "entrust.entrustAction"))
local _heroTpl = L_GameTpl:getHeroTpl()
local _delay = 5
local _count = 0
local _state, _weather, _voiceId, _voiceName
local isLoaded = false
local isNeedOpen = false
local isCreated = false

function this:CreateScene(options)
  _voiceId = options.id
  _voiceName = options.voiceName
  self:changeCamera()
  self:showTimeline(options)
end

function this:ShowScene(isShow)
  isNeedOpen = isShow
  self:internalScene(isShow)
  if isShow == true then
    self:playVoice(_voiceId, _voiceName)
  else
    self:stopVoice()
  end
end

function this:GetShowHeroConfigId()
  return _voiceId
end

function this:CloseScene()
  isNeedOpen = false
  isLoaded = false
  isCreated = false
  _voiceId = 0
  _voiceName = string.empty
  self:closeTimeline()
  self:recoverCamera()
  self:stopVoice()
end

function this:internalScene(isShow)
  C_UISceneManager.SetSceneVisible(not isShow)
  C_AzurTimelineMgr.SetAllAssetsActive(isShow)
  if isShow == true then
    C_AzurTimelineMgr.PlayTimelineState(_state, true, true)
  end
end

function this:changeCamera()
  self.lastCameraBlendStyle = C_CameraManager.GetMainCameraBrain().m_DefaultBlend.m_Style
  C_CameraManager.SetBrainBlendStyle(L_Const.blendStyle.cut)
end

function this:recoverCamera()
  if self.lastCameraBlendStyle ~= nil then
    C_CameraManager.SetBrainBlendStyle(self.lastCameraBlendStyle)
    self.lastCameraBlendStyle = nil
  end
end

function this:showTimeline(options)
  local id = options.id
  local finishAction = options.finishAction
  _state = options.posName
  if _state == nil or _state == "" then
    _state = L_Const.heroTimelineState.Detail
  end
  local hero = _heroTpl:getTplById(id)
  if hero ~= nil then
    local clothing = L_GameTpl:getHeroClothingTpl():getTplById(options.clothingId)
    local path = L_Config:getPathByHash(clothing.uiperform)
    local scenePath = L_Config:getPathByHash(clothing.uibackground)
    scenePath = L_CommonUtil.getMultiPlatformScenePath(scenePath)
    local timelineAssetName = C_AzurTimelineMgr.GetTimelineAssetName(_state)
    C_AzurTimelineMgr.AsyncLoadTimelineAssets(path, timelineAssetName, scenePath, id, true, nil, function(obj)
      if finishAction ~= nil then
        finishAction()
      end
      isLoaded = true
      isCreated = true
      self:internalScene(isNeedOpen)
    end, 0, options.playerId, options.clothingId)
  else
    errorf("通用结算， heroTpl中没有找到id:" .. id, 2)
  end
end

function this:closeTimeline()
  C_AzurTimelineMgr.DisposeTimelineControl()
  if AzurWorld.visbleMgr then
    C_UISceneManager.SetSceneActive(true)
  end
  if AzurWorld.HomeMgr then
    L_HomeManager:setHomeRootActive(true)
  end
  if AzurWorld.HUDMgr then
    AzurWorld.HUDMgr:SetAllVisible(true)
  end
end

function this:playVoice(configId, moduleType)
  if configId == nil or configId == 0 then
    return
  end
  if moduleType == nil or moduleType == "" then
    moduleType = L_Const.heroModuleType.Property
  end
  L_HeroVoiceManager:playHeroVoiceByConfigId(configId, moduleType)
end

function this:stopVoice()
  L_HeroVoiceManager:stopHeroVoice()
end

function this:createTimer()
  self._timer = L_GameTimer.new(function()
    self.bind.go_mask = false
  end, _delay, 0)
end

function this:closeTimer()
  if self._timer then
    L_GameTimer.remove(self._timer)
    self._timer = nil
  end
end

function this:countDown()
  _count = _count + 1
  if _count == 2 then
    self.bind.go_mask = false
  end
end

return this
