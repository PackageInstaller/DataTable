_class("TriggerFactory", Object)
TriggerFactory = TriggerFactory

function TriggerFactory:Constructor()
  self._triggerPrototype = {}
  for k, v in pairs(TriggerType) do
    local clsName = "TT" .. k
    self._triggerPrototype[v] = Classes[clsName]
  end
end

function TriggerFactory:CreateTrigger(triggerOwner, triggerCond, world)
  local notifyTypes = triggerCond[1]
  for i, n in ipairs(notifyTypes) do
    notifyTypes[i] = world:ReplaceNotifyType(n)
  end
  local triggers = CombinedTrigger:New(triggerOwner, notifyTypes, world)
  for i, cond in ipairs(triggerCond) do
    if 1 < i then
      local triggerType = cond[1]
      local triggerProto = self._triggerPrototype[triggerType]
      if not triggerProto then
        Log.error("TriggerFactory:CreateTrigger() not find trigger type:", triggerType)
        return
      end
      local trigger = triggerProto:New(triggers, cond)
      triggers:AddTrigger(trigger)
    end
  end
  return triggers
end
