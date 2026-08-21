_class("BuffLogicRecordBuffLayerToViewValue", BuffLogicBase)
BuffLogicRecordBuffLayerToViewValue = BuffLogicRecordBuffLayerToViewValue

function BuffLogicRecordBuffLayerToViewValue:Constructor(buffInstance, logicParam)
  self._buffLayerType = logicParam.buffLayerType
  self._isRevert = false
  if logicParam.isRevert and logicParam.isRevert == 1 then
    self._isRevert = true
  end
end

function BuffLogicRecordBuffLayerToViewValue:DoLogic()
  local svc = self._world:GetService("BuffLogic")
  local buffLayer = 0
  if not self._isRevert then
    buffLayer = svc:GetBuffLayer(self._entity, self._buffLayerType)
  end
  local buffResult = BuffResultRecordBuffLayerToViewValue:New(self._buffLayerType, buffLayer, self._isRevert)
  return buffResult
end
