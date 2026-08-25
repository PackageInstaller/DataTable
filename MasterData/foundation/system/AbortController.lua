local AbortSignal = System.NewClass("AbortSignal")

function AbortSignal:ctor()
  self.aborted = false
  self.event = SystemEvent()
end

function AbortSignal:RemoveListener(listener)
  self.event:Remove(listener)
end

function AbortSignal:AddListener(listener)
  self.event:Register(listener)
end

function AbortSignal:DispatchEvent()
  self.event:Dispatch()
end

local AbortController = System.NewClass("AbortController")

function AbortController:ctor()
  self.signal = AbortSignal()
end

function AbortController:Abort()
  if self.signal.aborted then
    return
  end
  self.signal.aborted = true
  self.signal:DispatchEvent()
end

return AbortController
