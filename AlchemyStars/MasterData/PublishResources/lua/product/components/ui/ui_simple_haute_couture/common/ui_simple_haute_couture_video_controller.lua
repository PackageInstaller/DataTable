_class("UISimpleHauteCoutureVideoController", UIController)
UISimpleHauteCoutureVideoController = UISimpleHauteCoutureVideoController

function UISimpleHauteCoutureVideoController:Constructor()
end

function UISimpleHauteCoutureVideoController:OnShow(uiParams)
  self._videoName = uiParams[1]
  self._bgm = uiParams[2]
  self:_GetComponents()
  self:_LoadVideo()
end

function UISimpleHauteCoutureVideoController:_GetComponents()
  self._pauseObj = self:GetGameObject("pause")
  self._vp = self:GetUIComponent("VideoPlayer", "VideoPlayer")
  self._rawImage = self:GetUIComponent("RawImage", "VideoPlayer")
end

function UISimpleHauteCoutureVideoController:_LoadVideo()
  local url = ResourceManager:GetInstance():GetAssetPath(self._videoName .. ".mp4", LoadType.VideoClip)
  Log.debug("[guide movie] move url ", url)
  self._rt = UnityEngine.RenderTexture:New(1420, 805, 16)
  self._rawImage.texture = self._rt
  self._vp.targetTexture = self._rt
  self._vp.gameObject:SetActive(true)
  self._vp.url = url
  self._vp.targetCamera = GameGlobal.UIStateManager():GetControllerCamera("UISimpleHauteCoutureVideoController")
  self._vp:Play()
  self._vp.loopPointReached = self._vp.loopPointReached + self._LoopPointReached
  GameGlobal.UIStateManager():GetControllerCamera("UISimpleHauteCoutureVideoController"):Render()
  if self._bgm then
    self._oldBgm = AudioHelperController.GetCurrentBgm()
    AudioHelperController.PlayBGM(self._bgm, 0)
  end
  self._vp.frame = 0
  self._playing = true
  self._pauseObj:SetActive(not self._playing)
  self._shareBtnGO = self:GetGameObject("ShareBtn")
  self._shareBtnGO:SetActive(self:GetModule(ShareModule):CanShare())
end

function UISimpleHauteCoutureVideoController:BgOnClick(go)
  self:CloseDialog()
  if self._rt then
    self._rt:Release()
    self._rt = nil
  end
  if self._oldBgm then
    AudioHelperController.PlayBGM(self._oldBgm)
  end
  if not self._playing then
    AudioHelperController.UnpauseBGM()
  end
end

function UISimpleHauteCoutureVideoController:VideoPlayerOnClick(go)
  if self._playing then
    self._playing = false
  else
    self._playing = true
  end
  if self._playing then
    self._vp:Play()
    if self._bgm then
      AudioHelperController.UnpauseBGM()
    end
  else
    self._vp:Pause()
    if self._bgm then
      AudioHelperController.PauseBGM()
    end
  end
  self._pauseObj:SetActive(not self._playing)
end

function UISimpleHauteCoutureVideoController:ShareBtnOnClick(go)
  self:Lock("UISimpleHauteCoutureVideoControllerShare")
  self:StartTask(function(TT)
    YIELD(TT)
    self:ShowDialog("UIShare", self:GetName(), nil, nil, nil, nil, ShareContentType.Video, ShareSceneType.SkinVideo, self._videoName)
    self:UnLock("UISimpleHauteCoutureVideoControllerShare")
  end, self)
end
