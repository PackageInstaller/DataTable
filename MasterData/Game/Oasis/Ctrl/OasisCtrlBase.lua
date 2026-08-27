local OasisCtrlBase = class("OasisCtrlBase")

function OasisCtrlBase:ctor(oasisCtrl)
  self.oasisCtrl = oasisCtrl
  table.insert(self.oasisCtrl.ctrls, self)
end

function OasisCtrlBase:OnDelete()
end

return OasisCtrlBase
