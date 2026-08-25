local AvgScreenEffect = CommonDefine.AvgScreenEffect
local CanvasGroup = CS.UnityEngine.CanvasGroup
local TimeUtil = CS.Framework.TimeUtil
local Vector2 = CS.UnityEngine.Vector2
local TypeUIAnimationController = typeof(CS.Z1Client.UIAnimationController)
local AvgActionPlayScreenEffect, Super = System.NewClass("AvgActionPlayScreenEffect", AvgActionBase)

function AvgActionPlayScreenEffect:ctor(...)
  Super.ctor(self, ...)
  self.copyMap = {}
end

function AvgActionPlayScreenEffect:DoAction(_, _, finishCb)
  local screenEffectMap = self.avgModel:GetScreenffectMap()
  local ScreenEffectConfig = {
    [AvgScreenEffect.Awake] = self.ui.Effect_Yanjing,
    [AvgScreenEffect.BlinkEye] = self.ui.Effect_Yanjing,
    [AvgScreenEffect.CloseEye] = self.ui.Effect_Yanjing,
    [AvgScreenEffect.Retro] = self.ui.Effect_Retro,
    [AvgScreenEffect.Mucus] = self.ui.EmptyNode,
    [AvgScreenEffect.KeyWorkVideo] = self.ui.EmptyNode
  }
  local BottomEffectConfig = {
    [AvgScreenEffect.Smoke] = CommonRes.AVGScreenEffect.Smoke,
    [AvgScreenEffect.Flame] = CommonRes.AVGScreenEffect.Flame,
    [AvgScreenEffect.Rain] = CommonRes.AVGScreenEffect.Rain,
    [AvgScreenEffect.Snow] = CommonRes.AVGScreenEffect.Snow,
    [AvgScreenEffect.Disturb] = CommonRes.AVGScreenEffect.Disturb,
    [AvgScreenEffect.DisturbFx] = CommonRes.AVGScreenEffect.DisturbFx,
    [AvgScreenEffect.SpeedLine] = CommonRes.AVGScreenEffect.SpeedLine,
    [AvgScreenEffect.KeyWorkEffect] = CommonRes.AVGScreenEffect.KeyWorkEffect
  }
  local TopEffectConfig = {
    [AvgScreenEffect.WhiteSmoke] = CommonRes.AVGScreenEffect.WhiteSmoke,
    [AvgScreenEffect.WhiteSmokeFall] = CommonRes.AVGScreenEffect.WhiteSmokeFall,
    [AvgScreenEffect.WhiteSmokeFallLoop] = CommonRes.AVGScreenEffect.WhiteSmokeFallLoop,
    [AvgScreenEffect.LightRain] = CommonRes.AVGScreenEffect.LightRain,
    [AvgScreenEffect.OldFilm] = CommonRes.AVGScreenEffect.OldFilm,
    [AvgScreenEffect.RedScreen] = CommonRes.AVGScreenEffect.RedScreen,
    [AvgScreenEffect.RedFlower] = CommonRes.AVGScreenEffect.RedFlower,
    [AvgScreenEffect.BlackFlower] = CommonRes.AVGScreenEffect.BlackFlower,
    [AvgScreenEffect.BloodSmoke] = CommonRes.AVGScreenEffect.BloodSmoke,
    [AvgScreenEffect.BlackSmoke] = CommonRes.AVGScreenEffect.BlackSmoke,
    [AvgScreenEffect.RedLoop] = CommonRes.AVGScreenEffect.RedLoop,
    [AvgScreenEffect.StarLight] = CommonRes.AVGScreenEffect.StarLight,
    [AvgScreenEffect.LampLight] = CommonRes.AVGScreenEffect.LampLight,
    [AvgScreenEffect.SandStorm] = CommonRes.AVGScreenEffect.SandStorm,
    [AvgScreenEffect.Erosion] = CommonRes.AVGScreenEffect.Erosion
  }
  local videoPath = CommonDefine.ScreenEffectVideoPath
  for effectName, effectGo in pairs(ScreenEffectConfig) do
    local showState = screenEffectMap[effectName]
    self:TweenShowOrClose(effectGo, showState, self:GetIsPreShow(effectName))
    local videoParams = videoPath[effectName]
    if videoParams then
      self:UniqVideoEffct(showState, self:GetIsPreShow(effectName), videoParams)
    end
  end
  for effectName, effectPath in pairs(BottomEffectConfig) do
    local showState = screenEffectMap[effectName]
    local parentTf = self.ui.Group_UI_Vx.transform
    self:TweenShowOrCloseByLoadPrefab(parentTf, effectPath, showState, self:GetIsPreShow(effectName))
  end
  for effectName, effectPath in pairs(TopEffectConfig) do
    local showState = screenEffectMap[effectName]
    local parentTf = self.ui.Group_UI_Vx_Top.transform
    self:TweenShowOrCloseByLoadPrefab(parentTf, effectPath, showState, self:GetIsPreShow(effectName))
  end
  self:UniqDisturbEffect(screenEffectMap[AvgScreenEffect.Disturb], self:GetIsPreShow(AvgScreenEffect.Disturb))
  self:ContinueShakeEffect(screenEffectMap[AvgScreenEffect.ContinueShake], self:GetIsPreShow(AvgScreenEffect.ContinueShake))
  local screenEffectAni = {
    [AvgScreenEffect.CloseEye] = CommonDefine.AvgScreenEffectAni.CloseEye,
    [AvgScreenEffect.BlinkEye] = CommonDefine.AvgScreenEffectAni.BlinkEye
  }
  for effectName, aniName in pairs(screenEffectAni) do
    if screenEffectMap[effectName] then
      self:PlayAnim(aniName)
    end
  end
  if screenEffectMap[AvgScreenEffect.Awake] then
    self:UniqAwakeEyeEffect(finishCb)
    return
  end
  local delay = self:GetDelayFinishTime(screenEffectMap)
  if delay then
    self.binder:BindTimer(delay, 0, nil, finishCb)
  else
    finishCb()
  end
  self.preScreenEffectMap = table.clone(screenEffectMap)
