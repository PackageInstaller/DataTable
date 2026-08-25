local IntroFadeDuration = 2
local CGActivityComp, Super = System.NewComponent("CGActivityComp")

function CGActivityComp:ctor(uiNode, activityDefine, isPlayMusic)
  Super.ctor(self)
  self.ui = UIBaseResource(uiNode)
  self.activtyDefine = activityDefine
  self.uiNode = uiNode
  self.uiAnimController = self.ui.uiNode:GetComponent(typeof(CS.Z1Client.UIAnimationController))
  self.timeline = self.ui.uiNode:GetComponent(typeof(CS.UnityEngine.Playables.PlayableDirector))
  self.isPlayMusic = isPlayMusic
  self.contentGo = uiNode.transform:Find("Content")
  if not self.contentGo then
    return
  end
  self.contentChildCount = self.contentGo.childCount
end

function CGActivityComp:OnBind(binder)
  self.binder = binder
  self:HideItems()
  binder:BindTimer(0, -1, System.fn(self, self.HideItems))
  self:ChangeBgImage()
  self:TryPlayConfigLoopVideo()
  self:PlayAnim()
  binder:BindEvent(EventMgr.Instance.OpenUIPanel, System.fn(self, self.OnOpenUIPanel))
  EventMgr.Instance.CGActivityPlayed:Dispatch(self.activtyDefine.resPath)
end

function CGActivityComp:ChangeBgImage()
  if not self.activtyDefine.changeBgImage then
    return
  end
  if not self.ui.Image_Bg then
    return
  end
  local activityType = self.activtyDefine.changeBgImage
  local activityTid = ActivityDataUtils.GetAtitivtyTidByType(activityType)
  local bgImage = ActivityDataUtils.GetBgImage(activityTid)
  self.binder:SetImage(self.ui.Image_Bg, bgImage)
end

function CGActivityComp:OnOpenUIPanel(panelUrl)
  if panelUrl == Urls.ActivityMainPanel and self.ui.UI_Events_Panel_Lily_Audio then
    self.ui.UI_Events_Panel_Lily_Audio:SetActive(false)
  end
end

function CGActivityComp:OnUnbind()
  self:StopConfigLoopVideo()
  self:ClearTimeline()
end

function CGActivityComp:_GetActivityLoopVideoPath()
  local activityDefine = self.activtyDefine
  return activityDefine and activityDefine.openVideoPath or nil
end

function CGActivityComp:_GetActivityIntroVideoPath()
  local activityDefine = self.activtyDefine
  return activityDefine and activityDefine.openIntroVideoPath or nil
end

function CGActivityComp:_GetVideoPlayerNodes()
  if not self.ui or not self.ui.uiNode then
    return nil, nil
  end
  local activityDefine = self.activtyDefine
  local defaultDefine = ActivityDefine.DefaultCompClsInfo
  local nodeName = activityDefine and activityDefine.videoPlayerNodeName or defaultDefine.videoPlayerNodeName or "VideoPlayer"
  local bakNodeName = activityDefine and activityDefine.videoPlayerBakNodeName or defaultDefine.videoPlayerBakNodeName or "VideoPlayerBak"
  local mediaNode = self.ui[nodeName]
  if not mediaNode then
    return nil, nil
  end
  return mediaNode, self.ui[bakNodeName]
end

function CGActivityComp:TryPlayConfigLoopVideo()
  local videoPath = self:_GetActivityLoopVideoPath()
  if string.isempty(videoPath) then
    return false
  end
  self:StopConfigLoopVideo()
  self._loopVideoPath = videoPath
  local introNode = self.ui and self.ui.VideoPlayerIntro
  local videoPlayerIntroBak = self.ui and self.ui.VideoPlayerIntroBak
  self._loopVideoPlayer = GameVideoPlayer(introNode, videoPlayerIntroBak)
  local introPath = self:_GetActivityIntroVideoPath()
  if string.isempty(introPath) then
    self:_PlayLoopVideoOnMainNode(videoPath)
  else
    self:_PlayIntroVideo(introPath, videoPath)
  end
  return true
end

function CGActivityComp:_PlayIntroVideo(introPath, loopPath)
  local introPlayer = self._loopVideoPlayer
  if not self.ui.VideoPlayerIntro then
    function introPlayer.finishedCallback()
      if self._loopVideoPlayer then
        self:_PlayLoopVideoOnMainNode(loopPath)
      end
    end
    
    introPlayer:SetLooping(false)
    
    function introPlayer.preparedCallback(success)
      if not self._loopVideoPlayer then
        return
      end
      if success then
        self._loopVideoPlayer:Play()
      else
        self:_PlayLoopVideoOnMainNode(loopPath)
      end
    end
    
    introPlayer:OpenMedia(introPath)
    return
  end
  introPlayer:SetLooping(false)
  self._introFinished = false
  self._loopVideoReady = false
  self._loopVideoPrepareFailed = false
  
  function introPlayer.preparedCallback(success)
    if not self._loopVideoPlayer then
      return
    end
    if success then
      self._loopVideoPlayer:Play()
      self:_PlayLoopVideoOnSecondNode(loopPath)
    else
      self:_PlayLoopVideoOnMainNode(loopPath)
    end
  end
  
  function introPlayer.finishedCallback()
    if self._loopVideoPlayer then
      self._introFinished = true
      if self._loopVideoReady then
        self:_SwapIntroToLoop()
      elseif self._loopVideoPrepareFailed then
        self:_PlayLoopVideoOnMainNode(loopPath)
      end
    end
  end
  
  introPlayer:OpenMedia(introPath)
end

