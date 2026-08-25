local TimelineVideoUIAdd, Super = System.NewClass("TimelineVideoUIAdd", UIBasePanel)
TimelineVideoUIAdd.uiResCls = TimelineVideoUIAddResource

function TimelineVideoUIAdd:ctor(rgbVideo, alphaVideo, isLoop, videoCallback, videoTime)
  Super.ctor(self)
  self.rbgVideoUrl = rgbVideo
  self.alphaVideoUrl = alphaVideo
  self.isLoop = isLoop
  self.videoCallback = videoCallback
  self.videoTime = videoTime
end

function TimelineVideoUIAdd:OnBind(binder)
  self.binder = binder
  self.videoPlayer = AVProAlphaVideoPlayer(self.ui.color, self.ui.color_bak, self.ui.alpha, self.ui.alpha_bak)
  self:SetRendered(false)
  
  function self.videoPlayer.preparedCallback()
    self:SetRendered(true)
  end
  
  self.videoPlayer:OpenMedia(self.rbgVideoUrl, self.alphaVideoUrl)
  self.videoPlayer:SetLooping(self.isLoop)
  self.videoPlayer:SetRawImage(self.ui.uiNode)
  self.videoPlayer.autoPlayed = true
  if not self.videoTime then
    self.videoPlayer.finishedCallback = System.fn(self, self.OnVideoEndReached)
  else
    binder:BindTimer(self.videoTime, 0, nil, System.fn(self, self.OnVideoEndReached))
  end
end

function TimelineVideoUIAdd:OnUnbind()
  if self.videoPlayer then
    self.videoPlayer:Dispose()
  end
end

function TimelineVideoUIAdd:OnVideoEndReached()
  if not self.isLoop then
    self:Close()
  end
  if self.videoCallback then
    self.videoCallback()
  end
end

return TimelineVideoUIAdd
