local GuideConditionUtils = System.NewClass("GuideConditionUtils")

function GuideConditionUtils.ResonanceUpgradedCompleted()
  do return end
  return ResonanceDataUtils.IsResonanceUpgraded, nil
end

function GuideConditionUtils.AwakerUpgradedCompleted()
  local awakerMap = AwakerDataUtils.GetAwakerDataMap()
  for tid, data in pairs(awakerMap) do
    if data.level > 1 then
      return true
    end
  end
  return false
end

function GuideConditionUtils.TeamFormationCompleted()
  local teams = DBGTeamDataUtils.GetDBGTeams(CommonDefine.TeamType.Normal)
  local team = teams[1] or {}
  for _, awakerTid in ipairs(team.awakerTids or {}) do
    if awakerTid and 0 ~= awakerTid then
      return true
    end
  end
end

function GuideConditionUtils.WeaponFormationCompleted()
  local teams = DBGTeamDataUtils.GetDBGTeams(CommonDefine.TeamType.Normal)
  local team = teams[1] or {}
  if team and team.awakers then
    for _, awakersData in pairs(team.awakers) do
      for _, weaponSlot in pairs(AwakerDataUtils.GetWeaponSlotData(awakersData)) do
        if weaponSlot and weaponSlot.weaponUid and 0 ~= weaponSlot.weaponUid then
          return true
        end
      end
    end
  end
end

function GuideConditionUtils.SkillFormationCompleted()
  local teams = DBGTeamDataUtils.GetDBGTeams(CommonDefine.TeamType.Normal)
  local team = teams[1] or {}
  if team.keeperSkill and 0 ~= team.keeperSkill then
    return true
  end
end

function GuideConditionUtils.ThreeOrMoreSchoolAwaker()
  local awakerMap = AwakerDataUtils.GetOwnedAwakerMap()
  local schoolMap = {}
  local schoolCount = 0
  for tid, data in pairs(awakerMap) do
    local school = AwakerDataUtils.GetAwakerSchool(tid)
    if not schoolMap[school] then
      schoolMap[school] = true
      schoolCount = schoolCount + 1
    end
  end
  return schoolCount >= 3
end

function GuideConditionUtils.CheckOceanSkillGuideCondEffect()
  return bg.battleDataCenter:GetOceanModel() == BattleConst.OceanModel.OceanModel1
end

function GuideConditionUtils.CheckBloodSkillGuideCondEffect()
  if BattleSkillUtils.IsColdBloodRecoverTimes() then
    return false
  end
  if BattleSkillUtils.IsColdBloodInCd() then
    return false
  end
  return true
end

function GuideConditionUtils.CheckDimensionSkillGuideCondEffect()
  if BattleSkillUtils.IsDimensionSchoolSkillInCd() then
    return false
  end
  if BattleSkillUtils.IsDimensionCardEmpty() then
    return false
  end
  if BattleSkillUtils.IsDimensionSkillRecoverTimes() then
    return false
  end
  return true
end

return GuideConditionUtils
