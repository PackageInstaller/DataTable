local SuperDimensionAsset = "TimelineRoot/SuperDimension/SuperDimension.prefab"
local T_Renderer = typeof(CS.UnityEngine.Renderer)
local SuperDimensionTimelinePlayer, Super = System.NewClass("SuperDimensionTimelinePlayer", TimelinePlayer)

function SuperDimensionTimelinePlayer:ctor()
  self.superDimensionPlayer = CS.UnityEngine.GameObject("SuperDimensionPlayer")
  Super.ctor(self, self.superDimensionPlayer)
  self.isShowingSuperDimension = true
  self.timelineConfig = TimelineConfig()
  self.assetPath = SuperDimensionAsset
end

function SuperDimensionTimelinePlayer:Prepare()
  CS.AMTimeline.AMResourcesCache.PrepareDirector(self.assetPath)
end

function SuperDimensionTimelinePlayer:StopLooping()
  if self.amPlayer then
    if not self.isPlayedStop and self.superDimensVideo then
      self.isPlayedStop = true
      self.superDimensVideo:PlayFinishedVideo()
    end
    self.amPlayer:StopLooping()
  end
  return self
end

function SuperDimensionTimelinePlayer:StartSuperDimension()
  if self.isPlayingDimensionTimeline then
    return
  end
  self.isPlayingDimensionTimeline = true
  self:OnDimensionBegan()
  self:PlayTimeline(self.assetPath)
end

function SuperDimensionTimelinePlayer:ShowSuperDimension(showed)
  self.isShowingSuperDimension = showed
  if not self.amPlayer then
    return
  end
  local amObjects = self.amPlayer:GetAMObjects()
  for i = 0, amObjects.Count - 1 do
    local amObject = amObjects[i]
    if amObject.gameObject then
      local renderers = amObject.gameObject:GetComponentsInChildren(T_Renderer, true)
      for j = 0, renderers.Length - 1 do
        renderers[j].enabled = self.isShowingSuperDimension
      end
    end
  end
end

function SuperDimensionTimelinePlayer:PlayTimeline(assetPath)
  self.timelineConfig:Reset()
  self.timelineConfig.assetPath = assetPath
  self.timelineConfig.looping = -1
  
  function self.timelineConfig.onComplete()
    self.isPlayedStop = false
    if self.superDimensVideo then
      self.superDimensVideo:Dispose()
      self.superDimensVideo = nil
    end
    self.isPlayingDimensionTimeline = false
    if self.awaiterAnimFinished then
      self.awaiterAnimFinished:SetCompleted()
    end
    if bg.battleScene then
      bg.battleScene.battleSceneMgr:UnLoadTimelineLoadScenes()
      bg.battleScene.battleSceneMgr:Temp_UnLoadSuperDimensionScene()
      bg.battleScene:ResumeUniversalCycle()
    end
  end
  
  function self.timelineConfig.onStarted()
    if not self.isShowingSuperDimension then
      self:ShowSuperDimension(false)
    end
    if bg.battleScene then
      bg.battleScene:PauseUniversalCycle()
    end
  end
  
  self:Play(self.timelineConfig)
  return self
end

function SuperDimensionTimelinePlayer:OnTLEvent(eventId, eventParam)
  Super.OnTLEvent(self, eventId, eventParam)
  if eventId == rc.TimeLineEvent.SceneTransEvent then
    if bg.battleScene then
      bg.battleScene:EnterDimensionScene(eventParam)
    end
  elseif eventId == rc.TimeLineEvent.SuperDimensionFinish then
    if not self:_CheckPlayerUID() then
      return
    end
    if bg.battlePanel and self.superDimensVideo then
      if self.isPlayedStop or self.amPlayer:IsInLooping() then
        return
      end
      self.isPlayedStop = true
      self.superDimensVideo:PlayFinishedVideo()
    end
  elseif eventId == rc.TimeLineEvent.SuperDimensionLoop then
    if not self:_CheckPlayerUID() then
      return
    end
    if bg.battlePanel and self.superDimensVideo then
      self.superDimensVideo:PlayLoopingVideo()
    end
  elseif eventId == rc.TimeLineEvent.SuperDimensionStart then
    if not bg.battlePanel or not self:_CheckPlayerUID() then
      return
    end
    if not self.superDimensVideo then
      self.superDimensVideo = SuperDimensionVideosMgr()
    end
    self.superDimensVideo:PlayStartVideo()
  elseif eventId == rc.TimeLineEvent.StringEvent and "StartSuperDimensionBout" == eventParam then
    if self.awaiterAnimBegan then
      self.awaiterAnimBegan:SetCompleted()
    end
  elseif eventId == rc.TimeLineEvent.ShowBattleScene then
    if bg.battleScene then
      bg.battleScene:ShowScene(true, true)
    end
  elseif eventId == rc.TimeLineEvent.HideBattleScene and bg.battleScene then
    bg.battleScene:ShowScene(false, true)
  end
end

function SuperDimensionTimelinePlayer:Stop()
  self.isPlayedStop = false
  if self.superDimensVideo then
    self.superDimensVideo:Dispose()
    self.superDimensVideo = nil
  end
  Super.Stop(self)
end

function SuperDimensionTimelinePlayer:Dispose()
  if self.superDimensVideo then
    self.superDimensVideo:Dispose()
    self.superDimensVideo = nil
  end
  Super.Dispose(self)
  self.isPlayingDimensionTimeline = false
  if self.superDimensionPlayer then
    CS.UnityEngine.GameObject.Destroy(self.superDimensionPlayer)
    self.superDimensionPlayer = nil
  end
  self:ClearTimers()
end

function SuperDimensionTimelinePlayer:StopPlaySuperDimension()
  self:OnDimensionBoutEnd()
  if not bg.battleScene:HasAwakerPlayingSkill() then
    self:ClearTimers()
    self:StopLooping()
    return
  end
  
  local function DelayStopLooping()
    if self.delayStopLoopingTimerId and not bg.battleScene:HasAwakerPlayingSkill() then
      self:ClearTimers()
      self:StopLooping()
    end
  end
  
  self.delayStopLoopingTimerId = TimerManager.Instance:CreateTimer(0.001, -1, DelayStopLooping, DelayStopLooping)
end

function SuperDimensionTimelinePlayer:ClearTimers()
  if self.delayStopLoopingTimerId then
    TimerManager.Instance:StopTimer(self.delayStopLoopingTimerId)
    self.delayStopLoopingTimerId = nil
  end
end

function SuperDimensionTimelinePlayer:OnDimensionBegan()
  self.awaiterAnimBegan = Awaiter.Get()
  EventMgr.Instance.AnimAwaiterArise:Dispatch(self.awaiterAnimBegan, "SuperDimensionTimelineBegan")
end

function SuperDimensionTimelinePlayer:OnDimensionBoutEnd()
  self.awaiterAnimFinished = Awaiter.Get()
  EventMgr.Instance.AnimAwaiterArise:Dispatch(self.awaiterAnimFinished, "SuperDimensionTimelineEnded")
end

function SuperDimensionTimelinePlayer:OnBattleBoutAnimEnded()
  self:PlayTimeline(self.assetPath)
end

function SuperDimensionTimelinePlayer:_CheckPlayerUID()
  if not (DataCenter.playerData and DataCenter.playerData.DRole and DataCenter.playerData.DRole.uid) or DataCenter.playerData.DRole.uid <= 0 then
    return false
  end
  local uid = DataCenter.playerData.DRole.uid
  if 100400419 ~= uid and 100000050 ~= uid then
    return true
  end
  return false
end

return SuperDimensionTimelinePlayer
