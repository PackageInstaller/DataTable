require("stn_ui_simulate_fake_input")
_class("UISimulate_FakeInputWithReturnParam", UISimulate_FakeInput)
UISimulate_FakeInputWithReturnParam = UISimulate_FakeInputWithReturnParam

function UISimulate_FakeInputWithReturnParam:_HandleFakeEvent(...)
  if type(self.m_pRunData) == "table" then
    self.m_fakeParam.args = self.m_pRunData
  else
    self.m_fakeParam.args = {
      self.m_pRunData
    }
  end
  self:PrintLog("FakeInput, UI = ", self.m_fakeParam.ui, ", Input = ", self.m_fakeParam.input)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.FakeInput, self.m_fakeParam)
end
