_class("UIGuideVideoController", UIController)
UIGuideVideoController = UIGuideVideoController

function UIGuideVideoController:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UIGuideVideoController:OnShow(uiParams)
  self:InitWidget()
  local cfg = Cfg.cfg_video[uiParams[1]]
  local freeExit = uiParams[2] or false
  local videoName = cfg.VideoName
  self:_LoadVideo(videoName)
  if freeExit then
    self._startCheck = false
    self.exitGo:SetActive(true)
  else
    self.exitGo:SetActive(false)
    self:StartTask(function(TT)
      while not self._videoPlayer.isPlaying do
        YIELD(TT)
      end
      self._startCheck = true
    end)
  end
end

function UIGuideVideoController:Update()
  if not self._startCheck then
    return
  end
  if not self._finish and not self._videoPlayer.isPlaying then
    self._finish = true
    self._videoPlayer:Pause()
    self.exitGo:SetActive(true)
  end
end

function UIGuideVideoController:InitWidget()
  self._videoPlayer = self:GetUIComponent("VideoPlayer", "videoPlayer")
  self._rawImage = self:GetUIComponent("RawImage", "videoPlayer")
  self._rt = UnityEngine.RenderTexture:New(1420, 805, 16)
  self._rawImage.texture = self._rt
  self._videoPlayer.targetTexture = self._rt
  self.exitGo = self:GetGameObject("exit")
  self.exitGo:SetActive(false)
end

function UIGuideVideoController:_LoadVideo(videoName)
  local url = ResourceManager:GetInstance():GetAssetPath(videoName .. ".mp4", LoadType.VideoClip)
  Log.debug("[guide movie] move url ", url)
  self._videoPlayer.gameObject:SetActive(true)
  self._videoPlayer.url = url
  self._videoPlayer.isLooping = false
  self._videoPlayer.targetCamera = GameGlobal.UIStateManager():GetControllerCamera("UIGuideVideoController")
  self._videoPlayer:Play()
  GameGlobal.UIStateManager():GetControllerCamera("UIGuideVideoController"):Render()
end

function UIGuideVideoController:ExitBtnOnClick(go)
  self:CloseDialog()
end
