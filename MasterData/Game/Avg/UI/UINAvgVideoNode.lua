local UINAvgVideoNode = class("UINAvgVideoNode", UIBaseNode)
local base = UIBaseNode
local CS_MovieManager_ins = CS.MovieManager.Instance

function UINAvgVideoNode:ctor(avgSystem)
  self.avgSystem = avgSystem
end

function UINAvgVideoNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.rawImage_LoopVideo.gameObject:SetActive(false)
  UIUtil.AddButtonListener(self.ui.btn_Skip, self, self.__OnClickSkip)
  self.__onVideoPlayComplete = BindCallback(self, self.OnAvgVideoPlayComplete)
end

function UINAvgVideoNode:PlayAvgVideo(videoPath, vedioAudioCfg)
  if string.IsNullOrEmpty(videoPath) then
    return
  end
  self.vedioAudioCfg = vedioAudioCfg
  self:Show()
  if self.moviePlayer == nil then
    self.moviePlayer = CS_MovieManager_ins:GetMoviePlayer()
  end
  self.ui.rawImage.enabled = false
  self.moviePlayer:SetVideoRender(self.ui.rawImage)
  self.moviePlayer:PlayVideo(PathConsts:GetVideoFilePathWitLang(videoPath), self.__onVideoPlayComplete)
  if vedioAudioCfg ~= nil then
    self.vedioAuBack = AudioManager:PlayAudio(vedioAudioCfg.cue, vedioAudioCfg.sheet, eAudioSourceType.BgmSource, function()
      self.vedioAuBack = nil
    end)
    self.moviePlayer:SetPauseVideoCallback(function(pause)
      if self.vedioAuBack == nil then
        return
      end
      AudioManager:PauseAudioBack(self.vedioAuBack, pause)
    end)
  end
  return true
end

function UINAvgVideoNode:__OnClickSkip()
  self.moviePlayer:StopVideo()
  self:OnAvgVideoPlayComplete()
end

function UINAvgVideoNode:_ClearVedioAuBack()
  if self.vedioAuBack ~= nil then
    AudioManager:StopAudioByBack(self.vedioAuBack)
    self.vedioAuBack = nil
  end
end

function UINAvgVideoNode:OnAvgVideoPlayComplete()
  CS_MovieManager_ins:ReturnMoviePlayer(self.moviePlayer)
  self.moviePlayer = nil
  self:Hide()
  self:_ClearVedioAuBack()
  self.avgSystem:PlayAvgVideoComplete()
end

function UINAvgVideoNode:PlayAvgVideoLoop(videoPath, loopFrame)
  if string.IsNullOrEmpty(videoPath) then
    return
  end
  if self.loopMoviePlayer == nil then
    self.loopMoviePlayer = CS_MovieManager_ins:GetMoviePlayer()
  end
  self.ui.rawImage_LoopVideo.gameObject:SetActive(true)
  self.loopMoviePlayer:SetVideoRender(self.ui.rawImage_LoopVideo)
  self:SetAvgVideoLoop(loopFrame)
end

function UINAvgVideoNode:SetAvgVideoLoop(loopFrame)
  if self.loopMoviePlayer == nil then
    return
  end
  if loopFrame == nil then
    self.avgSystem.avgCtrl:AvgLogError("AvgVideoLoop : loopFrame is nil")
    return
  end
  if #loopFrame ~= 2 then
    self.avgSystem.avgCtrl:AvgLogError("AvgVideoLoop : loopFrame count is not two")
    return
  end
  self.loopMoviePlayer:SetLoopSeek(loopFrame[1], loopFrame[2], true)
end

function UINAvgVideoNode:StopAvgVideoLoop()
  if self.loopMoviePlayer == nil then
    return
  end
  self.loopMoviePlayer:StopVideo()
  self.ui.rawImage_LoopVideo.gameObject:SetActive(false)
end

function UINAvgVideoNode:OnDelete()
  if self.moviePlayer ~= nil then
    CS_MovieManager_ins:ReturnMoviePlayer(self.moviePlayer)
    self.moviePlayer = nil
  end
  if self.loopMoviePlayer ~= nil then
    CS_MovieManager_ins:ReturnMoviePlayer(self.loopMoviePlayer)
    self.loopMoviePlayer = nil
  end
  self:_ClearVedioAuBack()
  if self.vedioAudioCfg ~= nil then
    AudioManager:RemoveCueSheet(self.vedioAudioCfg.sheet)
  end
  base.OnDelete(self)
end

return UINAvgVideoNode
