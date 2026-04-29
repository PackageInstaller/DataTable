_class("UICriVideoControllerNowrap", UIController)
UICriVideoControllerNowrap = UICriVideoControllerNowrap

function UICriVideoControllerNowrap:OnShow(uiParams)
  self.uiParams = uiParams
  self:_GetComponents()
  require("tolua.reflection")
  tolua.loadassembly("CriMw.CriWare.Runtime")
  self._type = typeof("CriWare.CriManaMovieControllerForUI")
  self._playerType = typeof("CriWare.CriMana.Player")
  self:_OnValue()
  self:PlayAudio()
end

function UICriVideoControllerNowrap:_GetComponents()
  self._playVideoScreenObj = self:GetGameObject("PlayVideo")
  self._videoPlayerObj = self:GetGameObject("VideoPlayer")
  self._skipAudioObj = self:GetGameObject("SkipAudioBtn")
  self._subTitle = self:GetGameObject("Subtitle")
  self._videoSubtitleText = self._subTitle:GetComponent("UILocalizationText")
  self._bgRawImage = self:GetUIComponent("RawImageLoader", "BgRawImage")
  self._bgRawImageObj = self:GetGameObject("BgRawImage")
  self._isPauseAudio = false
  self._isShowSkipBtn = false
  self._subTitledArray = {}
  self._twoSide = self:GetGameObject("TwoSides")
  self._leftImage = self:GetUIComponent("RawImageLoader", "Left")
  self._rightImage = self:GetUIComponent("RawImageLoader", "Right")
end

function UICriVideoControllerNowrap:_OnValue()
  self.videoName = self.uiParams[1]
  self.videoBgRawImageName = self.uiParams[2]
  self.closeCallback = self.uiParams[3]
  local rightVideoBg = self.uiParams[4]
  if rightVideoBg then
    self._bgRawImage.gameObject:SetActive(false)
    self._twoSide:SetActive(true)
    self._leftImage:LoadImage(self.videoBgRawImageName)
    self._rightImage:LoadImage(rightVideoBg)
  else
    self._twoSide:SetActive(false)
    if self.videoBgRawImageName then
      self._bgRawImage.gameObject:SetActive(true)
      self._bgRawImage:LoadImage(self.videoBgRawImageName)
    else
      self._bgRawImage.gameObject:SetActive(false)
    end
  end
end

function UICriVideoControllerNowrap:PlayAudio()
  self._playVideoScreenObj:SetActive(true)
  if self._videoPlayer == nil then
    self._videoPlayer = self._videoPlayerObj:AddComponent(self._type)
    local path = ResourceManager:GetInstance():GetAssetPath(self.videoName .. ".usme", LoadType.ADX2Audio, true)
    self:_SetValue("moviePath", path)
    self:_SetValue("playOnStart", false)
    self:_SetValue("loop", false)
  end
  self._videoPlayerObj:SetActive(true)
  self._player = self:_GetValue("player")
  self._prepareVideTask = TaskManager:GetInstance():StartTask(function(TT)
    while not self._videoPlayerObj.activeInHierarchy do
      YIELD(TT)
    end
    self._subTitle:SetActive(true)
    while not self:_GetValue("IsMonoBehaviourStartCalled") do
      YIELD(TT)
    end
    while not self._subTitle.activeInHierarchy do
      YIELD(TT)
    end
    local nValue = math.ceil(Mathf.Log(self:GetLanguageKey(), 2))
    self:_CallFunction("Play", nil)
    self.originBGM = AudioHelperController.GetCurrentBgm()
    AudioHelperController.StopBGM()
    self._waitPlayAudioTask = self:StartTask(self.WaitPlayAudio, self)
  end)
end

function UICriVideoControllerNowrap:OnHide()
  if self._prepareVideTask ~= nil then
    GameGlobal.TaskManager():KillTask(self._prepareVideTask)
    self._prepareVideTask = nil
  end
  if self._waitPlayAudioTask ~= nil then
    GameGlobal.TaskManager():KillTask(self._waitPlayAudioTask)
    self._waitPlayAudioTask = nil
  end
  if self._delayHideJumpBtnTask ~= nil then
    GameGlobal.TaskManager():KillTask(self._delayHideJumpBtnTask)
    self._delayHideJumpBtnTask = nil
  end
  if self.showBGTask ~= nil then
    GameGlobal.TaskManager():KillTask(self.showBGTask)
    self.showBGTask = nil
  end
  if self.closeCallback then
    self.closeCallback()
  end
  AudioHelperController.PlayBGM(self.originBGM, AudioConstValue.BGMCrossFadeTime)
end

function UICriVideoControllerNowrap:GetLanguageKey()
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

