local UINChapterListItem = class("UINChapterListItem", UIBaseNode)
local base = UIBaseNode

function UINChapterListItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINChapterListItem:InitUINSectorChapterListItem(index)
  self.index = index
  self.ui.tex_Num.text = string.format("%02d", index)
end

function UINChapterListItem:SetMainChapter()
  self.ui.layout.padding.left = self.ui.padding
  self.ui.layout.padding.right = self.ui.padding
  self.ui.tex_Num.color = self.ui.big_fontColor
  self.ui.tex_Num.fontSize = self.ui.big_fontSize
end

function UINChapterListItem:SetSideChapter()
  self.ui.layout.padding.left = 0
  self.ui.layout.padding.right = 0
  self.ui.tex_Num.color = self.ui.small_fontColor
  self.ui.tex_Num.fontSize = self.ui.small_fontSize
end

function UINChapterListItem:SetChapterListItemRedDotOpen(bool)
  self.ui.obj_redDot:SetActive(bool)
end

function UINChapterListItem:OnDelete()
  base.OnDelete(self)
end

return UINChapterListItem
