_class("AirActionExecutor", Object)
AirActionExecutor = AirActionExecutor

function AirActionExecutor:Constructor(aircraftMain)
  self._actions = ArrayList:New()
  self._needAdd = {}
  self._needRemoveIdxs = {}
  self._aircraftMain = aircraftMain
end

function AirActionExecutor:Init()
end

function AirActionExecutor:Update(deltaTimeMS)
  if #self._needAdd > 0 then
    for _, action in ipairs(self._needAdd) do
      self._actions:PushBack(action)
    end
    self._needAdd = {}
  end
  for idx, a in ipairs(self._actions.elements) do
    local action = a
    if self:CheckOver(idx, action) then
    else
      action:Update(deltaTimeMS)
      self:CheckOver(idx, action)
    end
  end
  if 0 < #self._needRemoveIdxs then
    for _, idx in ipairs(self._needRemoveIdxs) do
      self._actions:RemoveAt(idx)
    end
    self._needRemoveIdxs = {}
  end
end

function AirActionExecutor:CheckOver(idx, action)
  if action:IsOver() then
    self._needRemoveIdxs[#self._needRemoveIdxs + 1] = idx
    return true
  end
  return false
end

function AirActionExecutor:Dispose()
  self._actions:ForEach(function(a)
    local action = a
    action:Dispose()
  end)
  self._actions:Clear()
  self._actions = nil
  self._aircraftMain = nil
end

function AirActionExecutor:StartAction(action)
  action:Start()
  self._needAdd[#self._needAdd + 1] = action
end

function AirActionExecutor:GetActionList()
  local a = {}
  self._actions:ForEach(function(action)
    a[#a + 1] = action
  end)
  return a
end

function AirActionExecutor:StopAction(action)
  local success = false
  if action:IsOver() then
    Log.fatal("[AircraftAction] Action is already over")
    success = false
  else
    action:Stop()
    success = true
  end
  return success
end

function AirActionExecutor:PushAction(action)
  self._actions:PushBack(action)
end

function AirActionExecutor:StopPetAllAction(pet)
  local tmpID = pet:TemplateID()
  self._actions:ForEach(function(_act)
    local action = _act
    local pets = action:GetPets()
    if pets and 0 < #pets then
      for _, value in ipairs(pets) do
        if value:TemplateID() == tmpID and not action:IsOver() then
          action:Stop()
        end
      end
    end
  end)
end

function AirActionExecutor:StopByIndex(index)
  local action = self._actions:GetAt(index)
  local success = false
  if action:IsOver() then
    Log.fatal("[AircraftAction] Action is already over")
    success = false
  else
    action:Stop()
    success = true
  end
  self._actions:RemoveAt(index)
  return success
end
