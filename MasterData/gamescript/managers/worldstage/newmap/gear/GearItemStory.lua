local GearItemStory, Super = System.NewClass("GearItemStory", GearItemBase)

function GearItemStory:OnTriggerChild(srvData)
  if nil == srvData then
    self:AfterTrigger()
    return
  end
  self:EndTriggering()
  local skipPlot = AvgStoryManager.Instance:IsSkipPlot()
  if srvData.data and srvData.data.plot and not skipPlot then
    self.curPlot = srvData.data.plot
    EventMgr.Instance.OnStoryStart:RegisterEvent(System.fn(self, self.OnStoryStart))
    EventMgr.Instance.OnStoryTail:RegisterEvent(System.fn(self, self.OnStoryEnd))
    EventMgr.Instance.GuideEvent:RegisterEvent(System.fn(self, self.OnGuideEvent))
    self.manager.parent.owner:PlayStory(self.curPlot)
  end
end

function GearItemStory:OnStoryStart(plot)
  if plot == self.curPlot then
    self.manager.parent:StopBGM()
    EventMgr.Instance.LostLifeAudio:Dispatch({play = false})
  end
end

function GearItemStory:OnStoryEnd(plot)
  if plot == self.curPlot then
    self:AfterTrigger()
    EventMgr.Instance.LostLifeAudio:Dispatch({play = true})
  end
  self.curPlot = nil
end

function GearItemStory:OnGuideEvent(guideEvent, guideData)
  if guideEvent == CommonDefine.GuideEvent.GearTrigger and self.curPlot then
    EventMgr.Instance.StopStory:Dispatch(self.curPlot)
    self.curPlot = nil
  end
end

function GearItemStory:GetGearTypeName()
  local skipPlot = AvgStoryManager.Instance:IsSkipPlot()
  if skipPlot then
    return ""
  else
    do return Super.GetGearTypeName end
    return Super.GetGearTypeName, self
  end
end

function GearItemStory:GetIconPath()
  local skipPlot = AvgStoryManager.Instance:IsSkipPlot()
  if skipPlot then
    return nil
  else
    do return Super.GetIconPath end
    return Super.GetIconPath, self
  end
end

function GearItemStory:AfterTrigger()
  Super.AfterTrigger(self)
  ProtoManager.Instance:ReqServer("WorldRequest", "OnGearClose", function(data)
  end, nil, self:GetUid())
  self.curPlot = nil
  self.manager.parent:PlayBGM()
end

function GearItemStory:Dispose()
  Super.Dispose(self)
  EventMgr.Instance.OnStoryStart:RemoveEvent(System.fn(self, self.OnStoryStart))
  EventMgr.Instance.OnStoryEnd:RemoveEvent(System.fn(self, self.OnStoryEnd))
end

return GearItemStory
