local UINWATechLine = class("UINWATechLine", UIBaseNode)
local base = UIBaseNode

function UINWATechLine:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINWATechLine:InitWALineItem(preTechItem, techItem)
  local startPos = preTechItem.transform.anchoredPosition
  local endPos = techItem.transform.anchoredPosition
  local techItemSize = techItem.transform.sizeDelta
  local sizeDelta = Vector2.New(4, math.abs(endPos.y - startPos.y) - techItemSize.y)
  self.transform.sizeDelta = sizeDelta
  self.transform.anchoredPosition = Vector2.New(startPos.x + techItemSize.x / 2, startPos.y - techItemSize.y)
end

function UINWATechLine:OnDelete()
  base.OnDelete(self)
end

return UINWATechLine
