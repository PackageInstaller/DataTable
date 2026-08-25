local MAX_TEAM_NUM = 20
local DBGTeamDataUtils = {}

function DBGTeamDataUtils.ResetAll()
  Logger.ReportApusInfo("DBGTeam ResetTeamData")
  DataCenter.dbgTeamData.allTeams = {}
  DataCenter.dbgTeamData.reqTeamTypes = {}
  DataCenter.dbgTeamData.recommendedSchoolID = 0
  DataCenter.dbgTeamData.specialKeeperSkill = nil
  DataCenter.dbgTeamData.clearForbiddenAwakers = false
end

function DBGTeamDataUtils.GetAllTeamsData()
  return DataCenter.dbgTeamData.allTeams
end

function DBGTeamDataUtils.GetTeamsDataByType(teamType)
  if nil == teamType then
    return nil
  end
  local allTeams = DBGTeamDataUtils.GetAllTeamsData()
  allTeams[teamType] = allTeams[teamType] or {}
  return allTeams[teamType]
end

function DBGTeamDataUtils.EnterDBGTeamPanel(panelData)
  local teamType = CommonDefine.TeamType.Normal
  if panelData.previewAwakersData then
    UIManager.Instance:Reopen(Urls.DBGTeamBuildMainPanel, panelData)
    return
  end
  if panelData.teamMode == CommonDefine.TeamAssign.eStageTeamMode.Special then
    teamType = CommonDefine.TeamType.Special
  end
  DBGTeamDataUtils.ReqShowTeam(teamType, function()
    UIManager.Instance:Reopen(Urls.DBGTeamBuildMainPanel, panelData)
  end)
end

function DBGTeamDataUtils.ReqShowTeam(teamType, callBack)
  if DataCenter.dbgTeamData.reqTeamTypes[teamType] then
    if callBack then
      callBack()
    end
    return
  end
  Logger.ReportApusInfo("DBGTeam ReqShowTeam")
  ProtoManager.Instance:ReqServer("GameRequest", "ShowTeam", function(data)
    DataCenter.dbgTeamData.reqTeamTypes[teamType] = true
    Logger.ReportApusInfo("DBGTeam ReqShowTeamSuccessful")
    DBGTeamDataUtils.ParseShowTeamData(teamType, data)
    if callBack then
      callBack()
    end
  end, nil, teamType)
end

function DBGTeamDataUtils.RefreshAllReqShowTeam()
  local reqTeamTypes = DataCenter.dbgTeamData.reqTeamTypes
  local refreshTypes = {}
  for teamType, reqed in pairs(reqTeamTypes) do
    if reqed then
      table.insert(refreshTypes, teamType)
    end
  end
  for _, teamType in ipairs(refreshTypes) do
    reqTeamTypes[teamType] = nil
    DBGTeamDataUtils.ReqShowTeam(teamType, function()
      GlobalDispatcher:Dispatch(NotifyId.OnTeamCacheRefreshed, teamType)
    end)
  end
end

function DBGTeamDataUtils.ReqStageSpecialAwakerDataAttrs(stageId)
  local specialTeamId = TeamAssignDataUtils.GetStageSpecialTeamId(stageId)
  if specialTeamId and TeamAssignDataUtils.IsExistPresetAwaker(specialTeamId) then
    DBGTeamDataUtils.ReqSpecialTeamAwakerDataAttrs(specialTeamId)
  end
end

function DBGTeamDataUtils.ReqSpecialTeamAwakerDataAttrs(specialTeamId)
  ProtoManager.Instance:ReqServer("StageRequest", "GetStageSpecialAwakerData", function(data)
    Logger.Info("ReqSpecialTeamAwakerDataAttrs", table.tostring(data, 5))
    EventMgr.Instance.OnTeamSpecialAwakerAttr:Dispatch(data)
  end, nil, specialTeamId)
end

function DBGTeamDataUtils.IsTeamUnlocked(teamType, index)
  if index <= cd.StartUnlockTeamIndex then
    return true
  end
  local teamsData = DBGTeamDataUtils.GetTeamsDataByType(teamType)
  if not teamsData or not teamsData.teamsUnlock then
    return false
  end
  return teamsData.teamsUnlock[index]
end

