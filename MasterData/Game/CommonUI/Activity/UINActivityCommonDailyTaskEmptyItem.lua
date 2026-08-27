local UINActivityCommonDailyTaskEmptyItem = class("UINActivityCommonDailyTaskEmptyItem", UIBaseNode)
local base = UIBaseNode

function UINActivityCommonDailyTaskEmptyItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINActivityCommonDailyTaskEmptyItem:InitDailyTaskEmptyItem()
end

function UINActivityCommonDailyTaskEmptyItem:SetTaskNextShowTex()
end

function UINActivityCommonDailyTaskEmptyItem:PlayDailyTaskEmptyItemAnim()
  if IsNull(self.ui.animNode) then
    return
  end
  self:__StopAnim()
  self.ui.animNode:DOFade(0, 0.35):From():SetDelay(0.15):SetLink(self.gameObject)
  self.ui.animNode.gameObject.transform:DOLocalMoveX(-15, 0.35):From():SetDelay(0.15):SetLink(self.gameObject)
end

function UINActivityCommonDailyTaskEmptyItem:__StopAnim()
  if IsNull(self.ui.animNode) then
    return
  end
  self.ui.animNode:DOComplete()
  self.ui.animNode.gameObject.transform:DOComplete()
end

function UINActivityCommonDailyTaskEmptyItem:OnDelete()
  self:__StopAnim()
  base.OnDelete(self)
end

return UINActivityCommonDailyTaskEmptyItem
