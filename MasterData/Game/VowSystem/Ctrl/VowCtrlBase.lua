local VowCtrlBase = {}
local VowCtrlBase = class("VowCtrlBase")

function VowCtrlBase:ctor(vowCtrl)
  self.vowCtrl = vowCtrl
  self.vowCtrl.ctrls[self] = true
end

function VowCtrlBase:Delete()
  self.vowCtrl.ctrls[self] = nil
end

return VowCtrlBase
