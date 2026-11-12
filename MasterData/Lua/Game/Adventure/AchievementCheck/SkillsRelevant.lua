local SkillsRelevant = {}

function SkillsRelevant.KillMonsterWithoutHitBySkill(mapAchievementData, AchievementDataDic)
  if mapAchievementData.ClientCompleteParams2 == nil then
    return 0
  end
  if mapAchievementData.ClientCompleteParams1 == nil then
    return 0
  end
  if AchievementDataDic.DamageDataDic == nil then
    return 0
  end
  if AchievementDataDic.killDataDic == nil then
    return 0
  end
  for _, nHitDamageId in ipairs(mapAchievementData.ClientCompleteParams2) do
    for nCharId, mapDamageDic in pairs(AchievementDataDic.DamageDataDic) do
      if mapDamageDic:ContainsKey(nHitDamageId) then
        return 0
      end
    end
  end
  for _, nMonsterId in ipairs(mapAchievementData.ClientCompleteParams1) do
    for nCharId, mapKillDic in pairs(AchievementDataDic.killDataDic) do
      if mapKillDic:ContainsKey(nMonsterId) then
        return 1
      end
    end
  end
  return 0
end

return SkillsRelevant
