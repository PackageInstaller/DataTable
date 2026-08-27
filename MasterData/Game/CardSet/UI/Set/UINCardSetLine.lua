local UINCardSetLine = class("UINCardSetLine", UIBaseNode)
local base = UIBaseNode
local cs_Ease = CS.DG.Tweening.Ease

function UINCardSetLine:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINCardSetLine:SetCardSetLineWidth(width)
  self.ui.layoutEle.ignoreLayout = false
  self.ui.layoutEle.preferredWidth = width
end

function UINCardSetLine:PlayIntroTween(index)
  self.ui.layoutEle:DOComplete()
  self.ui.layoutEle:DOPreferredSize(Vector2.New(1200, 0), 0.5, true):From():SetEase(cs_Ease.OutExpo):SetLink(self.gameObject):SetDelay(0.2 + index * 0.05)
end

function UINCardSetLine:SetCardSetLineEnd()
  self.ui.layoutEle.ignoreLayout = true
end

function UINCardSetLine:OnDelete()
  base.OnDelete(self)
end

return UINCardSetLine
