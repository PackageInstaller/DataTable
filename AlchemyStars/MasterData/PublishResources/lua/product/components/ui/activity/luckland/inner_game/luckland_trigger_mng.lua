_class("LLTriggerMng", Object)
LLTriggerMng = LLTriggerMng

function LLTriggerMng:Constructor()
  self._triggerFactory = LuckLandTriggerFactory:New()
end

function LLTriggerMng:Dispose()
end

function LLTriggerMng:CreateTrigger(buffObj, notifyCfg, triggerCfg)
  return self._triggerFactory:CreateTrigger(buffObj, notifyCfg, triggerCfg)
end

function LLTriggerMng:Notify(notify)
  local entity = notify:GetNotifyEntity()
  local buffArray = entity:GetBuffArray()
  for _, buffObj in ipairs(buffArray) do
    if buffObj:IsTriggerSatisfied(notify) then
      buffObj:OnTrigger(notify)
    end
  end
end
