_class("UIVideo", UIController)
UIVideo = UIVideo

function UIVideo:OnShow(uiParams)
  self._onVideoComplete = uiParams[1]
  AudioHelperController.PauseBGM()
  local url = ResourceManager:GetInstance():GetAssetPath("pv.mp4", LoadType.VideoClip)
  if EDITOR then
    if self._onVideoComplete then
      self._onVideoComplete()
    end
  elseif self._onVideoComplete then
    self._onVideoComplete()
  end
end

function UIVideo:OnHide()
  AudioHelperController.UnpauseBGM()
  self._onVideoComplete = nil
end
