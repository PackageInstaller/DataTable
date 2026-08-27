local UINAthDetailSuitItem = class("UINAthDetailSuitItem", UIBaseNode)
local base = UIBaseNode

function UINAthDetailSuitItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINAthDetailSuitItem:InitAthDetailSuitItem(curNum, suitNum, intro)
  self.ui.tex_Collect:SetIndex(0, tostring(suitNum))
  self.ui.tex_Intro.text = intro
  if suitNum <= curNum then
    self.ui.img_Collect.color = self.ui.color_ValidBg
    self.ui.tex_Collect.text.color = Color.white
  else
    self.ui.img_Collect.color = self.ui.color_InvalidBg
    self.ui.tex_Collect.text.color = Color.black
  end
end

function UINAthDetailSuitItem:OnDelete()
  base.OnDelete(self)
end

return UINAthDetailSuitItem
