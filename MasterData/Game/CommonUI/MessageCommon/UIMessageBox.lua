local UIMessageBox = class("UIMessageBox", UIBaseWindow)
local base = UIBaseWindow

function UIMessageBox:OnInit()
  self.__permanent = true
  UIUtil.AddButtonListener(self.ui.btnClose, self, self.OnClickClose)
  UIUtil.AddButtonListener(self.ui.buttonConfirm, self, self.OnClickConfirm)
  UIUtil.AddButtonListener(self.ui.buttonNo, self, self.OnClickNo)
  UIUtil.AddButtonListener(self.ui.buttonYes, self, self.OnClickYes)
end

function UIMessageBox:_Reset()
  self.ui.textNode:SetActive(false)
  self.ui.yesNoNode:SetActive(false)
  self.ui.btnClose.gameObject:SetActive(false)
  self.ui.buttonConfirm.gameObject:SetActive(false)
  self.ui.buttonYes.interactable = true
end

function UIMessageBox:ShowTextBox(msg)
  self:_Reset()
  local hasMsg = msg ~= nil
  self.ui.textNode:SetActive(hasMsg)
  self.ui.tex_Content.text = msg
  self.ui.yesNoNode:SetActive(false)
  self.ui.buttonConfirm.gameObject:SetActive(false)
  self.ui.btnClose.gameObject:SetActive(false)
end

function UIMessageBox:ShowTextBoxWithConfirm(msg, comfirmFunc)
  self:_Reset()
  self:ShowTextBox(msg)
  self.ui.buttonConfirm.gameObject:SetActive(true)
  self.confirmFunc = comfirmFunc
end

function UIMessageBox:ShowTextBoxWithClose(msg, closeFunc)
  self:_Reset()
  self:ShowTextBox(msg)
  self.ui.btnClose.gameObject:SetActive(true)
  self.closeFunc = closeFunc
end

function UIMessageBox:ShowTextBoxWithYesAndNo(msg, yesFunc, noFunc, withYesWait)
  self:_Reset()
  self:ShowTextBox(msg)
  self.ui.yesNoNode:SetActive(true)
  self.yesFunc = yesFunc
  self.noFunc = noFunc
end

function UIMessageBox:_ClearBtnYesTimer()
  if self._btnYesTimerId == nil then
    return
  end
  TimerManager:StopTimer(self._btnYesTimerId)
  self._btnYesTimerId = nil
end

function UIMessageBox:OnClickClose()
  self:Hide()
  if self.closeFunc ~= nil then
    local func = self.closeFunc
    self.closeFunc = nil
    func()
  end
end

function UIMessageBox:OnClickConfirm()
  self:Hide()
  if self.confirmFunc ~= nil then
    local func = self.confirmFunc
    self.confirmFunc = nil
    func()
  end
  if self.dontRemindFunc ~= nil then
    local func = self.dontRemindFunc
    self.dontRemindFunc = nil
    func(self.ui.tog_RemindSwitch.isOn)
  end
end

function UIMessageBox:OnClickNo()
  self:Hide()
  if self.noFunc ~= nil then
    local func = self.noFunc
    self.noFunc = nil
    self.yesFunc = nil
    func()
  end
end

function UIMessageBox:OnClickYes()
  self:Hide()
  if self.yesFunc ~= nil then
    local func = self.yesFunc
    self.yesFunc = nil
    self.noFunc = nil
    func()
  end
  if self.dontRemindFunc ~= nil then
    local func = self.dontRemindFunc
    self.dontRemindFunc = nil
    func(self.ui.tog_RemindSwitch.isOn)
  end
end

function UIMessageBox:OnHide()
  self:_ClearBtnYesTimer()
  base.OnHide(self)
end

function UIMessageBox:OnDelete()
  base.OnDelete(self)
end

return UIMessageBox
