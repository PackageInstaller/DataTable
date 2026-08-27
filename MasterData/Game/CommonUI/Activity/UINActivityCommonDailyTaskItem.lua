local UINActivityCommonDailyTaskItem = class("UINActivityCommonDailyTaskItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")

function UINActivityCommonDailyTaskItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_ItemClick, self, self.ClickConfirm)
  UIUtil.AddButtonListener(self.ui.btn_Refresh, self, self.ClickRefresh)
  self._itemPool = UIItemPool.New(UINBaseItemWithReceived, self.ui.uINBaseItemWithReceived)
  self.ui.uINBaseItemWithReceived:SetActive(false)
end

function UINActivityCommonDailyTaskItem:InitDailyTaskItem()
end

function UINActivityCommonDailyTaskItem:SetDailyTaskItemRef()
end

function UINActivityCommonDailyTaskItem:RefreshDailyTaskItem()
end

function UINActivityCommonDailyTaskItem:ClickRefresh()
end

function UINActivityCommonDailyTaskItem:ClickConfirm()
end

function UINActivityCommonDailyTaskItem:PlayDailyTaskItemAnim()
  if IsNull(self.ui.animNode) then
    return
  end
  self:__StopAnim()
  self.ui.animNode:DOFade(0, 0.35):From():SetDelay(0.15):SetLink(self.gameObject)
  self.ui.animNode.gameObject.transform:DOLocalMoveX(-15, 0.35):From():SetDelay(0.15):SetLink(self.gameObject)
end

function UINActivityCommonDailyTaskItem:__StopAnim()
  if IsNull(self.ui.animNode) then
    return
  end
  self.ui.animNode:DOComplete()
  self.ui.animNode.gameObject.transform:DOComplete()
end

function UINActivityCommonDailyTaskItem:OnDelete()
  self:__StopAnim()
  base.OnDelete(self)
end

return UINActivityCommonDailyTaskItem
