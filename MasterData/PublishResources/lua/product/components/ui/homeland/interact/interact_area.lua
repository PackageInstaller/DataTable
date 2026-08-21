_class("InteractArea", Object)
InteractArea = InteractArea

function InteractArea:Constructor(build, distance)
  self._build = build
  self.interactDistance = distance
  self.active = true
end

function InteractArea:Dispose()
end

function InteractArea:IsActive()
  return self.active
end

function InteractArea:SetActive(active)
  self.active = active
end

function InteractArea:GetBuild()
  return self._build
end

function InteractArea:InteractArea()
  if not self._build then
    return
  end
  self._build:EnterInteractArea()
end

function InteractArea:UnInteractArea()
  if not self._build then
    return
  end
  self._build:LeaveInteractArea()
end

function InteractArea:IsTrigger(pos)
  local interactPos = self:_GetInteractPosition()
  if not interactPos then
    return false
  end
  if not pos then
    return false
  end
  local distance = Vector3.Distance(interactPos, pos)
  return distance <= self.interactDistance
end

function InteractArea:_GetInteractPosition()
  if not self._build then
    return nil
  end
  return self._build:GetInteractAreaPosition()
end
