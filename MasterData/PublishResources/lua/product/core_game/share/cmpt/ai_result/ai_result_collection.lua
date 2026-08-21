_class("AIResultCollection", Object)
AIResultCollection = AIResultCollection

function AIResultCollection:Constructor()
  self._normalAttackResultList = {}
  self._spellResultList = {}
  self._walkResultList = {}
  self._rotateBodyAreaResultList = {}
end

function AIResultCollection:ClearCollection()
  self._normalAttackResultList = {}
  self._spellResultList = {}
  self._walkResultList = {}
  self._rotateBodyAreaResultList = {}
end

function AIResultCollection:HasNormalAttackResult()
  local resCount = #self._normalAttackResultList
  if 0 < resCount then
    return true
  end
  return false
end

function AIResultCollection:GetNormalAttackResultList()
  return self._normalAttackResultList
end

function AIResultCollection:HasSpellResult()
  local resCount = #self._spellResultList
  if 0 < resCount then
    return true
  end
  return false
end

function AIResultCollection:GetSpellResultList()
  return self._spellResultList
end

function AIResultCollection:AddSpellResult(res)
  self._spellResultList[#self._spellResultList + 1] = res
end

function AIResultCollection:AddNormalAttackResult(res)
  self._normalAttackResultList[#self._normalAttackResultList + 1] = res
end

function AIResultCollection:GetWalkResultList()
  return self._walkResultList
end

function AIResultCollection:AddWalkResult(walkResult)
  self._walkResultList[#self._walkResultList + 1] = walkResult
end

function AIResultCollection:HasRotateBodyAreaResult()
  local resCount = #self._rotateBodyAreaResultList
  if 0 < resCount then
    return true
  end
  return false
end

function AIResultCollection:GetRotateBodyAreaResultList()
  return self._rotateBodyAreaResultList
end

function AIResultCollection:AddRotateBodyAreaResult(aiResult)
  self._rotateBodyAreaResultList[#self._rotateBodyAreaResultList + 1] = aiResult
end
