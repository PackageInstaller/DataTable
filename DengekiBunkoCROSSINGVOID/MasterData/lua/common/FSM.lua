local FSM = {state = "", nextState = ""}

function FSM:Invoke(funcName)
  local func = rawget(self, funcName)
  if func ~= nil then
    func(self)
  end
end

function FSM:Update()
  if self.nextState ~= self.state then
    self:Invoke("Leave" .. self.state)
    self.state = self.nextState
    self:Invoke("Enter" .. self.state)
  else
    self:Invoke("Update" .. self.state)
  end
end

function FSM:ChangeState(fromState, newState)
  if fromState == "" or fromState == self.state then
    self.nextState = newState
    return true
  end
end

function FSM:new()
  return setmetatable({}, {__index = self})
end

return FSM
