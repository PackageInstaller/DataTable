local UIDungeonTowerSuccess = class("UIDungeonTowerSuccess", UIBaseWindow)
local base = UIBaseWindow

function UIDungeonTowerSuccess:OnInit()
  UIUtil.Push2BackStack(self, self.OnBtnCloseClick)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.OnClickClose)
end

function UIDungeonTowerSuccess:InitDunTowerNounUnlock(unlockName)
  self.ui.tex_Condition.text = string.format(ConfigData:GetTipContent(970), unlockName)
end

function UIDungeonTowerSuccess:SetBtnCloseAction(action)
  self.onBtnCloseAction = action
end

function UIDungeonTowerSuccess:OnClickClose()
  UIUtil.OnClickBackByUiTab(self)
end

function UIDungeonTowerSuccess:OnBtnCloseClick()
  if self.onBtnCloseAction ~= nil then
    local bindFunc = self.onBtnCloseAction
    self.onBtnCloseActio = nil
    bindFunc()
  end
  self:Delete()
end

function UIDungeonTowerSuccess:OnDelete()
  base.OnDelete(self)
end

return UIDungeonTowerSuccess
