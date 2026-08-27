local UIShowCharacter = class("UIShowCharacter", UIBaseWindow)
local base = UIBaseWindow

function UIShowCharacter:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_Return, self, self.ExitButtonClicked)
  self.ctrl = ControllerManager:GetController(ControllerTypeId.ShowCharacter, true)
  UIUtil.SetTopStatus(self, self.BackAction, nil, nil, nil, true)
end

function UIShowCharacter:InitSettingGraph()
end

function UIShowCharacter:BackAction()
  self.ctrl:ExitShowCharacter()
end

function UIShowCharacter:ExitButtonClicked()
  UIUtil.OnClickBackByUiTab(self)
end

function UIShowCharacter:OnDelete()
  self.ctrl = nil
  base.OnDelete(self)
end

return UIShowCharacter
