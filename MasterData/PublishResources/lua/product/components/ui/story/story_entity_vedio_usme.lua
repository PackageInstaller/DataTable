_class("StoryEntityVedioUsme", StoryEntityMovable)
StoryEntityVedioUsme = StoryEntityVedioUsme
local StoryVideoPlayerStatus = {
  Stop = 1,
  Dechead = 7,
  WaitPrep = 3,
  Prep = 4,
  Ready = 5,
  Playing = 6,
  PlayEnd = 2,
  Error = 8,
  StopProcessing = 9
}
_enum("StoryVideoPlayerStatus", StoryVideoPlayerStatus)

function StoryEntityVedioUsme:Constructor(ID, gameObject, request, storyManager, resourceName)
  StoryEntityVedioUsme.super.Constructor(self, ID, gameObject, request, storyManager)
  self._entiyType = StoryEntityType.Usme
  self._resourceName = resourceName
  self._storyManager = storyManager
  self._gameObject = gameObject
  self._request = request
  self:_GetComponents()
  self:_InitDefaultValue()
end

function StoryEntityVedioUsme:_GetComponents()
  self._videoPlayerObj = self._gameObject.transform:Find("FullScreenArea/VideoPlayer").gameObject
  self._skipAudioObj = self._gameObject.transform:Find("FullScreenArea/SkipAudioBtn").gameObject
  self._subTitle = self._gameObject.transform:Find("FullScreenArea/Subtitle").gameObject
  self._videoSubtitleText = self._subTitle:GetComponent("UILocalizationText")
  UIEventTriggerListener.Get(self._videoPlayerObj).onClick = function()
    if self._isCanShowSkipBtn then
      self:PlayVideoOnClick()
    end
  end
  UIEventTriggerListener.Get(self._skipAudioObj).onClick = function()
    self:SkipAudioBtnOnClick()
  end
end

function StoryEntityVedioUsme:_InitDefaultValue()
  self._isPauseAudio = false
  self._isShowSkipBtn = false
  self._isCanShowSkipBtn = false
  self._isfirstShow = true
  self._subTitledArray = {}
  self.videoName = self._resourceName.Resource
  self._gameObject.transform.localPosition = Vector3.zero
  self._loopPv = false
  self._noWarp = true
  if CriWare.CriManaMovieControllerForUI then
    self._noWarp = false
  else
    require("tolua.reflection")
    tolua.loadassembly("CriMw.CriWare.Runtime")
    self._type = typeof("CriWare.CriManaMovieControllerForUI")
    self._playerType = typeof("CriWare.CriMana.Player")
  end
end

function StoryEntityVedioUsme:Destroy()
  StoryEntityVedioUsme.super.Destroy(self)
  if self._prepareVideTask ~= nil then
    GameGlobal.TaskManager():KillTask(self._prepareVideTask)
    self._prepareVideTask = nil
  end
  if self._waitPlayVedioTask ~= nil then
    GameGlobal.TaskManager():KillTask(self._waitPlayVedioTask)
    self._waitPlayVedioTask = nil
  end
  if self._delayHideJumpBtnTask ~= nil then
    GameGlobal.TaskManager():KillTask(self._delayHideJumpBtnTask)
    self._delayHideJumpBtnTask = nil
  end
  AudioHelperController.PlayBGM(self.originBGM, AudioConstValue.BGMCrossFadeTime)
end

function StoryEntityVedioUsme:_TriggerKeyframe(keyframeData)
  StoryEntityVedioUsme.super._TriggerKeyframe(self, keyframeData)
  self:_TriggerLoop(keyframeData)
  self:_TriggerActive(keyframeData)
  self:_TriggerScreenType(keyframeData)
  self:_TriggerSlince(keyframeData)
end

function StoryEntityVedioUsme:_TriggerActive(keyframeData)
  if self._isfirstShow then
    if self._storyManager:GetAuto() then
      self._storyManager:SetAuto(false)
      self._playVedioBackAuto = true
    end
    self:PlayVedio()
    if keyframeData.Layer == nil then
      self._storyManager:SetLayer(self._gameObject.transform, 999)
    end
    self._delayCanShowBtnTask = TaskManager:GetInstance():StartTask(function(TT)
      YIELD(TT, 5000)
      self._isCanShowSkipBtn = true
    end, self)
    self._isfirstShow = false
  end
  if keyframeData.Active then
    self._videoPlayerObj:SetActive(true)
    self:ResumeVedio()
  elseif keyframeData.Active == false then
    self._videoPlayerObj:SetActive(false)
    self:PauseVedio()
  end
end

function StoryEntityVedioUsme:_TriggerScreenType(keyframeData)
  local rectTf = self._videoPlayerObj:GetComponent("RectTransform")
  if keyframeData.FullScreen then
    rectTf.anchorMin = Vector2.zero
    rectTf.anchorMax = Vector2.one
    rectTf.sizeDelta = Vector2(0, 0)
  else
    rectTf.anchorMin = Vector2.one * 0.5
    rectTf.anchorMax = Vector2.one * 0.5
    rectTf.sizeDelta = Vector2(2539, 1439)
  end
end

function StoryEntityVedioUsme:_TriggerSlince(keyframeData)
  if keyframeData.Slince == true then
    self._criVideoPlayer:SetVolume(0)
  else
    self._criVideoPlayer:SetVolume(1)
  end
end

function StoryEntityVedioUsme:_TriggerLoop(keyframeData)
  if keyframeData.Loop == true then
    self._loopPv = true
  else
    self._loopPv = false
  end
end

