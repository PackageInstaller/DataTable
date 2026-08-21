_class("L2R_ChainAttackResult", Object)
L2R_ChainAttackResult = L2R_ChainAttackResult

function L2R_ChainAttackResult:Constructor(dataList)
  self._chainAtkResultList = dataList
end

function L2R_ChainAttackResult:GetPetChainSkillDataList(entityID)
  local chainResData = self._chainAtkResultList[entityID]
  if chainResData == nil then
    return nil
  end
  return chainResData:GetChainAttackResultAtkDataList()
end

function L2R_ChainAttackResult:GetPetShadowChainSkillDataList(entityID)
  local chainResData = self._chainAtkResultList[entityID]
  if chainResData == nil then
    return nil
  end
  return chainResData:GetChainAttackResultShadowAtkDataList()
end

function L2R_ChainAttackResult:GetPetAgentChainSkillDataList(entityID)
  local chainResData = self._chainAtkResultList[entityID]
  if chainResData == nil then
    return nil
  end
  return chainResData:GetChainAttackResultAgentAtkDataList()
end

function L2R_ChainAttackResult:GetPetReplaceChainSkillDataList(entityID)
  local chainResData = self._chainAtkResultList[entityID]
  if chainResData == nil then
    return nil
  end
  return chainResData:GetChainAttackResultReplaceAtkDataList()
end

function L2R_ChainAttackResult:GetPetHasCastChainSkill(entityID)
  local chainResData = self._chainAtkResultList[entityID]
  if chainResData == nil then
    return false
  end
  return chainResData:GetChainAttackResultCastSkillFlag()
end

function L2R_ChainAttackResult:GetPetCastChainSkillID(entityID)
  local chainResData = self._chainAtkResultList[entityID]
  if chainResData == nil then
    return -1
  end
  return chainResData:GetChainAttackResultSkillID()
end

function L2R_ChainAttackResult:ChainAttackResultHasDamage(entityID)
  local chainResData = self._chainAtkResultList[entityID]
  if chainResData == nil then
    return false
  end
  local effectResListTable = chainResData:GetChainAttackResultAtkDataList()
  for i, effectResList in ipairs(effectResListTable) do
    for _, v in ipairs(effectResList) do
      local chainAttackData = v
      if chainAttackData:GetEffectResultByArray(SkillEffectType.Damage) then
        return true
      end
    end
  end
  return false
end

function L2R_ChainAttackResult:GetDeadEntityIDListByPet(entityID)
  local chainResData = self._chainAtkResultList[entityID]
  if chainResData == nil then
    return nil
  end
  return chainResData:GetDeadEntityIDList()
end

function L2R_ChainAttackResult:GetChainTeamResult()
  return self._chainTeamResult
end

function L2R_ChainAttackResult:SetChainTeamResult(team)
  self._chainTeamResult = team
end
