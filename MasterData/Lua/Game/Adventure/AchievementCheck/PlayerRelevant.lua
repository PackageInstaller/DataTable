local PlayerRelevant = {}

function PlayerRelevant.CritCount(mapAchievementData, AchievementDataDic)
  local ret = 0
  for nCharId, nCritCount in ipairs(AchievementDataDic.CritCountData) do
    if #mapAchievementData.ClientCompleteParams1 == 0 or 0 < table.indexof(mapAchievementData.ClientCompleteParams1, nCharId) then
      ret = ret + nCritCount
    end
  end
  return ret
end

function PlayerRelevant.CastSkillTypeCount(mapAchievementData, AchievementDataDic)
  local nCount = 0
  local tbTarget = mapAchievementData.ClientCompleteParams1
  for nSkillId, nCastCount in pairs(AchievementDataDic.CastSkillData) do
    local mapSkill = ConfigTable.GetData("Skill", nSkillId)
    if mapSkill ~= nil and 0 < table.indexof(tbTarget, mapSkill.Type) then
      nCount = nCount + nCastCount
    end
  end
  return nCount
end

function PlayerRelevant.CastSkillCount(mapAchievementData, AchievementDataDic)
  local nCount = 0
  local tbTarget = mapAchievementData.ClientCompleteParams1
  for nSkillId, nCastCount in pairs(AchievementDataDic.CastSkillData) do
    local mapSkill = ConfigTable.GetData("Skill", nSkillId)
    if mapSkill ~= nil and 0 < table.indexof(tbTarget, mapSkill.Id) then
      nCount = nCount + nCastCount
    end
  end
  return nCount
end

function PlayerRelevant.ExtremDodgeCount(mapAchievementData, AchievementDataDic)
  local ret = 0
  for nCharId, nPrefectDodgeCount in ipairs(AchievementDataDic.PrefectDodgeData) do
    if #mapAchievementData.ClientCompleteParams1 == 0 or 0 < table.indexof(mapAchievementData.ClientCompleteParams1, nCharId) then
      ret = ret + nPrefectDodgeCount
    end
  end
  return ret
end

function PlayerRelevant.TriggerTagElement(mapAchievementData, AchievementDataDic)
  local nCount = 0
  local tbTarget = mapAchievementData.ClientCompleteParams1
  for nMark, nTriggerCount in pairs(AchievementDataDic.MarkTriggerData) do
    if 0 < table.indexof(tbTarget, nMark) then
      nCount = nCount + nTriggerCount
    end
  end
  return nCount
end

function PlayerRelevant.OneHitDamage(mapAchievementData, AchievementDataDic)
  local nTarget = mapAchievementData.ClientCompleteParams1[1]
  if nTarget <= AchievementDataDic.MaxDamageValue then
    return 1
  end
  return 0
end

function PlayerRelevant.ClearLevelWithHPBelow(mapAchievementData, AchievementDataDic, bSuccess)
  if not bSuccess then
    return 0
  end
  local nTarget = mapAchievementData.ClientCompleteParams1[1]
  local nCurPrec = AchievementDataDic.MainActorHpPrec * 100
  if nTarget >= nCurPrec then
    return 1
  end
  return 0
end

return PlayerRelevant
