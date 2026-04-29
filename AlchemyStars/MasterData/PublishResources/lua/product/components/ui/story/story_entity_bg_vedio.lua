_class("StoryEntityBgVedio", StoryEntityMovable)
StoryEntityBgVedio = StoryEntityBgVedio

function StoryEntityBgVedio:Constructor(ID, gameObject, request, storyManager, resourceName)
  StoryEntityBgVedio.super.Constructor(self, ID, gameObject, request, storyManager)
  self._entiyType = StoryEntityType.BgVedio
  self._resourceName = resourceName
  self._storyManager = storyManager
  self._gameObject = gameObject
  self._request = request
  self:_GetComponents()
  self:_InitDefaultValue()
end

function StoryEntityBgVedio:_GetComponents()
  self._videoPlayerObj = self._gameObject.transform:Find("FullScreenArea/VideoPlayer").gameObject
  self._skipAudioObj = self._gameObject.transform:Find("FullScreenArea/SkipAudioBtn").gameObject
  self._subTitle = self._gameObject.transform:Find("FullScreenArea/Subtitle").gameObject
  self._videoSubtitleText = self._subTitle:GetComponent("UILocalizationText")
end

function StoryEntityBgVedio:_InitDefaultValue()
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

function StoryEntityBgVedio:Destroy()
  StoryEntityBgVedio.super.Destroy(self)
  if self._prepareVideTask ~= nil then
    GameGlobal.TaskManager():KillTask(self._prepareVideTask)
    self._prepareVideTask = nil
  end
  if self._waitPlayVedioTask ~= nil then
    GameGlobal.TaskManager():KillTask(self._waitPlayVedioTask)
    self._waitPlayVedioTask = nil
  end
end

function StoryEntityBgVedio:_TriggerKeyframe(keyframeData)
  StoryEntityBgVedio.super._TriggerKeyframe(self, keyframeData)
  self:_TriggerLoop(keyframeData)
  self:_TriggerActive(keyframeData)
  self:_TriggerScreenType(keyframeData)
  self:_TriggerSlince(keyframeData)
  self:_TriggerScale(keyframeData)
end

function StoryEntityBgVedio:_TriggerActive(keyframeData)
  if self._isfirstShow then
    if self._storyManager:GetAuto() then
      self._storyManager:SetAuto(false)
      self._playVedioBackAuto = true
    end
    self:PlayVedio()
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

function StoryEntityBgVedio:_TriggerScreenType(keyframeData)
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

function StoryEntityBgVedio:_TriggerSlince(keyframeData)
  if keyframeData.Slince == true then
    self._criVideoPlayer:SetVolume(0)
  else
    self._criVideoPlayer:SetVolume(1)
  end
end

function StoryEntityBgVedio:_TriggerLoop(keyframeData)
  if keyframeData.Loop == true then
    self._loopPv = true
  else
    self._loopPv = false
  end
end

function StoryEntityBgVedio:_TriggerScale(keyframeData)
  local rectTf = self._videoPlayerObj:GetComponent("RectTransform")
  if keyframeData.Scale ~= nil then
    rectTf.localScale = Vector3(keyframeData.Scale, keyframeData.Scale, keyframeData.Scale)
  else
    rectTf.localScale = Vector3.one
  end
end

function StoryEntityBgVedio:PlayVedio()
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
    while not self._subTitle.activeInHierarchy do
      YIELD(TT)
    end
    self._videoPlayerObj:SetActive(true)
    self._waitPlayVedioTask = TaskManager:GetInstance():StartTask(self.WaitPlayVedio, self)
  end)
end

function StoryEntityBgVedio:WaitPlayVedio(TT)
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

function StoryEntityBgVedio:PauseVedio()
  self._isPauseAudio = true
  self._criVideoPlayer:Pause(true)
end

function StoryEntityBgVedio:ResumeVedio()
  self._isPauseAudio = false
  self._criVideoPlayer:Pause(false)
end

function StoryEntityBgVedio:PlayVedioComplete()
  self._skipAudioObj:SetActive(false)
  self._videoSubtitleText.text = ""
  self._subTitle:SetActive(false)
  self._videoPlayerObj:SetActive(false)
  if self._playVedioBackAuto then
    self._storyManager:SetAuto(true)
  end
  Log.debug("PlayAudioComplete Stop", tostring(self._criVideoPlayer:GetPlayerStatus()))
end
