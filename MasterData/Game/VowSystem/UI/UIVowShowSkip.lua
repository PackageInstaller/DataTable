local UIVowShowSkip = class("UIVowShowSkip", UIBaseWindow)
local base = UIBaseWindow

function UIVowShowSkip:OnInit()
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.__BackAction):PushTopStatusDataToBackStack()
  self.ui.tex_Title.text = ConfigData:GetTipContent(23015)
  self.ui.tex_Content.text = ConfigData:GetTipContent(23016)
  self.ui.text_Tip.text = ConfigData:GetTipContent(23017)
  UIUtil.AddButtonListener(self.ui.btn_Cancel, self, self.__OnClickCancle)
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self.__OnClickConfirm)
end

function UIVowShowSkip:InitVowShowSkip(confirmFunc, cancleFunc)
  self._confirmFunc = confirmFunc
  self._cancleFunc = cancleFunc
end

function UIVowShowSkip:__OnClickCancle()
  if self._cancleFunc ~= nil then
    self._cancleFunc()
  end
  UIUtil.OnClickBackByUiTab(self)
end

function UIVowShowSkip:__OnClickConfirm()
  if self._confirmFunc ~= nil then
    self._confirmFunc()
  end
  UIUtil.OnClickBackByUiTab(self)
end

function UIVowShowSkip:__BackAction()
  self:Delete()
end

return UIVowShowSkip
