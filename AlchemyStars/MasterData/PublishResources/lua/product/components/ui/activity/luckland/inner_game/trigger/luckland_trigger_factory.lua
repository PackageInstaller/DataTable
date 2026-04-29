_class("LuckLandTriggerFactory", Object)
LuckLandTriggerFactory = LuckLandTriggerFactory

function LuckLandTriggerFactory:Constructor()
  self._triggerPrototype = {}
  for k, v in pairs(LuckLandTriggerType) do
    local clsName = "LLTT" .. k
    self._triggerPrototype[v] = Classes[clsName]
  end
end

function LuckLandTriggerFactory:CreateTrigger(triggerOwner, notifyTypes, triggerCfg)
  local combTrigger = LLCombinedTrigger:New(triggerOwner, notifyTypes)
  for i, cfg in ipairs(triggerCfg) do
    local triggerType = cfg[1]
    local triggerProto = self._triggerPrototype[triggerType]
    if not triggerProto then
      Log.error("[LuckLandTriggerFactory]CreateTrigger() not find trigger type:", triggerType)
      return
    end
    local triggerParam = table.sub(cfg, 2, #cfg)
    local trigger = triggerProto:New(triggerOwner, triggerType, triggerParam)
    combTrigger:AddTrigger(trigger)
  end
  return combTrigger
end
