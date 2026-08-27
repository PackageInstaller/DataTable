local SectorCtrlBase = class("SectorCtrlBase")

function SectorCtrlBase:ctor(sectorCtrl)
  self.sctCtrl = sectorCtrl
  table.insert(self.sctCtrl.ctrls, self)
end

function SectorCtrlBase:OnDelete()
end

return SectorCtrlBase
