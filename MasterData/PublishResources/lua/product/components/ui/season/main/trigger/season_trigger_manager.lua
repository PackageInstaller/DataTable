_class("SeasonTriggerManager", Object)
SeasonTriggerManager = SeasonTriggerManager

function SeasonTriggerManager:Constructor()
  self._triggerName = "Trigger"
end

function SeasonTriggerManager:OnInit(seasonID)
  self._triggerRoot = GameObjectHelper.CreateEmpty(self._triggerName, nil)
  self._trigger = SeasonTrigger:New(seasonID, self._triggerRoot.transform)
end

function SeasonTriggerManager:FindTrigger(triggerId)
  return self._trigger:FindTrigger(triggerId)
end

function SeasonTriggerManager:Update(deltaTime)
  self._trigger:Update(deltaTime)
end

function SeasonTriggerManager:Dispose()
  self._trigger:Dispose()
  self._trigger = nil
  UnityEngine.Object.Destroy(self._triggerRoot)
  self._triggerRoot = nil
end