function UICriVideoControllerNowrap:WaitPlayAudio(TT)
  local bEndPlay = false
  while true do
    local currentVideoStatus = tostring(self:_GetPlayerValue("status"))
    if self._isPauseAudio then
      YIELD(TT)
    end
    if currentVideoStatus == VideoPlayerStatus.Playing then
      YIELD(TT)
      if not self.showBg then
        self.showBg = true
        self.showBGTask = self:StartTask(function(_TT)
          YIELD(_TT, 100)
          self._bgRawImageObj:SetActive(true)
          self.showBGTask = nil
        end)
      end
    elseif currentVideoStatus == VideoPlayerStatus.Dechead then
      YIELD(TT)
    elseif currentVideoStatus == VideoPlayerStatus.WaitPrep then
      YIELD(TT)
    elseif currentVideoStatus == VideoPlayerStatus.Prep then
      YIELD(TT)
    elseif currentVideoStatus == VideoPlayerStatus.Ready then
      YIELD(TT)
    else
      Log.debug("WaitPlayAudio bEndPlay", currentVideoStatus)
      bEndPlay = true
    end
    if bEndPlay then
      break
    end
  end
  Log.debug("WaitPlayAudio Stop", currentVideoStatus)
  self:_CallFunction("Stop", nil)
  self:PlayAudioComplete()
end

function UICriVideoControllerNowrap:PauseAudio()
  self:_CallFunction("Pause", "System.Boolean", true)
  self._isPauseAudio = true
end

function UICriVideoControllerNowrap:ResumeAudio()
  self._isPauseAudio = false
  self:_CallFunction("Pause", "System.Boolean", false)
end

function UICriVideoControllerNowrap:SkipAudio()
  self._isPauseAudio = false
  self:_CallFunction("Stop", nil)
  self:CloseDialog()
end

function UICriVideoControllerNowrap:PlayAudioComplete()
  Log.debug("PlayAudioComplete Stop", self:_GetPlayerValue("status"))
  self._playVideoScreenObj:SetActive(false)
  self._skipAudioObj:SetActive(false)
  self._videoSubtitleText.text = ""
  self._subTitle:SetActive(false)
  self:CloseDialog()
end

function UICriVideoControllerNowrap:SkipAudioBtnOnClick()
  self:PauseAudio()
  PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, "", StringTable.Get("str_draw_card_video_close_desc"), function(param)
    self:SkipAudio()
  end, nil, function(param)
    self:ResumeAudio()
  end, nil)
end

function UICriVideoControllerNowrap:PlayVideoOnClick()
  if self._isShowSkipBtn == true then
    return
  end
  self._isShowSkipBtn = true
  self._skipAudioObj:SetActive(true)
  self._delayHideJumpBtnTask = self:StartTask(function(TT)
    YIELD(TT, 3000)
    self._skipAudioObj:SetActive(false)
    self._isShowSkipBtn = false
  end, self)
end

function UICriVideoControllerNowrap:_SetValue(name, value)
  local property = tolua.getproperty(self._type, name)
  if property then
    property:Set(self._videoPlayer, value, nil)
    property:Destroy()
    return true
  else
    local field = tolua.getfield(self._type, name)
    if field then
      field:Set(self._videoPlayer, value)
      field:Destroy()
      return true
    end
  end
  Log.exception("严重错误 Get找不到属性或字段:", name)
  return false
end

function UICriVideoControllerNowrap:_GetValue(name)
  local property = tolua.getproperty(self._type, name)
  if property then
    local value = property:Get(self._videoPlayer, nil)
    property:Destroy()
    return value, true
  else
    local field = tolua.getfield(self._type, name)
    if field then
      local value = field:Get(self._videoPlayer)
      field:Destroy()
      return value, true
    end
  end
  Log.exception("严重错误 Set找不到属性或字段:", name)
  return nil, false
end

function UICriVideoControllerNowrap:_CallFunction(name, paramType, ...)
  local func
  if paramType then
    func = tolua.getmethod(self._type, name, typeof(paramType))
  else
    func = tolua.getmethod(self._type, name)
  end
  if func then
    local r, o = func:Call(self._videoPlayer, ...)
    func:Destroy()
    return r, true
  end
  Log.exception("严重错误 找不到方法:", name)
  return nil, false
end

function UICriVideoControllerNowrap:_GetPlayerValue(name)
  local property = tolua.getproperty(self._playerType, name)
  if property then
    local value = property:Get(self._player, nil)
    property:Destroy()
    return value, true
  else
    local field = tolua.getfield(self._playerType, name)
    if field then
      local value = field:Get(self._player)
      field:Destroy()
      return value, true
    end
  end
  Log.exception("严重错误 Get找不到Player属性或字段:", name)
  return nil, false
end

function UICriVideoControllerNowrap:_CallPlayerFunction(name, paramType, ...)
  local func
  if paramType then
    func = tolua.getmethod(self._playerType, name, typeof(paramType))
  else
    func = tolua.getmethod(self._playerType, name, nil)
  end
  if func then
    local r, o = func:Call(self._player, ...)
    func:Destroy()
    return r, true
  end
  Log.exception("严重错误 找不到Player方法:", name)
  return nil, false
end
