local UINFmtCardItemTag = class("UINFmtCardItemTag", UIBaseNode)
local base = UIBaseNode

function UINFmtCardItemTag:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINFmtCardItemTag:InitTag(oriVal, nowVal, textIndex)
  local scale = self.ui.img_arrow.localScale
  scale.y = nowVal < oriVal and 1 or -1
  self.ui.img_arrow.localScale = scale
  self.ui.tex_Sync:SetIndex(textIndex)
end

return UINFmtCardItemTag
