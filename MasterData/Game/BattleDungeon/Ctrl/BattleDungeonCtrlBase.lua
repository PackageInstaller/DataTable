local BattleDungeonCtrlBase = class("BattleDungeonCtrlBase")

function BattleDungeonCtrlBase:ctor(bdCtrl)
  self.bdCtrl = bdCtrl
  table.insert(self.bdCtrl.ctrls, self)
end

function BattleDungeonCtrlBase:OnDelete()
end

return BattleDungeonCtrlBase
