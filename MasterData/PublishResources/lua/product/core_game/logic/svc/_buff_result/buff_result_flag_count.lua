require("_buff_result_base")
_class("BuffResultFlagCount", BuffResultBase)
BuffResultFlagCount = BuffResultFlagCount

function BuffResultFlagCount:Constructor(flagID, layerBefore, layer)
  self._flagID = flagID
  self._layerBefore = layerBefore
  self._layer = layer
end

function BuffResultFlagCount:GetFlagID()
  return self._flagID
end

function BuffResultFlagCount:GetLayerBefore()
  return self._layerBefore
end

function BuffResultFlagCount:GetLayerAfter()
  return self._layer
end
