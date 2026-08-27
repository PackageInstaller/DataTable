local base = UIBaseNode
local UINLbQuickEntranceItem = class("UINLbQuickEntranceItem", base)

function UINLbQuickEntranceItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Jump, self, self._OnClickJump)
end

function UINLbQuickEntranceItem:InitLbQuickEntranceItem(actionData)
  self._actionData = actionData
  self.ui.tex_TitlleName.text = actionData:GetLbIntrctActionName()
  self.ui.tex_Des.text = actionData:GetLbIntrctActionSubName()
  self:UpdLbQuickEntranceItemLock()
  self:UpdLbQuickEntranceItemBlueDot()
end

function UINLbQuickEntranceItem:UpdLbQuickEntranceItemLock()
  local isUnlock = self._actionData:IsLbIntrctEntiUnlock()
  self.ui.obj_Lock:SetActive(not isUnlock)
  if not isUnlock then
    self.ui.tex_Lock:SetIndex(self._actionData:GetLbIntrctActionLockStateDes())
  end
end

function UINLbQuickEntranceItem:UpdLbQuickEntranceItemBlueDot()
  self.ui.blueDot:SetActive(self._actionData:IsShowLbIntrctActionBluedot())
end

function UINLbQuickEntranceItem:_OnClickJump()
  if self._actionData ~= nil then
    self._actionData:InvokeLbIntrctAction(true)
  end
end

function UINLbQuickEntranceItem:OnDelete()
  base.OnDelete(self)
end

return UINLbQuickEntranceItem
