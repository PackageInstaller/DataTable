local WarChessCtrlBase = class("WarChessCtrlBase")

function WarChessCtrlBase:ctor(wcCtrl)
  self.wcCtrl = wcCtrl
  table.insert(self.wcCtrl.ctrls, self)
end

function WarChessCtrlBase:OnSceneUnload()
end

function WarChessCtrlBase:Delete()
end

return WarChessCtrlBase
