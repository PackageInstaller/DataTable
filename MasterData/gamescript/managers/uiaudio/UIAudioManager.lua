local Z1ButtonState = CS.Z1Client.Z1ButtonState
local TypeImage = typeof(CS.UnityEngine.UI.Image)
local TypeRawImage = typeof(CS.UnityEngine.UI.RawImage)
local TypeOfAudioEffect = typeof(CS.FrameWork.AudioEffect)
local DefaultButtonEvent = "UI_CM_BTN_BASIC_CLICK"
local DefaultCheckBoxEvent = "UI_CM_CHECKBOX_SELECT"
local ButtonWwiseEvts = {
  _Confirm = "UI_CM_BTN_LV1_ENTER",
  _Cancel = "UI_CM_BTN_LV1_CANCEL",
  _Confirm_LV2 = "UI_CM_BTN_LV2_ENTER",
  _Cancel_LV2 = "UI_CM_BTN_LV2_CANCEL",
  _Confirm_LV3 = "UI_CM_BTN_LV3_ENTER",
  _Cancel_LV3 = "UI_CM_BTN_LV3_CANCEL",
  _Page = "UI_CM_BTN_PAGES_CLICK",
  _Detail = "UI_CM_BTN_DETAIL_CLICK",
  _Close = "UI_CM_BTN_TURNOFF_CLICK",
  _Back = "UI_CM_BTN_TURNOFF_CLICK",
  _Receive = "UI_CM_BTN_RECEIVE_CLICK",
  _Tab = "UI_CM_TAB_CLICK",
  _LoginUI = "UI_CM_BTN_LOADING_CLICK",
  _MainUI = "UI_CM_BTN_MAININTERFACE_CLICK",
  _ItemSel = "UI_CM_ITEMBOX_SELECT",
  _ConfirmCheckBox = "UI_CM_CONFIRMBOX_SELECT",
  _Add = "UI_CM_BTN_ADD_CLICK",
  _MaterialBar = "UI_CM_BTN_MATERIALBAR_CLICK"
}
local UIAudioManager, Super = System.NewClass("UIAudioManager", Manager)

function UIAudioManager:ctor()
  Super.ctor(self)
  self.stack = AudioChangeUIStack()
  self._lastPanelMusic = nil
  self._lastMusicPanelUrl = nil
  self._mainSceneMusicState = nil
end

function UIAudioManager:Awake(binder)
  Super.Awake(self)
  binder:BindEvent(EventMgr.Instance.AfterAddUIPanel, System.fn(self, self.OnOpenUIPanel))
  binder:BindEvent(EventMgr.Instance.AfterCloseUIPanel, System.fn(self, self.OnCloseUIPanel))
end

function UIAudioManager:OnDestroy()
  Super.OnDestroy(self)
  self.curPanelOpenEvent = nil
end

function UIAudioManager:PlayAudioEffect(widget)
  self:PlayButtonAudioEffect(widget)
end

function UIAudioManager:GetButtonPlayAudioEffectFunc(widget)
  local function PlayAudioEffectFunc(btnState)
    self:PlayButtonAudioEffect(widget, btnState)
  end
  
  return PlayAudioEffectFunc
end

function UIAudioManager:GetTogglePlayAudioEffectFunc(widget)
  local function PlayAudioEffectFunc(toggleState)
    if not toggleState then
      return
    end
    self:PlayToggleAudioEffect(widget, toggleState)
  end
  
  return PlayAudioEffectFunc
end

function UIAudioManager:PlayButtonAudioEffect(widget, btnState)
  if Main.isAppDestroyed then
    return
  end
  btnState = btnState or Z1ButtonState.Default
  local audioEvent
  local audioEffect = widget:GetComponent(TypeOfAudioEffect)
  if audioEffect then
    if not audioEffect.CanPlayAudio then
      return
    end
    audioEvent = audioEffect:GetButtonAudioEvent(btnState)
  else
    audioEvent = self:GetWidgetClickAudioEventId(widget)
  end
  if nil == audioEvent or "" == audioEvent then
    audioEvent = DefaultButtonEvent
  end
  AudioManager.Instance:PostSoundEvent(audioEvent)
end

