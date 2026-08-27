local UIN3DFormationWarningNode = class("UIN3DFormationWarningNode", UIBaseNode)
local base = UIBaseNode

function UIN3DFormationWarningNode:ctor(fmtCtrl)
  self.fmtCtrl = fmtCtrl
end

function UIN3DFormationWarningNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UIN3DFormationWarningNode:OpenWarningTip4WcLevel()
  self.ui.twinkle:SetActive(true)
  self.ui.warningOutLine.color = self.ui.color_red
  self.ui.warningInside.color = self.ui.color_red
  self.ui.tex_warningDes:SetIndex(0)
end

function UIN3DFormationWarningNode:OpenWarningTip4SectorIIMultEffic()
  self.ui.twinkle:SetActive(false)
  self.ui.warningOutLine.color = self.ui.color_yellow
  self.ui.warningInside.color = self.ui.color_yellow
  self.ui.tex_warningDes:SetIndex(1)
end

function UIN3DFormationWarningNode:OnDelete()
  base.OnDelete(self)
end

return UIN3DFormationWarningNode
