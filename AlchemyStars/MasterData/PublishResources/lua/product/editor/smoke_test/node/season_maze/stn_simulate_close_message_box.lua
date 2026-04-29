require("base_state_node")
_class("UISimulate_CloseMessageBox", CTestRobot_Base)
UISimulate_CloseMessageBox = UISimulate_CloseMessageBox

function UISimulate_CloseMessageBox:Constructor(pManger, stUI, stFunction, ...)
  self.m_fakeParam = {
    ui = stUI,
    input = stFunction,
    args = {
      ...
    }
  }
end

function UISimulate_CloseMessageBox:OnWorking()
  self:_HandleFakeEvent()
  return UISimulate_CloseMessageBox.super.OnWorking(self)
end

function UISimulate_CloseMessageBox:_HandleFakeEvent(...)
  local popup = Popup:New("UICommonMessageBox", 1, ...)
  GameGlobal.UIStateManager():ClosePopup(popup)
end