function UIAudioManager:PlayToggleAudioEffect(widget, toggleState)
  toggleState = toggleState or false
  local audioEvent
  local audioEffect = widget:GetComponent(TypeOfAudioEffect)
  if audioEffect then
    if not audioEffect.CanPlayAudio then
      return
    end
    audioEvent = audioEffect:GetToggleAudioEvent(toggleState)
  else
    audioEvent = self:GetWidgetClickAudioEventId(widget)
  end
  if not audioEvent or "" == audioEvent then
    audioEvent = DefaultCheckBoxEvent
  end
  AudioManager.Instance:PostSoundEvent(audioEvent)
end

function UIAudioManager:GetWidgetClickAudioEventId(widget)
  local imageComp = widget:GetComponent(TypeImage)
  local audioCfg = imageComp and imageComp.sprite and self:GetUIAudioConfigByName(imageComp.sprite.name)
  if audioCfg then
    return audioCfg.WwiseEvent
  end
  imageComp = widget:GetComponentInChildren(TypeImage)
  audioCfg = imageComp and imageComp.sprite and self:GetUIAudioConfigByName(imageComp.sprite.name)
  if audioCfg then
    return audioCfg.WwiseEvent
  end
  local rawImageComp = widget:GetComponent(TypeRawImage)
  audioCfg = rawImageComp and rawImageComp.texture and self:GetUIAudioConfigByName(rawImageComp.texture.name)
  if audioCfg then
    return audioCfg.WwiseEvent
  end
  audioCfg = self:GetUIAudioConfigByName(widget.name)
  if audioCfg then
    return audioCfg.WwiseEvent
  end
  do return self.GetUIButtonAudioEventByName, self, widget.name end
  return self.GetUIButtonAudioEventByName, self, widget.name, widget.transform.parent and widget.transform.parent.name or nil
end

function UIAudioManager:GetUIAudioConfigByName(name)
  if self.name2AudioConfigs and self.name2AudioConfigs[name] then
    return self.name2AudioConfigs[name]
  end
  local audios = DT.UIAudio
  local audioCfg
  for k, v in pairs(audios) do
    if string.find(name, v.ImageKey) then
      audioCfg = v
      break
    end
  end
  if audioCfg then
    self.name2AudioConfigs = self.name2AudioConfigs or {}
    self.name2AudioConfigs[name] = audioCfg
  end
  return audioCfg
end

function UIAudioManager:GetUIButtonAudioEventByName(name, parentName)
  for k, v in pairs(ButtonWwiseEvts) do
    if string.find(name, k) or nil ~= parentName and string.find(parentName, k) then
      return v
    end
  end
end

function UIAudioManager:GetMainSceneMusicState()
  return self._mainSceneMusicState
end

function UIAudioManager:SetMainSceneMusicState(isEnable)
  if self._mainSceneMusicState == isEnable then
    return
  end
  self._mainSceneMusicState = isEnable
  if isEnable then
    local mainSceneOpenEvent = UIChangeAudioUtils.GetOpenEventByUrl(Urls.MainPanel)
    if mainSceneOpenEvent then
      AudioManager.Instance:PostSoundEvent(mainSceneOpenEvent)
    end
  end
end

function UIAudioManager:ResumePanelMusic()
  local url = self:GetLastMusicPanelUrl()
  if not url then
    if self._mainSceneMusicState then
      self:_PlayPanelMusic(Urls.MainPanel)
    end
    return
  end
  if not self._mainSceneMusicState then
    return
  end
  self:_PlayPanelMusic(Urls.MainPanel)
  self:_PlayPanelMusic(url)
end

function UIAudioManager:OnOpenUIPanel(url, panel)
  if Main.isAppDestroyed then
    return
  end
  self:PanelOpenAudioEvent(url, panel)
  self:ProcessChangeUIAudio_WhenOpen(url, panel)
end

function UIAudioManager:OnCloseUIPanel(url, panel)
  if Main.isAppDestroyed then
    return
  end
  self:PanelCloseAudioEvent(url, panel)
  self:ProcessChangeUIAudio_WhenClose(url, panel)
  if self._lastMusicPanelUrl == url then
    self._lastMusicPanelUrl = nil
    self._lastPanelMusic = nil
  end
end