function DBGTeamDataUtils.ReqUnlockTeam(teamType, index, callback)
  if not DBGTeamDataUtils.IsTeamUnlocked(teamType, index) then
    if not DBGTeamDataUtils.IsTeamUnlocked(teamType, index - 1) then
      Alert.Show(10915)
      return
    end
    local costList = DT.GetOriginalConstant("TeamUnlockCost_11To20")
    local unlockIndex = index - CommonDefine.StartUnlockTeamIndex
    local costItem = costList[unlockIndex * 2 - 1]
    local costItemName = ItemDataUtils.GetItemName(costItem)
    local costNum = costList[unlockIndex * 2]
    Alert.ShowWithParams(10916, {costItemName, costNum}, nil, function()
      if not ItemDataUtils.IsItemEnough(costItem, costNum) and costItem == cd.CurrencyType.SeniorMoney then
        local ownedNum = ItemDataUtils.GetItemNum(costItem) or 0
        DiamondShopDataUtils.RechargeTips(costNum - ownedNum, function()
        end)
        return
      end
      if not ItemDataUtils.IsItemEnough(costItem, costNum, true) then
        return
      end
      DBGTeamDataUtils._DoReqUnlockTeam(teamType, index, callback)
    end)
    Alert.ShowCoin(DT.GetOriginalConstant("TeamUnlockCostCurrencies"), true)
    return
  end
end

function DBGTeamDataUtils._DoReqUnlockTeam(teamType, index, callback)
  ProtoManager.Instance:ReqServer("GameRequest", "UnlockTeam", function(data)
    Logger.ReportApusInfo("DBGTeam UnlockTeam")
    local teamName = LT.Text("Team") .. " " .. index
    if 20 ~= index then
      Alert.ShowWithParams(10917, {teamName})
    else
      Alert.ShowWithParams(10918, {teamName})
    end
    local teamsData = DBGTeamDataUtils.GetTeamsDataByType(teamType)
    teamsData.teamsUnlock = teamsData.teamsUnlock or {}
    teamsData.teamsUnlock[index] = true
    if callback then
      callback()
    end
  end, nil, teamType, index)
end

function DBGTeamDataUtils.UpdateTeam(sendData)
  if sendData.teamMode == CommonDefine.TeamAssign.eStageTeamMode.Preview then
    return
  end
  if DBGTeamDataUtils.CheckTakeOffInValid(sendData) then
    return
  end
  local teamType = sendData.teamType
  sendData.keeperSkill = sendData.keeperSkill or KeeperSkillUtils.GetDefaultItem()
  
  local function successCb(data)
    Logger.Info("UpdateTeam successful ", table.tostring(data))
    local teamsData = DBGTeamDataUtils.GetTeamsDataByType(teamType)
    teamsData.teams = teamsData.teams or {}
    teamsData.teams[sendData.teamIdx] = teamsData.teams[sendData.teamIdx] or {}
    local teamDt = teamsData.teams[sendData.teamIdx]
    teamDt.awakerTids = sendData.awakerTids
    teamDt.name = sendData.name
    teamDt.keeperSkill = sendData.keeperSkill
    teamDt.schoolTid = data.schoolTid
    teamDt.awakers = data.awakers
    teamsData.lastSelectTeam = sendData.teamIdx
    if sendData.callback then
      local teamInfo = table.deepclone(teamDt)
      sendData.callback(teamInfo)
    end
  end
  
  local function failCb()
    Logger.Debug("UpdateTeam Error")
  end
  
  local equipData = {}
  for tid, info in pairs(sendData.awakerEquipData) do
    if tid and tid > 0 then
      equipData[tid] = info
    end
  end
  Logger.ReportApusInfo("DBGTeam UpdateTeam")
  ProtoManager.Instance:ReqServer("GameRequest", "UpdateTeam", successCb, failCb, sendData.teamType, equipData, sendData.teamIdx, sendData.name, sendData.keeperSkill, sendData.awakerTids)
end

