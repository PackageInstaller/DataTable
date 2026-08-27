local UIEventWeChatViewQRCode = class("UIEventWeChatViewQRCode", UIBaseWindow)
local base = UIBaseWindow

function UIEventWeChatViewQRCode:OnInit()
  UIUtil.AddButtonListener(self.ui.background, self, self.OnClickClose)
  UIUtil.HideTopStatus()
end

function UIEventWeChatViewQRCode:OnClickClose()
  self:Delete()
  UIUtil.ReShowTopStatus()
end

return UIEventWeChatViewQRCode
