local base = require("Game.ActivityLobby.UI.Main.QuickEntrance.UINLbQuickEntranceItem")
local UINLbSGQuickEntranceItem = class("UINLbSGQuickEntranceItem", base)
local cs_MessageCommon = CS.MessageCommon

function UINLbSGQuickEntranceItem:OnInit()
  base.OnInit(self)
  UIUtil.AddButtonListener(self.ui.btn_Lock, self, self.OnClickLock)
end

function UINLbSGQuickEntranceItem:InitLbQuickEntranceItem(actionData)
  self._actionData = actionData
  self.ui.tex_TitleName.text = actionData:GetLbIntrctActionName()
  local id = actionData:GetLbIntrctActionId()
  self.ui.img_IconOff:SetIndex(id - 1)
  local needSprite = self.ui.img_IconOn:GetIndex(id - 1)
  local spriteState = self.ui.btn_Jump.spriteState
  spriteState.pressedSprite = needSprite
  self.ui.btn_Jump.spriteState = spriteState
  self:UpdLbQuickEntranceItemLock()
  self:UpdLbQuickEntranceItemBlueDot()
end

function UINLbSGQuickEntranceItem:OnClickLock()
  local tips = self._actionData:GetLbIntrctActionLockClickTip()
  if not string.IsNullOrEmpty(tips) then
    cs_MessageCommon.ShowMessageTips(tips)
  end
end

function UINLbSGQuickEntranceItem:UpdLbQuickEntranceItemLock()
  local isUnlock = self._actionData:IsLbIntrctEntiUnlock()
  self.ui.obj_Lock:SetActive(not isUnlock)
end

function UINLbSGQuickEntranceItem:OnDelete()
  base.OnDelete(self)
end

return UINLbSGQuickEntranceItem
