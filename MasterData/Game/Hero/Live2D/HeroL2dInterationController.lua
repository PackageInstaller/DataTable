local HeroInterationBaseController = require("Game.Hero.Live2D.HeroInterationBaseController")
local HeroL2dInterationController = class("HeroL2dInterationController", HeroInterationBaseController)
local base = HeroInterationBaseController
local cs_l2dParameterClip = CS.Live2D.Cubism.Samples.OriginalWorkflow.Demo.L2dParameterClip
local cs_time = CS.UnityEngine.Time
local csCubismInterationController = CS.Live2D.Cubism.Samples.OriginalWorkflow.Demo.CubismInterationController
local csL2DAnimationClipType = CS.L2DAnimationClipType
local cs_SortingLayer = CS.UnityEngine.SortingLayer
local cs_ParticleSystemRenderer = CS.UnityEngine.ParticleSystemRenderer
local friendshipAnimationName = "friendShipAnimation"
local soundOnlyAnimName = "soundOnlyAnim"
local L2DAnimationClipType = {
  Normal = 1,
  Idle = 2,
  Interaction = 3,
  ExternalEvent = 4,
  Login = 5
}

function HeroL2dInterationController:InitL2dInteration(cs_CubismInterationController, heroId, heroSkinId, camera, openGuiJudge, aniPlayFunc, animationPlayEventCallback, lastCv, needHideBg, isCloseL2dSfx)
  self.closeMouseListen = false
  self.coundPlaySound = true
  if needHideBg == nil then
    needHideBg = false
  end
  if isCloseL2dSfx == nil then
    isCloseL2dSfx = false
  end
  self:SetL2DHideBg(needHideBg)
  self:SetOpenL2dSfx(isCloseL2dSfx)
  self.cs_CubismInterationController = cs_CubismInterationController
  self.heroId = heroId
  if heroSkinId == 0 then
    local heroCfg = ConfigData.hero_data[heroId]
    if heroCfg ~= nil then
      heroSkinId = heroCfg.default_skin
    end
  end
  self.heroSkinId = heroSkinId
  self.aniPlayFunc = aniPlayFunc
  self._lastPlayedCVId = lastCv
  self.aniCallback = nil
  if animationPlayEventCallback ~= nil then
    self.aniCallback = animationPlayEventCallback
    self.cs_CubismInterationController:OnAnimationPlayEvent("+", self.aniCallback)
  elseif self.aniPlayFunc ~= nil then
    self.aniCallback = BindCallback(self, self.AniPlayCallback)
    self.cs_CubismInterationController:OnAnimationPlayEvent("+", self.aniCallback)
  end
  self.l2dAnimationEventCallback = BindCallback(self, self.l2dAnimationEvent)
  self.cs_CubismInterationController:AnimationEventAction("+", self.l2dAnimationEventCallback)
  self.l2dTriggerEventCallback = BindCallback(self, self.l2dTriggerEvent)
  self.cs_CubismInterationController:TriggerEventAction("+", self.l2dTriggerEventCallback)
  self:__InitCSComponent()
  if not IsNull(self.cs_mouth) then
    self.cs_mouth.BlendMode = CS.Live2D.Cubism.Framework.CubismParameterBlendMode.Additive
  end
  self:SetMouthActive(false)
  if self.heroSkinId ~= 0 then
    self.config = ConfigData.skin_live2d[self.heroSkinId]
  else
    self.config = ConfigData.skin_live2d[self.heroId]
    warn("has heroId l2d!!!")
  end
  if IsNull(self.normalClip) then
    self.normalClip = self.cs_CubismInterationController.NormalAnimation
  end
  if IsNull(self.normalClip) then
    local l2DParameterClips = self.cs_CubismInterationController.L2DParameterClips
    for i = 0, l2DParameterClips.Count - 1 do
      local l2dClip = l2DParameterClips[i]
      if l2dClip.Name == csCubismInterationController.NormalL2DClipName and l2dClip.AnimationClipType == csL2DAnimationClipType.Normal then
        self.normalClip = l2dClip.Clip
      end
    end
  end
  self:__AddFriendShipAnimation(heroId)
  self._isHasWaitLive2dAni = self.cs_CubismInterationController:IsHasWaitLive2dAni()
  self._isHasTouchLive2dAni = self.cs_CubismInterationController:IsHasTouchLive2dAni()
  local shortTime, longTime
  if self._isHasWaitLive2dAni then
    shortTime = ConfigData.game_config.l2dWaitAnimationTime.ShortTime
    longTime = ConfigData.game_config.l2dWaitAnimationTime.LongTime
  else
    shortTime = ConfigData.buildinConfig.HomeOnHookVoiceTime
    longTime = ConfigData.buildinConfig.HomeOnHookVoiceTime
  end
  self.cs_CubismInterationController:InitController(true, true, shortTime, longTime, camera)
  self.cs_CubismInterationController.enabled = true
  self.cs_CubismInterationController.OpenGuiJudge = openGuiJudge
  self:LoadCustomLive2dLua()
  self:HideL2dBg()
  self:HideHolight()
