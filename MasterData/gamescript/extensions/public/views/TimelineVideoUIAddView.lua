local TimelineVideoUIAddView, Super = NewClass("TimelineVideoUIAddView", BaseView)
TimelineVideoUIAddView.uiResCls = TimelineVideoUIAddResource

function TimelineVideoUIAddView:ctor(rgbVideo, alphaVideo, isLoop, videoCallback, videoTime)
  Super.ctor(self)
  self._rgbVideoUrl = rgbVideo
  self._alphaVideoUrl = alphaVideo
  self._isLoop = isLoop
  self._videoCallback = videoCallback
  self._videoTime = videoTime
end

function TimelineVideoUIAddView:OnBuildView()
end

function TimelineVideoUIAddView:RegisterNotifications()
end

function TimelineVideoUIAddView:RegisterEvents()
end

function TimelineVideoUIAddView:OnEnterView()
  Super.OnEnterView(self)
  self:SetRendered(false)
  self._videoPlayer = AVProAlphaVideoPlayer(self.ui.color, self.ui.color_bak, self.ui.alpha, self.ui.alpha_bak)
  
  function self._videoPlayer.preparedCallback()
    self:SetRendered(true)
  end
  
  self._videoPlayer:OpenMedia(self._rgbVideoUrl, self._alphaVideoUrl)
  self._videoPlayer:SetLooping(self._isLoop)
  self._videoPlayer:SetRawImage(self.ui.uiNode)
  self._videoPlayer.autoPlayed = true
  if not self._videoTime then
    self._videoPlayer.finishedCallback = System.fn(self, self._OnVideoEndReached)
  else
    self:BindTimer(self._videoTime, 0, nil, System.fn(self, self._OnVideoEndReached))
  end
end

function TimelineVideoUIAddView:OnExitView()
  Super.OnExitView(self)
  if self._videoPlayer then
    self._videoPlayer:Dispose()
    self._videoPlayer = nil
  end
end

function TimelineVideoUIAddView:_OnVideoEndReached()
  if self._videoCallback then
    self._videoCallback()
  end
  if not self._isLoop then
    self:Close()
  end
end

return TimelineVideoUIAddView
