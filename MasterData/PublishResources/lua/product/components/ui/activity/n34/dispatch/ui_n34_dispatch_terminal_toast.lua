_class("UIN34DispatchTerminalToast", UIController)
UIN34DispatchTerminalToast = UIN34DispatchTerminalToast

function UIN34DispatchTerminalToast:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UIN34DispatchTerminalToast:OnShow(uiParams)
  self.status = uiParams[1]
  self:InitWidget()
  self:SetTipsText()
end

function UIN34DispatchTerminalToast:InitWidget()
  self.tip = self:GetUIComponent("UILocalizationText", "Tip")
  self.tip2 = self:GetUIComponent("UILocalizationText", "Tip2")
end

function UIN34DispatchTerminalToast:SetTipsText()
  if self.status == N34TerminalItemStatus.NotStart then
    self.tip:SetText(StringTable.Get("str_n34_dispatch_toast_tips"))
    self.tip2:SetText(StringTable.Get("str_n34_dispatch_toast_tips_2"))
  elseif self.status == N34TerminalItemStatus.Unlock then
    self.tip:SetText(StringTable.Get("str_n34_dispatch_toast_tips_3"))
    self.tip2:SetText(StringTable.Get("str_n34_dispatch_toast_tips_4"))
  elseif self.status == N34TerminalItemStatus.Going then
    self.tip:SetText(StringTable.Get("str_n34_dispatch_toast_tips_5"))
    self.tip2:SetText(StringTable.Get("str_n34_dispatch_toast_tips_6"))
  end
end

function UIN34DispatchTerminalToast:BGOnClick(go)
  self:CloseDialog()
end
