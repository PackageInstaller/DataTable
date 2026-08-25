local MonsterTimelineRoot = "TimelineRoot/Skill/Monster/"
local TimelineConfig = System.NewClass("TimelineConfig")

function TimelineConfig:ctor()
  self:Reset()
end

TimelineConfig.TrackPlayMode = {
  Default = 0,
  PVE = 1,
  PVP = 2
}

function TimelineConfig:Reset()
  self.assetPath = nil
  self.direction = 0
  self.onEarlyTermination = nil
  self.looping = 0
  self.onComplete = nil
  self.onStarted = nil
  self.abortSignal = nil
  self.aceTarget = nil
  self.targets = nil
  self.playbackSpeed = 1.0
  self.onEvent = nil
  self.seekTime = 0
  self.controlChildrenTargetIndex = -1
  self.centerPosition = nil
  self.useSmoothTime = false
end

function TimelineConfig.CheckFinalDirection(path, direction)
  if TimelineConfig.IsMonsterTimeline(path) then
    if 0 == direction then
      direction = 1
    else
      direction = 0
    end
  end
  return direction
end

function TimelineConfig.IsMonsterTimeline(path)
  do return string.find, path end
  return string.find, path, MonsterTimelineRoot
end

function TimelineConfig.GetTimelineData(config, isLogError)
  local DT = bg.DT
  local aniTimelineCfg = DT.TimelineEventData[config.animFile] or {}
  local timelineData = aniTimelineCfg[config.castAnimation]
  if not timelineData then
    if isLogError or nil == isLogError then
      Logger.Error("%s找不到对应的Timeline文件%s", config.animFile, config.castAnimation)
    end
    timelineData = aniTimelineCfg.Attack
  end
  return timelineData
end

function TimelineConfig.GetAwakerDirection(awaker)
  do return awaker.GetTimelineDir end
  return awaker.GetTimelineDir, awaker
end

return TimelineConfig