end

function AvgActionPlayScreenEffect:GetVideoUIAddPlayer()
  if not self.tempTimelineVideoAdd then
    self.tempTimelineVideoAdd = CS.UnityEngine.GameObject.Instantiate(self.ui.TimelineVideoUIAdd)
    self.tempTimelineVideoAdd.transform:SetParent(self.ui.TimelineVideoUIAdd.transform.parent, false)
  end
  self.tempTimelineVideoAdd:SetActive(true)
  local uiRes = TimelineVideoUIAddResource(self.tempTimelineVideoAdd)
  local videoUIAddPlayer = AVProAlphaVideoPlayer(uiRes.color, uiRes.color_bak, uiRes.alpha, uiRes.alpha_bak)
  videoUIAddPlayer:SetRawImage(uiRes.uiNode)
  return videoUIAddPlayer
end

function AvgActionPlayScreenEffect:GetDelayFinishTime(effectMap)
  if effectMap[AvgScreenEffect.Erosion] then
    return 2.5
  end
end

function AvgActionPlayScreenEffect:GetIsPreShow(effectName)
  return self.preScreenEffectMap and self.preScreenEffectMap[effectName] or false
end

function AvgActionPlayScreenEffect:PlayAnim(aniName)
  local uiAnimCtr = self.ui.Effect_Yanjing:GetComponent(TypeUIAnimationController)
  uiAnimCtr:PlayState(aniName)
end

function AvgActionPlayScreenEffect:UniqAwakeEyeEffect(finishCb)
  local uiAnimCtr = self.ui.Effect_Yanjing:GetComponent(TypeUIAnimationController)
  uiAnimCtr:PlayState("UI_Story_Effect_yanjing_vx")
  self.avgPanel.textComp:ClearDialogText()
  local delayTime = 2.1
  delayTime = delayTime / TimeUtil.GetTimeScale()
  self.avgPanel.isForceHideDialog.value = true
  self.binder:BindTimer(delayTime, 0, nil, function()
    finishCb()
    self.avgPanel.isForceHideDialog.value = false
    self.ui.Group_Dialog:SetActive(self.avgPanel:GetIsShowGroupDialog())
  end)
end

