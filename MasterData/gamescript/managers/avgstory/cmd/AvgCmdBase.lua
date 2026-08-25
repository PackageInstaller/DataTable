local AvgCmdBase, Super = System.NewClass("AvgCmdBase")

function AvgCmdBase:ctor(cmdComp, params)
  Super.ctor(self)
  self.cmdComp = cmdComp
  self.params = params
end

function AvgCmdBase:Awake()
end

function AvgCmdBase:Pause()
  self.isPaused = true
end

function AvgCmdBase:Finish()
  self.isPaused = nil
  if self.cmdComp then
    self.cmdComp:ExecuteNextCmd()
  end
end

function AvgCmdBase:OnDestroy()
  self.cmdComp = nil
end

return AvgCmdBase
