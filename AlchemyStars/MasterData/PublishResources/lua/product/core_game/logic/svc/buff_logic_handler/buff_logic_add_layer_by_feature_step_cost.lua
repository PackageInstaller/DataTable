require("buff_logic_base")
_class("BuffLogicAddLayerByFeatureStepCost", BuffLogicBase)
BuffLogicAddLayerByFeatureStepCost = BuffLogicAddLayerByFeatureStepCost

function BuffLogicAddLayerByFeatureStepCost:Constructor(buffInstance, logicParam)
  self._layerType = logicParam.layerType or self._buffInstance:GetBuffEffectType()
  self._mulValue = logicParam.mulValue or 1
  self._addValue = logicParam.addValue or 0
  self._dontDisplay = logicParam.dontDisplay
end

function BuffLogicAddLayerByFeatureStepCost:DoLogic(notify)
  if notify then
    local notifyType = notify:GetNotifyType()
    if notifyType == NotifyType.FeatureStepPointMoveCost or notifyType == NotifyType.FeatureStepPointSkillCost then
      local stepCost = notify:GetCostVal()
      local addLayer = math.floor(stepCost * self._mulValue) + self._addValue
      if addLayer == 0 then
        return
      end
      local svc = self._world:GetService("BuffLogic")
      local curMarkLayer, buffInst = svc:AddBuffLayer(self._entity, self._layerType, addLayer)
      local buffResult = BuffResultAddLayer:New(curMarkLayer, self._dontDisplay)
      buffResult:SetBuffSeq(buffInst:BuffSeq())
      return buffResult
    end
  end
end
