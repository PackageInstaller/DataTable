_class("FSMState", Object)
FSMState = FSMState

function FSMState:Constructor(stateType, stateMachine)
  self.stateType = stateType
  self.stateMachine = stateMachine
  self:OnInit()
end

function FSMState:GetStateType()
  return self.stateType
end

function FSMState:ChangeState(stateType, ...)
  if self.stateMachine then
    self.stateMachine:ChangeState(stateType, ...)
  end
end

function FSMState:SetMachine(stateMachine)
  if stateMachine == nil then
    if error then
      error(string.format("%s: set state machine is nil.", self.__cname))
    end
    return
  end
  self.stateMachine = stateMachine
end

function FSMState:Dispose()
  self:Exit()
  self:OnDispose()
  self.stateType = nil
  self.stateMachine = nil
end

function FSMState:TryEnter()
  return true
end

function FSMState:Enter(data)
end

function FSMState:Exit()
  self:OnStateFinish()
end

function FSMState:Excute(delta)
end

function FSMState:OnInit()
end

function FSMState:OnDispose()
end

function FSMState:SetStateFinishCallback(callback, sender)
  self.callback = callback
  self.sender = sender
end

function FSMState:OnStateFinish()
  if self.callback then
    self.callback(self.sender)
  end
end
