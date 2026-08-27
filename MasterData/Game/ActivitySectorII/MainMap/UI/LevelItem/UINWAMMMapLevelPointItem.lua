local UINWAMMMapLevelPointItem = class("UINWAMMMapLevelPointItem", UIBaseNode)
local base = UIBaseNode

function UINWAMMMapLevelPointItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINWAMMMapLevelPointItem:InitLevelPointItem(isBattle, index)
  self.ui.tex_Point.text = tostring(index)
  self.ui.obj_img_Line:SetActive(true)
  self.ui.img_Line.enabled = false
end

function UINWAMMMapLevelPointItem:PlayOnSelectTween(isBattle)
  self.ui.tween_animaNode:DOPlayForward()
  self.ui.img_Line.enabled = true
end

function UINWAMMMapLevelPointItem:PlayOnCancleSelectTween()
  self.ui.tween_animaNode:DOPlayBackwards()
  self.ui.img_Line.enabled = false
end

function UINWAMMMapLevelPointItem:SetArrowSprites(isClear, isHard)
  if isClear then
    self.ui.img_Dis:SetIndex(0)
  elseif isHard then
    self.ui.img_Dis:SetIndex(2)
  else
    self.ui.img_Dis:SetIndex(1)
  end
end

function UINWAMMMapLevelPointItem:OnDelete()
  base.OnDelete(self)
end

return UINWAMMMapLevelPointItem
