local TeamAssign = CommonDefine.TeamAssign
local ePosState = TeamAssign.ePosState
local eStageTeamMode = TeamAssign.eStageTeamMode
local TeamAssignDataUtils = {}
local tempTable = {
  0,
  0,
  0,
  0
}

function TeamAssignDataUtils.GetAwakerDataMap(teamMode, stageCfg)
  if teamMode == eStageTeamMode.Normal or teamMode == eStageTeamMode.Special then
    do return end
    return AwakerDataUtils.GetOwnedAwakerMap
  end
end

function TeamAssignDataUtils.GetBattlePosState(cfgId)
  if nil == cfgId or 0 == cfgId then
    return nil
  end
  local tSlotState = {}
  local tFakeAwakerDatas = {}
  local tCfg = DT.SpecialTeamAssign[cfgId]
  for i, v in ipairs(tCfg.data_list) do
    local awakerId = v.AwakerIndex
    if tonumber(awakerId) then
      awakerId = tonumber(awakerId)
      local skills = {}
      local awakerConfig = AwakerDataUtils.GetAwakerConfig(awakerId)
      for slot, skillLevel in pairs(v.SkillLv or {}) do
        skills[slot] = {
          slot = slot,
          level = skillLevel,
          upNum = skillLevel,
          lock = false,
          isUp = false,
          tid = awakerConfig.SkillList[slot]
        }
      end
      local attrs = AwakerDataUtils.GetNotOwnAwakerAttrs(awakerId, v.AwakerLv)
      for attrTid, attrVal in pairs(v.Attr or {}) do
        attrs[DT.ActorAttrType[attrTid].Name] = attrVal
      end
      local isFakeAwaker = true
      if v.IsOwnedAwaker == cd.TeamAssignAwaker.UseOwnedAwaker then
        isFakeAwaker = false
      end
      local fakeAwaker = {
        IsOwnedAwaker = v.IsOwnedAwaker,
        tid = awakerId * -1,
        level = v.AwakerLv,
        slot = i,
        potencyLevel = v.PotencyLv or 0,
        skills = skills,
        slots = skills,
        attrs = attrs,
        isFakeAwaker = isFakeAwaker,
        weaponTid = v.Weapon,
        weaponPotencyLv = v.WeaponPotencyLv,
        subWeaponTid = v.SubWeapon,
        subWeaponPotencyLv = v.SubWeaponPotencyLv,
        suitEffectId = v.TrinketSuitEffect,
        isSpecialAwaker = true,
        talents = AwakerTalentExtModel.Instance:GetDefaultTalentLvMap(awakerId, v.Talent)
      }
      tFakeAwakerDatas[awakerId] = fakeAwaker
    end
    tSlotState[i] = awakerId
  end
  return tSlotState, tFakeAwakerDatas
end

function TeamAssignDataUtils.GetMaxBattleNum(tSlotState)
  local num = 0
  for i, v in ipairs(tSlotState) do
    if v ~= ePosState.BanBattlePos then
      num = num + 1
    end
  end
  return num
end

function TeamAssignDataUtils.GetBattleAwakerTids(teamMode, stageCfg)
  if teamMode == eStageTeamMode.Normal then
    local stageGroupId = stageCfg.BelongGroup
    local cachedTeamData = WorldStageManager.Instance:GetTeamData(stageGroupId)
    return cachedTeamData
  elseif teamMode == eStageTeamMode.Special then
    do return TeamAssignDataUtils.GetSpecialModeBattleAwakerIds end
    return TeamAssignDataUtils.GetSpecialModeBattleAwakerIds, stageCfg, WorldStageManager.Instance, stageGroupId
  end
end

