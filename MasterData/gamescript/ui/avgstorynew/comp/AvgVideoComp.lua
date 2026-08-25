local Vector3 = CS.UnityEngine.Vector3
local POS_REMOTE = Vector3(9999, 9999, 0)
local POS_ZERO = Vector3(0, 0, 0)
local AVG_LOG_EVENT = "AvgVideo Waining: {type} {url}"
local AvgVideoComp, Super = System.NewClass("AvgVideoComp")

function AvgVideoComp:ctor(ui, binder, avgModel, avgPanel)
  Super.ctor(self)
  self.ui = ui
  self.binder = binder
  self.avgModel = avgModel
  self.avgPanel = avgPanel
  self.isVideoBg = Vue.ref(false)
  self.bgVideoUrl = Vue.ref(nil)
  self.playingVideoUrl = Vue.ref(nil)
  self.prepareVideoUrl = Vue.ref(nil)
  self.playingVideoPlayer = nil
  self.videoUpdateTimer = nil
  self.isVideoEnd = false
  self.isVideoLooping = false
  self.preparedMap = {}
  self.preparingMap = {}
  self.preparedCallbackMap = {}
end

function AvgVideoComp:Awake()
  self.videoPlay1 = GameVideoPlayer(self.ui.VideoPlayer1, self.ui.VideoPlayer3)
  self.videoPlay2 = GameVideoPlayer(self.ui.VideoPlayer2, self.ui.VideoPlayer4)
  self:BindToPrepareVideo()
  self:HideAllVideoPlayer()
  self:PrepareFirstVideo()
  self.binder:onDestroy(function()
    self:HideAllVideoPlayer()
    LateUpdateBeat.Instance:Remove(self.CheckVideoErrorOccu, self)
  end)
  LateUpdateBeat.Instance:Add(self.CheckVideoErrorOccu, self)
end

function AvgVideoComp:CheckVideoErrorOccu()
  if self.videoErrorOccu then
    self.videoErrorOccu = false
    local storyId = DT.GetConstant("LoginScreenPV")
    if storyId == self.avgModel.storyId then
      local endCallback = self.endCallback
      self:StopSafeTimer()
      self.isVideoEnd = true
      if endCallback then
        endCallback()
      else
        UIManager.Instance:CloseByUrl(Urls.AvgDialogPanelNew)
      end
    end
  end
end

function AvgVideoComp:BindToPrepareVideo()
  self.binder:BindToRaw(function(_, url)
    if url then
      self:PrepareVideo(url)
    end
  end, function()
    local prepareUrl = self.prepareVideoUrl.value
    local bgVideoUrl = self.bgVideoUrl.value
    local playingVideoUrl = self.playingVideoUrl.value
    if bgVideoUrl and playingVideoUrl and bgVideoUrl ~= playingVideoUrl then
      return
    end
    return prepareUrl
  end)
end

function AvgVideoComp:HideAllVideoPlayer()
  self.videoPlay1:SetPosition(POS_REMOTE)
  self.videoPlay2:SetPosition(POS_REMOTE)
  self:ClearPreparedVideoPlayer(self.videoPlay1)
  self:ClearPreparedVideoPlayer(self.videoPlay2)
  self.preparedCallbackMap = {}
  self.videoPlay1:CloseMedia()
  self.videoPlay2:CloseMedia()
  self:StopSafeTimer()
end

function AvgVideoComp:PrepareFirstVideo()
  local firstVideoUrl = AvgStoryManager.Instance:GetReadyVideoUrl(self.avgModel.storyId, 0)
  if firstVideoUrl then
    self:PrepareVideo(firstVideoUrl)
  end
end

function AvgVideoComp:SetPlaySpeed(speed)
end

function AvgVideoComp:SetPlayingVideoPlayer(videoPlayer)
  if self.playingVideoPlayer then
    self:ClearPreparedVideoPlayer(self.playingVideoPlayer)
  end
  self.playingVideoPlayer = videoPlayer
  if videoPlayer then
    self:ClearPreparedVideoPlayer(videoPlayer)
  end
end

function AvgVideoComp:MovePlayerCenter()
  if self.playingVideoPlayer == self.videoPlay1 then
    self.videoPlay1:SetPosition(POS_ZERO)
  else
    self.videoPlay2:SetPosition(POS_ZERO)
  end
end

function AvgVideoComp:GetPreparingVideoPlayer()
  for _, videoPlayer in pairs({
    self.videoPlay1,
    self.videoPlay2
  }) do
    if self:IsVideoPlayerIdle(videoPlayer) then
      return videoPlayer
    end
  end
end

function AvgVideoComp:IsVideoPlayerIdle(videoPlayer)
  if self.playingVideoPlayer == videoPlayer then
    return
  end
  for _, preparingPlayer in pairs(self.preparingMap) do
    if preparingPlayer == videoPlayer then
      return
    end
  end
  return true
end

function AvgVideoComp:_IsPreparedPlayerValid(videoPlayer)
  return videoPlayer and not string.isempty(videoPlayer.mediaPath)
