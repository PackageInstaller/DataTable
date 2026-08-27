local UICJResult = class("UICJResult", UIBaseWindow)
local base = UIBaseWindow

function UICJResult:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_Back, self, self.__OnBtnClick)
end

function UICJResult:InitCJResult(isWin, clickAction)
  self:RefeshWinUI(isWin)
  self:SetClickAction(clickAction)
end

function UICJResult:RefeshWinUI(isWin)
  self.ui.img_Bg.color = isWin and self.ui.col_Blue or self.ui.col_Red
  self.ui.Img_Result:SetIndex(isWin and 0 or 1)
  self.ui.tex_Result:SetIndex(isWin and 0 or 1)
end

function UICJResult:SetClickAction(clickAction)
  self.clickAction = clickAction
end

function UICJResult:__OnBtnClick()
  if self.clickAction ~= nil then
    self.clickAction()
  end
  self:Delete()
end

function UICJResult:OnDelete()
  base.OnDelete(self)
end

return UICJResult
