local PVPTeamBuildData = DataCenter.pvpTeamBuildData
local PvPTeamBuildDataUtils = {}

function PvPTeamBuildDataUtils.Reset()
  PVPTeamBuildData.teamDataGroup = {}
end

function PvPTeamBuildDataUtils.InitBySvrData(svrData)
  PvPTeamBuildDataUtils.SetTeamData(svrData.teams)
  PvPTeamBuildDataUtils.SetLastChooseTeam(svrData.chooseIdx)
end

function PvPTeamBuildDataUtils.InitByTestData()
  local testData = {
    [1] = {
      name = "TestTeam",
      awakerList = {
        {tid = 1},
        {tid = 3},
        {tid = 4},
        {tid = 5}
      },
      weaponList = {
        {tid = 45},
        {tid = 46},
        {tid = 47},
        {tid = 48}
      },
      keeperSkillList = {
        {tid = 120},
        {tid = 121}
      }
    }
  }
  PvPTeamBuildDataUtils.SetTeamData(testData)
end

function PvPTeamBuildDataUtils.OpenPvPTeamBuildMainPanel()
  if PVPTeamBuildData.teamDataGroup and not table.next(PVPTeamBuildData.teamDataGroup) then
    PvPTeamBuildDataUtils.ReqOnOpenTeam(function()
      UIManager.Instance:Reopen(Urls.PvPTeamBuildMainPanel)
    end)
    return
  end
  PvPTeamBuildDataUtils.ReqOnOpenTeam()
  UIManager.Instance:Reopen(Urls.PvPTeamBuildMainPanel)
end

function PvPTeamBuildDataUtils.OpenPvPTeamSingleBuildPanel(model, type, idx)
  UIManager.Instance:Reopen(Urls.PvPTeamSingleBuildPanel, model, type, idx)
end

function PvPTeamBuildDataUtils.OpenPvPTeamMultiBuildPanel(model)
  UIManager.Instance:Reopen(Urls.PvPTeamMultiBuildPanel, model)
end

function PvPTeamBuildDataUtils.ReqOnChooseTeam(teamIdx, callback)
  PvPTeamBuildDataUtils.SetLastChooseTeam(teamIdx)
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("GameRequest", "OnChooseTeam", function(data)
    Logger.Info("========== 切换PvP编队成功 ==========\n", table.tostring(data or {}))
    if callback then
      callback()
    end
  end, function(data)
    Logger.Info("========== 切换PvP编队失败 ==========\n", table.tostring(data or {}))
  end, teamIdx)
end

function PvPTeamBuildDataUtils.ReqOnOpenTeam(callback)
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("GameRequest", "OnOpenPvpTeam", function(data)
    Logger.Info("========== 拉取PvP编队数据成功 ==========\n", table.tostring(data or {}))
    PvPTeamBuildDataUtils.InitBySvrData(data)
    if callback then
      callback()
    end
  end, function(data)
    Logger.Info("========== 拉取PvP编队数据失败 ==========\n", table.tostring(data or {}))
  end)
end

function PvPTeamBuildDataUtils.ReqTeamRename(teamIdx, newName, callback)
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("GameRequest", "OnRenamePvpTeam", function(data)
    Logger.Info("========== 修改PvP编队名成功 ==========\n", table.tostring(data or {}))
    PvPTeamBuildDataUtils.SetTeamNameByIdxKey(teamIdx, newName)
    if callback then
      callback()
    end
  end, function(data)
    Logger.Info("========== 修改PvP编队名失败 ==========\n", table.tostring(data or {}))
  end, teamIdx, newName)
end

function PvPTeamBuildDataUtils.ReqUpdateTeam(teamIdx, awakerTids, weaponTids, keeperSkillTids, callback)
  local sendTeamData = {
    awakerTids = table.clone(awakerTids),
    weaponTids = table.clone(weaponTids),
    keeperSkillTids = table.clone(keeperSkillTids)
  }
  
  local function CreateGroup(tids, targetGroup)
    for _, tid in ipairs(tids) do
      table.insert(targetGroup, {tid = tid})
    end
    return targetGroup
  end
  
  local newPvPTeamData = {
    awakerList = CreateGroup(awakerTids, {}),
    weaponList = CreateGroup(weaponTids, {}),
    keeperSkillList = CreateGroup(keeperSkillTids, {})
  }
  PvPTeamBuildDataUtils.UpdateTeamDataByTeamIdx(teamIdx, newPvPTeamData)
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("GameRequest", "OnUpdatePvpTeam", function(data)
    Logger.Info("========== 修改PvP编队成功 ==========\n", table.tostring(data or {}))
    if callback then
      callback()
    end
  end, function(data)
    Logger.Info("========== 修改PvP编队失败 ==========\n", table.tostring(data or {}))
  end, teamIdx, sendTeamData)
end

function PvPTeamBuildDataUtils.GetPvpRankCfgBySortId(sortId)
  local rst
  for _, cfg in pairs(DT.PVPRank) do
    if cfg.BaseSortID == sortId then
      rst = cfg
      break
    end
  end
  return rst
end

