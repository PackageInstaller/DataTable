_class("Singleton", Object)
Singleton = Singleton

function Singleton:GetInstance()
  if not self._instance then
    self._instance = self:New(self)
  end
  return self._instance
end

function Singleton:Dispose()
  self._instance = nil
end