function TeamAssignDataUtils.GetSpecialModeBattleAwakerIds(stageCfg)
  local awakerIds = {
    0,
    0,
    0,
    0
  }
  local cfgId = stageCfg.SpecialTeamIndex
  local tCfg = DT.SpecialTeamAssign[cfgId]
  for i, v in ipairs(tCfg and tCfg.data_list or {}) do
    local awakerIndex = tonumber(v.AwakerIndex)
    if awakerIndex and (not v.IsOwnedAwaker or v.IsOwnedAwaker ~= cd.TeamAssignAwaker.UseOwnedAwaker) then
      awakerIds[i] = tonumber(v.AwakerIndex) * -1
    end
  end
  return awakerIds
end

function TeamAssignDataUtils.GetAwakerSpecialSlot(stageId, awakerTid)
  if not stageId or not awakerTid then
    return
  end
  awakerTid = math.abs(awakerTid)
  local specialTeamAssignCfg = TeamAssignDataUtils.GetStageSpecialTeamCfg(stageId) or {}
  for slot, v in ipairs(specialTeamAssignCfg.data_list or {}) do
    if v.AwakerIndex == awakerTid then
      local cfgAssignAwakerType = v.IsOwnedAwaker or cd.TeamAssignAwaker.UseOwnedAwaker
      if cd.TeamAssignAwakerFixedSlot[cfgAssignAwakerType] then
        return slot
      end
    end
  end
end

function TeamAssignDataUtils._GetRealAwakerId(awakerId)
  local isReal = awakerId ~= ePosState.FreeBattlePos and awakerId ~= ePosState.BanBattlePos
  return isReal and awakerId or 0
end

function TeamAssignDataUtils.GetSpecialTeamForbids(specialTeamIndex)
  local specialTeamCfg = specialTeamIndex and DT.SpecialTeamAssign[specialTeamIndex] or {}
  local firstRow = specialTeamCfg and specialTeamCfg.data_list and specialTeamCfg.data_list[1]
  do return table.clone end
  return table.clone, firstRow and firstRow.BanAwakerList or {}
end

function TeamAssignDataUtils.GetTeamBuildPanelDataByPreviewAwakersData(previewAwakersData, callFunc)
  local awakerDataMap = {}
  for _, awakerData in pairs(previewAwakersData.awakers) do
    awakerDataMap[awakerData.tid] = awakerData
  end
  local panelData = {
    previewAwakersData = previewAwakersData,
    teamMode = TeamAssign.eStageTeamMode.Preview,
    awakerDataMap = awakerDataMap
  }
  return panelData
end

function TeamAssignDataUtils.GetTeamBuildPanelDataWithoutStageCfg(callFunc)
  local teamMode = TeamAssign.eStageTeamMode.Normal
  local tempAwakerDataMap = TeamAssignDataUtils.GetAwakerDataMap(teamMode)
  local panelData = {awakerDataMap = tempAwakerDataMap, teamMode = teamMode}
  return panelData
end

function TeamAssignDataUtils.GetTeamBuildPanelDataByStageCfg(stageCfg, callFunc)
  local stageGroupId = stageCfg.BelongGroup
  local teamMode = TeamAssignDataUtils.GetTeamModeBySpecialTeamIdx(stageCfg.SpecialTeamIndex)
  local teamType = teamMode == eStageTeamMode.Special and CommonDefine.TeamType.Special or CommonDefine.TeamType.Normal
  local tempAwakerDataMap = TeamAssignDataUtils.GetAwakerDataMap(teamMode, stageCfg)
  local cachedTeamData = TeamAssignDataUtils.GetBattleAwakerTids(teamMode, stageCfg)
  local tSlotState, tFakeAwakerDatas = TeamAssignDataUtils.GetBattlePosState(stageCfg.SpecialTeamIndex)
  local panelData = {
    awakerDataMap = tempAwakerDataMap,
    fakeAwakerTids = cachedTeamData,
    recommandSchoolTids = stageCfg.RecClass,
    challengeFunc = callFunc,
    recommandScore = stageCfg.RecScore,
    stageGroupType = DT.StageGroup[stageGroupId].Type,
    stageId = stageCfg.ID,
    tSlotState = tSlotState,
    tFakeAwakerDatas = tFakeAwakerDatas,
    teamMode = teamMode,
    teamType = teamType,
    specialTeamIndex = stageCfg.SpecialTeamIndex,
    specialTeamForbids = TeamAssignDataUtils.GetSpecialTeamForbids(stageCfg.SpecialTeamIndex)
  }
  return panelData
