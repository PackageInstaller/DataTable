require("buff_logic_base")
_class("BuffLogicAddLayerByTeleportDistance", BuffLogicBase)
BuffLogicAddLayerByTeleportDistance = BuffLogicAddLayerByTeleportDistance

function BuffLogicAddLayerByTeleportDistance:Constructor(buffInstance, logicParam)
  self._layerType = logicParam.layerType or self._buffInstance:GetBuffEffectType()
  self._buffInstance._buffLayerName = self._buffInstance._buffsvc:GetBuffLayerName(self._layerType)
  self._dontDisplay = logicParam.dontDisplay
end

function BuffLogicAddLayerByTeleportDistance:DoLogic(notify)
  local svc = self._world:GetService("BuffLogic")
  local utilCalcSvc = self._world:GetService("UtilCalc")
  local currentRingNum = utilCalcSvc:GetGridRingNum(notify:GetPosNew(), notify:GetPosOld(), notify:GetNotifyEntity():BodyArea():GetArea())
  local curMarkLayer = svc:AddBuffLayer(self._entity, self._layerType, currentRingNum)
  local buffResult = BuffResultAddLayer:New(curMarkLayer, self._dontDisplay)
  return buffResult
end
