local AIStateBase = class("AIStateBase")
AIStateBase.AIExecuteState = {
  Init = 0,
  Runnig = 1,
  Fail = 2,
  End = 4
}

function AIStateBase:ctor(aiCtrl, actionCfg, exitAction)
  self.duration = 0
  self.exeState = AIStateBase.AIExecuteState.Init
  self.aiCtrl = aiCtrl
  self.actionCfg = actionCfg
  self.exitAction = exitAction
end

function AIStateBase:SetStateDuration(duration)
  self.duration = duration
end

function AIStateBase:StartState()
end

function AIStateBase:InterruptState(gotoNext)
end

function AIStateBase:StartExitWait(action, ...)
end

function AIStateBase:EnableExitState()
  return true
end

function AIStateBase:GetStateName()
  return ""
end

function AIStateBase:OnExit()
  self.exeState = AIStateBase.AIExecuteState.End
end

function AIStateBase:ExitByWaitAction(action)
  local autoNext = true
  if action ~= nil then
    autoNext = false
  end
  if self.exitAction ~= nil then
    self.exitAction(self, autoNext)
  end
  if action ~= nil then
    action(true)
  end
end

function AIStateBase:OnUpdate()
end

return AIStateBase
