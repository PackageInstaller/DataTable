require("base_state_node")
_class("UISimulate_FakeInput", CTestRobot_Base)
UISimulate_FakeInput = UISimulate_FakeInput

function UISimulate_FakeInput:Constructor(pManger, stUI, stFunction, ...)
  self.m_fakeParam = {
    ui = stUI,
    input = stFunction,
    args = {
      ...
    }
  }
end

function UISimulate_FakeInput:OnWorking()
  self:_HandleFakeEvent()
  return UISimulate_FakeInput.super.OnWorking(self)
end

function UISimulate_FakeInput:_HandleFakeEvent(...)
  self:PrintLog("FakeInput, UI = ", self.m_fakeParam.ui, ", Input = ", self.m_fakeParam.input)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.FakeInput, self.m_fakeParam)
end