function DBGTeamDataUtils.CheckTakeOffInValid(sendData)
  local takeOffAllEquipAwakerNum = 0
  for awakerTid, equipData in pairs(sendData.awakerEquipData) do
    local isClientEquipTrinketEmpty = DBGTeamDataUtils.CheckEquipEmpty(equipData.trinkets)
    local isClientEquipWeaponEmpty = DBGTeamDataUtils.CheckEquipEmpty(equipData.weapons)
    local svrEquipData = DBGTeamDataUtils.GetDbgTeamsAwakerEquipData(sendData.teamType, sendData.teamIdx, awakerTid)
    local svrTrinketEquipData = svrEquipData and svrEquipData.trinket and svrEquipData.trinket.trinkets
    local svrWeaponEquipData = svrEquipData and svrEquipData.weaponSlots
    local isSvrEquipTrinketEmpty = DBGTeamDataUtils.CheckEquipEmpty(svrTrinketEquipData)
    local isSvrEquipWeaponEmpty = DBGTeamDataUtils.CheckEquipEmpty(svrWeaponEquipData)
    local isTakeOffAllWeapon = isClientEquipWeaponEmpty and not isSvrEquipWeaponEmpty
    local isTakeOffAllTrinket = isClientEquipTrinketEmpty and not isSvrEquipTrinketEmpty
    if isTakeOffAllWeapon or isTakeOffAllTrinket then
      takeOffAllEquipAwakerNum = takeOffAllEquipAwakerNum + 1
    end
    if takeOffAllEquipAwakerNum > 2 then
      return true
    end
  end
  return false
end

function DBGTeamDataUtils.CheckEquipEmpty(equipList)
  if not equipList or not table.next(equipList) then
    return true
  end
  for _, equipId in pairs(equipList) do
    if 0 ~= equipId then
      return false
    end
  end
  return true
end

function DBGTeamDataUtils.ParseShowTeamData(teamType, data)
  Logger.ReportApusInfo("DBGTeam ParseShowTeamData")
  local allTeams = DBGTeamDataUtils.GetAllTeamsData()
  allTeams[teamType] = allTeams[teamType] or {}
  local teamDataOfType = allTeams[teamType]
  teamDataOfType.teams = data.teams
  teamDataOfType.lastSelectTeam = data.lastSelectTeam
  teamDataOfType.teamsUnlock = data.teamsUnlock
end

function DBGTeamDataUtils.ParseShowOneTeamData(teamType, idx, teamData)
  Logger.ReportApusInfo("DBGTeam ParseShowOneTeamData")
  local teamsData = DBGTeamDataUtils.GetTeamsDataByType(teamType)
  teamsData.teams = teamsData.teams or {}
  teamsData.teams[idx] = teamData
end

function DBGTeamDataUtils.GetDBGTeams(teamtype)
  local teamsData = DBGTeamDataUtils.GetTeamsDataByType(teamtype)
  if not teamsData then
    return {}
  end
  return teamsData.teams or {}
end

function DBGTeamDataUtils.GetDbgTeamsAwakerEquipData(teamType, teamIdx, awakerTid)
  local teamsData = DBGTeamDataUtils.GetTeamsDataByType(teamType)
  if not teamsData then
    return
  end
  local teams = teamsData.teams
  return teams and teams[teamIdx] and teams[teamIdx].awakers and teams[teamIdx].awakers[awakerTid]
end

function DBGTeamDataUtils.GetDBGLastSelectTeam(teamType)
  local teamsData = DBGTeamDataUtils.GetTeamsDataByType(teamType)
  local lastSelectTeam = teamsData and teamsData.lastSelectTeam or nil
  return lastSelectTeam
end

function DBGTeamDataUtils.GetDBGTeamName(teamtype, idx)
  local teamData = DBGTeamDataUtils.GetDBGTeams(teamtype)[idx]
  if teamData and teamData.name and teamData.name ~= "nil" then
    return teamData.name
  end
  return LT.Text("Team") .. idx
end

function DBGTeamDataUtils.DealCfgNegativeAwakers(awakerTids)
  local awakers = {}
  for i, tid in ipairs(awakerTids) do
    awakers[i] = tid < 0 and 0 or tid
  end
  return awakers
end

