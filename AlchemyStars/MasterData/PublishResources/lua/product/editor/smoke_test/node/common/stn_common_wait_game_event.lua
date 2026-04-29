require("base_state_node")
_class("Common_WaitGameEvent", CTestRobot_Base)
Common_WaitGameEvent = Common_WaitGameEvent

function Common_WaitGameEvent:Constructor(pManger, nEventType, timeout)
  self.m_nEventType = nEventType
  self.m_callback = nil
  self.m_bEventTrigger = false
  if timeout then
    self._maxTimeoutMS = timeout * 0.001
  end
end

function Common_WaitGameEvent:OnBegin(...)
  self.m_nWaitStart = os.clock()
  self.m_bEventTrigger = false
  self:_AddListener()
  return Common_WaitGameEvent.super.OnBegin(self, ...)
end

function Common_WaitGameEvent:OnWorking()
  local isTimeout = self._maxTimeoutMS and os.clock() - self.m_nWaitStart > self._maxTimeoutMS or false
  if not self.m_bEventTrigger and not isTimeout then
    return false
  end
  return Common_WaitGameEvent.super.OnWorking(self)
end

function Common_WaitGameEvent:OnEnd(...)
  self:_RemoveListener()
  return Common_WaitGameEvent.super.OnEnd(self, ...)
end

function Common_WaitGameEvent:_AddListener()
  self.m_callback = GameHelper:GetInstance():CreateCallback(self._OnEvent, self)
  self.m_pGameCenter.EventDispatcher():AddCallbackListener(self.m_nEventType, self.m_callback)
end

function Common_WaitGameEvent:_RemoveListener()
  self.m_pGameCenter.EventDispatcher():RemoveCallbackListener(self.m_nEventType, self.m_callback)
end

function Common_WaitGameEvent:_OnEvent(...)
  self.m_bEventTrigger = true
  self:Log(self, "WaitEvent Trigger Event = ", self.m_nEventType)
end
