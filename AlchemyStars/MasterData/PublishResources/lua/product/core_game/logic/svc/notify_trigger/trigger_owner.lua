_class("ITriggerOwner", Object)
ITriggerOwner = ITriggerOwner

function ITriggerOwner:OnTrigger()
end

function ITriggerOwner:GetOwnerEntity()
end

function ITriggerOwner:GetWorld()
end

_class("TriggerCallbackOwner", ITriggerOwner)
TriggerCallbackOwner = TriggerCallbackOwner

function TriggerCallbackOwner:Constructor(obj, callback, ...)
  self._obj = obj
  self._callback = callback
  self._params = {
    ...
  }
end

function TriggerCallbackOwner:OnTrigger(notify)
  self._callback(self._obj, notify, table.unpack(self._params))
end
