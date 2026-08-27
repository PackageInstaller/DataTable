local FormationCtrlBase = class("FormationCtrlBase")

function FormationCtrlBase:ctor(fmtCtrl)
  self.fmtCtrl = fmtCtrl
  table.insert(self.fmtCtrl.ctrls, self)
end

function FormationCtrlBase:OnDelete()
end

return FormationCtrlBase