function DBGTeamDataUtils.GetWeaponInTeamIdx(teamType, checkWeaponUid)
  if not checkWeaponUid or 0 == checkWeaponUid then
    return nil
  end
  local teamsData = DBGTeamDataUtils.GetDBGTeams(teamType)
  for i = 1, MAX_TEAM_NUM do
    local teamData = teamsData[i]
    if teamData and teamData.awakers then
      for _, awakersData in pairs(teamData.awakers) do
        for _, weaponSlot in pairs(AwakerDataUtils.GetWeaponSlotData(awakersData)) do
          if weaponSlot and weaponSlot.weaponUid and weaponSlot.weaponUid == checkWeaponUid then
            return i
          end
        end
      end
    end
  end
  return nil
end

function DBGTeamDataUtils.IsTogetherWithSSRWeapon(weaponUid, teamType)
  local QualitySSR = cd.CommonQuality.Orange
  if not weaponUid or 0 == weaponUid then
    return false
  end
  if not teamType then
    return DBGTeamDataUtils.IsTogetherWithSSRWeapon(weaponUid, CommonDefine.TeamType.Normal) or DBGTeamDataUtils.IsTogetherWithSSRWeapon(weaponUid, CommonDefine.TeamType.Special)
  end
  local teamsData = teamType and DBGTeamDataUtils.GetDBGTeams(teamType)
  for _, teamData in pairs(teamsData) do
    if teamData and teamData.awakers then
      for _, awakersData in pairs(teamData.awakers) do
        local weaponSlotList = AwakerDataUtils.GetWeaponSlotData(awakersData)
        local isSSRWeapon = false
        local isSelfWeapon = false
        for _, weaponSlot in pairs(weaponSlotList) do
          if weaponSlot and weaponSlot.weaponUid then
            if weaponSlot.weaponUid == weaponUid then
              isSelfWeapon = true
            else
              local weaponData = ItemDataUtils.GetWeaponByUid(weaponSlot.weaponUid)
              local weaponTid = weaponData and weaponData.tid or 0
              local weaponCfg = ItemDataUtils.GetItemConfig(weaponTid)
              if weaponCfg and weaponCfg.Quality == QualitySSR and not ItemDataUtils.IsMaxLevelWeapon(weaponSlot.weaponUid) then
                isSSRWeapon = true
              end
            end
          end
        end
        if isSelfWeapon and isSSRWeapon then
          return true
        end
      end
    end
  end
  return false
end

function DBGTeamDataUtils.GetTrinketInTeamIdx(teamType, checkTrinketUid)
  if not checkTrinketUid or 0 == checkTrinketUid then
    return nil
  end
  local teamsData = DBGTeamDataUtils.GetDBGTeams(teamType)
  for i = 1, MAX_TEAM_NUM do
    local teamData = teamsData[i]
    if teamData and teamData.awakers then
      for _, awakersData in pairs(teamData.awakers) do
        for _, trinketUid in pairs(awakersData.trinket and awakersData.trinket.trinkets or {}) do
          if trinketUid == checkTrinketUid then
            return i
          end
        end
      end
    end
  end
  return nil
end

function DBGTeamDataUtils.GetTrinketInTeamIdxList(teamType, checkTrinketUid)
  local list = {}
  if not checkTrinketUid or 0 == checkTrinketUid then
    return list
  end
  local teamsData = DBGTeamDataUtils.GetDBGTeams(teamType)
  for i = 1, MAX_TEAM_NUM do
    local teamData = teamsData[i]
    if teamData and teamData.awakers then
      for _, awakersData in pairs(teamData.awakers) do
        for _, trinketUid in pairs(awakersData.trinket and awakersData.trinket.trinkets or {}) do
          if trinketUid == checkTrinketUid then
            list = list or {}
            table.insert(list, i)
          end
        end
      end
    end
  end
  return list
end

function DBGTeamDataUtils.SetDBGLastSelectTeam(teamType, val)
  local teamsData = DBGTeamDataUtils.GetTeamsDataByType(teamType)
  teamsData.lastSelectTeam = val
end

function DBGTeamDataUtils.SetSpecialKeeperSkill(skillId)
  DataCenter.dbgTeamData.specialKeeperSkill = skillId or KeeperSkillUtils.GetDefaultItem()
end

function DBGTeamDataUtils.GetSpecialKeeperSkill()
  return DataCenter.dbgTeamData.specialKeeperSkill or KeeperSkillUtils.GetDefaultItem()
end

