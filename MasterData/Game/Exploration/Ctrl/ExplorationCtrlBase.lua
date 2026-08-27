local ExplorationCtrlBase = class("ExplorationCtrlBase")

function ExplorationCtrlBase:ctor(epCtrl)
  self.epCtrl = epCtrl
  table.insert(self.epCtrl.ctrls, self)
end

function ExplorationCtrlBase:OnDelete()
end

return ExplorationCtrlBase