function AvgActionPlayScreenEffect:TweenShowOrCloseByLoadPrefab(parentTf, effectPath, isCurShow, isPreShow)
  if not isPreShow and isCurShow then
    local prefab = ResLoadMgr.LoadAsset(effectPath, self)
    if not self.copyMap[effectPath] then
      self.copyMap[effectPath] = GameObject.Instantiate(prefab, parentTf)
    end
    local copy = self.copyMap[effectPath]
    copy:SetActive(true)
    local canvasGroup = self:GetCanvasGroup(copy)
    if canvasGroup then
      canvasGroup.alpha = 0
      canvasGroup:DOFade(1, 0.3)
    end
  end
  if isPreShow and not isCurShow then
    local copy = self.copyMap[effectPath]
    if copy then
      local canvasGroup = self:GetCanvasGroup(copy)
      if canvasGroup then
        canvasGroup:DOFade(0, 0.3):OnComplete(function()
          GameObject.Destroy(copy)
        end)
      else
        GameObject.Destroy(copy)
      end
      self.copyMap[effectPath] = nil
    end
  end
end

function AvgActionPlayScreenEffect:TweenShowOrClose(gameObj, isCurShow, isPreShow)
  if not isPreShow and isCurShow then
    gameObj:SetActive(false)
    gameObj:SetActive(true)
    local canvasGroup = self:GetCanvasGroup(gameObj)
    if canvasGroup then
      canvasGroup.alpha = 0
      canvasGroup:DOFade(1, 0.3)
    end
  end
  if isPreShow and not isCurShow then
    local canvasGroup = self:GetCanvasGroup(gameObj)
    if canvasGroup then
      canvasGroup:DOFade(0, 0.3):OnComplete(function()
        gameObj:SetActive(false)
      end)
    else
      gameObj:SetActive(false)
    end
  end
end

function AvgActionPlayScreenEffect:GetCanvasGroup(gameObj)
  do return gameObj.GetComponent, gameObj, typeof(CanvasGroup) end
  return gameObj.GetComponent, gameObj, typeof(CanvasGroup)
end

function AvgActionPlayScreenEffect:UniqDisturbEffect(isCurShow, isPreShow)
  if not isPreShow and isCurShow then
    self.avgPanel.bgComp:EnableDisturbMetiral(true)
  end
  if isPreShow and not isCurShow then
    self.avgPanel.bgComp:EnableDisturbMetiral(false)
  end
end

function AvgActionPlayScreenEffect:UniqVideoEffct(isCurShow, isPreShow, videoParams)
  if not isPreShow and isCurShow then
    self:StopVideo()
    if not self.videoUIAddPlayer then
      self.videoUIAddPlayer = self:GetVideoUIAddPlayer()
    end
    self.videoUIAddPlayer:RemoveAllListeners()
    self.tempTimelineVideoAdd:SetActive(true)
    self.videoUIAddPlayer:OpenMedia(videoParams[1], videoParams[2])
    self.videoUIAddPlayer:SetLooping(videoParams[3] or false)
    AddLuaCompOnce(self.tempTimelineVideoAdd, AVProVideoLiftTimeControl):SetVideoPlayer(self.videoUIAddPlayer)
    if not videoParams[3] then
      function self.videoUIAddPlayer.finishedCallback()
        self:StopVideo()
      end
    end
  end
  if isPreShow and not isCurShow then
    self:StopVideo()
  end
end

function AvgActionPlayScreenEffect:StopVideo()
  if self.videoUIAddPlayer then
    self.videoUIAddPlayer:Dispose()
    self.videoUIAddPlayer = nil
  end
  if not IsNil(self.tempTimelineVideoAdd) then
    self.tempTimelineVideoAdd:SetActive(false)
  end
end

function AvgActionPlayScreenEffect:ContinueShakeEffect(isCurShow, isPreShow)
  if not isPreShow and isCurShow then
    local bgLoopAniCtr = self.ui.AvgDialogBg:GetComponent(TypeUIAnimationController)
    if bgLoopAniCtr then
      bgLoopAniCtr:LoopPlayState("UI_Story_Panel_AvgDialogBg_KeepShake_vx")
    end
  end
  if isPreShow and not isCurShow then
    local bgLoopAniCtr = self.ui.AvgDialogBg:GetComponent(TypeUIAnimationController)
    if bgLoopAniCtr then
      bgLoopAniCtr:StopPlayableGraph()
      self.ui.Image_Bg_Show.transform.anchoredPosition = Vector2.zero
    end
  end
end

return AvgActionPlayScreenEffect
