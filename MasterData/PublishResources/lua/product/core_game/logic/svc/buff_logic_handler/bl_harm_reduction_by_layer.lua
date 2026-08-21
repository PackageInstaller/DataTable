_class("BuffLogicDoHarmReductionByLayer", BuffLogicBase)
BuffLogicDoHarmReductionByLayer = BuffLogicDoHarmReductionByLayer

function BuffLogicDoHarmReductionByLayer:Constructor(_buffIns, logicParam)
  self._layerType = logicParam.layerType or self._buffInstance:GetBuffEffectType()
  self._mulValPerLayer = logicParam.mulValPerLayer
  self._overrideModifierIDByLayerType = logicParam.overrideModifierIDByLayerType
end

function BuffLogicDoHarmReductionByLayer:DoLogic()
  local modifierID = self._overrideModifierIDByLayerType and self._layerType or self:GetBuffSeq()
  local curMarkLayer = self._buffLogicService:GetBuffLayer(self._entity, self._layerType)
  local val = self._mulValPerLayer * curMarkLayer * -1
  self._buffLogicService:ChangeFinalBeHitDamageParam(self._entity, modifierID, val)
end

function BuffLogicDoHarmReductionByLayer:DoOverlap(logicParam)
  self._mulValPerLayer = logicParam.mulValPerLayer
  self:DoLogic()
end

_class("BuffLogicRemoveHarmReductionByLayer", BuffLogicBase)
BuffLogicRemoveHarmReductionByLayer = BuffLogicRemoveHarmReductionByLayer

function BuffLogicRemoveHarmReductionByLayer:Constructor(buffInstance, logicParam)
  self._layerType = logicParam.layerType or self._buffInstance:GetBuffEffectType()
  self._overrideModifierIDByLayerType = logicParam.overrideModifierIDByLayerType
end

function BuffLogicRemoveHarmReductionByLayer:DoLogic()
  local modifierID = self._overrideModifierIDByLayerType and self._layerType or self:GetBuffSeq()
  self._buffLogicService:RemoveFinalBeHitDamageParam(self._entity, modifierID)
end
