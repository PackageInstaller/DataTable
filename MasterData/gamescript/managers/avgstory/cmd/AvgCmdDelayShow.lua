local AvgCmdDelayShow, Super = System.NewClass("AvgCmdDelayShow")

function AvgCmdDelayShow:ctor(cmdComp, params)
  Super.ctor(self)
  self.cmdComp = cmdComp
  self.params = params
end

function AvgCmdDelayShow:Awake()
end

function AvgCmdDelayShow:Pause()
end

function AvgCmdDelayShow:Finish()
end

function AvgCmdDelayShow:OnDestroy()
  self.cmdComp = nil
end

return AvgCmdDelayShow
