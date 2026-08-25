local AvgActionPlayVideo = System.NewClass("AvgActionPlayVideo", AvgActionBase)

function AvgActionPlayVideo:DoAction(_, videoUrl)
  if not videoUrl then
    self:FinishAction()
    return
  end
  self:PlayDialogVideo(videoUrl)
end

function AvgActionPlayVideo:PlayDialogVideo(videoUrl)
  self.avgPanel.textComp:ClearDialogText()
  local videoTimeA = self.avgModel.videoTimeA
  local videoTimeB = self.avgModel.videoTimeB
  local isLoop = self.avgModel.isVideoLoop
  local videoEndFunc
  
  function videoEndFunc()
    self:OnVideoEnd()
    if self.avgModel:IsVideoType(CommonDefine.AvgVideoType.VideoPure) then
      self.avgPanel.avgVideoComp:ClearVideo()
      self.avgModel:NextDialog()
    end
    if self.avgModel.isVideoAutoNext then
      self.avgModel:NextDialog()
    end
  end
  
  if isLoop then
    self:OnVideoEnd()
  end
  if self.avgModel.keepDialogInVideo then
    self:FinishAction()
  end
  self.avgPanel.avgVideoComp:PlayVideo(videoUrl, videoTimeA, videoTimeB, isLoop, function()
    videoEndFunc()
  end)
end

function AvgActionPlayVideo:OnVideoEnd()
  UIManager.Instance:CloseByUrl(Urls.VideoCaptionPanel)
  self:FinishAction()
end

return AvgActionPlayVideo
