local PortraitTimelinePlayer, Super = System.NewClass("PortraitTimelinePlayer", TimelinePlayer)

function PortraitTimelinePlayer:ctor(player)
  Super.ctor(self, player)
  self.pauseWhilePreparingVideo = true
end

function PortraitTimelinePlayer:OnTLEvent(eventId, eventParam)
  Super.OnTLEvent(self, eventId, eventParam)
  if eventId == rc.TimeLineEvent.SwitchPortrait and self.SwitchPortraitCall then
    self.SwitchPortraitCall()
  end
end

function PortraitTimelinePlayer:SetSwitchPortraitCall(func)
  self.SwitchPortraitCall = func
end

function PortraitTimelinePlayer:Dispose()
  Super.Dispose(self)
  self.SwitchPortraitCall = nil
end

return PortraitTimelinePlayer
