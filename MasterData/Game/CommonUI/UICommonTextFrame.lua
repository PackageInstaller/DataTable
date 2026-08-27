local UICommonTextFrame = class("UICommonTextFrame", UIBaseWindow)
local base = UIBaseWindow

function UICommonTextFrame:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_background, self, self.OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.OnClickClose)
end

function UICommonTextFrame:SetWCScoreText(curScore, predictScore)
  if predictScore == nil then
    local str = self.ui.tex_Info:GetIndex(1, tostring(curScore))
    str = string.gsub(str, "\\n", "\n")
    self.ui.tex.text = str
  else
    local str = self.ui.tex_Info:GetIndex(0, tostring(curScore), tostring(predictScore))
    str = string.gsub(str, "\\n", "\n")
    self.ui.tex.text = str
  end
end

function UICommonTextFrame:OnClickClose()
  self:Delete()
end

function UICommonTextFrame:OnDelete()
  base.OnDelete(self)
end

return UICommonTextFrame
