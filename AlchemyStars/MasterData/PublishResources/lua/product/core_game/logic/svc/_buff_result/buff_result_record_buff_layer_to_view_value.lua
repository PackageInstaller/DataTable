require("_buff_result_base")
_class("BuffResultRecordBuffLayerToViewValue", BuffResultBase)
BuffResultRecordBuffLayerToViewValue = BuffResultRecordBuffLayerToViewValue

function BuffResultRecordBuffLayerToViewValue:Constructor(buffLayerType, layerCount, isRevert)
  self._buffLayerType = buffLayerType
  self._layerCount = layerCount
  self._isRevert = isRevert
end

function BuffResultRecordBuffLayerToViewValue:GetBuffLayerType()
  return self._buffLayerType
end

function BuffResultRecordBuffLayerToViewValue:GetLayerCount()
  return self._layerCount
end

function BuffResultRecordBuffLayerToViewValue:GetIsRevert()
  return self._isRevert
end
