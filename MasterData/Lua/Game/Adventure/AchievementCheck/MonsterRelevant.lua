local MonsterRelevant = {}

function MonsterRelevant.CheckKillMonsterWithoutKillSpecifiedMonster(mapAchievementData, AchievementDataDic)
  for _, nMonsterId in ipairs(mapAchievementData.ClientCompleteParams1) do
    for nCharId, mapKillDic in pairs(AchievementDataDic.killDataDic) do
      if mapKillDic:ContainsKey(nMonsterId) then
        return 0
      end
    end
  end
  for _, nMonsterId in ipairs(mapAchievementData.ClientCompleteParams2) do
    for nCharId, mapKillDic in pairs(AchievementDataDic.killDataDic) do
      if mapKillDic:ContainsKey(nMonsterId) then
        return 1
      end
    end
  end
  return 0
end

function MonsterRelevant.CheckKillMonsterWithOneAttack(mapAchievementData, AchievementDataDic)
  local nTarget = mapAchievementData.ClientCompleteParams1[1]
  local nTargetChar = mapAchievementData.ClientCompleteParams2[1]
  for nCharId, nCount in pairs(AchievementDataDic.OnceSkillKillCountDic) do
    if (#nTargetChar == 0 or 0 < table.indexof(nTargetChar, nCharId)) and nCount > nTarget then
      return 1
    end
  end
  return 0
end

function MonsterRelevant.KillMonsterClass(mapAchievementData, AchievementDataDic)
  local nCount = 0
  local tbTarget = mapAchievementData.ClientCompleteParams1
  local tbTargetChar = mapAchievementData.ClientCompleteParams2
  for nCharId, mapKillDic in pairs(AchievementDataDic.killDataDic) do
    if #tbTargetChar == 0 or 0 < table.indexof(tbTargetChar, nCharId) then
      for nMonsterId, nKillCount in pairs(mapKillDic) do
        local mapMonsterCfg = ConfigTable.GetData("Monster", nMonsterId)
        if mapMonsterCfg ~= nil and 0 < table.indexof(tbTarget, mapMonsterCfg.EpicLv) then
          nCount = nCount + nKillCount
        end
      end
    end
  end
  return nCount
end

function MonsterRelevant.KillMonsterWithTag(mapAchievementData, AchievementDataDic)
  local nCount = 0
  local nTargetChar = mapAchievementData.ClientCompleteParams1
  local tbTarget = mapAchievementData.ClientCompleteParams3
  if tbTarget == nil then
    return 0
  end
  for nCharId, mapKillDic in pairs(AchievementDataDic.killDataDic) do
    if #nTargetChar == 0 or 0 < table.indexof(nTargetChar, nCharId) then
      for nMonsterId, nKillCount in pairs(mapKillDic) do
        local mapMonsterCfg = ConfigTable.GetData("Monster", nMonsterId)
        if mapMonsterCfg ~= nil then
          if 0 < table.indexof(mapMonsterCfg.Tag1, tbTarget) then
            nCount = nCount + nKillCount
          elseif 0 < table.indexof(mapMonsterCfg.Tag2, tbTarget) then
            nCount = nCount + nKillCount
          elseif 0 < table.indexof(mapMonsterCfg.Tag3, tbTarget) then
            nCount = nCount + nKillCount
          elseif 0 < table.indexof(mapMonsterCfg.Tag4, tbTarget) then
            nCount = nCount + nKillCount
          elseif 0 < table.indexof(mapMonsterCfg.Tag5, tbTarget) then
            nCount = nCount + nKillCount
          end
        end
      end
    end
  end
  return nCount
end

function MonsterRelevant.KillMonsterWithSkin(mapAchievementData, AchievementDataDic)
  local nCount = 0
  local tbTargetSkin = mapAchievementData.ClientCompleteParams1
  if tbTargetSkin == nil then
    return 0
  end
  for _, mapKillDic in pairs(AchievementDataDic.killDataDic) do
    if 0 < #tbTargetSkin then
      for nMonsterId, nKillCount in pairs(mapKillDic) do
        local mapMonsterCfg = ConfigTable.GetData("Monster", nMonsterId)
        if mapMonsterCfg ~= nil then
          local nFAId = mapMonsterCfg.FAId
          if 0 < table.indexof(tbTargetSkin, nFAId) then
            nCount = nCount + nKillCount
          end
        end
      end
    end
  end
  return nCount
end

return MonsterRelevant
