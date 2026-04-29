require("buff_logic_base")
_class("BuffLogicAddLayerByLegendPower", BuffLogicBase)
BuffLogicAddLayerByLegendPower = BuffLogicAddLayerByLegendPower

function BuffLogicAddLayerByLegendPower:Constructor(buffInstance, logicParam)
  self._layerType = logicParam.layerType or self._buffInstance:GetBuffEffectType()
  self._buffInstance._buffLayerName = self._buffInstance._buffsvc:GetBuffLayerName(self._layerType)
  self._dontDisplay = logicParam.dontDisplay
end

function BuffLogicAddLayerByLegendPower:DoLogic(notify)
  local svc = self._world:GetService("BuffLogic")
  local petEntity = self._buffInstance:Entity()
  local attributeCmpt = petEntity:Attributes()
  local curLegendPower = attributeCmpt:GetAttribute("LegendPower")
  local curMarkLayer = svc:AddBuffLayer(self._entity, self._layerType, curLegendPower)
  local buffResult = BuffResultAddLayer:New(curMarkLayer, self._dontDisplay)
  return buffResult
end