function PvPTeamBuildDataUtils.GetTeamDataByIdx(teamIdx, strKey)
  if not strKey then
    return PVPTeamBuildData.teamDataGroup[teamIdx]
  end
  return PVPTeamBuildData.teamDataGroup[teamIdx] and PVPTeamBuildData.teamDataGroup[teamIdx][strKey]
end

function PvPTeamBuildDataUtils.GetTeamNameByIdx(teamIdx)
  local defaultName = LT.Text("Formation_Default_TeamName_String" .. teamIdx)
  local teamData = PVPTeamBuildData.teamDataGroup[teamIdx]
  if not teamData then
    return defaultName
  end
  if not teamData.name or teamData.name == "" then
    teamData.name = defaultName
    return defaultName
  end
  return teamData.name
end

function PvPTeamBuildDataUtils.GetAwakerTidsByCollectTids(collectTids)
  local rst = {}
  for _, collectId in ipairs(collectTids) do
    if 0 == collectId then
      table.insert(rst, 0)
    else
      local awakerId = PvpCollectCfgUtils.GetAwakerTidByCollectTid(collectId)
      table.insert(rst, awakerId)
    end
  end
  return rst
end

function PvPTeamBuildDataUtils.GetLastChooseTeam()
  return PVPTeamBuildData.lastChooseTeam
end

function PvPTeamBuildDataUtils.GetPvpTeamBuildData()
  return PVPTeamBuildData
end

function PvPTeamBuildDataUtils.SetTeamData(tbl)
  PVPTeamBuildData.teamDataGroup = tbl
end

function PvPTeamBuildDataUtils.SetTeamNameByIdxKey(teamIdx, newName)
  PVPTeamBuildData.teamDataGroup[teamIdx].name = newName
end

function PvPTeamBuildDataUtils.UpdateTeamDataByTeamIdx(teamIdx, newData)
  for key, val in pairs(newData) do
    PVPTeamBuildData.teamDataGroup[teamIdx][key] = val
  end
end

function PvPTeamBuildDataUtils.SetLastChooseTeam(num)
  PVPTeamBuildData.lastChooseTeam = num
end

function PvPTeamBuildDataUtils.CheckSchoolConflict(tid, effectSchoolId)
  local awakerCfg = DT.AwakerConfig[PvpCollectCfgUtils.GetAwakerTidByCollectTid(tid)]
  if not awakerCfg then
    return false
  end
  local schoolCfg = DT.SchoolConfig[awakerCfg.School]
  local notChaos = schoolCfg.NameEn ~= CommonDefine.SchoolType.Chaos
  local notMatchSchool = effectSchoolId and awakerCfg.School ~= effectSchoolId
  local notEffectChaosSchool = effectSchoolId and DT.SchoolConfig[effectSchoolId].NameEn ~= CommonDefine.SchoolType.Chaos
  return notMatchSchool and notEffectChaosSchool and notChaos
end

function PvPTeamBuildDataUtils.CheckPositionConflict(tid, chosenPositionTids)
  local awakerCfg = AwakerDataUtils.GetAwakerConfig(PvpCollectCfgUtils.GetAwakerTidByCollectTid(tid))
  if not awakerCfg then
    return false
  end
  local positionTid = PvpCollectCfgUtils.GetCollectAwakerPvpPosition(tid)
  do return table.contains, chosenPositionTids end
  return table.contains, chosenPositionTids, positionTid
end

function PvPTeamBuildDataUtils.PasteTeamFromClipboard()
  local shareCode = StrUtils.PasteFromClipboard()
  print("-------------teamShareCode", shareCode)
  if not string.contains(shareCode, "@@") then
    do return end
    return PvPTeamBuildDataUtils.AlertPasterTeamError, shareCode, "@@", nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
  end
  shareCode = string.match(shareCode, "@@(.-)@@")
  if not shareCode then
    do return end
    return PvPTeamBuildDataUtils.AlertPasterTeamError, shareCode, "@@(.-)@@", nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
  end
  local awakerTids = {}
  local weaponTids = {}
  local keeperSkillTids = {}
  local loopIndex = 1
  local totalCount = #shareCode
  local shareCodeTable = {}
  for i = 1, #shareCode do
    shareCodeTable[i] = string.sub(shareCode, i, i)
  end
  local collectKeys = PvPTeamBuildDataUtils._GetCollectKeys()
  while loopIndex <= totalCount do
    local code = shareCodeTable[loopIndex]
    local codeNumber
    local step = 1
    if not TeamShareUtils.IsValidCode(code) then
      do return end
      return PvPTeamBuildDataUtils.AlertPasterTeamError, code, i, i
    end
    if not TeamShareUtils.IsMultipleCode(code) then
      codeNumber = TeamShareUtils.CodeToNumber(code)
      step = 1
    else
      local nextCode = shareCodeTable[loopIndex + 1]
      code = code .. nextCode
      codeNumber = TeamShareUtils.CodeToNumber(code)
      step = 2
    end
    local tid = 0 == codeNumber and 0 or collectKeys[codeNumber]
    if not codeNumber then
      do return end
      return PvPTeamBuildDataUtils.AlertPasterTeamError, code, i
    end
    if #awakerTids < CommonDefine.PvpTeamImportAwakerCount then
      table.insert(awakerTids, tid)
      if 0 ~= tid and PvpCollectCfgUtils.GetCollectionType(tid) ~= CommonDefine.PVPCollectionType.Awaker then
        do return end
        return PvPTeamBuildDataUtils.AlertPasterTeamError, CommonDefine.PVPCollectionType.Awaker, tid
      end
    elseif #weaponTids < CommonDefine.PvpTeamImportWeaponCount then
      table.insert(weaponTids, tid)
      if 0 ~= tid and PvpCollectCfgUtils.GetCollectionType(tid) ~= CommonDefine.PVPCollectionType.Weapon then
        do return end
        return PvPTeamBuildDataUtils.AlertPasterTeamError, CommonDefine.PVPCollectionType.Weapon, tid
      end
    else
      table.insert(keeperSkillTids, tid)
      if 0 ~= tid and PvpCollectCfgUtils.GetCollectionType(tid) ~= CommonDefine.PVPCollectionType.KeeperSkill then
        do return end
        return PvPTeamBuildDataUtils.AlertPasterTeamError, CommonDefine.PVPCollectionType.KeeperSkill, tid
      end
    end
    loopIndex = loopIndex + step
  end
  print("-------------------team code success", table.tostring(awakerTids), table.tostring(weaponTids), table.tostring(keeperSkillTids))
  UIManager.Instance:Reopen(Urls.PvpTeamImportView, awakerTids, weaponTids, keeperSkillTids)
