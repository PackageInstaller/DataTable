local Vector2 = CS.UnityEngine.Vector2
local UIAnimationController = CS.Z1Client.UIAnimationController
local IntroFadeDuration = 2
local ActivityPermanentBaseComp, Super = System.NewComponent("ActivityPermanentBaseComp")

function ActivityPermanentBaseComp:ctor(uiNode, resPath, activityTid)
  Super.ctor(self)
  self.ui = resPath(uiNode)
  self._activityTid = activityTid
end

function ActivityPermanentBaseComp:OnBind(binder)
  self.binder = binder
  self.uiAnimController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  if self.ui.Btn_Shop then
    binder:SetActive(self.ui.Btn_Shop, false)
  end
  binder:SetActive(self.ui.Btn_Reward, false)
  binder:SetActive(self.ui.Btn_Record, false)
  binder:SetActive(self.ui.Group_Locked, false)
  binder:SetActive(self.ui.Group_Finish, false)
  binder:SetActive(self.ui.Text_C_ChallengeTip, false)
  binder:SetActive(self.ui.Text_Time, false)
  binder:SetText(self.ui.Text_Desc, LT.Text(ActivityCfgUtils.GetCfgField("ActivityPlot", self._activityTid)))
end

function ActivityPermanentBaseComp:GetOpenAnim()
  return "UI_Events_Panel_MagicStory_Open"
end

function ActivityPermanentBaseComp:GetCloseAnim()
  return "UI_Events_Panel_MagicStory_Close"
end

function ActivityPermanentBaseComp:_GetActivityLoopVideoPath()
  local activityDefine = ActivityDataUtils.GetActivityCompInfoByTid(self._activityTid)
  return activityDefine and activityDefine.openVideoPath or nil
end

function ActivityPermanentBaseComp:_GetActivityIntroVideoPath()
  local activityDefine = ActivityDataUtils.GetActivityCompInfoByTid(self._activityTid)
  return activityDefine and activityDefine.openIntroVideoPath or nil
end

function ActivityPermanentBaseComp:_GetVideoPlayerNodes()
  if not self.ui or not self.ui.uiNode then
    return nil, nil
  end
  local activityDefine = ActivityDataUtils.GetActivityCompInfoByTid(self._activityTid)
  local defaultDefine = ActivityDefine.DefaultCompClsInfo
  local nodeName = activityDefine and activityDefine.videoPlayerNodeName or defaultDefine.videoPlayerNodeName or "VideoPlayer"
  local bakNodeName = activityDefine and activityDefine.videoPlayerBakNodeName or defaultDefine.videoPlayerBakNodeName or "VideoPlayerBak"
  local mediaNode = self.ui[nodeName]
  if not mediaNode then
    return nil, nil
  end
  return mediaNode, self.ui[bakNodeName]
end

function ActivityPermanentBaseComp:TryPlayConfigLoopVideo()
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

function ActivityPermanentBaseComp:_PlayIntroVideo(introPath, loopPath)
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

function ActivityPermanentBaseComp:_PlayLoopVideoOnSecondNode(loopPath)
  local mediaNode, mediaNodeBak = self:_GetVideoPlayerNodes()
  if not mediaNode then
    return
  end
  self._loopVideoPlayer2 = GameVideoPlayer(mediaNode, mediaNodeBak)
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

function ActivityPermanentBaseComp:_PlayLoopVideoOnMainNode(loopPath)
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

function ActivityPermanentBaseComp:_SwapIntroToLoop()
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

function ActivityPermanentBaseComp:_OnIntroFadeOutComplete()
  if not self._loopVideoPlayer then
    return
  end
  local introNode = self.ui.VideoPlayerIntro
  if introNode and not IsNil(introNode) then
    introNode:SetActive(false)
  end
  local _, introBakNode = self:_GetVideoPlayerNodes()
  if introBakNode and not IsNil(introBakNode) then
    introBakNode:SetActive(false)
  end
  self:_DisposeIntroPlayer()
end

function ActivityPermanentBaseComp:_DisposeIntroPlayer()
  if self._loopVideoPlayer then
    self._loopVideoPlayer.preparedCallback = nil
    self._loopVideoPlayer.finishedCallback = nil
    self._loopVideoPlayer:Dispose()
    self._loopVideoPlayer = nil
  end
end

function ActivityPermanentBaseComp:StopConfigLoopVideo()
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

function ActivityPermanentBaseComp:OnOpenAnim(callback)
  self:Show()
  self:TryPlayConfigLoopVideo()
  self.uiAnimController:PlayState(self:GetOpenAnim(), function()
    if callback then
      callback()
    end
  end)
end

function ActivityPermanentBaseComp:OnCloseAnim(callback)
  self:StopConfigLoopVideo()
  self.uiAnimController:PlayState(self:GetCloseAnim(), function()
    self:Hide()
    if callback then
      callback()
    end
  end)
end

function ActivityPermanentBaseComp:Show()
  if self.ui and self.ui.uiNode then
    self.ui.uiNode.transform.anchoredPosition = Vector2.zero
    self.ui.uiNode:SetActive(true)
  end
  if self.ui.Text_Title then
    StrUtils.SetPreferedWidthFontSize(self.ui.Text_Title, nil, 800)
  end
  if self.ui.Text_Diary then
    StrUtils.SetPreferedWidthFontSize(self.ui.Text_Diary, nil, 800)
  end
end

function ActivityPermanentBaseComp:Hide()
  if self.ui and self.ui.uiNode then
    self.ui.uiNode.transform.anchoredPosition = Vector2(9999, 9999)
    self.ui.uiNode:SetActive(false)
  end
end

return ActivityPermanentBaseComp
