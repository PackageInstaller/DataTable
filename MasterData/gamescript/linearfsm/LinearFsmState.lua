local LinearFsmState = System.NewClass("LinearFsmState")

function LinearFsmState:ctor(entity)
  self.entity = entity
  self.isFinish = false
  self.isEntered = false
end

function LinearFsmState:SetParent(parent)
  self.parent = parent
end

function LinearFsmState:IsValid()
  return true
end

function LinearFsmState:CheckEnter()
  if self:IsEntered() then
    return false
  end
  return true
end

function LinearFsmState:Enter(...)
end

function LinearFsmState:CheckExit()
  if self.isFinish then
    return true
  end
end

function LinearFsmState:Exit()
  self.isEntered = false
end

function LinearFsmState:SetFinish()
  self.isFinish = true
  self:CheckNextImmediately()
end

function LinearFsmState:CheckNextImmediately()
  self.parent:UpdateStageFsm()
end

function LinearFsmState:Reset()
end

function LinearFsmState:DoEnter(...)
  self.isEntered = true
  self:Enter(...)
end

function LinearFsmState:IsEntered()
  return self.isEntered
end

function LinearFsmState:OnDestroy()
  self:Reset()
end

return LinearFsmState
