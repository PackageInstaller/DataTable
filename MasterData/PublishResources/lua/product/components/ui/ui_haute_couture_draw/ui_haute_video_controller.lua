_class("UIHauteVideoController", UIController)
UIHauteVideoController = UIHauteVideoController

function UIHauteVideoController:Constructor()
end

function UIHauteVideoController:OnShow(uiParams)
  self._cfg = uiParams[1]
  self._VideoName = self._cfg.VideoName
  self._Bgm = self._cfg.Bgm
  self._pause = self:GetGameObject("pause")
  self:_LoadVideo()
end

function UIHauteVideoController:_LoadVideo()
  local url = ResourceManager:GetInstance():GetAssetPath(self._VideoName .. ".mp4", LoadType.VideoClip)
  Log.debug("[guide movie] move url ", url)
  self._vp = self:GetUIComponent("VideoPlayer", "VideoPlayer")
  self._rawImage = self:GetUIComponent("RawImage", "VideoPlayer")
  self._rt = UnityEngine.RenderTexture:New(1420, 805, 16)
  self._rawImage.texture = self._rt
  self._vp.targetTexture = self._rt
  self._vp.gameObject:SetActive(true)
  self._vp.url = url
  self._vp.targetCamera = GameGlobal.UIStateManager():GetControllerCamera("UIHauteVideoController")
  self._vp:Play()
  self._vp.loopPointReached = self._vp.loopPointReached + self._LoopPointReached
  GameGlobal.UIStateManager():GetControllerCamera("UIHauteVideoController"):Render()
  if self._Bgm then
    self._oldBgm = AudioHelperController.GetCurrentBgm()
    AudioHelperController.PlayBGM(self._Bgm, 0)
  end
  self._vp.frame = 0
  self._playing = true
  self._pause:SetActive(not self._playing)
end

function UIHauteVideoController:bgOnClick(go)
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

function UIHauteVideoController:VideoPlayerOnClick(go)
  if self._playing then
    self._playing = false
  else
    self._playing = true
  end
  if self._playing then
    self._vp:Play()
    if self._Bgm then
      AudioHelperController.UnpauseBGM()
    end
  else
    self._vp:Pause()
    if self._Bgm then
      AudioHelperController.PauseBGM()
    end
  end
  self._pause:SetActive(not self._playing)
end
