local Vector2 = CS.UnityEngine.Vector2
local IntroFadeDuration = 2
local ActivityBaseComp, Super = System.NewComponent("ActivityBaseComp")

function ActivityBaseComp:ctor(ui, activityData)
  Super.ctor(self)
  if activityData then
    self.activityData = activityData
  end
  if ui then
    self.ui = ui
  end
end

function ActivityBaseComp:OnBind(binder)
  self.binder = binder
end

function ActivityBaseComp:_SetActivityPlot(textGameObj)
  local desc = ""
  if self.activityConfig and self.activityConfig.ActivityPlot then
    desc = LT.Text(self.activityConfig.ActivityPlot)
  end
  textGameObj = textGameObj or self.ui.Text_Desc
  if textGameObj then
    self.binder:SetText(textGameObj, desc)
  end
  if self.ui.Text_C_Topic then
    local activityName = ActivityDataUtils.GetActivityName(self.activityTid)
    self.binder:SetText(self.ui.Text_C_Topic, activityName)
  end
end

function ActivityBaseComp:_SetActivityIllustrate(btnGameObj)
  if self.ui.Text_C_illustrate then
    self.binder:SetText(self.ui.Text_C_illustrate, LT.Text("ActivityDescriptionTitle"))
  end
  btnGameObj = btnGameObj or self.ui.UI_Common_Btn_Question
  self.binder:BindZ1Button(btnGameObj, function()
    local title = ActivityDataUtils.GetRuleTitle(self.activityTid)
    local content = ActivityDataUtils.GetRuleContent(self.activityTid)
    if content then
      UIManager.Instance:Reopen(Urls.CommonillustrateView, title, content)
    end
  end)
  self.binder:BindToVisible(btnGameObj, function()
    local content = ActivityDataUtils.GetRuleContent(self.activityTid)
    return nil ~= content
  end)
end

function ActivityBaseComp:_BindActivityTimer()
  if not (self.activityData and self.binder and self.ui) or not self.ui.Text_Time then
    Logger.Warn("_BindActivityTimer wrong activityData:%s binder:%s Text_Time:%s", self.activityData, self.binder, self.ui and self.ui.Text_Time)
    return
  end
  local timeType = ActivityDataUtils.GetTimeType(self.activityData.activityTid)
  if timeType == ActivityDefine.ActivityTimeType.Permanent then
    self.binder:SetText(self.ui.Text_Time, LT.Text("ActivityTimePermanent"))
    return
  end
  local leftTime = ActivityDataUtils.GetLeftTime(self.activityData) or 0
  if leftTime <= 0 then
    if self.activityData.endTime > 0 and self.activityData.endTime < TimeUtils.GetServerTime() then
      self.binder:SetText(self.ui.Text_Time, LT.Text("ActivityTimeExpired"))
    end
    return
  end
  self.binder:SetText(self.ui.Text_Time, TimeUtils.ActivityCountDownFormat(leftTime))
  self.activityTimer = self.binder:BindTimer(1, -1, function()
    xpcall(function()
      if not (self and self.ui) or not self.ui.uiNode then
        return
      end
      leftTime = leftTime - 1
      if leftTime <= 0 then
        self:_ClearTimer()
        return
      end
      self.binder:SetText(self.ui.Text_Time, TimeUtils.ActivityCountDownFormat(leftTime))
    end, function()
      self:_ClearTimer()
    end)
  end, function()
    self.binder:SetText(self.ui.Text_Time, LT.Text("ActivityTimeExpired"))
    self:_ClearTimer()
  end)
end

function ActivityBaseComp:_ClearTimer()
  if self.activityTimer then
    TimerManager.Instance:StopTimer(self.activityTimer)
    self.activityTimer = nil
  end
end

function ActivityBaseComp:_BindPortraitComp()
  if not (self.activityTid and self.binder and self.ui) or not self.ui.Image_Awaker then
    return
  end
  local config = ActivityDataUtils.GetConfig(self.activityTid)
  if not config or not config.ShowAwaker then
    return
  end
  local awakerTid = config.ShowAwaker
  if not self.awakerPortraitComp then
    local portraitAlign = CommonDefine.PortraitAlign.Center
    self.awakerPortraitComp = self.binder:BindComponent(AwakerPortraitComp(self.ui.Image_Awaker, awakerTid, nil, nil, portraitAlign))
  else
    self.awakerPortraitComp:ChangeAwakerTid(awakerTid)
  end
