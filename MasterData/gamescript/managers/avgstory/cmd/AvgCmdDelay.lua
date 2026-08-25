local AvgCmdDelay, Super = System.NewClass("AvgCmdDelay", AvgCmdBase)

function AvgCmdDelay:Awake()
  self:Pause()
end

function AvgCmdDelay:OnDestroy()
  Super.OnDestroy(self)
  TimerManager.Instance:StopTimer(self.delayTimer)
end

return AvgCmdDelay
