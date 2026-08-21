require("_buff_result_base")
_class("BuffResultDamageByBuffRoundLayerAndClear", BuffResultBase)
BuffResultDamageByBuffRoundLayerAndClear = BuffResultDamageByBuffRoundLayerAndClear

function BuffResultDamageByBuffRoundLayerAndClear:Constructor(damageInfo, targetBuffSeq)
  self._damageInfo = damageInfo
  self._targetBuffSeq = targetBuffSeq
end

function BuffResultDamageByBuffRoundLayerAndClear:GetDamageInfo()
  return self._damageInfo
end

function BuffResultDamageByBuffRoundLayerAndClear:GetTargetBuffSeq()
  return self._targetBuffSeq
end
