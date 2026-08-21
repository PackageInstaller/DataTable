_class("BuffResultAddExtraLayer", BuffResultBase)
BuffResultAddExtraLayer = BuffResultAddExtraLayer

function BuffResultAddExtraLayer:Constructor(e, layerType, extraLayer, finalLayer, targetBuffSeq, oldBuffLayer)
  self._entity = e
  self._layerType = layerType
  self._extraLayer = extraLayer
  self._finalLayer = finalLayer
  self._targetBuffSeq = targetBuffSeq
  self._oldBuffLayer = oldBuffLayer
end

function BuffResultAddExtraLayer:GetOldBuffLayer()
  return self._oldBuffLayer
end

function BuffResultAddExtraLayer:GetFinalLayer()
  return self._finalLayer
end

function BuffResultAddExtraLayer:GetTargetBuffSeq()
  return self._targetBuffSeq
end

function BuffResultAddExtraLayer:GetAddLayer()
  return self._extraLayer
end

function BuffResultAddExtraLayer:GetLayerType()
  return self._layerType
end

function BuffResultAddExtraLayer:GetEntity()
  return self._entity
end

function BuffResultAddExtraLayer:SaveNotifyData(notify)
  self._notify__layer = notify:GetLayer()
  self._notify__totalCount = notify:GetTotalCount()
end

function BuffResultAddExtraLayer:GetNotifyOldTotalLayer()
  return self._notify__totalCount
end
