local UINStOTechLineItem = class("UINStOTechLineItem", UIBaseNode)
local base = UIBaseNode

function UINStOTechLineItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINStOTechLineItem:InitStOTechLineItem(startPos, endPos)
  local diffVec = endPos - startPos
  local x = math.abs(startPos.x - endPos.x)
  local y = math.abs(startPos.y - endPos.y)
  local sizeDelta, pivot
  if x > y then
    pivot = startPos.x > endPos.x and Vector2.New(1, 0.5) or Vector2.New(0, 0.5)
    sizeDelta = Vector2.New(x, 4)
  else
    pivot = startPos.y > endPos.y and Vector2.New(0.5, 1) or Vector2.New(0.5, 0)
    sizeDelta = Vector2.New(4, y)
  end
  self.transform.pivot = pivot
  self.transform.sizeDelta = sizeDelta
end

function UINStOTechLineItem:RefreshStOTechLineItem(valid)
  self.ui.img.color = valid and Color.white or Color.gray
end

function UINStOTechLineItem:OnDelete()
  base.OnDelete(self)
end

return UINStOTechLineItem