end

function TeamAssignDataUtils.GetSpecialSlotCfg(stageId, slotIndex)
  local specialTeamCfg = stageId and TeamAssignDataUtils.GetStageSpecialTeamCfg(stageId)
  local cfg = specialTeamCfg and specialTeamCfg.data_list[slotIndex]
  return cfg or {}
end

function TeamAssignDataUtils.GetSlotCanInputAwakers(stageId, slotIndex, ownedAwakerMap, fakeAwakerDatas)
  local list = {}
  local slotCfg = TeamAssignDataUtils.GetSpecialSlotCfg(stageId, slotIndex)
  if not table.next(slotCfg) then
    do return table.values end
    return table.values, ownedAwakerMap, nil, nil
  end
  if slotCfg.AwakerIndex == cd.TeamAssign.ePosState.BanBattlePos then
    return {}
  end
  if slotCfg.AwakerIndex == cd.TeamAssign.ePosState.FreeBattlePos then
    do return table.values end
    return table.values, ownedAwakerMap, nil, nil
  end
  local tid = tonumber(slotCfg.AwakerIndex)
  if slotCfg.IsOwnedAwaker == cd.TeamAssignAwaker.SwitchSameAwaker then
    if fakeAwakerDatas[tid] then
      table.insert(list, fakeAwakerDatas[tid])
    end
    if ownedAwakerMap[tid] then
      table.insert(list, ownedAwakerMap[tid])
    end
    return list
  end
  if slotCfg.IsOwnedAwaker == cd.TeamAssignAwaker.Trail then
    list = table.values(ownedAwakerMap)
    if fakeAwakerDatas[tid] then
      table.insert(list, fakeAwakerDatas[tid])
    end
    return list
  end
  if not slotCfg.IsOwnedAwaker or slotCfg.IsOwnedAwaker == cd.TeamAssignAwaker.UseConfigData then
    do return table.values end
    return table.values, ownedAwakerMap, fakeAwakerDatas[tid]
  end
  do return table.values end
  return table.values, ownedAwakerMap, fakeAwakerDatas[tid]
end

function TeamAssignDataUtils.GetQuickBuildAwakers(stageId, ownedAwakerMap, fakeAwakerDatas)
  local map = {}
  for i = 1, 4 do
    local list = TeamAssignDataUtils.GetSlotCanInputAwakers(stageId, i, ownedAwakerMap, fakeAwakerDatas)
    for _, data in ipairs(list) do
      map[data.tid] = data
    end
  end
  do return table.values end
  return table.values, map, 1, nil, TeamAssignDataUtils.GetSlotCanInputAwakers(stageId, i, ownedAwakerMap, fakeAwakerDatas), ipairs(list)
end

function TeamAssignDataUtils.GetStageSpecialTeamId(stageId)
  local stageCfg = CopyDataUtils.GetStageCfg(stageId)
  return stageCfg and stageCfg.SpecialTeamIndex
end

function TeamAssignDataUtils.GetStageSpecialTeamCfg(stageId)
  local SpecialTeamIndex = TeamAssignDataUtils.GetStageSpecialTeamId(stageId)
  return SpecialTeamIndex and DT.SpecialTeamAssign[SpecialTeamIndex]
end

function TeamAssignDataUtils.GetStageSpecialKeeperSkill(stageId)
  local teamAssignCfg = TeamAssignDataUtils.GetStageSpecialTeamCfg(stageId or 0)
  if teamAssignCfg and teamAssignCfg.data_list and teamAssignCfg.data_list[1] then
    return teamAssignCfg.data_list[1].KeeperSkill
  end
