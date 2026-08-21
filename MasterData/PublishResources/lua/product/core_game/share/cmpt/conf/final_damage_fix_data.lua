_class("FinalDamageFixData", Object)
FinalDamageFixData = FinalDamageFixData

function FinalDamageFixData:Constructor(targetID, mulVal)
  self._targetID = targetID
  self._mulVal = mulVal
end

function FinalDamageFixData:GetTargetID()
  return self._targetID
end

function FinalDamageFixData:GetMulVal()
  return self._mulVal
end