end

function PvPTeamBuildDataUtils.AlertPasterTeamError()
  Alert.Show("PVPTeamShareCodeError")
end

function PvPTeamBuildDataUtils._GetCollectKeys()
  if PvPTeamBuildDataUtils._collectKeys then
    return PvPTeamBuildDataUtils._collectKeys
  end
  local keys = table.keys(DT.PVPCollect)
  table.sort(keys)
  PvPTeamBuildDataUtils._collectKeys = keys
  return keys
end

function PvPTeamBuildDataUtils.GetTeamShareContentByTeamIdx(teamIdx)
  local teamData = PvPTeamBuildDataUtils.GetTeamDataByIdx(teamIdx)
  if not teamData then
    return nil
  end
  print("------------GetTeamShareContentByTeamIdx", table.tostring(teamData))
  local awakerTids = teamData.awakerList
  local weaponTids = teamData.weaponList
  local keeperSkillTids = teamData.keeperSkillList
  local teamName = teamData.name
  do return PvPTeamBuildDataUtils.GetTeamShareContent, awakerTids, weaponTids, keeperSkillTids end
  return PvPTeamBuildDataUtils.GetTeamShareContent, awakerTids, weaponTids, keeperSkillTids, teamName
end

function PvPTeamBuildDataUtils.GetTeamShareCode(awakerTids, weaponTids, keeperSkillTids)
  local tidList = {}
  local collectKeys = PvPTeamBuildDataUtils._GetCollectKeys()
  for _, list in ipairs({
    awakerTids or {},
    weaponTids or {},
    keeperSkillTids or {}
  }) do
    for _, data in ipairs(list) do
      local tid = data.tid or 0
      local tidIndex = table.indexof(collectKeys, tid) or 0
      local tidCode = TeamShareUtils.NumberToCode(tidIndex)
      table.insert(tidList, tidCode)
    end
  end
  local code = table.concat(tidList, "")
  do return string.format, "@@%s@@" end
  return string.format, "@@%s@@", code, keeperSkillTids or {}, nil, ipairs(list)
end

function PvPTeamBuildDataUtils.GetTeamShareContent(awakerTids, weaponTids, keeperSkillTids, teamName)
  local shareContent = LT.Text("PVPTeamShareCode")
  local replaceMap = {}
  replaceMap[0] = PvPTeamBuildDataUtils.GetTeamShareCode(awakerTids, weaponTids, keeperSkillTids)
  replaceMap[1] = PlayerDataUtils.GetName()
  replaceMap[2] = PlayerDataUtils.GetPlayerUid()
  replaceMap[3] = teamName or LT.Text(teamName) or "-"
  local replaceIndex2Name = {
    [12] = {keeperSkillTids, 1},
    [7] = {awakerTids, 4},
    [6] = {awakerTids, 3},
    [5] = {awakerTids, 2},
    [4] = {awakerTids, 1},
    [13] = {keeperSkillTids, 2},
    [11] = {weaponTids, 4},
    [10] = {weaponTids, 3},
    [9] = {weaponTids, 2},
    [8] = {weaponTids, 1}
  }
  for index, data in pairs(replaceIndex2Name) do
    local tids = data[1]
    local count = data[2]
    for i = 1, count do
      local tid = tids[i] and tids[i].tid
      replaceMap[index] = tid and PvpCollectCfgUtils.GetCollectionName(tid) or "-"
    end
  end
  for k, v in pairs(replaceMap) do
    shareContent = shareContent:replace(string.format("{%s}", k), v)
  end
  StrUtils.CopyToClipboard(shareContent)
  return shareContent
end

return PvPTeamBuildDataUtils
