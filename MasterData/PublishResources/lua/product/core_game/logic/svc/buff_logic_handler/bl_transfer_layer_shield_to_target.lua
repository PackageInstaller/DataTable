_class("BuffLogicTransferLayerShieldToTarget", BuffLogicBase)
BuffLogicTransferLayerShieldToTarget = BuffLogicTransferLayerShieldToTarget

function BuffLogicTransferLayerShieldToTarget:Constructor(buffInstance, logicParam)
end

function BuffLogicTransferLayerShieldToTarget:DoLogic(notify)
  if not notify.GetDefenderEntity then
    return
  end
  local targetEntity = notify:GetDefenderEntity()
  local e = self._buffInstance:Entity()
  local buffLogic = self._world:GetService("BuffLogic")
  local myLayerCount = buffLogic:GetBuffLayer(e, BuffEffectType.LayerShield)
  buffLogic:AddBuffLayer(targetEntity, BuffEffectType.LayerShield, myLayerCount)
  local newLayer = buffLogic:GetBuffLayer(targetEntity, BuffEffectType.LayerShield)
  local buffResult = BuffResultTransferCasterLayerShieldToTarget:New(e:GetID(), targetEntity:GetID(), newLayer)
  return buffResult
end
