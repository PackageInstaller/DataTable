_class("UIActivityOneAndHalfAnniversaryVideoController", UIController)
UIActivityOneAndHalfAnniversaryVideoController = UIActivityOneAndHalfAnniversaryVideoController

function UIActivityOneAndHalfAnniversaryVideoController:OnShow(uiParams)
  self._orgBgm = AudioHelperController.GetCurrentBgm()
  AudioHelperController.StopBGM()
  self._isFirstPlay = uiParams[1]
  self:_LoadVideo()
end

function UIActivityOneAndHalfAnniversaryVideoController:_LoadVideo()
  local url = ResourceManager:GetInstance():GetAssetPath("Byakuya_VerB_ProRes4444_1121_x264.mp4", LoadType.VideoClip)
  self:LoadVideo(url)
  self._playing = true
end

function UIActivityOneAndHalfAnniversaryVideoController:LoadVideo(url)
  self._vp = self:GetUIComponent("VideoPlayer", "VideoPlayer")
  self._rawImage = self:GetUIComponent("RawImage", "VideoPlayer")
  self._rt = UnityEngine.RenderTexture:New(1920, 1080, 16)
  self._rawImage.texture = self._rt
  self._vp.targetTexture = self._rt
  self._vp.targetCamera = GameGlobal.UIStateManager():GetControllerCamera("UIActivityOneAndHalfAnniversaryVideoController")
  self._vp.gameObject:SetActive(true)
  self._vp.url = url
  self._vp:Play()
  self._vp.loopPointReached = self._vp.loopPointReached + function()
    self:_LoopPointReached()
  end
  self._vp.prepareCompleted = self._vp.prepareCompleted + function()
    self:_PrepareCompleted()
  end
  GameGlobal.UIStateManager():GetControllerCamera("UIActivityOneAndHalfAnniversaryVideoController"):Render()
  self._vp.frame = 0
end

function UIActivityOneAndHalfAnniversaryVideoController:SkipAudioBtnOnClick()
  self._vp:Pause()
  AudioHelperController.PauseBGM()
  PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, "", StringTable.Get("str_story_skip_confirm"), function()
    self:CloseVideo()
  end, nil, function()
    self._vp:Play()
    AudioHelperController.UnpauseBGM()
  end)
end

function UIActivityOneAndHalfAnniversaryVideoController:CloseVideo()
  AudioHelperController.StopBGM()
  self._vp:Stop()
  self:CloseDialog()
  if self._isFirstPlay then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnOneAndHalfAnniversaryFinish)
  else
    local roleModule = GameGlobal.GetModule(RoleModule)
    local pstId = roleModule:GetPstId()
    if LocalDB.GetInt("OneAndHalfAnniversary_" .. pstId, 0) == 0 then
      LocalDB.SetInt("OneAndHalfAnniversary_" .. pstId, 1)
    end
    AudioHelperController.PlayBGM(self._orgBgm)
  end
end

function UIActivityOneAndHalfAnniversaryVideoController:_LoopPointReached()
  self:CloseVideo()
end

function UIActivityOneAndHalfAnniversaryVideoController:_PrepareCompleted()
  AudioHelperController.PlayBGM(CriAudioIDConst.BGMN25ANNIVERSARY)
end

function UIActivityOneAndHalfAnniversaryVideoController:OnHide()
  if self._rt then
    self._rt:Release()
    self._rt = nil
  end
end
