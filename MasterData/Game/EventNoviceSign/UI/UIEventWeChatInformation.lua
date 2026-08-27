local UIEventWeChatInformation = class("UIEventWeChatInformation", UIBaseWindow)
local base = UIBaseWindow

function UIEventWeChatInformation:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.OnClickBack)
  UIUtil.AddButtonListener(self.ui.background, self, self.OnClickBack)
  UIUtil.HideTopStatus()
end

function UIEventWeChatInformation:InitWeChatInfo(actNameStr)
  self.ui.tex_Title:SetIndex(0, actNameStr)
  self.ui.tex_Content.text = ConfigData:GetTipContent(12000)
end

function UIEventWeChatInformation:OnClickBack()
  self:Delete()
  UIUtil.ReShowTopStatus()
end

return UIEventWeChatInformation
