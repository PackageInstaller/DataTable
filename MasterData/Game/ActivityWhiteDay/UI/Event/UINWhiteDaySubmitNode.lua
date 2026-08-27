local UINWhiteDaySubmitNode = class("UINWhiteDaySubmitNode", UIBaseNode)
local base = UIBaseNode

function UINWhiteDaySubmitNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINWhiteDaySubmitNode:InitWDSubmitNode(AWDCtrl, AWDLineData)
  self.AWDCtrl = AWDCtrl
  self.AWDLineData = AWDLineData
end

function UINWhiteDaySubmitNode:OnDelete()
  base.OnDelete(self)
end

return UINWhiteDaySubmitNode