end

function TeamAssignDataUtils.IsForbidCopyTeam(stageId)
  local specialTeamCfg = TeamAssignDataUtils.GetStageSpecialTeamCfg(stageId)
  if not specialTeamCfg then
    return false
  end
  for _, v in ipairs(specialTeamCfg.data_list) do
    if v.AwakerIndex == CommonDefine.TeamAssign.ePosState.BanBattlePos then
      return true
    end
  end
end

function TeamAssignDataUtils.FilterAwakerSchool(awakerList, schoolType, curTeamAwakers)
  if not schoolType or 0 == schoolType then
    return awakerList
  end
  local ignoreSchoolMap = {}
  for _, tid in ipairs(curTeamAwakers or {}) do
    ignoreSchoolMap[tid] = true
  end
  for i = #awakerList, 1, -1 do
    local awaker = awakerList[i]
    local awakerTid = awaker.tid
    local config = DT.AwakerConfig[awakerTid]
    if ignoreSchoolMap[awakerTid] then
    elseif config and config.School ~= schoolType then
      table.remove(awakerList, i)
    end
  end
  return awakerList
end

function TeamAssignDataUtils.IsExistPresetAwaker(specialTeamIndex)
  if not specialTeamIndex then
    return false
  end
  local tCfg = TeamAssignDataUtils.GetSpecialTeamAssignCfg(specialTeamIndex)
  if not table.next(tCfg) then
    return false
  end
  for i, v in ipairs(tCfg.data_list) do
    local awakerId = v.AwakerIndex
    if awakerId ~= ePosState.FreeBattlePos and awakerId ~= ePosState.BanBattlePos and (not v.IsOwnedAwaker or v.IsOwnedAwaker ~= cd.TeamAssignAwaker.UseOwnedAwaker) then
      return true
    end
    if v.IsOwnedAwaker == cd.TeamAssignAwaker.SwitchSameAwaker or v.IsOwnedAwaker == cd.TeamAssignAwaker.Trail then
      return true
    end
  end
  return false
end

function TeamAssignDataUtils.GetTeamModeBySpecialTeamIdx(specialTeamIndex)
  local rst = eStageTeamMode.Normal
  if not specialTeamIndex then
    return rst
  end
  local tCfg = TeamAssignDataUtils.GetSpecialTeamAssignCfg(specialTeamIndex)
  if not table.next(tCfg) then
    return rst
  end
  for i, v in ipairs(tCfg.data_list) do
    local awakerId = v.AwakerIndex
    local isUseOwnedAwaker = v.IsOwnedAwaker == cd.TeamAssignAwaker.UseOwnedAwaker
    if awakerId ~= ePosState.FreeBattlePos and not isUseOwnedAwaker then
      return eStageTeamMode.Special
    end
  end
  return rst
end

function TeamAssignDataUtils.GetSpecialTeamAssignCfg(specialTeamIndex)
  if not specialTeamIndex then
    return {}
  end
  local tCfg = DT.SpecialTeamAssign[specialTeamIndex]
  if not tCfg then
    return {}
  end
  return tCfg
end

function TeamAssignDataUtils.GetIsOwnedAwakerTid(specialTeamIndex)
  local tCfg = TeamAssignDataUtils.GetSpecialTeamAssignCfg(specialTeamIndex)
  if not table.next(tCfg) then
    return nil
  end
  for i, v in ipairs(tCfg.data_list) do
    local awakerId = v.AwakerIndex
    if awakerId ~= ePosState.FreeBattlePos and awakerId ~= ePosState.BanBattlePos and v.IsOwnedAwaker and v.IsOwnedAwaker == cd.TeamAssignAwaker.UseOwnedAwaker then
      return awakerId
    end
  end
  return nil
end

function TeamAssignDataUtils.IsTeamPanelShowGroupToggle(teamMode)
  return eStageTeamMode.Normal == teamMode
end

return TeamAssignDataUtils
