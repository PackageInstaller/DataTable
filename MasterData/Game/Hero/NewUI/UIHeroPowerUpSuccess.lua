local UIHeroPowerUpSuccess = class("UIHeroPowerUpSuccess", UIBaseWindow)
local base = UIBaseWindow

function UIHeroPowerUpSuccess:OnInit()
  local data = UIUtil.Push2BackStack(self, self.OnBtnCloseClicked)
  data:SetTopStatusVisible(false)
  UIUtil.RefreshTopStatus()
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.OnClickClose)
end

function UIHeroPowerUpSuccess:InitHeroPowerUpSuccess(lastHeroPower, curHeroPower)
  self.ui.uiAdapter:AdaptBgUI()
  self.ui.tex_OldPower.text = tostring(lastHeroPower)
  self.ui.tex_NewPower.text = tostring(curHeroPower)
  AudioManager:PlayAudioById(1076)
end

function UIHeroPowerUpSuccess:SetBackClickAction(clickAction)
  self.__clickAction = clickAction
end

function UIHeroPowerUpSuccess:OnClickClose()
  UIUtil.OnClickBackByUiTab(self)
end

function UIHeroPowerUpSuccess:OnBtnCloseClicked()
  if self.__clickAction ~= nil then
    local bindfunc = self.__clickAction
    self.__clickAction = nil
    bindfunc()
  end
  self:Delete()
end

function UIHeroPowerUpSuccess:OnDelete()
  base.OnDelete(self)
end

return UIHeroPowerUpSuccess