end

function HeroL2dInterationController:LoadCustomLive2dLua()
  if self.config == nil then
    return
  end
  self.live2dLuaPath = self.config.customLive2dLua
  local CustomLive2dLuaPath = self.live2dLuaPath
  if string.IsNullOrEmpty(CustomLive2dLuaPath) then
    return
  end
  self.CustomLive2dLua = require(CustomLive2dLuaPath).New()
  self.CustomLive2dLua:Init(self)
end

function HeroL2dInterationController:__AddFriendShipAnimation(heroId)
  if IsNull(self.cs_CubismInterationController) then
    return
  end
  if heroId ~= 0 then
    if not PlayerDataCenter:ContainsHeroData(heroId) then
      return
    end
    local heroData = PlayerDataCenter:GetHeroData(heroId)
    self.friendShipCvIds = ConfigData:GetUnLockFriendShipCvIds(heroId, heroData)
  end
  local L2DParameterClips = self.cs_CubismInterationController.L2DParameterClips
  local friendShipClip
  for i = 0, L2DParameterClips.Count - 1 do
    local l2dClip = L2DParameterClips[i]
    l2dClip.isHaveMouseAni = self:IsSSRLive2D() and not self:IsUseNormalClip(l2dClip) and self:IsHasMouseAnim(l2dClip)
    if l2dClip.Name == friendshipAnimationName then
      friendShipClip = l2dClip
    end
  end
  if friendShipClip ~= nil then
    if self.friendShipCvIds == nil or #self.friendShipCvIds == 0 then
      friendShipClip.RandomPlayWeight = 0
      friendShipClip.AnimationClipType = 3
      return
    else
      friendShipClip.RandomPlayWeight = 4
      friendShipClip.AnimationClipType = 2
      friendShipClip.isHaveMouseAni = false
      friendShipClip:UpdateTimeStamp(cs_time.time)
      self.cs_CubismInterationController:ReSetCacheValue()
      return
    end
  end
  if self.friendShipCvIds == nil or #self.friendShipCvIds == 0 then
    return
  end
  if IsNull(self.normalClip) then
    return
  end
  local friendShipAnimation = cs_l2dParameterClip(self.normalClip, self.cs_CubismInterationController.MainLayer)
  friendShipAnimation.Name = friendshipAnimationName
  friendShipAnimation.isHaveMouseAni = false
  friendShipAnimation.RandomPlayWeight = 4
  friendShipAnimation.ConditionStateIndex = self.cs_CubismInterationController.currentStateIndex
  friendShipAnimation:UpdateTimeStamp(cs_time.time)
  if L2DParameterClips ~= nil then
    L2DParameterClips:Add(friendShipAnimation)
    self.cs_CubismInterationController:ReSetCacheValue()
  end
end

