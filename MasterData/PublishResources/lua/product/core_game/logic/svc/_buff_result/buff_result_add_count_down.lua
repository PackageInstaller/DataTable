require("_buff_result_base")
_class("BuffResultAddCountDown", BuffResultBase)
BuffResultAddCountDown = BuffResultAddCountDown

function BuffResultAddCountDown:Constructor(countDown, buffseq, layerType)
  self._countDown = countDown
  self._buffseq = buffseq
  self._layerType = layerType
end

function BuffResultAddCountDown:GetLayerType()
  return self._layerType
end

function BuffResultAddCountDown:GetCountDown()
  return self._countDown
end

function BuffResultAddCountDown:GetBuffSeq()
  return self._buffseq
end
