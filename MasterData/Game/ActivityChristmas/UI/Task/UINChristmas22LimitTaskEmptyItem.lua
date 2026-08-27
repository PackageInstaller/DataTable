local UINChristmas22LimitTaskEmptyItem = class("UINChristmas22LimitTaskEmptyItem", UIBaseNode)
local base = UIBaseNode

function UINChristmas22LimitTaskEmptyItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINChristmas22LimitTaskEmptyItem:SetTaskNextShowTex(str)
  self.ui.tex_Timer.text = str
end

function UINChristmas22LimitTaskEmptyItem:PlayChristmas22LimitTaskEmptyItemAnim()
  if IsNull(self.ui.animNode) then
    return
  end
  self:__StopAnim()
  self.ui.animNode:DOFade(0, 0.35):From():SetDelay(0.15):SetLink(self.gameObject)
  self.ui.animNode.gameObject.transform:DOLocalMoveX(-15, 0.35):From():SetDelay(0.15):SetLink(self.gameObject)
end

function UINChristmas22LimitTaskEmptyItem:__StopAnim()
  if IsNull(self.ui.animNode) then
    return
  end
  self.ui.animNode:DOComplete()
  self.ui.animNode.gameObject.transform:DOComplete()
end

function UINChristmas22LimitTaskEmptyItem:OnDelete()
  self:__StopAnim()
end

return UINChristmas22LimitTaskEmptyItem