function HeroL2dInterationController:__InitCSComponent()
  if IsNull(self.cs_CubismInterationController) then
    return
  end
  local live2dGameObject = self.cs_CubismInterationController.gameObject
  self.cs_rayCast = live2dGameObject:GetComponent(typeof(CS.Live2D.Cubism.Framework.Raycasting.CubismRaycaster))
  self.cs_mouth = live2dGameObject:GetComponent(typeof(CS.Live2D.Cubism.Framework.MouthMovement.CubismMouthController))
  self.cs_cubismLookController = live2dGameObject:GetComponent(typeof(CS.Live2D.Cubism.Framework.LookAt.CubismLookController))
  self.cs_cubismParitcleController = self.cs_CubismInterationController:GetComponent(typeof(CS.Live2D.Cubism.Framework.Effect.CubismParitcleEffectController))
  local l2dBinding = {}
  UIUtil.LuaUIBindingTable(live2dGameObject, l2dBinding)
  self.cs_renderController = l2dBinding.renderController
  self.cs_commonPerpectiveHandle = l2dBinding.commonPerpectiveHandle
  self.cs_lookTarget = l2dBinding.lookTarget.gameObject:GetComponent(typeof(CS.Live2D.Cubism.Samples.OriginalWorkflow.Demo.CubismLookTarget))
end

function HeroL2dInterationController:IsSSRLive2D()
  if self.config ~= nil then
    local live2d_level = self.config.level
    return live2d_level == 3
  end
  return false
end

function HeroL2dInterationController:IsUseNormalClip(l2dClip)
  if l2dClip ~= nil and self.normalClip ~= nil then
    return l2dClip.Clip == self.normalClip
  end
end

function HeroL2dInterationController:IsHasMouseAnim(l2dClip)
  local clipName = l2dClip.Name
  local hasMouseAnim = string.sub(clipName, 0, 6) ~= "wait_0" and clipName ~= "login_0" and clipName ~= friendshipAnimationName
  return hasMouseAnim
end

function HeroL2dInterationController:AniPlayCallback(l2dClipType, loginType, hitArea, animName, animLength, isHaveMouseAni)
  if l2dClipType == L2DAnimationClipType.Normal then
    return
  end
  if self.config == nil then
    warn("英雄:" .. self.heroId .. "{" .. animName .. "}动作的cv未适配")
    return
  end
  if self.CustomLive2dLua ~= nil then
    self.CustomLive2dLua:OnPlayL2dClip(animName)
  end
  local cvId = self:GetRandomWaitCvId(self.heroId, animName, self.config)
  if cvId == nil and l2dClipType == L2DAnimationClipType.Login then
    if loginType ~= 0 then
      local loginCvIds = self.config.aniCvDic[tostring(loginType)]
      if loginCvIds ~= nil and 0 < #loginCvIds then
        cvId = loginCvIds[1]
      else
        cvId = loginType
      end
    else
      local window = UIManager:GetWindow(UIWindowTypeID.Home)
      if window ~= nil and window.homeAdjutant ~= nil then
        cvId = window.homeAdjutant:GetLoginType()
      end
    end
  end
  local delay_second = self.config.delay_seconds[cvId]
  if delay_second ~= nil then
    return nil
  end
  if cvId == nil then
    return
  end
  local dontCheckTime = false
  if l2dClipType == L2DAnimationClipType.Interaction or l2dClipType == L2DAnimationClipType.ExternalEvent then
    dontCheckTime = true
  end
  if animName == "touch_0" then
    animLength = 0
  end
  local closeMouseListen = isHaveMouseAni
  self.closeMouseListen = closeMouseListen
  self:__PlayCV(cvId, animLength, dontCheckTime, closeMouseListen)
end

function HeroL2dInterationController:__PlayCV(cvId, aniLength, dontCheckTime, closeMouseListen)
  if not self:CheckGlobalPlayTimeInterval(self.heroId, dontCheckTime) then
    return
  end
  if not self.coundPlaySound then
    return
  end
  self._lastPlayedCVId = cvId
  if self.aniPlayFunc ~= nil then
    self.aniPlayFunc(self._lastPlayedCVId, aniLength, not closeMouseListen)
    local lastCvInfo = PlayerDataCenter.cacheSaveData:GetLastHeroInterationCVInfo()
    lastCvInfo.lastVoiceHeroId = self.heroId
    lastCvInfo.lastVoiceTIme = cs_time.time
    PlayerDataCenter.cacheSaveData:SetLastHeroInterationCVInfo(lastCvInfo)
  end
