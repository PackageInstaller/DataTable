_class("BuffResultForceRefreshLayer", BuffResultBase)
BuffResultForceRefreshLayer = BuffResultForceRefreshLayer

function BuffResultForceRefreshLayer:Constructor(layer, seq, buffLayerName)
  self._layer = layer
  self._seq = seq
  self._buffLayerName = buffLayerName
end

function BuffResultForceRefreshLayer:GetBuffLayer()
  return self._layer
end

function BuffResultForceRefreshLayer:GetBuffSeq()
  return self._seq
end

function BuffResultForceRefreshLayer:GetBuffLayerName()
  return self._buffLayerName
end
