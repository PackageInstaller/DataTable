local base = UIBaseNode
local UINDeliverySimulatorSelectTipItem = class("UINDeliverySimulatorSelectTipItem", base)

function UINDeliverySimulatorSelectTipItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINDeliverySimulatorSelectTipItem:InitDeliverySimulatorSelectTipItem(des)
  self.ui.tex_Des.text = des
end

function UINDeliverySimulatorSelectTipItem:OnDelete()
end

return UINDeliverySimulatorSelectTipItem
