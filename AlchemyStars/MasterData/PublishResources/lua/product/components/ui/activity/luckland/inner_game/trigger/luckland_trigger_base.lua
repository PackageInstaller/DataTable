require("luckland_trigger_type")
_class("LuckLandTriggerBase", Object)
LuckLandTriggerBase = LuckLandTriggerBase

function LuckLandTriggerBase:Constructor(owner, triggerType, param)
  self._owner = owner
  self._triggerType = triggerType
  self._param = param
end

function LuckLandTriggerBase:GetNotifyType()
  return self._owner:GetNotifyType()
end

function LuckLandTriggerBase:GetTriggerType()
  return self._triggerType
end

function LuckLandTriggerBase:OnNotify(notify)
end

function LuckLandTriggerBase:IsSatisfied(notify)
  return false
end

function LuckLandTriggerBase:GetTriggerParamByIndex(paramIndex)
  local paramCount = #self._param
  if paramIndex > paramCount then
    return nil
  end
  return self._param[paramIndex]
end

_class("LLCombinedTrigger", Object)
LLCombinedTrigger = LLCombinedTrigger

function LLCombinedTrigger:Constructor(triggerOwner, notifyTypes)
  self._triggers = {}
  self._triggerOwner = triggerOwner
  self._notifyTypes = notifyTypes
end

function LLCombinedTrigger:IsNotifyMatch(notifyType)
  if table.icontains(self._notifyTypes, notifyType) then
    return true
  end
  return false
end

function LLCombinedTrigger:AddTrigger(trigger)
  table.insert(self._triggers, trigger)
end

function LLCombinedTrigger:GetTriggers()
  return self._triggers
end

function LLCombinedTrigger:IsSatisfied(notify)
  for i, trigger in ipairs(self._triggers) do
    if not trigger:IsSatisfied(notify) then
      return false
    end
  end
  return true
end

function LLCombinedTrigger:OnTrigger(notify)
  self._triggerOwner:OnTrigger(notify)
end

function LLCombinedTrigger:SetActive(active)
  self._active = active
end

function LLCombinedTrigger:IsActive()
  return self._active
end