function DBGTeamDataUtils.GetAwaker2TrinketsByTeamIdx(teamType, teamIdx)
  if not teamIdx then
    return
  end
  local teamDatas = DBGTeamDataUtils.GetDBGTeams(teamType)
  if not teamDatas then
    return
  end
  local currTeamData = teamDatas[teamIdx]
  if not currTeamData or not currTeamData.awakers then
    return
  end
  local awaker2Trinkets = {}
  for awakerTid, teamAwakerData in pairs(currTeamData.awakers) do
    if not (teamAwakerData and teamAwakerData.trinket) or not teamAwakerData.trinket.trinkets then
    else
      local trinketsCopy = {}
      for pos, uid in pairs(teamAwakerData.trinket.trinkets) do
        trinketsCopy[pos] = uid
      end
      awaker2Trinkets[awakerTid] = trinketsCopy
    end
  end
  return awaker2Trinkets
end

function DBGTeamDataUtils.GetSortItemKeys()
  local awakerKeys = table.keys(DT.AwakerConfig)
  local weaponKeys = {}
  local trinketKeys = {}
  local keeperSkillKeys = {}
  for id, cfg in pairs(DT.Item) do
    if cfg.Type == cd.ItemType.Weapon then
      table.insert(weaponKeys, id)
    elseif cfg.Type == cd.ItemType.Trinket then
      table.insert(trinketKeys, id)
    elseif cfg.Type == cd.ItemType.KeeperSkill then
      table.insert(keeperSkillKeys, id)
    end
  end
  table.sort(awakerKeys)
  table.sort(weaponKeys)
  table.sort(trinketKeys)
  table.sort(keeperSkillKeys)
  return awakerKeys, weaponKeys, trinketKeys, keeperSkillKeys
end

function DBGTeamDataUtils.GetSortSuitKeys()
  local suitKeys = table.keys(DT.TrinketSuitEffect or {})
  table.sort(suitKeys)
  return suitKeys
end

local function _GetFullSuitIdByTrinketTids(tids)
  if not tids or #tids < cd.TeamTrinketCount then
    return 0
  end
  local suitId
  local count = 0
  for j = 1, cd.TeamTrinketCount do
    local tid = tids[j]
    if not tid or 0 == tid then
      return 0
    end
    local s = AwakerTrinketDataUtils.GetSuitIdByItemTid(tid)
    if not s then
      return 0
    end
    if not suitId then
      suitId = s
    elseif suitId ~= s then
      return 0
    end
    count = count + 1
  end
  return count == cd.TeamTrinketCount and suitId or 0
end

function DBGTeamDataUtils.GetTeamShareCode(awakerTidList, weaponTidList, trinketsTidList, trinketsMainAttrList, keeperSkill)
  print("---------------get team share code", table.tostring(awakerTidList))
  local awakerKeys, weaponKeys, _, keeperSkillKeys = DBGTeamDataUtils.GetSortItemKeys()
  local suitKeys = DBGTeamDataUtils.GetSortSuitKeys()
  local code = ""
  for i = 1, cd.TeamAwakerCount do
    local awakerTid = awakerTidList[i]
    local awakerIndex = table.indexof(awakerKeys, awakerTid) or 0
    local awakerCode = TeamShareUtils.NumberToCode(awakerIndex)
    print("--------------awakerCode encode", awakerTid, awakerIndex, awakerCode)
    code = code .. awakerCode
  end
  for i = 1, cd.TeamAwakerCount do
    for j = 1, cd.TeamWeaponCount do
      local weaponTid = weaponTidList[i] and weaponTidList[i][j] or 0
      local weaponIndex = table.indexof(weaponKeys, weaponTid) or 0
      local weaponCode = TeamShareUtils.NumberToCode(weaponIndex)
      code = code .. weaponCode
    end
  end
  for i = 1, cd.TeamAwakerCount do
    local fullSuitId = _GetFullSuitIdByTrinketTids(trinketsTidList and trinketsTidList[i])
    local suitIndex = fullSuitId and 0 ~= fullSuitId and table.indexof(suitKeys, fullSuitId) or 0
    local trinketCode = TeamShareUtils.NumberToCode(suitIndex)
    code = code .. trinketCode
  end
  local keeperSkillIndex = table.indexof(keeperSkillKeys, keeperSkill) or 0
  local keeperSkillCode = TeamShareUtils.NumberToCode(keeperSkillIndex)
  code = code .. keeperSkillCode
  code = string.format("@@%s@@", code)
  return code
