local UICADPAWarringWin = class("UICADPAWarringWin", UIBaseWindow)
local base = UIBaseWindow

function UICADPAWarringWin:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_background, self, self.CloseCADPAWarring)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.CloseCADPAWarring)
end

function UICADPAWarringWin:CloseCADPAWarring()
  self:Delete()
end

function UICADPAWarringWin:OnDelete()
  base.OnDelete(self)
end

return UICADPAWarringWin
