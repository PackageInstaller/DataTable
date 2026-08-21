_class("DataAddPartnerResult", Object)
DataAddPartnerResult = DataAddPartnerResult

function DataAddPartnerResult:Constructor(partnerID, petInfo, matchPet, petRes, hp, maxHP)
  self._partnerID = partnerID
  self._petInfo = petInfo
  self._matchPet = matchPet
  self._petRes = petRes
  self._hp = hp
  self._maxHP = maxHP
end

function DataAddPartnerResult:GetPartnerID()
  return self._partnerID
end

function DataAddPartnerResult:GetPetInfo()
  return self._petInfo
end

function DataAddPartnerResult:GetMatchPet()
  return self._matchPet
end

function DataAddPartnerResult:GetPetRes()
  return self._petRes
end

function DataAddPartnerResult:GetHP()
  return self._hp
end

function DataAddPartnerResult:GetMaxHP()
  return self._maxHP
end

_class("DataAddRelicResult", Object)
DataAddRelicResult = DataAddRelicResult

function DataAddRelicResult:Constructor(relicID, buffSeqList, switchState)
  self._relicID = relicID
  self._buffSeqList = buffSeqList
  self._switchState = switchState
end

function DataAddRelicResult:GetRelicID()
  return self._relicID
end

function DataAddRelicResult:GetBuffSeqList()
  return self._buffSeqList
end

function DataAddRelicResult:GetSwitchState()
  return self._switchState
end