end

local function _ReadOneCode(shareCodeTable, loopIndex, totalCount)
  if totalCount < loopIndex then
    return nil
  end
  local code = shareCodeTable[loopIndex]
  if not TeamShareUtils.IsValidCode(code) then
    return nil
  end
  local codeNumber
  local step = 1
  if not TeamShareUtils.IsMultipleCode(code) then
    codeNumber = TeamShareUtils.CodeToNumber(code)
  else
    if totalCount < loopIndex + 1 then
      return nil
    end
    code = code .. shareCodeTable[loopIndex + 1]
    codeNumber = TeamShareUtils.CodeToNumber(code)
    step = 2
  end
  return codeNumber, step
end

function DBGTeamDataUtils.GetTeamFromShareCode(shareCode)
  if not string.contains(shareCode, "@@") then
    return
  end
  shareCode = string.match(shareCode, "@@(.-)@@")
  if not shareCode then
    return
  end
  local awakerKeys, weaponKeys, trinketKeys, keeperSkillKeys = DBGTeamDataUtils.GetSortItemKeys()
  local suitKeys = DBGTeamDataUtils.GetSortSuitKeys()
  local awakerTids = {}
  local weaponTids = {}
  local trinketTids = {}
  local keeperSkillTid = 0
  local loopIndex = 1
  local totalCount = #shareCode
  local shareCodeTable = {}
  for i = 1, #shareCode do
    shareCodeTable[i] = string.sub(shareCode, i, i)
  end
  while loopIndex <= totalCount do
    local code = shareCodeTable[loopIndex]
    local codeNumber
    local step = 1
    if not TeamShareUtils.IsValidCode(code) then
      Logger.Warn("-----------share code is not valid", code)
    else
      if not TeamShareUtils.IsMultipleCode(code) then
        codeNumber = TeamShareUtils.CodeToNumber(code)
        step = 1
      else
        local nextCode = shareCodeTable[loopIndex + 1]
        code = code .. nextCode
        codeNumber = TeamShareUtils.CodeToNumber(code)
        step = 2
      end
      if #awakerTids < cd.TeamAwakerCount then
        local awakerTid = 0 == codeNumber and 0 or awakerKeys[codeNumber]
        if 0 ~= awakerTid and (not awakerTid or not DT.AwakerConfig[awakerTid]) then
          return
        end
        table.insert(awakerTids, awakerTid)
      elseif #weaponTids < cd.TeamWeaponCount * cd.TeamAwakerCount then
        local weaponTid = 0 == codeNumber and 0 or weaponKeys[codeNumber]
        if 0 ~= weaponTid and (not (weaponTid and DT.Item[weaponTid]) or DT.Item[weaponTid].Type ~= cd.ItemType.Weapon) then
          return
        end
        table.insert(weaponTids, weaponTid)
      elseif #trinketTids < cd.TeamTrinketCount * cd.TeamAwakerCount then
        local remaining = totalCount - loopIndex + 1
        if 0 == #trinketTids and remaining <= 10 then
          local _ = trinketKeys
          local convertTrinketTids = {}
          local curIdx = loopIndex
          for _ = 1, cd.TeamAwakerCount do
            local suitIndex, sstep = _ReadOneCode(shareCodeTable, curIdx, totalCount)
            if nil == suitIndex then
              return
            end
            curIdx = curIdx + sstep
            local suitId = suitIndex and suitIndex > 0 and suitKeys[suitIndex] or 0
            local tids = AwakerTrinketDataUtils.GetTrinketTidsBySuitId(suitId)
            table.insert(convertTrinketTids, tids)
          end
          local ksIndex, sstep = _ReadOneCode(shareCodeTable, curIdx, totalCount)
          if nil == ksIndex then
            return
          end
          curIdx = curIdx + sstep
          keeperSkillTid = ksIndex and ksIndex > 0 and keeperSkillKeys[ksIndex] or 0
          if 0 ~= keeperSkillTid and (not DT.Item[keeperSkillTid] or DT.Item[keeperSkillTid].Type ~= cd.ItemType.KeeperSkill) then
            return
          end
          loopIndex = curIdx
          local convertWeaponTids = {}
          for i = 1, cd.TeamAwakerCount do
            convertWeaponTids[i] = {}
            for j = 1, cd.TeamWeaponCount do
              table.insert(convertWeaponTids[i], table.remove(weaponTids, 1))
            end
          end
          local teamInfo = {
            awakerTids = awakerTids,
            weaponTids = convertWeaponTids,
            trinketTids = convertTrinketTids,
            trinketMainAttrs = {},
            keeperSkill = keeperSkillTid
          }
          return teamInfo
        end
        local trinketTid = 0 == codeNumber and 0 or trinketKeys[codeNumber]
        if 0 ~= trinketTid and (not (trinketTid and DT.Item[trinketTid]) or DT.Item[trinketTid].Type ~= cd.ItemType.Trinket) then
          return
        end
        table.insert(trinketTids, trinketTid)
      else
        keeperSkillTid = 0 == codeNumber and 0 or keeperSkillKeys[codeNumber]
        if 0 ~= keeperSkillTid and (not (keeperSkillTid and DT.Item[keeperSkillTid]) or DT.Item[keeperSkillTid].Type ~= cd.ItemType.KeeperSkill) then
          return
        end
      end
    end
    loopIndex = loopIndex + step
  end
  local convertWeaponTids = {}
  for i = 1, cd.TeamAwakerCount do
    convertWeaponTids[i] = {}
    for j = 1, cd.TeamWeaponCount do
      table.insert(convertWeaponTids[i], table.remove(weaponTids, 1))
    end
  end
  local convertTrinketTids = {}
  for i = 1, cd.TeamAwakerCount do
    convertTrinketTids[i] = {}
    for j = 1, cd.TeamTrinketCount do
      table.insert(convertTrinketTids[i], table.remove(trinketTids, 1))
    end
  end
  local teamInfo = {
    awakerTids = awakerTids,
    weaponTids = convertWeaponTids,
    trinketTids = convertTrinketTids,
    trinketMainAttrs = {},
    keeperSkill = keeperSkillTid
  }
  print("-----------------convert to team info", table.tostring(teamInfo))
  return teamInfo