end

function AvgVideoComp:IsVideoPrepared(videoUrl)
  do return self._IsPreparedPlayerValid, self end
  return self._IsPreparedPlayerValid, self, self.preparedMap[videoUrl]
end

function AvgVideoComp:GetPreparedVideoPlayer(videoUrl)
  local videoPlayer = self.preparedMap[videoUrl]
  if not self:_IsPreparedPlayerValid(videoPlayer) then
    self.preparedMap[videoUrl] = nil
    return nil
  end
  return videoPlayer
end

function AvgVideoComp:PrepareVideo(videoUrl, onPreparedFunc, errorCb)
  onPreparedFunc = onPreparedFunc or function()
  end
  if self.preparedMap[videoUrl] then
    if self:_IsPreparedPlayerValid(self.preparedMap[videoUrl]) then
      onPreparedFunc()
      return
    end
    self.preparedMap[videoUrl] = nil
  end
  if self.preparedCallbackMap[videoUrl] then
    if self.preparingMap[videoUrl] then
      table.insert(self.preparedCallbackMap[videoUrl], onPreparedFunc)
      return
    end
    self.preparedCallbackMap[videoUrl] = nil
  end
  self.preparedCallbackMap[videoUrl] = {onPreparedFunc}
  local prepareVideoPlayer = self:GetPreparingVideoPlayer()
  if not prepareVideoPlayer then
    self.preparedCallbackMap[videoUrl] = nil
    Logger.Error("AvgVideoComp:PrepareVideo 没有可用的VideoPlayer")
    return
  end
  Logger.Info("AvgVideoComp:PrepareVideo videoUrl=" .. videoUrl)
  self:ClearPreparedVideoPlayer(prepareVideoPlayer)
  self.preparingMap[videoUrl] = prepareVideoPlayer
  
  local function preparedFunc()
    if self.preparingMap[videoUrl] ~= prepareVideoPlayer then
      return
    end
    Logger.Info("AvgVideoComp:PrepareVideo Done videoUrl=" .. videoUrl)
    self.preparedMap[videoUrl] = prepareVideoPlayer
    self.preparingMap[videoUrl] = nil
    local callbackList = self.preparedCallbackMap[videoUrl]
    self.preparedCallbackMap[videoUrl] = nil
    for _, callback in ipairs(callbackList or {}) do
      callback()
    end
  end
  
  prepareVideoPlayer.preparedCallback = preparedFunc
  
  function prepareVideoPlayer.finishedCallback(errorOccued)
    Logger.Info("AvgVideoComp: Finished videoUrl=" .. videoUrl)
    self.preparedCallbackMap[videoUrl] = nil
    self.preparingMap[videoUrl] = nil
    if errorOccued then
      self.videoErrorOccu = true
      Logger.ReportApusInfo(AVG_LOG_EVENT, "PrepareError", videoUrl)
      if errorCb then
        errorCb()
      end
    end
  end
  
  xpcall(function()
    prepareVideoPlayer:OpenMedia(videoUrl)
  end, function()
    preparedFunc()
    if errorCb then
      errorCb()
    end
  end)
end

function AvgVideoComp:PlayVideoBg(videoUrl)
  self.bgVideoUrl.value = videoUrl
  self:PlayVideo(videoUrl, 0, -1, true)
end

function AvgVideoComp:ClearVideoBg()
  self.bgVideoUrl.value = nil
  self:ClearVideo()
end

function AvgVideoComp:ClearPreparedVideoPlayer(videoPlayer)
  local copy = table.clone(self.preparedMap)
  for k, v in pairs(copy) do
    if v == videoPlayer then
      self.preparedMap[k] = nil
    end
  end
  for k, v in pairs(self.preparingMap) do
    if v == videoPlayer then
      self.preparingMap[k] = nil
      self.preparedCallbackMap[k] = nil
    end
  end
end

function AvgVideoComp:CreateSafeTimer(url, callback)
  if self.saveTimer then
    self.binder:StopTimer(self.saveTimer)
    self.saveTimer = nil
  end
  local saveTime = 5
  self.saveTimer = self.binder:BindTimer(saveTime, 0, nil, function()
    if callback then
      callback()
    end
    Logger.ReportApusInfo(AVG_LOG_EVENT, "Safe Time", url)
  end)
end

function AvgVideoComp:StopSafeTimer()
  if self.saveTimer then
    self.binder:StopTimer(self.saveTimer)
    self.saveTimer = nil
  end
  if self.timer then
    self.binder:StopTimer(self.timer)
    self.timer = nil
  end
end

