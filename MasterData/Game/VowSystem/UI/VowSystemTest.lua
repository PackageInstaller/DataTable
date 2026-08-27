local base = UIBaseWindow
local VowSystemTest = class("VowSystemTest", base)

function VowSystemTest:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_Clear, self, self._OnClickClear)
  UIUtil.AddButtonListener(self.ui.btn_Sample, self, self._OnClickSample)
  UIUtil.AddButtonListener(self.ui.btn_LifeGame, self, self._OnClickLifeGame)
  local homeWindow = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeWindow ~= nil then
    homeWindow:OpenOtherWin()
    self:SetFromWhichUI(eBaseWinFromWhere.home)
  end
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self._OnClickClose):SetTopStatusVisible(true):PushTopStatusDataToBackStack()
  UIUtil.SetTopStatusBtnShow(false, false)
end

function VowSystemTest:InitVowSystemTest(vowCtrl)
  self._vowCtrl = vowCtrl
end

function VowSystemTest:_OnClickClear()
  self._vowCtrl.vowCardCtrl:ClearVowCard()
end

function VowSystemTest:_OnClickSample()
  self._vowCtrl.vowCardCtrl:VowCardSampleText(self.ui.inputField.text)
end

function VowSystemTest:_OnClickLifeGame()
  self._vowCtrl.vowCardCtrl:GenGameOfLife()
end

function VowSystemTest:_OnClickClose()
  self:OnCloseWin()
  self:Delete()
end

function VowSystemTest:OnDelete()
  ControllerManager:DeleteController(ControllerTypeId.VowSystem)
  base.OnDelete(self)
end

return VowSystemTest
