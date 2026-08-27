local DeliverySimulatorInteractEntityBase = class("DeliverySimulatorInteractEntityBase")

function DeliverySimulatorInteractEntityBase:ctor(dsEntityId, interactObj)
  self.dsEntityId = dsEntityId
  self.gameObject = interactObj
  self.interactRangeCollider = self.gameObject.transform:FindComponent("InteractRange", eUnityComponentID.Collider)
  if self.interactRangeCollider == nil then
    self.interactRangeCollider = self.gameObject.transform:FindComponent(eUnityComponentID.Collider)
  end
end

function DeliverySimulatorInteractEntityBase:InitInteractEntityUI(mainWindow)
end

function DeliverySimulatorInteractEntityBase:Reset()
end

function DeliverySimulatorInteractEntityBase:OnPlayerTrigger(dsPlayerEntity, dsCtrl, isEnterOrExit)
end

function DeliverySimulatorInteractEntityBase:OnUpDate()
end

function DeliverySimulatorInteractEntityBase:PlayTouchAnim()
end

function DeliverySimulatorInteractEntityBase:PlayExitAnim()
end

function DeliverySimulatorInteractEntityBase:Delete()
  if self.OnDelete ~= nil then
    self:OnDelete()
  end
end

return DeliverySimulatorInteractEntityBase
