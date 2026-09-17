local this = class("moduleHeroShow", G_UIModuleBase)
local _heroTpl = L_GameTpl:getHeroTpl()
local _delay = 5
local _count = 0

function this.bind()
  return {go_mask = false}
end

function this.methods()
  return {}
end

function this:initData(options)
  self:changeCamera()
  self:showTimeline(options)
  self:playVoice(options.id, options.voiceName)
end

function this:open()
end

function this:close()
  self:closeTimeline()
  self:recoverCamera()
  self:stopVoice()
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
  local state = options.posName
  if state == nil or state == "" then
    state = L_Const.heroTimelineState.Detail
  end
  local hero = _heroTpl:getTplById(id)
  if hero ~= nil then
    local clothing = L_GameTpl:getHeroClothingTpl():getTplById(options.clothingId)
    local path = L_Config:getPathByHash(clothing.uiperform)
    local scenePath = L_Config:getPathByHash(clothing.uibackground)
    scenePath = L_CommonUtil.getMultiPlatformScenePath(scenePath)
    local timelineAssetName = C_AzurTimelineMgr.GetTimelineAssetName(state)
    C_AzurTimelineMgr.AsyncLoadTimelineAssets(path, timelineAssetName, scenePath, id, true, function()
    end, function(obj)
      if finishAction ~= nil then
        finishAction()
      end
      C_UISceneManager.SetSceneVisibleTag(true, "moduleHeroShow")
      C_UISceneManager.SetSceneVisible()
      C_AzurTimelineMgr.SetAssetsActive(true)
      C_AzurTimelineMgr.PlayTimelineState(state, true, true)
    end, 0, options.playerId, options.clothingId)
  else
    errorf("通用结算， heroTpl中没有找到id:" .. id, 2)
  end
end

function this:closeTimeline()
  C_AzurTimelineMgr.DisposeTimelineControl()
  C_UISceneManager.SetSceneVisibleTag(false, "moduleHeroShow")
  C_UISceneManager.SetSceneVisible()
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