function CGActivityComp:_PlayLoopVideoOnSecondNode(loopPath)
  local mediaNode, bakMediaNode = self:_GetVideoPlayerNodes()
  if not mediaNode then
    return
  end
  self._loopVideoPlayer2 = GameVideoPlayer(mediaNode, bakMediaNode)
  self._loopVideoReady = false
  self._loopVideoPrepareFailed = false
  local loopPlayer = self._loopVideoPlayer2
  loopPlayer:SetLooping(true)
  
  function loopPlayer.preparedCallback(success)
    if not self._loopVideoPlayer2 then
      return
    end
    if success then
      self._loopVideoReady = true
      if self._introFinished then
        self:_SwapIntroToLoop()
      end
    else
      self._loopVideoPrepareFailed = true
      self._loopVideoPlayer2:Dispose()
      self._loopVideoPlayer2 = nil
      if self._introFinished then
        self:_PlayLoopVideoOnMainNode(loopPath)
      end
    end
  end
  
  loopPlayer:OpenMedia(loopPath)
end

function CGActivityComp:_PlayLoopVideoOnMainNode(loopPath)
  local player = self._loopVideoPlayer
  if not player then
    return
  end
  player.finishedCallback = nil
  player:SetLooping(true)
  
  function player.preparedCallback(success)
    if success and self._loopVideoPlayer then
      self._loopVideoPlayer:Play()
    end
  end
  
  player:OpenMedia(loopPath)
end

function CGActivityComp:_SwapIntroToLoop()
  if not self._loopVideoPlayer2 or not self._loopVideoReady then
    return
  end
  self._loopVideoPlayer2:Play()
  if self._loopVideoPlayer then
    self._loopVideoPlayer:Pause()
    self._loopVideoPlayer:FadeOut(IntroFadeDuration, function()
      self:_OnIntroFadeOutComplete()
    end)
  end
end

function CGActivityComp:_OnIntroFadeOutComplete()
  if not self._loopVideoPlayer then
    return
  end
  local introNode = self.ui.VideoPlayerIntro
  if introNode and not IsNil(introNode) then
    introNode:SetActive(false)
  end
  local introBakNode = self.ui.VideoPlayerIntroBak
  if introBakNode and not IsNil(introBakNode) then
    introBakNode:SetActive(false)
  end
  self:_DisposeIntroPlayer()
end

function CGActivityComp:_DisposeIntroPlayer()
  if self._loopVideoPlayer then
    self._loopVideoPlayer.preparedCallback = nil
    self._loopVideoPlayer.finishedCallback = nil
    self._loopVideoPlayer:Dispose()
    self._loopVideoPlayer = nil
  end
end

function CGActivityComp:StopConfigLoopVideo()
  self._loopVideoPath = nil
  self._introFinished = false
  self._loopVideoReady = false
  self._loopVideoPrepareFailed = false
  self:_DisposeIntroPlayer()
  if self._loopVideoPlayer2 then
    self._loopVideoPlayer2:Dispose()
    self._loopVideoPlayer2 = nil
  end
end

function CGActivityComp:PlayAnim(callback)
  if self.ui.UI_Events_Panel_Lily_Audio then
    self.ui.UI_Events_Panel_Lily_Audio:SetActive(self.isPlayMusic or false)
  end
  if self.activtyDefine.openTimeline then
    self:PlayTimeline(self.activtyDefine.openTimeline)
  else
    if not self.uiAnimController then
      return
    end
    if self.activtyDefine.openAnim then
      self.uiAnimController:PlayState(self.activtyDefine.openAnim, callback)
    else
      if self.timeline then
        self.timeline.time = 0
        self.timeline:Play()
        return
      end
      local animationInfoList = self.uiAnimController.animationInfoList
      if 0 == animationInfoList.Count then
        return
      end
      local clipInfo = animationInfoList[0]
      if clipInfo and clipInfo.clip then
        self.uiAnimController:PlayState(clipInfo.clip.name, callback)
      end
    end
  end
end

function CGActivityComp:PlayTimeline(timelinePath)
  self:ClearTimeline()
  self.player = self.ui.uiNode
  self.timelinePlayer = PortraitTimelinePlayer(self.player)
  local timelineConfig = TimelineConfig()
  timelineConfig.assetPath = timelinePath
  self.timelinePlayer:Play(timelineConfig)
end

function CGActivityComp:ClearTimeline()
  if self.timelinePlayer then
    self.timelinePlayer:Stop()
    self.timelinePlayer:Dispose()
    self.timelinePlayer = nil
  end
end

local ignoreItems = {
  "UI_Spine_Loopani",
  "Timeline_Loop"
}

function CGActivityComp:HideItems()
  if not self.contentGo then
    return
  end
  local startHideChild = self.activtyDefine.startHideChild or 4
  for i = startHideChild, self.contentChildCount do
    local child = self.contentGo:GetChild(i - 1)
    if child then
      local name = child.gameObject.name
      if not table.contains(ignoreItems, name) then
        self.binder:SetActive(child.gameObject, false)
      end
    end
  end
  if self.ui.Group_UnLock then
    self.binder:SetActive(self.ui.Group_UnLock, false)
  end
  if self.ui.Group_Locked then
    self.binder:SetActive(self.ui.Group_Locked, false)
  end
  if self.ui.Btn_Reward then
    self.binder:SetActive(self.ui.Btn_Reward, false)
  end
  if self.ui.Btn_Sign then
    self.binder:SetActive(self.ui.Btn_Sign, false)
  end
  if self.ui.Btn_Task then
    self.binder:SetActive(self.ui.Btn_Task, false)
  end
end

return CGActivityComp
