local UIVowChangeNameDialog = class("UIVowChangeNameDialog", UIBaseWindow)
local base = UIBaseWindow
local UINChangeHeroName = require("Game.VowSystem.Dialog.UINChangeHeroName")

function UIVowChangeNameDialog:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_background, self, self.Cancle)
  self.ui.changeHeroName:SetActive(false)
  UIUtil.SetTopStatus(self, self.BackAction)
end

function UIVowChangeNameDialog:OpenChangeHeroNameDialog(heroId)
  UIUtil.HideTopStatus()
  if self.changeHeroName == nil then
    self.changeHeroName = UINChangeHeroName.New()
    self.changeHeroName.CloseFunction = BindCallback(self, self.Cancle)
    self.changeHeroName:Init(self.ui.changeHeroName)
  end
  self.changeHeroName:UpdateDialog(heroId)
  self.changeHeroName:Show()
end

function UIVowChangeNameDialog:SetVowCloseCallback(callback)
  self._closeCallback = callback
end

function UIVowChangeNameDialog:BackAction()
  if self._closeCallback ~= nil then
    self._closeCallback()
  end
  self:OnCloseWin()
  self:Delete()
end

function UIVowChangeNameDialog:Cancle()
  UIUtil.OnClickBackByUiTab(self)
end

function UIVowChangeNameDialog:OnShow()
  base.OnShow(self)
  AudioManager:PlayAudioById(1066)
end

function UIVowChangeNameDialog:OnDelete()
  UIUtil.ReShowTopStatus()
  if self.changeHeroName ~= nil then
    self.changeHeroName:Delete()
  end
  base.OnDelete(self)
end

return UIVowChangeNameDialog