end

function ActivityBaseComp:_BindLoadVXFx()
  local vxPrefab = ActivityDataUtils.GetVXPrfab(self.activityTid)
  if string.isempty(vxPrefab) then
    return
  end
  local prefab = self.binder:LoadAsset(vxPrefab)
  self.binder:Instantiate(prefab, self.ui.Image_Map.transform)
end

function ActivityBaseComp:_BindSkinTaskComp(extraParam)
  local skinTaskNode = self:_GetSkinTaskNode()
  if not skinTaskNode then
    return
  end
  local skinTaskInfo = ActivityCfgUtils.GetActivitySkinTaskInfo(self.activityTid)
  if not skinTaskInfo then
    self.binder:SetActive(skinTaskNode, false)
    return
  end
  local skinActivityTid = skinTaskInfo.skinActivityTid
  local skinActivityData = ActivityDataUtils.GetActivityData(skinActivityTid)
  if not skinActivityData or not ActivityDataUtils.IsActivityOpen(skinActivityTid) then
    self.binder:SetActive(skinTaskNode, false)
    return
  end
  self.binder:SetActive(skinTaskNode, true)
  self.binder:BindComponent(ActivitySkinTaskItem(self.ui.UI_Summon_GiftTask, skinTaskInfo, function()
    ActivityDataUtils.ReqGainAward(skinActivityTid, skinTaskInfo.skinTaskTid)
  end, skinActivityTid, extraParam))
end

function ActivityBaseComp:_GetSkinTaskNode()
  return self.ui.UI_Summon_GiftTask
end

function ActivityBaseComp:Show()
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

function ActivityBaseComp:Hide()
  if self.ui and self.ui.uiNode then
    self.ui.uiNode.transform.anchoredPosition = Vector2(9999, 9999)
    self.ui.uiNode:SetActive(false)
  end
end

function ActivityBaseComp:OnOpenAnim(callback)
  self:Show()
  if callback then
    callback()
  end
end

function ActivityBaseComp:OnCloseAnim(callback)
  self:StopConfigLoopVideo()
  self:Hide()
  if callback then
    callback()
  end
end

function ActivityBaseComp:_GetActivityLoopVideoPath()
  local activityDefine = self.activtyDefine or self.activityDefine or ActivityDataUtils.GetActivityCompInfoByTid(self.activityTid)
  return activityDefine and activityDefine.openVideoPath or nil
end

function ActivityBaseComp:_GetActivityIntroVideoPath()
  local activityDefine = self.activtyDefine or self.activityDefine or ActivityDataUtils.GetActivityCompInfoByTid(self.activityTid)
  return activityDefine and activityDefine.openIntroVideoPath or nil
end

function ActivityBaseComp:_GetVideoPlayerNodes()
  if not self.ui or not self.ui.uiNode then
    return nil, nil
  end
  local activityDefine = self.activtyDefine or self.activityDefine or ActivityDataUtils.GetActivityCompInfoByTid(self.activityTid)
  local defaultDefine = ActivityDefine.DefaultCompClsInfo
  local nodeName = activityDefine and activityDefine.videoPlayerNodeName or defaultDefine.videoPlayerNodeName or "VideoPlayer"
  local bakNodeName = activityDefine and activityDefine.videoPlayerBakNodeName or defaultDefine.videoPlayerBakNodeName or "VideoPlayerBak"
  local mediaNode = self.ui[nodeName]
  if not mediaNode then
    return nil, nil
  end
  return mediaNode, self.ui[bakNodeName]
end

function ActivityBaseComp:TryPlayConfigLoopVideo()
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

function ActivityBaseComp:_PlayIntroVideo(introPath, loopPath)
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

function ActivityBaseComp:_PlayLoopVideoOnSecondNode(loopPath)
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

function ActivityBaseComp:_PlayLoopVideoOnMainNode(loopPath)
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

function ActivityBaseComp:_SwapIntroToLoop()
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

function ActivityBaseComp:_OnIntroFadeOutComplete()
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

function ActivityBaseComp:_DisposeIntroPlayer()
  if self._loopVideoPlayer then
    self._loopVideoPlayer.preparedCallback = nil
    self._loopVideoPlayer.finishedCallback = nil
    self._loopVideoPlayer:Dispose()
    self._loopVideoPlayer = nil
  end
end

function ActivityBaseComp:StopConfigLoopVideo()
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

return ActivityBaseComp