end

function HeroL2dInterationController:l2dTriggerEvent(triggerArg)
  if self.CustomLive2dLua ~= nil then
    self.CustomLive2dLua:OnTriggerCallCustomLua(triggerArg)
  end
end

function HeroL2dInterationController:l2dAnimationEvent(eventArgsStr)
  if eventArgsStr == nil then
    return
  end
  local args = string.split(eventArgsStr, "_")
  if table.length(args) == 0 then
    return
  end
  local eventType = args[1]
  if self.CustomLive2dLua ~= nil then
    self.CustomLive2dLua:OnLive2dEvent(eventType, args)
  end
  if eventType == Live2dAnimationEventType.characterVoice then
    if not self.coundPlaySound then
      return
    end
    self:PlayL2DCharacterVoiceEvent(tonumber(args[2]), tonumber(args[3]))
    return
  end
  if eventType == Live2dAnimationEventType.particle then
    self:PlayL2DEffectEvent(args[2], args[3] == "1")
    return
  end
  if eventType == Live2dAnimationEventType.loginTimeLine then
    self:SetLoginTimeLine(args[2] == "0")
    return
  end
  if eventType == Live2dAnimationEventType.soundFx then
    if not self.coundPlaySound then
      return
    end
    self:PlaySoundFxEvent(tonumber(args[2]), args[3], args[4] == "1")
    return
  end
  if eventType == Live2dAnimationEventType.luaCall and self.CustomLive2dLua ~= nil then
    self.CustomLive2dLua:OnEventCallCustomLua(args)
  end
end

function HeroL2dInterationController:PlayL2DCharacterVoiceEvent(cvId, animLength)
  self:__PlayCV(cvId, animLength, true, true)
end

function HeroL2dInterationController:PlayL2DEffectEvent(particleName, isActive)
  if IsNull(self.cs_cubismParitcleController) then
    return
  end
  if isActive then
    self.cs_cubismParitcleController:PlayParticle(particleName)
  else
    self.cs_cubismParitcleController:StopParticle(particleName)
  end
end

function HeroL2dInterationController:SetLoginTimeLine(isPause)
  if PlayerDataCenter.cacheSaveData:IsHasPlayedL2dLoginAnim() then
    return
  end
  local window = UIManager:GetWindow(UIWindowTypeID.Home)
  if window == nil then
    return
  end
  if isPause then
    window:PauseEnterTimeLine()
  else
    window:PlayEnterTimeLine()
    PlayerDataCenter.cacheSaveData:SetHasPlayedL2dLoginAnim(true)
  end
end

function HeroL2dInterationController:PlaySoundFxEvent(audioId, sfxType, isPlay)
  if not IsNull(self.cs_CubismInterationController) and not self.cs_CubismInterationController.IsOpenWait then
    return
  end
  if self:IsCloseL2dSfx() then
    return
  end
  if sfxType == "bgSfx" then
    if isPlay then
      if self.audioBackDic == nil then
        self.audioBackDic = {}
      end
      local auBack = self.audioBackDic[audioId]
      if auBack == nil then
        local auBack = AudioManager:PlayAudioById(audioId)
        self.audioBackDic[audioId] = auBack
      end
    elseif self.audioBackDic ~= nil then
      local auBack = self.audioBackDic[audioId]
      if auBack ~= nil then
        AudioManager:StopAudioByBack(auBack)
        self.audioBackDic[audioId] = nil
      end
    end
  elseif sfxType == "sfx" then
    AudioManager:PlayAudioById(audioId)
  end
end

Live2dAnimationEventType = {
  characterVoice = "characterVoice",
  particle = "particle",
  loginTimeLine = "loginTimeLine",
  soundFx = "soundFx",
  luaCall = "luaCall"
}