function StoryEntityVedioUsme:_TriggerScale(keyframeData)
  local rectTf = self._videoPlayerObj:GetComponent("RectTransform")
  if keyframeData.Scale ~= nil then
    rectTf.localScale = Vector3(keyframeData.Scale, keyframeData.Scale, keyframeData.Scale)
  else
    rectTf.localScale = Vector3.one
  end
end

function StoryEntityVedioUsme:PlayVedio()
  if self._videoPlayerObj.activeSelf == false then
    self._videoPlayerObj:SetActive(true)
    self._gameObject:SetActive(true)
  end
  if self._criVideoPlayer == nil then
    self._criVideoPlayer = self._videoPlayerObj:AddComponent(typeof(CriUIVideoPlayer))
    self._criVideoPlayer:PlayUSMEBySofdec2(self.videoName .. ".usme", self._loopPv, true, function(content)
      self._videoSubtitleText:SetText(content)
    end, function()
    end)
  end
  self._prepareVideTask = TaskManager:GetInstance():StartTask(function(TT)
    while not self._videoPlayerObj.activeInHierarchy do
      YIELD(TT)
    end
    self._subTitle:SetActive(true)
    while not self._subTitle.activeInHierarchy do
      YIELD(TT)
    end
    self._videoPlayerObj:SetActive(true)
    self.originBGM = AudioHelperController.GetCurrentBgm()
    AudioHelperController.StopBGM()
    self._waitPlayVedioTask = TaskManager:GetInstance():StartTask(self.WaitPlayVedio, self)
  end)
end

function StoryEntityVedioUsme:GetLanguageKey()
  local ls = {
    [1] = LanguageType.zh,
    [2] = LanguageType.tw,
    [4] = LanguageType.us,
    [8] = LanguageType.kr,
    [16] = LanguageType.jp,
    [32] = LanguageType.pt,
    [64] = LanguageType.es,
    [128] = LanguageType.idn,
    [256] = LanguageType.th
  }
  local languageType = Localization.GetCurLanguage()
  local languageIndex = 0
  for k, v in pairs(ls) do
    if languageType == v then
      languageIndex = k
      break
    end
  end
  return languageIndex
end

function StoryEntityVedioUsme:WaitPlayVedio(TT)
  local bEndPlay = false
  local currentVideoStatus = ""
  while true do
    currentVideoStatus = self._criVideoPlayer:GetPlayerStatus()
    if self._isPauseAudio then
      YIELD(TT)
    end
    if currentVideoStatus == StoryVideoPlayerStatus.Playing then
      YIELD(TT)
    elseif currentVideoStatus == StoryVideoPlayerStatus.Dechead then
      YIELD(TT)
    elseif currentVideoStatus == StoryVideoPlayerStatus.WaitPrep then
      YIELD(TT)
    elseif currentVideoStatus == StoryVideoPlayerStatus.Prep then
      YIELD(TT)
    elseif currentVideoStatus == StoryVideoPlayerStatus.Ready then
      YIELD(TT)
    else
      Log.debug("WaitPlayVedio bEndPlay", currentVideoStatus)
      bEndPlay = true
    end
    if bEndPlay then
      break
    end
  end
  Log.debug("WaitPlayVedio Stop", currentVideoStatus)
  self._criVideoPlayer:Stop()
  self:PlayVedioComplete()
end

function StoryEntityVedioUsme:PauseVedio()
  self._isPauseAudio = true
  self._criVideoPlayer:Pause(true)
end

function StoryEntityVedioUsme:ResumeVedio()
  self._isPauseAudio = false
  self._criVideoPlayer:Pause(false)
end

function StoryEntityVedioUsme:SkipVedio()
  self._isPauseAudio = false
  self._videoPlayerObj:SetActive(false)
  self._skipAudioObj:SetActive(false)
  self._criVideoPlayer:Stop()
  Log.sys("开始跳过剧情")
  if not self._storyManager then
    Log.warn("storyManager在确认跳过前已被置空")
    Log.sys("结束跳过剧情")
    return
  end
  self._storyManager:SkipParagraph()
  Log.sys("结束跳过剧情")
  if self._playVedioBackAuto then
    self._storyManager:SetAuto(true)
  end
end

function StoryEntityVedioUsme:PlayVedioComplete()
  self._skipAudioObj:SetActive(false)
  self._videoSubtitleText.text = ""
  self._subTitle:SetActive(false)
  self._videoPlayerObj:SetActive(false)
  if self._playVedioBackAuto then
    self._storyManager:SetAuto(true)
  end
  Log.debug("PlayAudioComplete Stop", tostring(self._criVideoPlayer:GetPlayerStatus()))
end

function StoryEntityVedioUsme:SkipAudioBtnOnClick()
  self:PauseVedio()
  self._skipAudioObj:SetActive(false)
  PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, "", StringTable.Get("str_story_skip_confirm"), function(param)
    self:SkipVedio()
  end, nil, function(param)
    self:ResumeVedio()
  end, nil)
end

function StoryEntityVedioUsme:PlayVideoOnClick()
  if self._videoPlayerObj.activeInHierarchy == false then
    return
  end
  if self._isShowSkipBtn == true then
    self._skipAudioObj:SetActive(false)
    self._isShowSkipBtn = false
    if self._delayHideJumpBtnTask ~= nil then
      GameGlobal.TaskManager():KillTask(self._delayHideJumpBtnTask)
      self._delayHideJumpBtnTask = nil
    end
    return
  end
  self._isShowSkipBtn = true
  self._skipAudioObj:SetActive(true)
  self._delayHideJumpBtnTask = TaskManager:GetInstance():StartTask(function(TT)
    YIELD(TT, 3000)
    self._skipAudioObj:SetActive(false)
    self._isShowSkipBtn = false
  end, self)
end
