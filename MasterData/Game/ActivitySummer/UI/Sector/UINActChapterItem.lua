local UINActChapterItem = class("UINActChapterItem", UIBaseNode)
local base = UIBaseNode

function UINActChapterItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINActChapterItem:InitActChapterItem(idx, posList)
  local index = idx - 1
  self.ui.tex_Chapter:SetIndex(index)
  self.ui.tex_State:SetIndex(index)
  local hasData = 2 <= #posList
  if hasData then
    local pos = Vector2.New(posList[1], posList[2])
    self:SetAnchorPos(pos)
  else
    self:Hide()
  end
end

function UINActChapterItem:SetAnchorPos(vector2Pos)
  self.transform.anchoredPosition = vector2Pos
end

function UINActChapterItem:OnDelete()
  base.OnDelete(self)
end

return UINActChapterItem
