require("buff_logic_base")
_class("BuffLogicAddLayerByChainCount", BuffLogicBase)
BuffLogicAddLayerByChainCount = BuffLogicAddLayerByChainCount

function BuffLogicAddLayerByChainCount:Constructor(buffInstance, logicParam)
  self._layerType = logicParam.layerType or self._buffInstance:GetBuffEffectType()
  self._mulValue = logicParam.mulValue or 1
  self._addValue = logicParam.addValue or 0
end

function BuffLogicAddLayerByChainCount:DoLogic(notify)
  local chainCount = notify:GetChainCount()
  local addLayer = math.floor(chainCount / self._mulValue) + self._addValue
  if addLayer == 0 then
    return
  end
  local svc = self._world:GetService("BuffLogic")
  local curMarkLayer = svc:AddBuffLayer(self._entity, self._layerType, addLayer)
end