function UIAudioManager:DisablePanelAudioEvent(url)
  self.disableAudioEventPanels = self.disableAudioEventPanels or {}
  local refCount = self.disableAudioEventPanels[url] or 0
  self.disableAudioEventPanels[url] = refCount + 1
end

function UIAudioManager:EnablePanelAudioEvent(url)
  local refCount = 0
  if self.disableAudioEventPanels and self.disableAudioEventPanels[url] then
    refCount = self.disableAudioEventPanels[url]
  end
  if refCount > 0 then
    self.disableAudioEventPanels[url] = refCount - 1
  end
end

function UIAudioManager:IsPanelAudioEventEnable(url)
  local refCount = 0
  if self.disableAudioEventPanels and self.disableAudioEventPanels[url] then
    refCount = self.disableAudioEventPanels[url]
  end
  return 0 == refCount
end

function UIAudioManager:PanelOpenAudioEvent(url, panel)
  if not self:IsPanelAudioEventEnable(url) then
    return
  end
  if panel.isFullScreen then
    local curTopUrl = UIManager.Instance:GetTopPanelThatNotChildView()
    self:SetLastTopFullUI(curTopUrl)
    if curTopUrl ~= panel.url then
      return
    end
  end
  self:_PlayPanelMusic(url)
end

function UIAudioManager:_PlayPanelMusic(url)
  local openEvent = UIChangeAudioUtils.GetOpenEventByUrl(url)
  if openEvent then
    AudioManager.Instance:PostSoundEvent(openEvent)
    if url ~= Urls.AlertConfirm2Panel then
      self._lastPanelMusic = openEvent
      self._lastMusicPanelUrl = url
    end
  end
end

function UIAudioManager:GetLastMusicPanelUrl()
  return self._lastMusicPanelUrl
end

function UIAudioManager:PanelCloseAudioEvent(url, panel)
  local closeEvent = UIChangeAudioUtils.GetCloseEventByUrl(url)
  if closeEvent then
    AudioManager.Instance:PostSoundEvent(closeEvent)
  end
end

function UIAudioManager:ProcessChangeUIAudio_WhenOpen(newUI, panel)
  local curUI = self.stack:GetTopElement()
  local tNewUIData = UIChangeAudioUtils.ChangeUI[newUI]
  local audioEvent = tNewUIData and tNewUIData[curUI] or nil
  if audioEvent then
    AudioManager.Instance:PostSoundEvent(audioEvent)
  end
  EventMgr.Instance.TopUIChangeEvent:Dispatch(newUI, panel.isFullScreen)
  self.stack:Push(newUI)
end

function UIAudioManager:SetChangeUIProcess(state)
  self.canProcess = state
end

function UIAudioManager:ProcessChangeUIAudio_WhenClose(closeUI, panel)
  if self.canProcess == false then
    return
  end
  local curUI = self.stack:GetTopElement()
  if curUI ~= closeUI then
    self.stack:Remove(closeUI)
  else
    self.stack:Pop()
    curUI = self.stack:GetTopElement()
    if curUI then
      local tCurUIData = UIChangeAudioUtils.ChangeUI[curUI]
      local audioEvent = tCurUIData and tCurUIData[closeUI] or nil
      if audioEvent then
        AudioManager.Instance:PostSoundEvent(audioEvent)
      end
      EventMgr.Instance.TopUIChangeEvent:Dispatch(curUI, panel.isFullScreen)
    end
  end
  local topFullUI = UIManager.Instance:GetTopPanelThatNotChildView()
  if not self.lastTopFullUI then
    self:SetLastTopFullUI(topFullUI)
  end
  if nil ~= topFullUI and "" ~= topFullUI and self.lastTopFullUI ~= topFullUI then
    self:SetLastTopFullUI(topFullUI)
    EventMgr.Instance.TopUIAudioEvent:Dispatch(topFullUI, closeUI)
  end
end

function UIAudioManager:PlayTopUIAudioEvent()
  if not self.lastTopFullUI then
    return
  end
  self:_PlayPanelMusic(self.lastTopFullUI)
end

function UIAudioManager:SetLastTopFullUI(ui)
  self.lastTopFullUI = ui
end

function UIAudioManager:GetTopUIElementUI()
  do return self.stack.GetTopElement end
  return self.stack.GetTopElement, self.stack
end

return UIAudioManager