function HeroL2dInterationController:GetRandomWaitCvId(heroId, animName, skinLive2dConfig)
  local cvIds
  if animName == friendshipAnimationName then
    cvIds = self.friendShipCvIds
  end
  if cvIds == nil or table.length(cvIds) == 0 then
    if string.find(animName, "assign") ~= nil then
      cvIds = {
        tonumber(string.split(animName, "_")[2])
      }
    else
      cvIds = skinLive2dConfig.aniCvDic[animName]
    end
  end
  if cvIds ~= nil and table.length(cvIds) > 0 then
    local index = math.random(#cvIds)
    local cvId = cvIds[index]
    return cvId
  end
end

function HeroL2dInterationController:IsExistLoginAni(loginType)
  if IsNull(self.cs_CubismInterationController) then
    return false
  end
  local loginL2DClips = self.cs_CubismInterationController:GetLoginL2DClips(loginType, false)
  if IsNull(loginL2DClips) or loginL2DClips.Count == 0 then
    return false
  end
  return true
end

function HeroL2dInterationController:SetRenderControllerSetting(sortingLayerName, uiCanvasGroup, sortingOrder, InfluencedByUICanvas)
  local renderController = self.cs_renderController
  if IsNull(renderController) then
    return
  end
  if sortingLayerName ~= nil and sortingLayerName ~= "" then
    renderController.SortingLayer = sortingLayerName
  end
  if not IsNull(uiCanvasGroup) then
    renderController.uiCanvasGroup = uiCanvasGroup
  end
  if sortingOrder ~= nil then
    renderController.SortingOrder = sortingOrder
  end
  renderController.InfluencedByUICanvas = InfluencedByUICanvas == true
  self:SetL2dEffectSortingLayer(sortingLayerName)
end

function HeroL2dInterationController:SetL2dEffectSortingLayer(sortingLayerName)
  local l2dParitcleController = self.cs_cubismParitcleController
  if IsNull(l2dParitcleController) then
    return
  end
  local sortingLayerID = cs_SortingLayer.NameToID(sortingLayerName)
  local particleEffects = l2dParitcleController.cubismParticleEffects
  if not IsNull(particleEffects) then
    for i = 0, particleEffects.Count - 1 do
      local particleEffect = particleEffects[i]
      if not IsNull(particleEffect) then
        local particle = particleEffect.Particle
        if not IsNull(particle) then
          local childParticleRenders = particle.gameObject:GetComponentsInChildren(typeof(cs_ParticleSystemRenderer))
          if not IsNull(childParticleRenders) then
            for j = 0, childParticleRenders.Length - 1 do
              local childParticle = childParticleRenders[j]
              childParticle.sortingLayerID = sortingLayerID
            end
          end
        end
      end
    end
  end
end

function HeroL2dInterationController:SetL2DHideBg(value)
  self.needHIdeL2dBg = value
end

function HeroL2dInterationController:SetOpenL2dSfx(value)
  self.isCloseL2dSfx = value
end

function HeroL2dInterationController:IsHideL2dBg()
  if self.needHIdeL2dBg == false then
    return false
  end
  if self.config ~= nil then
    local isOpenHideBg = self.config.is_open_hide_bg
    if not isOpenHideBg then
      return false
    end
    local skinId = self.config.id
    local isHideBg = PlayerDataCenter.skinData:IsHideL2dBg(skinId)
    return isHideBg
  end
  return false
end

function HeroL2dInterationController:HideL2dBg()
  local isHideL2dBg = self:IsHideL2dBg()
  if not isHideL2dBg then
    return
  end
  local renderController = self.cs_renderController
  self.ActiveLive2dBg(renderController, false)
end

function HeroL2dInterationController:IsHideHolight()
  if self.config ~= nil then
    local isRectify_holight = self.config.rectify_holight and ConfigData.game_config.IsUsingSkinRecitify
    if not isRectify_holight then
      return true
    end
    local skinId = self.config.id
    local isHideHolight = PlayerDataCenter.skinData:IsHideHolight(skinId)
    return isHideHolight
  end
  return false
end

function HeroL2dInterationController:HideHolight()
  local isHideHolight = self:IsHideHolight()
  if not isHideHolight then
    return
  end
  local renderController = self.cs_renderController
  self.ActiveLive2dHolight(renderController, false)
end

function HeroL2dInterationController:IsCloseL2dSfx()
  if self.isCloseL2dSfx == true then
    return true
  end
  if self.config ~= nil then
    local isHasL2dSfx = self.config.is_has_l2d_sfx
    if not isHasL2dSfx then
      return false
    end
    local skinId = self.config.id
    local isCloseL2dSfx = PlayerDataCenter.skinData:IsCloseLive2dSfx(skinId)
    return isCloseL2dSfx
  end
  return false
end

function HeroL2dInterationController:SetL2DPosType(posTypeName, alignUIFakeCam)
  local commonPerpectiveHandle = self.cs_commonPerpectiveHandle
  if IsNull(commonPerpectiveHandle) then
    return
  end
  commonPerpectiveHandle:SetL2DPosType(posTypeName, alignUIFakeCam == true)
  if self.CustomLive2dLua ~= nil then
    self.CustomLive2dLua:OnSetLive2dUIPos()
  end
end

function HeroL2dInterationController:IsContainL2DPosTypeData(posTypeName)
  local commonPerpectiveHandle = self.cs_commonPerpectiveHandle
  if IsNull(commonPerpectiveHandle) then
    return false
  end
  return commonPerpectiveHandle:IsContainPosTypeData(posTypeName)
end

function HeroL2dInterationController:OpenLookTarget(camera)
  local cubismLookController = self.cs_cubismLookController
  local lookTarget = self.cs_lookTarget
  if IsNull(cubismLookController) or IsNull(lookTarget) then
    return
  end
  cubismLookController.enabled = true
  cubismLookController:SetCamera(camera)
  lookTarget:SetCamera(camera)
  lookTarget:SetTimeClip(0.2)
end

function HeroL2dInterationController:PlayHeroEnterHomeAnimation(loginType)
  if IsNull(self.cs_CubismInterationController) then
    return
  end
  if not self:CheckGlobalPlayTimeInterval(self.heroId, false) then
    return
  end
  local isEndBattle = PlayerDataCenter.cacheSaveData:GetIsEndBattleForHeroInteration()
  if isEndBattle then
    self:PlayLoginAnimation(loginType, false)
    return
  end
  self.cs_CubismInterationController:PlayWaitAni()
end

function HeroL2dInterationController:PlayLoginAnimation(loginType, dontCheckTime)
  if IsNull(self.cs_CubismInterationController) then
    return 0
  end
  if dontCheckTime == nil then
    dontCheckTime = true
  end
  if self:CheckGlobalPlayTimeInterval(self.heroId, dontCheckTime) then
    local closeMouseListen = self:IsSSRLive2D() and self:IsExistLoginAni(loginType)
    self.closeMouseListen = closeMouseListen
    local aniLength = self.cs_CubismInterationController:PlayLoginAni(loginType, true)
    PlayerDataCenter.cacheSaveData:SetIsEndBattleForHeroInteration(false)
    return aniLength
  end
  return 0
end

function HeroL2dInterationController:SetInterationOpenRayCast(flag)
  if not IsNull(self.cs_rayCast) then
    self.cs_rayCast.enabled = flag
    if self.CustomLive2dLua ~= nil then
      self.CustomLive2dLua:SetInterationOpenRayCast(flag)
    end
  end
end

function HeroL2dInterationController:SetInterationCVOver(flag)
  if flag then
    self.closeMouseListen = false
  end
  if not IsNull(self.cs_CubismInterationController) then
    self:SetMouthActive(not flag)
    self.cs_CubismInterationController.IsCVOver = flag
    if self.CustomLive2dLua ~= nil then
      self.CustomLive2dLua:OnCvOver(flag)
    end
  end
end

function HeroL2dInterationController:SetInterationOpenWait(flag)
  if not IsNull(self.cs_CubismInterationController) then
    self.cs_CubismInterationController.IsOpenWait = flag
    if self.CustomLive2dLua ~= nil then
      self.CustomLive2dLua:OnSetInterationOpenWait(flag)
    end
  end
end

function HeroL2dInterationController:ResetInterationWaitTime()
  if not IsNull(self.cs_CubismInterationController) then
    self.cs_CubismInterationController:InitIdleAnimationTime()
  end
end

function HeroInterationBaseController:RestartBodyAnimation()
  if not IsNull(self.cs_CubismInterationController) then
    self.cs_CubismInterationController._motionController:StopAnimation(0, 0)
    self.cs_CubismInterationController:RestartBodyAnimation()
  end
end

function HeroL2dInterationController:IsPlayLoginAnimationOnAutoShowOver(loginType)
  if not IsNull(self.cs_CubismInterationController) then
    return self.cs_CubismInterationController:IsLoginAniPlayOnAutoShowOver(loginType)
  end
  return true
end

function HeroL2dInterationController:SetUIPenetration(isAllowedPenetration)
  if not IsNull(self.cs_CubismInterationController) then
    self.cs_CubismInterationController.OpenGuiJudge = not isAllowedPenetration
  end
end

function HeroL2dInterationController:Delete()
  if not IsNull(self.cs_CubismInterationController) then
    if self.aniCallback ~= nil then
      self.cs_CubismInterationController:OnAnimationPlayEvent("-", self.aniCallback)
      self.cs_CubismInterationController:AnimationEventAction("-", self.l2dAnimationEventCallback)
      self.cs_CubismInterationController:TriggerEventAction("-", self.l2dTriggerEventCallback)
    end
    self.aniCallback = nil
    self.l2dAnimationEventCallback = nil
    self.l2dTriggerEventCallback = nil
  end
  self:__DisposeCSComponent()
  self.normalClip = nil
  self.friendShipCvIds = nil
  self.CustomLive2dLua = nil
  if self.live2dLuaPath ~= nil then
    package.loaded[self.live2dLuaPath] = nil
    self.live2dLuaPath = nil
  end
  collectgarbage()
  base.Delete(self)
end

function HeroL2dInterationController:SetMouthActive(isEnabled)
  if not IsNull(self.cs_mouth) then
    self.cs_mouth.enabled = isEnabled and not self.closeMouseListen
  end
end

function HeroL2dInterationController:SetCoundPlaySound(value)
  self.coundPlaySound = value
end

function HeroL2dInterationController:__DisposeCSComponent()
  self.cs_rayCast = nil
  self.cs_mouth = nil
  self.cs_cubismLookController = nil
  self.cs_cubismParitcleController = nil
  self.cs_renderController = nil
  self.cs_commonPerpectiveHandle = nil
  self.cs_lookTarget = nil
  self.cs_CubismInterationController = nil
  self:StopCubismInterationAuido()
end

function HeroL2dInterationController:StopCubismInterationAuido()
  if self.audioBackDic ~= nil then
    for audioId, auBack in pairs(self.audioBackDic) do
      if auBack ~= nil then
        AudioManager:StopAudioByBack(auBack)
        self.audioBackDic[audioId] = nil
      end
    end
    self.audioBackDic = nil
  end
end

function HeroL2dInterationController.ActiveLive2dBg(renderController, isActive)
  if IsNull(renderController) then
    return
  end
  local renders = renderController.Renderers
  if renders == nil or renders.length == 0 then
    return
  end
  for i = 0, renders.Length - 1 do
    local render = renders[i]
    if not IsNull(render) and not IsNull(render.MeshRenderer) and not render.MeshRenderer.receiveShadows then
      render.MeshRenderer.gameObject:SetActive(isActive)
    end
  end
end

function HeroL2dInterationController.ActiveLive2dHolight(renderController, isActive)
  if IsNull(renderController) then
    return
  end
  local renders = renderController.Renderers
  if renders == nil or renders.length == 0 then
    return
  end
  for i = 0, renders.Length - 1 do
    local render = renders[i]
    if not IsNull(render) and not IsNull(render.MeshRenderer) and string.find(render.MeshRenderer.gameObject.name, "ArtMeshHoLight") then
      render.MeshRenderer.gameObject:SetActive(isActive)
    end
  end
end

return HeroL2dInterationController