function AvgVideoComp:PlayVideo(videoUrl, videoTimeA, videoTimeB, isLoop, endCallback, startCallback)
  self.playingVideoUrl.value = videoUrl
  if videoUrl == self.prepareVideoUrl.value then
    self.prepareVideoUrl.value = nil
  end
  self.endCallback = endCallback
  
  local function videoCallback()
    self:StopSafeTimer()
    self.isVideoEnd = true
    self.endCallback = nil
    if endCallback then
      endCallback()
      endCallback = nil
    end
  end
  
  self:CreateSafeTimer(videoUrl, videoCallback)
  local videoPlayer = self:GetPreparedVideoPlayer(videoUrl)
  if not videoPlayer then
    Logger.Info("AvgVideoComp:Video is not prepared videoUrl=" .. videoUrl)
    self:PrepareVideo(videoUrl, function()
      self:PlayVideo(videoUrl, videoTimeA, videoTimeB, isLoop, endCallback)
    end, videoCallback)
    return
  end
  
  function videoPlayer.startedCallabck()
    Logger.Info("AvgVideoComp:Video started videoUrl=" .. videoUrl)
    FrameWaiter.OnNextFrame(function()
      self:MovePlayerCenter()
      self.avgPanel:PlayDialogAudio(self.avgModel.dialogInfo)
      local videoCaptionPanel
      if self.avgModel.videoCaption then
        videoCaptionPanel = UIManager.Instance:Reopen(Urls.VideoCaptionPanel, self.avgModel.videoCaption)
      end
      if 1 == self.avgModel.chatIndex then
        EventMgr.Instance.OnStoryRealStart:Dispatch(self.avgModel.storyId)
      end
      if self.timer then
        self.binder:StopTimer(self.timer)
        self.timer = nil
      end
      self.timer = self.binder:BindTimer(0.01, -1, function()
        if videoCaptionPanel then
          local deltaVal = math.abs(videoPlayer:GetCurrentTime() - videoCaptionPanel.curTime)
          if deltaVal > 0.1 then
            videoPlayer:Seek(videoCaptionPanel.curTime)
            return
          end
        end
      end)
    end)
  end
  
  function videoPlayer.finishedCallback(errorOccued)
    Logger.Info("AvgVideoComp:Video finished videoUrl=" .. videoUrl)
    if not errorOccued then
      videoCallback()
    else
      self.videoErrorOccu = true
      videoCallback()
      Logger.ReportApusInfo(AVG_LOG_EVENT, "PlayerError", videoUrl)
    end
  end
  
  Logger.Info("AvgVideoComp:PlayVideo videoUrl=" .. videoUrl)
  self:SetPlayingVideoPlayer(videoPlayer)
  self.isVideoEnd = false
  self.binder:StopTimer(self.videoUpdateTimer)
  videoPlayer:SetLooping(isLoop and true or false)
  self.isVideoLooping = isLoop
  self:MovePlayerCenter()
  videoPlayer:Play()
  if self.bgVideoUrl.value and self.bgVideoUrl.value ~= videoUrl then
    videoPlayer:SetAsLastSibling()
  end
  if startCallback then
    startCallback()
  end
  local videoTotalTime = videoPlayer:GetLength()
  if videoTimeB == CommonDefine.AvgVideoEndTime and 0 ~= videoTotalTime then
    videoTimeB = videoTotalTime
  end
  self:StopSafeTimer()
  if videoTimeA == videoTimeB then
    videoPlayer:SeekToLiveTime(videoTimeA)
    videoPlayer:Pause()
    videoCallback()
    return
  end
  if 0 ~= videoTotalTime and videoTimeB ~= videoTotalTime then
    self.videoUpdateTimer = self.binder:BindTimer(0.01, -1, function()
      if videoTotalTime >= videoTimeB then
        self.isVideoEnd = true
        if isLoop then
          videoPlayer:SeekToLiveTime(videoTimeA)
        else
          videoPlayer:SeekToLiveTime(videoTimeB)
          videoPlayer:Pause()
          self.binder:StopTimer(self.videoUpdateTimer)
          videoCallback()
        end
      end
    end, nil)
  elseif not isLoop then
    self.binder:BindTimer(videoTotalTime + 0.1, 0, nil, function()
      videoCallback()
      Logger.ReportApusInfo(AVG_LOG_EVENT, "PlayerOverTime", videoUrl)
    end)
  else
    Logger.Info("Avg Play Loop Video. Will Be End By Other Place")
  end
end

function AvgVideoComp:IsVideoPureEnd()
  if self.avgModel:IsVideoType(CommonDefine.AvgVideoType.VideoPure) then
    return self.isVideoEnd
  end
  return true
end

function AvgVideoComp:IsVideoEnd()
  return self.isVideoEnd
end

function AvgVideoComp:ClearVideo()
  if self.playingVideoPlayer then
    self.playingVideoPlayer:Stop()
    self:HideAllVideoPlayer()
    self:SetPlayingVideoPlayer(nil)
  end
end

function AvgVideoComp:GetOppositeVideoPlayer(videoPlayer)
  if videoPlayer == self.videoPlay1 then
    return self.videoPlay2
  else
    return self.videoPlay1
  end
end

function AvgVideoComp:OnVideoPlayEnd()
  local videoPlayer = self.playingVideoPlayer
  if videoPlayer then
    videoPlayer:SetPosition(POS_REMOTE)
  end
  self.playingVideoUrl.value = nil
  self:SetPlayingVideoPlayer(nil)
end

return AvgVideoComp
