local ArtCollectionPlayVideoView, Super = NewClass("ArtCollectionPlayVideoView", BaseView)
ArtCollectionPlayVideoView.uiResCls = UI_Collection_Panel_PlayVideoResource

function ArtCollectionPlayVideoView:ctor(videoUrl)
  Super.ctor(self)
  self.videoUrl = videoUrl
end

function ArtCollectionPlayVideoView:OnEnterView()
  Super.OnEnterView(self)
  self:InitCloseBtn()
  self.vp = self:_CreateVideoPlayer(self.ui.VPlayer, self.ui.VPlayer_Bak)
  self.vp.OpenMedia(self.videoUrl)
  self.vp.Play(function()
  end, function()
    self:Close()
  end)
end

function ArtCollectionPlayVideoView:_CreateVideoPlayer(displayGO, displayGOBak)
  local mediaReadyAwaiter = Awaiter.Get()
  local mediaPlayer = GameVideoPlayer(displayGO, displayGOBak)
  local videoPlayer = {}
  
  function videoPlayer.Show()
    displayGO:SetActive(true)
  end
  
  function videoPlayer.Hide()
    displayGO:SetActive(false)
  end
  
  function videoPlayer.OpenMedia(url)
    mediaPlayer:CloseMedia()
    mediaPlayer:RemoveAllListeners()
    mediaReadyAwaiter:Reset()
    
    function mediaPlayer.preparedCallback()
      mediaPlayer:RemoveAllListeners()
      mediaReadyAwaiter:SetCompleted()
    end
    
    mediaPlayer:OpenMedia(url)
  end
  
  function videoPlayer.CloseMedia()
    mediaPlayer:CloseMedia()
    mediaPlayer:RemoveAllListeners()
    mediaReadyAwaiter:Reset()
  end
  
  function videoPlayer.Play(onBeginPlay, onEndOfVideo)
    mediaReadyAwaiter:OnCompleted(function()
      onBeginPlay()
      
      function mediaPlayer.finishedCallback()
        mediaPlayer:RemoveAllListeners()
        onEndOfVideo()
      end
      
      mediaPlayer:Rewind(true)
      mediaPlayer:Play()
    end)
  end
  
  function videoPlayer.Dispose()
    mediaReadyAwaiter:Recycle()
  end
  
  return videoPlayer
end

function ArtCollectionPlayVideoView:InitCloseBtn()
  self.closeBtn = self:AddViewComponent(self.ui.UI_Common_Btn_Back3, UICompBtnCloseItem, System.fn(self, self.Close))
end

function ArtCollectionPlayVideoView:OnExitView()
  Super.OnExitView(self)
  self.vp.Dispose()
end

return ArtCollectionPlayVideoView
