local UINActivityCommonTermTaskItem = class("UINActivityCommonTermTaskItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")

function UINActivityCommonTermTaskItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_ItemClick, self, self.OnClickConfirm)
  self._itemPool = UIItemPool.New(UINBaseItemWithReceived, self.ui.rewardItem)
  self.ui.rewardItem:SetActive(false)
end

function UINActivityCommonTermTaskItem:InitTermTaskItem()
end

function UINActivityCommonTermTaskItem:RefreshTermTaskItem()
end

function UINActivityCommonTermTaskItem:__RefreshFill()
end

function UINActivityCommonTermTaskItem:__RefreshPickConfirmBtn()
end

function UINActivityCommonTermTaskItem:__RefreshConfirmBtn()
end

function UINActivityCommonTermTaskItem:OnClickConfirm()
end

function UINActivityCommonTermTaskItem:TaskClick()
end

function UINActivityCommonTermTaskItem:PlayTermTaskAnim()
  if IsNull(self.ui.animNode) then
    return
  end
  self:__StopAnim()
  local delayTime = self.index * 0.05 + 0.05
  self.ui.animNode:DOFade(0, 0.25):From():SetDelay(delayTime):SetLink(self.gameObject)
  self.ui.animNode.gameObject.transform:DOLocalMoveX(-15, 0.25):From():SetDelay(delayTime):SetLink(self.gameObject)
end

function UINActivityCommonTermTaskItem:__StopAnim()
  if IsNull(self.ui.animNode) then
    return
  end
  self.ui.animNode:DOComplete()
  self.ui.animNode.gameObject.transform:DOComplete()
end

function UINActivityCommonTermTaskItem:OnDelete()
  self._itemPool:DeleteAll()
  base.OnDelete(self)
end

return UINActivityCommonTermTaskItem
