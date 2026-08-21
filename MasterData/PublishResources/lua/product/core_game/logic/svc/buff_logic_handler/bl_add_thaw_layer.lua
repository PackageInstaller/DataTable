_class("BuffLogicAddThawLayer", BuffLogicBase)
BuffLogicAddThawLayer = BuffLogicAddThawLayer

function BuffLogicAddThawLayer:Constructor(buffInstance, logicParam)
  self._value = logicParam.value or 1
  self._hpShieldPer = logicParam.hpShieldPer
  self._layerShieldCount = logicParam.layerShieldCount
end

function BuffLogicAddThawLayer:DoLogic(notify)
  self._entity:BuffComponent():AddBuffValue("ThawLayer", self._value)
  self._entity:BuffComponent():SetBuffValue("ThawCostHPShieldPer", self._hpShieldPer)
  self._entity:BuffComponent():SetBuffValue("ThawLayerShieldCount", self._layerShieldCount)
end

function BuffLogicAddThawLayer:DoOverlap()
  self:DoLogic()
end