end

function DBGTeamDataUtils.ValidateShareTeamInfo(teamInfo)
  if not teamInfo or not teamInfo.awakerTids then
    return false, "empty"
  end
  local awakerTids = teamInfo.awakerTids
  local existMap = {}
  local schoolMap = {}
  for _, tid in ipairs(awakerTids) do
    if tid and 0 ~= tid then
      if existMap[tid] then
        return false, "duplicate"
      end
      existMap[tid] = true
      local cfg = DT.AwakerConfig[tid]
      if cfg and cfg.School then
        schoolMap[cfg.School] = true
      end
    end
  end
  local schoolCount = 0
  for _ in pairs(schoolMap) do
    schoolCount = schoolCount + 1
  end
  if schoolCount > CommonDefine.TeamMixSchoolCount then
    return false, "schoolLimit"
  end
  local weaponTids = teamInfo.weaponTids
  if weaponTids then
    local weaponExistMap = {}
    for _, weaponList in ipairs(weaponTids) do
      for _, wTid in ipairs(weaponList) do
        if wTid and 0 ~= wTid then
          if weaponExistMap[wTid] then
            return false, "duplicateWeapon"
          end
          weaponExistMap[wTid] = true
        end
      end
    end
  end
  local tidList = {}
  for tid in pairs(existMap) do
    table.insert(tidList, tid)
  end
  for i = 1, #tidList do
    for j = i + 1, #tidList do
      for _, group in ipairs(CommonDefine.AwakerFilterMutualExclusionGroups or {}) do
        local hasA, hasB = false, false
        for _, gTid in ipairs(group) do
          if gTid == tidList[i] then
            hasA = true
          elseif gTid == tidList[j] then
            hasB = true
          end
        end
        if hasA and hasB then
          return false, "mutualExclusion"
        end
      end
    end
  end
  return true
end

function DBGTeamDataUtils.NormalizeAssistItems(items)
  if not items then
    return nil
  end
  local rst = {}
  for _, item in pairs(items) do
    if item and item.uid then
      rst[item.uid] = item
    end
  end
  return rst
end

return DBGTeamDataUtils
