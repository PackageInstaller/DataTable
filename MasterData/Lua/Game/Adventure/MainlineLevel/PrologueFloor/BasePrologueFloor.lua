local BasePrologueFloor = class("BasePrologueFloor")

function BasePrologueFloor:ctor(parentData)
  self.parent = parentData
end

function BasePrologueFloor:Enter()
  self:_BindEventCallback()
end

function BasePrologueFloor:_BindEventCallback()
  if type(self._mapEventConfig) ~= "table" then
    return
  end
  for nEventId, sCallbackName in pairs(self._mapEventConfig) do
    local callback = self[sCallbackName]
    if type(callback) == "function" then
      EventManager.Add(nEventId, self, callback)
    end
  end
end

function BasePrologueFloor:_UnbindEventCallback()
  if type(self._mapEventConfig) ~= "table" then
    return
  end
  for nEventId, sCallbackName in pairs(self._mapEventConfig) do
    local callback = self[sCallbackName]
    if type(callback) == "function" then
      EventManager.Remove(nEventId, self, callback)
    end
  end
end

function BasePrologueFloor:Exit()
  self:_UnbindEventCallback()
end

return BasePrologueFloor
