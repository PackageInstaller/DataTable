local tableInsert = table.insert
local tableSort = table.sort
local TeamAssign = CommonDefine.TeamAssign
local ePosState = TeamAssign.ePosState
local eStageTeamMode = TeamAssign.eStageTeamMode
local MaxBattleNum = CommonDefine.TeamAssign.MaxBattleNum
local TeamType = CommonDefine.TeamType
local MAX_TRINKGET_NUM = 6
local MAX_TEAM_NUM = 20

local function GetDefaultTeamTbl()
  return {
    awakerTidList = {
      0,
      0,
      0,
      0
    },
    isSelect = false,
    weaponsGroup = {
      {0, 0},
      {0, 0},
      {0, 0},
      {0, 0}
    },
    trinketsGroup = {
      {
        0,
        0,
        0,
        0,
        0,
        0
      },
      {
        0,
        0,
        0,
        0,
        0,
        0
      },
      {
        0,
        0,
        0,
        0,
        0,
        0
      },
      {
        0,
        0,
        0,
        0,
        0,
        0
      }
    },
    keeperSkillTid = KeeperSkillUtils.GetDefaultItem()
  }
end

local function CreateWeaponsGroup(teamData, targetTbl)
  local newWeaponsGroup = {}
  for idx, awakerTid in pairs(targetTbl.awakerTidList) do
    if teamData.awakers and teamData.awakers[awakerTid] then
      local tmpTbl = {}
      for weaponSlot, teamWeaponData in pairs(AwakerDataUtils.GetWeaponSlotData(teamData.awakers[awakerTid])) do
        tmpTbl[weaponSlot] = teamWeaponData.weaponUid
      end
      newWeaponsGroup[idx] = tmpTbl
    else
      newWeaponsGroup[idx] = {0, 0}
    end
  end
  return newWeaponsGroup
end

local function CreateTrinketsGroup(teamData, targetTbl)
  local newTrinketsGroup = {}
  for idx, awakerTid in pairs(targetTbl.awakerTidList) do
    if teamData.awakers and teamData.awakers[awakerTid] then
      local tmpTbl = {}
      local trinketUids = teamData.awakers[awakerTid].trinket and teamData.awakers[awakerTid].trinket.trinkets or {}
      for trinketSlot, trinketUid in pairs(trinketUids) do
        tmpTbl[trinketSlot] = trinketUid
      end
      newTrinketsGroup[idx] = tmpTbl
    else
      newTrinketsGroup[idx] = {
        0,
        0,
        0,
        0,
        0,
        0
      }
    end
  end
  for teamIdx = 1, #newTrinketsGroup do
    for slot = 1, MAX_TRINKGET_NUM do
      if not newTrinketsGroup[teamIdx][slot] then
        newTrinketsGroup[teamIdx][slot] = 0
      end
    end
  end
  return newTrinketsGroup
end

local function FindSourceTeamDataForTeamTbl(sourceTeams, teamTbl)
  if not (teamTbl and teamTbl.awakerTidList) or not sourceTeams then
    return nil
  end
  for _, data in pairs(sourceTeams) do
    if data and data.awakerTids == teamTbl.awakerTidList then
      return data
    end
  end
  return nil
end

local function FindSourceTeamByTidContents(sourceTeams, teamTbl)
  if not (teamTbl and teamTbl.awakerTidList) or not sourceTeams then
    return nil
  end
  for _, data in pairs(sourceTeams) do
    if data and data.awakerTids then
      local same = true
      for i = 1, MaxBattleNum do
        if (data.awakerTids[i] or 0) ~= (teamTbl.awakerTidList[i] or 0) then
          same = false
          break
        end
      end
      if same then
        return data
      end
    end
  end
  return nil
end

local function IsSameTrinketsGroup(groupA, groupB)
  for idx = 1, MaxBattleNum do
    local trinketsA = groupA and groupA[idx]
    local trinketsB = groupB and groupB[idx]
    for slot = 1, MAX_TRINKGET_NUM do
      local uidA = trinketsA and trinketsA[slot] or 0
      local uidB = trinketsB and trinketsB[slot] or 0
      if uidA ~= uidB then
        return false
      end
    end
  end
  return true
end

local function IsCopyAssistMirroredInAssistSlot(slotIndex, tid)
  if slotIndex ~= CommonDefine.TeamAssign.MaxBattleNum then
    return false
  end
  local copies = DataCenter.copiesData
  if not copies then
    return false
  end
  local assistTid = copies.AssistAwakerTid or 0
  local assistPlayerUid = copies.AssistPlayerUid or 0
  return assistTid == tid and 0 ~= assistTid and 0 ~= assistPlayerUid
end

local function SanitizeAwakerTidListOwnedOrFake(teamMode, tFakeAwakerDatas, awakerTidList)
  local maxNum = CommonDefine.TeamAssign.MaxBattleNum
  for i = 1, maxNum do
    local tid = awakerTidList[i]
    if tid and 0 ~= tid then
      local isSpecialPresetFake = teamMode == eStageTeamMode.Special and tFakeAwakerDatas and tFakeAwakerDatas[tid * -1] ~= nil
      local isCopyAssistSlotTid = IsCopyAssistMirroredInAssistSlot(i, tid)
      if not isSpecialPresetFake and not isCopyAssistSlotTid and not AwakerDataUtils.HasOwnedAwaker(tid) then
        awakerTidList[i] = 0
      end
    end
  end
end

local function SanitizeTempTeamsOwnedAwakers(tempTeams, sourceTeams, teamMode, tFakeAwakerDatas)
  for key, teamTbl in pairs(tempTeams) do
    if teamTbl and teamTbl.awakerTidList then
      SanitizeAwakerTidListOwnedOrFake(teamMode, tFakeAwakerDatas, teamTbl.awakerTidList)
      local dbgTeam = sourceTeams[key] or FindSourceTeamDataForTeamTbl(sourceTeams, teamTbl)
      if dbgTeam then
        teamTbl.weaponsGroup = CreateWeaponsGroup(dbgTeam, teamTbl)
        teamTbl.trinketsGroup = CreateTrinketsGroup(dbgTeam, teamTbl)
      end
    end
  end
end

local function CrearteDBGPanelTeamData(targetTbl, idx, dbgteamData)
  targetTbl[idx].awakerTidList = dbgteamData.awakerTids
  targetTbl[idx].weaponsGroup = CreateWeaponsGroup(dbgteamData, targetTbl[idx])
  targetTbl[idx].trinketsGroup = CreateTrinketsGroup(dbgteamData, targetTbl[idx])
  targetTbl[idx].keeperSkillTid = dbgteamData.keeperSkill
  return targetTbl
end

local function CreateNormalTypeTeam(teamType, inPutTeams)
  local rst = {}
  for i = 1, MAX_TEAM_NUM do
    table.insert(rst, GetDefaultTeamTbl())
    if not DBGTeamDataUtils.IsTeamUnlocked(teamType, i) then
      break
    end
  end
  local maxNum = CommonDefine.TeamAssign.MaxBattleNum
  for key, data in pairs(inPutTeams) do
    if data and data.awakerTids then
      if not data.awakerTids[maxNum] then
        data.awakerTids[maxNum] = 0
      end
      rst = CrearteDBGPanelTeamData(rst, key, data)
    end
  end
  return rst
end

local function CheckTeamIsEmpty(awakerTidList, fakeAwakerTids)
  for idx, tid in pairs(awakerTidList) do
    if (not fakeAwakerTids or 0 == fakeAwakerTids[idx]) and 0 ~= tid then
      return false
    end
  end
  return true
end

local function FilterBanAwakers(awakerTidList, model, stageId)
  local temp
  for slot, awakerTid in pairs(awakerTidList) do
    local slotCfg = TeamAssignDataUtils.GetSpecialSlotCfg(stageId, slot)
    local isSlotBanned = slotCfg.AwakerIndex == cd.TeamAssign.ePosState.BanBattlePos
    if isSlotBanned or model:IsBanAwaker(awakerTid, slot) then
      temp = temp or table.clone(awakerTidList)
      temp[slot] = 0
    end
  end
  return temp or awakerTidList
end

local function CreateTeamWithStageIdKey(teamType, inPutTeams, stageGroupId, stageId, model)
  local rst = {}
  table.insert(rst, GetDefaultTeamTbl())
  for key, data in pairs(inPutTeams) do
    if key == stageId and data and data.awakerTids then
      rst = CrearteDBGPanelTeamData(rst, 1, data)
      break
    end
  end
  local fakeAwakerTids = model.fakeAwakerTids
  local awakerTidList = rst[1].awakerTidList
  if not CheckTeamIsEmpty(awakerTidList, fakeAwakerTids) then
    rst[1].awakerTidList = FilterBanAwakers(rst[1].awakerTidList, model, stageId)
    return rst
  end
  local stageDataList = CopyDataUtils.GetStageInfo(stageGroupId)
  local curPassStageTid = stageDataList and stageDataList.curPassStageTid or 0
  for key, data in pairs(inPutTeams) do
    if key == curPassStageTid and data and data.awakerTids then
      rst = CrearteDBGPanelTeamData(rst, 1, data)
      break
    end
  end
  if not CheckTeamIsEmpty(rst[1].awakerTidList, fakeAwakerTids) then
    rst[1].awakerTidList = FilterBanAwakers(rst[1].awakerTidList, model, stageId)
    return rst
  end
  for key, data in pairs(inPutTeams) do
    if data and data.awakerTids then
      local stageCfg = DT.Stage[key]
      if stageCfg and stageCfg.BelongGroup == stageGroupId and not CheckTeamIsEmpty(data.awakerTids) then
        rst = CrearteDBGPanelTeamData(rst, 1, data)
        break
      end
    end
  end
  if not CheckTeamIsEmpty(rst[1].awakerTidList, fakeAwakerTids) then
    rst[1].awakerTidList = FilterBanAwakers(rst[1].awakerTidList, model, stageId)
    return rst
  end
  return rst
end

local function GetItemDataTidByUid(uid)
  return ItemDataUtils.GetItemByUid(uid) and ItemDataUtils.GetItemByUid(uid).tid or 0
end

local teamType2CreateFuncMap = {
  [TeamType.Normal] = CreateNormalTypeTeam,
  [TeamType.Special] = CreateTeamWithStageIdKey
}

local function createDBGTeamBuildModelState(data)
  local state = {}
  state.fakeAwakerTids = data.fakeAwakerTids
  state.useCfgAwakerSlots = {
    false,
    false,
    false,
    false
  }
  state.reactiveNum = 1
  state.previewAwakersData = data.previewAwakersData
  state.showAllSchool = 0
  state.showAwakerList = {}
  state.teamAwakerTids = {
    0,
    0,
    0,
    0
  }
  state.teamWeaponGroups = {
    {0, 0},
    {0, 0},
    {0, 0},
    {0, 0}
  }
  
  function state.teamWeaponUids()
    local rst = {}
    for _, group in pairs(state.teamWeaponGroups) do
      for _, weaponUid in pairs(group) do
        table.insert(rst, weaponUid)
      end
    end
    return rst
  end
  
  function state.teamWeaponTids()
    local rst = {}
    for _, group in pairs(state.teamWeaponGroups) do
      for _, weaponUid in pairs(group) do
        local weaponData = ItemDataUtils.GetItemByUid(weaponUid)
        if weaponData then
          table.insert(rst, weaponData.tid)
        end
      end
    end
    return rst
  end
  
  state.teamTrinketGroups = {
    {
      0,
      0,
      0,
      0,
      0,
      0
    },
    {
      0,
      0,
      0,
      0,
      0,
      0
    },
    {
      0,
      0,
      0,
      0,
      0,
      0
    },
    {
      0,
      0,
      0,
      0,
      0,
      0
    }
  }
  state.keeperSkill = TeamAssignDataUtils.GetStageSpecialKeeperSkill(data.stageId) or data.keeperSkill
  state.curTeamIndex = 1
  state.curAwakerSlot = 0
  state.curBuildingAwakerTeam = {}
  
  function state.fightAwakerNum()
    local assistAwakerId = state:GetAssistAwakerId()
    local tids = state:GetFightIdsIncludeFake()
    if 0 == tids[CommonDefine.TeamAssign.MaxBattleNum] and 0 ~= assistAwakerId then
      tids[CommonDefine.TeamAssign.MaxBattleNum] = assistAwakerId
    end
    local arr = tids
    if not arr or #arr < 0 then
      return 0
    end
    local num = 0
    for idx, tid in ipairs(arr) do
      if state:IsAbyssChallenge() and state:CheckIsHideSlot(idx) then
        if not table.contains(state:GetFightedAssistAwakerTids(), tid) then
          num = num + 1
        end
      elseif 0 ~= tid then
        num = num + 1
      end
    end
    return num
  end
  
  state.teamAwakerItemList = {}
  
  function state.schoolList()
    local list = {
      state.showAllSchool
    }
    for tid, _ in pairs(DT.SchoolConfig) do
      tableInsert(list, tid)
    end
    
    local function sortFunc(a, b)
      local cfgA = DT.SchoolConfig[a]
      local cfgB = DT.SchoolConfig[b]
      local orderA = cfgA and cfgA.Order or 0
      local orderB = cfgB and cfgB.Order or 0
      return orderA < orderB
    end
    
    tableSort(list, sortFunc)
    return list
  end
  
  state.teamMode = data.teamMode
  state.tSlotState = data.tSlotState
  state.tFakeAwakerDatas = data.tFakeAwakerDatas
  
  function state.MaxBattleNum()
    if state.teamMode == eStageTeamMode.Normal then
      return MaxBattleNum
    elseif state.teamMode == eStageTeamMode.Special then
      do return TeamAssignDataUtils.GetMaxBattleNum end
      return TeamAssignDataUtils.GetMaxBattleNum, state.tSlotState
    elseif state.teamMode == eStageTeamMode.Preview then
      return MaxBattleNum
    end
  end
  
  state.schoolItemList = {}
  state.recommandScore = data.recommandLevel
  
  function state.totalFighting()
    local totalFighting = 0
    local awakerNum = 0
    if state.teamMode == eStageTeamMode.Preview then
      return 0
    end
    for _, tid in ipairs(state.teamAwakerTids) do
      local awakerData = state.awakerDataMap[tid]
      if state.teamMode == eStageTeamMode.Special then
        local specTeamIdx = state.stageCfg.SpecialTeamIndex
        local specialCfg = DT.SpecialTeamAssign[specTeamIdx]
        local fakeData = state.tFakeAwakerDatas[tid * -1]
        if fakeData then
          local singleCfg = specialCfg.data_list[fakeData.slot]
          if singleCfg.IsOwnedAwaker == nil or singleCfg.IsOwnedAwaker == cd.TeamAssignAwaker.UseConfigData then
            awakerData = fakeData
          end
        end
      end
      if awakerData and awakerData.level then
        totalFighting = totalFighting + awakerData.level
        awakerNum = awakerNum + 1
      end
    end
    return awakerNum > 0 and math.floor(totalFighting / awakerNum) or 0
  end
  
  state.teamCreateIndex = 1
  state.teamTempChooseIndex = 1
  
  function state.recommendFighting()
    if state.recommandScore then
      return state.recommandScore
    end
    return state.stageCfg and state.stageCfg.StageLevel or 0
  end
  
  state.curSelectSchool = state.showAllSchool
  state.showCounter = false
  state.teamSchoolTid = 0
  state.stageGroupType = data.stageGroupType
  state.stageId = data.stageId
  
  function state.stageCfg()
    return state.stageId and DT.Stage[state.stageId] or {}
  end
  
  state.teamType = data.teamType or TeamType.Normal
  state.sortType = state.teamType ~= TeamType.Daily and CommonDefine.AwakerSortType.Level or CommonDefine.AwakerSortType.Quality
  state.sortOrder = CommonDefine.SortOrder.Descend
  
  function state.sortTypeList()
    local list = {}
    for _, typeValue in pairs(CommonDefine.AwakerSortType) do
      if nil ~= typeValue and type(typeValue) == "number" then
        local typeName = AwakerDataUtils.GetSortTypeTitle(typeValue)
        tableInsert(list, {type = typeValue, name = typeName})
      end
    end
    tableSort(list, function(a, b)
      return a.type < b.type
    end)
    return list
  end
  
  state.recommandSchoolTids = data.recommandSchoolTids
  state.awakerDataMap = data.awakerDataMap
  if state.teamMode == eStageTeamMode.Normal then
    state.defaultTeamIndex = nil
  elseif table.contains({
    eStageTeamMode.Special,
    eStageTeamMode.Preview
  }, state.teamMode) then
    state.defaultTeamIndex = 1
  end
  state.isShowQuickBuildPanel = false
  state.isShowSortTypePanel = false
  state.specialTeamForbids = data.specialTeamForbids or {}
  state.assistCount = data.extraData and data.extraData.assistCount or nil
  state.fightedStageGroups = data.extraData and data.extraData.stageGroups or nil
  state.fightedStageGroupData = {}
  state.fightedAssistAwakerTids = {}
  
  function state.forbidden()
    local rst = {}
    for _, awakerTid in ipairs(state.specialTeamForbids or {}) do
      table.insert(rst, awakerTid)
    end
    local fightedAwakers = state:GetFightedStageGroupData()
    if table.next(fightedAwakers) then
      for awakerId, _ in pairs(fightedAwakers) do
        if not table.contains(rst, awakerId) then
          table.insert(rst, awakerId)
        end
      end
    end
    if not state:IsAwakerSchoolLimit() then
      return rst
    end
    local buildingTeam = table.clone(state.curBuildingAwakerTeam)
    if state.curAwakerSlot and 0 ~= state.curAwakerSlot then
      buildingTeam[state.curAwakerSlot] = 0
    end
    local emptyNum = 0
    for _, tid in pairs(buildingTeam) do
      if 0 == tid then
        emptyNum = emptyNum + 1
      end
    end
    local limitSchoolId, limitNum
    for schoolId, num in pairs(state.limitSchoolAwaker) do
      limitSchoolId = schoolId
      limitNum = num
    end
    local limitSchoolType = DT.SchoolConfig[limitSchoolId].NameEn
    local speciNum = 0
    for _, tid in pairs(buildingTeam) do
      if 0 == tid or not tid then
      else
        local schoolType = DT.SchoolConfig[state:GetAwakerSchool(tid)].NameEn
        if schoolType == limitSchoolType then
          speciNum = speciNum + 1
        end
      end
    end
    local needAddNum = math.max(limitNum - speciNum, 0)
    print("teamForbidden emptyNum ", emptyNum)
    print("teamForbidden needAddNum ", needAddNum)
    print("teamForbidden limitSchoolType ", limitSchoolType)
    print("teamForbidden buildingTeam ", table.tostring(buildingTeam))
    local onlyAddLimitAwaker = emptyNum <= needAddNum
    local teamNotFull = 0 ~= emptyNum
    if onlyAddLimitAwaker then
      for _, awakerData in pairs(state.showAwakerList) do
        local awakerId = awakerData.tid
        local isInBuildingTeam = table.contains(buildingTeam, awakerId)
        if isInBuildingTeam then
        else
          local schoolCfg = DT.SchoolConfig[state:GetAwakerSchool(awakerId)]
          local isLimitSchoolType = schoolCfg.NameEn == limitSchoolType
          if not isLimitSchoolType then
            table.insert(rst, awakerId)
          end
        end
      end
    end
    return rst
  end
  
  state.challengeFunc = data.challengeFunc
  
  local function GetCareerList(tidList, forbiddenTab, activeMinNum)
    if not tidList then
      return {}
    end
    local tidList = table.clone(tidList)
    local assistAwakerId = state:GetAssistAwakerId()
    if 0 ~= assistAwakerId then
      tidList[state.MaxBattleNum] = assistAwakerId
    end
    local careerList = {}
    for _, config in pairs(DT.SchoolConfig) do
      careerList[config.NameEn] = {
        schoolId = config.ID,
        enable = false
      }
    end
    local awakerNum = 0
    
    local function updateCareerListFunc(tid, schoolId)
      awakerNum = awakerNum + 1
      local schoolCfg = DT.SchoolConfig[schoolId]
      careerList[schoolCfg.NameEn].enable = true
    end
    
    local forbiddenTab = table.clone(forbiddenTab or {})
    for idx, tid in pairs(tidList) do
      local awakerCfg = DT.AwakerConfig[math.abs(tid)]
      if state:IsAbyssChallenge() and state:CheckIsHideSlot(idx) then
        if awakerCfg and not table.contains(state:GetFightedAssistAwakerTids(), tid) then
          updateCareerListFunc(tid, awakerCfg.School)
        end
      elseif awakerCfg and not table.contains(forbiddenTab, tid) then
        updateCareerListFunc(tid, awakerCfg.School)
      end
    end
    for _, info in pairs(careerList) do
      info.enable = info.enable and awakerNum >= (activeMinNum or 0)
    end
    return careerList
  end
  
  function state.careerEffectList()
    local careerList = GetCareerList(state.teamAwakerTids, state.forbidden, state.MaxBattleNum)
    return careerList
  end
  
  function state.buildEffectList()
    local careerList = GetCareerList(state.curBuildingAwakerTeam, state.forbidden, state.MaxBattleNum)
    return careerList
  end
  
  state.showScollBar = false
  state.scollBarTimer = nil
  state.isStartChallenge = false
  state.allTeamList = {}
  
  function state.curTeamName()
    if state.teamMode == eStageTeamMode.Special then
      do return LT.Text end
      return LT.Text, "SpecialTeamAssignTitle", nil
    elseif state.teamMode == eStageTeamMode.Preview then
      do return LT.Text end
      return LT.Text, "SpecialTeamAssignTitle", nil
    else
      do return DBGTeamDataUtils.GetDBGTeamName, state.teamType end
      return DBGTeamDataUtils.GetDBGTeamName, state.teamType, state.curTeamIndex
    end
  end
  
  state.BuildTeamOperate = {Add = 1, Remove = 2}
  state.BuildTeamType = {QuickBuild = 1, ChooseBuild = 2}
  state.indexTranMap = {
    [1] = "I",
    [2] = "II",
    [3] = "III",
    [4] = "IV",
    [5] = "V",
    [6] = "VI",
    [7] = "VII",
    [8] = "VIII",
    [9] = "IX",
    [10] = "X",
    [11] = "XI",
    [12] = "XII",
    [13] = "XIII",
    [14] = "XIV",
    [15] = "XV",
    [16] = "XVI",
    [17] = "XVII",
    [18] = "XVIII",
    [19] = "XIX",
    [20] = "XX"
  }
  
  function state.limitSchoolAwaker()
    do return CopyDataUtils.GetAwakerRequirementMap end
    return CopyDataUtils.GetAwakerRequirementMap, state.stageId
  end
  
  state.page = CommonDefine.DBGTeamBuildPage.Main
  state.assistUid = nil
  state.singleChooseSpecialAwakerMode = false
  
  function state.selectAwakerBaseAttrs()
    local awaker = state:GetAwakerDataBySlot(state.curAwakerSlot)
    if not awaker then
      return {}
    end
    local attrs = {}
    local clientAttrs = awaker.clientAttrs
    if not clientAttrs and not AwakerDataUtils.HasOwnedAwaker(awaker.tid) then
      clientAttrs = AwakerDataUtils.GetAwakerShowAttrs(awaker.attrs)
    end
    local PerAttrKey = "_per"
    for _, attr in pairs(clientAttrs or {}) do
      if not attr then
      else
        local cfg = DT.ActorAttrType[attr.tid]
        if not cfg then
          Logger.Info("找不到属性配置:", attr.tid)
        elseif state:IsBaseAttr(attr.tid) then
          local v = table.clone(attr)
          local attrKey = cfg.Name .. PerAttrKey
          local baseValue = v.count
          local perVal = awaker.attrs[attrKey]
          v.attrDesc = AttrUtils.CalAttrDesc(awaker, v.attrDesc, attrKey)
          if perVal then
            perVal = perVal / 100
            v.count = AttrUtils.GetAwakerFinalAttr(baseValue, perVal)
          end
          tableInsert(attrs, v)
        end
      end
    end
    
    local function attrSort(a, b)
      local cfgA = DT.ActorAttrType[a.tid]
      local cfgB = DT.ActorAttrType[b.tid]
      local sortA = cfgA.AttributeSort or 0
      local sortB = cfgB.AttributeSort or 0
      return sortA < sortB
    end
    
    tableSort(attrs, attrSort)
    return attrs
  end
  
  state.banClick = false
  return state
end

local function createDBGTeamBuildModelViews(model)
  local views = {}
  
  function views:IsAbyssChallenge()
    return model.stageGroupType and model.stageGroupType == CommonDefine.StageGroupType.AbyssChallenge
  end
  
  function views:IsLimitAwakers()
    if self:IsAbyssChallenge() then
      return true
    end
    do return self.IsLimitAwakersByStageType end
    return self.IsLimitAwakersByStageType, self
  end
  
  function views:IsLimitAwakersByStageType()
    local limitTypes = DT.GetOriginalConstant("AwakerUseTimesLimitByStageGroupType") or {}
    do return table.contains, limitTypes end
    return table.contains, limitTypes, model.stageGroupType
  end
  
  function views:IsDailyChallenge()
    return model.stageGroupType and model.stageGroupType == CommonDefine.StageGroupType.DailyChallenge
  end
  
  function views:GetTeamAwakerTidBySlot(slot)
    return model.teamAwakerTids[slot]
  end
  
  function views:GetTeamWeaponGroupBySlot(teamSlot)
    return model.teamWeaponGroups[teamSlot]
  end
  
  function views:GetTeamTrinketGroupBySlot(teamSlot)
    return model.teamTrinketGroups[teamSlot]
  end
  
  function views:IsTeamUnlocked(index)
    do return DBGTeamDataUtils.IsTeamUnlocked, model.teamType end
    return DBGTeamDataUtils.IsTeamUnlocked, model.teamType, index
  end
  
  function views:GetTeamAwakerTids()
    return model.teamAwakerTids
  end
  
  function views:IsAwakerInTeam(awakerTid)
    do return table.contains, model.teamAwakerTids end
    return table.contains, model.teamAwakerTids, awakerTid
  end
  
  function views:IsAwakerInBuildingTeam(awakerTid, isIncludeAbs)
    local buildingAwakers = model.curBuildingAwakerTeam
    if not isIncludeAbs then
      do return table.contains, buildingAwakers end
      return table.contains, buildingAwakers, awakerTid
    else
      return table.contains(buildingAwakers, awakerTid) or table.contains(buildingAwakers, awakerTid * -1)
    end
  end
  
  function views:HasTheSameAwaker(type, curAwakerId)
    local result = false
    if type == model.BuildTeamType.QuickBuild then
      for _, awakerId in ipairs(model.curBuildingAwakerTeam) do
        if awakerId and 0 ~= awakerId and curAwakerId ~= awakerId and AwakerDataUtils.GetChangerForm(awakerId) == curAwakerId then
          result = true
          break
        end
      end
    elseif type == model.BuildTeamType.ChooseBuild then
      for _, awakerId in ipairs(model.teamAwakerTids) do
        if awakerId and 0 ~= awakerId and curAwakerId ~= awakerId and AwakerDataUtils.GetChangerForm(awakerId) == curAwakerId then
          result = true
          break
        end
      end
    end
    return result
  end
  
  function views:GetTheSameAwaker(awakerTid)
    for _, tid in ipairs(model.teamAwakerTids) do
      if tid and 0 ~= tid and tid ~= awakerTid and AwakerDataUtils.GetChangerForm(tid) == awakerTid then
        return tid
      end
    end
    return nil
  end
  
  function views:CheckChangerFormAwaker(teamAwakerTids, curSlot, curSelectTid)
    local changeFormAwakerTids = {}
    for idx, awakerTid in pairs(teamAwakerTids) do
      if idx ~= curSlot and 0 ~= awakerTid then
        local changeFormAwakerTid = AwakerDataUtils.GetChangerForm(awakerTid)
        if 0 ~= changeFormAwakerTid then
          table.insert(changeFormAwakerTids, changeFormAwakerTid)
        end
      end
    end
    do return table.contains, changeFormAwakerTids end
    return table.contains, changeFormAwakerTids, curSelectTid, pairs(teamAwakerTids)
  end
  
  function views:IsWrongCareer(awakerId)
    local validSchoolMap = model:GetValidSchoolMap()
    local schoolId = DT.AwakerConfig[math.abs(awakerId)].School
    local result = not validSchoolMap[schoolId]
    return result
  end
  
  function views:GetCurEnableSchoolId()
    local validShoolMap = model:GetValidSchoolMap()
    for _, config in pairs(DT.SchoolConfig) do
      if validShoolMap[config.ID] and config.NameEn ~= CommonDefine.SchoolType.Chaos then
        return config.ID
      end
    end
  end
  
  function views:GetRealFightAwakerIdMap()
    if model.teamMode == eStageTeamMode.Normal then
      local tAwakerTids = table.clone(model.teamAwakerTids)
      return tAwakerTids
    elseif model.teamMode == eStageTeamMode.Special then
      local tAwakerTids = {
        0,
        0,
        0,
        0
      }
      for i, awakerId in ipairs(model.teamAwakerTids) do
        if 0 ~= awakerId and not self:HasFakeAwaker(awakerId) then
          tAwakerTids[i] = awakerId
        end
      end
      return tAwakerTids
    elseif model.teamMode == eStageTeamMode.Preview then
      local tAwakerTids = table.clone(model.teamAwakerTids)
      return tAwakerTids
    end
  end
  
  function views:GetFightIdsIncludeFake()
    if model.teamMode == eStageTeamMode.Normal then
      local tAwakerTids = table.clone(model.teamAwakerTids)
      return tAwakerTids
    elseif model.teamMode == eStageTeamMode.Special then
      local tAwakerTids = {
        0,
        0,
        0,
        0
      }
      for i, awakerId in ipairs(model.teamAwakerTids) do
        tAwakerTids[i] = awakerId
      end
      return tAwakerTids
    elseif model.teamMode == eStageTeamMode.Preview then
      local tAwakerTids = table.clone(model.teamAwakerTids)
      return tAwakerTids
    end
  end
  
  function views:GetDisplayKeeperSkillItem()
    local specialTeamKeeperSkill = TeamAssignDataUtils.GetStageSpecialKeeperSkill()
    if specialTeamKeeperSkill then
      return specialTeamKeeperSkill
    end
    local uniqueSkillItem = self:GetUniqueSkillItem()
    return uniqueSkillItem or model.keeperSkill or KeeperSkillUtils.GetDefaultItem()
  end
  
  function views:GetCanAssistCount()
    return model.assistCount and DT.GetConstant("AbyssChallengeAwakerSupportTimes") - model.assistCount or 0
  end
  
  function views:IsDisableKeepSkill()
    if self.stageCfg.KeeperSkillLimit == "DisableKeeperSkill" then
      return true
    end
  end
  
  function views:GetUniqueSkillItem()
    if type(self.stageCfg.KeeperSkillLimit) == "number" then
      do return KeeperSkillUtils.GetItemIdBySkill end
      return KeeperSkillUtils.GetItemIdBySkill, self.stageCfg.KeeperSkillLimit
    end
  end
  
  function views:HasRealFightAwaker()
    if model.teamMode == eStageTeamMode.Normal then
      return true
    else
      for i, awakerId in ipairs(model.teamAwakerTids) do
        if 0 ~= awakerId and not self:HasFakeAwaker(awakerId) then
          return true
        end
      end
      return false
    end
  end
  
  function views:GetFirstValidAwakerTid()
    for index = 1, 4 do
      local awakerTid = model.teamAwakerTids[index]
      if awakerTid and awakerTid > 0 then
        return awakerTid
      end
    end
  end
  
  function views:IsAwakerSchoolLimit()
    return model.limitSchoolAwaker and table.next(model.limitSchoolAwaker) ~= nil
  end
  
  function views:GetUnmetSchoolLimit()
    if not self:IsAwakerSchoolLimit() then
      return
    end
    local tidList = table.clone(self.teamAwakerTids)
    local assistAwakerId = self:GetAssistAwakerId()
    if 0 ~= assistAwakerId then
      tidList[self.MaxBattleNum] = assistAwakerId
    end
    for schoolId, num in pairs(self.limitSchoolAwaker) do
      local schoolCfg = DT.SchoolConfig[schoolId]
      if schoolCfg and num > 0 then
        local sameSchoolNum = 0
        for _, awakerTid in pairs(tidList) do
          local awakerCfg = DT.AwakerConfig[math.abs(awakerTid)]
          if awakerCfg and awakerCfg.School == schoolId then
            sameSchoolNum = sameSchoolNum + 1
          end
        end
        if num > sameSchoolNum then
          return schoolId, num
        end
      end
    end
  end
  
  function views:IsTeamMeetSchoolLimit()
    return self:GetUnmetSchoolLimit() == nil
  end
  
  function views:GetBuildTeamSchool()
  end
  
  function views:GetValidSchoolMap(slot)
    local index = slot or model.curAwakerSlot
    local allSchoolMap = {
      [cd.SchoolId.Choas] = true,
      [cd.SchoolId.Blood] = true,
      [cd.SchoolId.Dimension] = true,
      [cd.SchoolId.Ocean] = true
    }
    local curSchoolMap = {}
    local curSchoolCount = 0
    local list = table.clone(model.curBuildingAwakerTeam)
    local assistAwakerId = model:GetAssistAwakerId()
    if 0 ~= assistAwakerId then
      list[cd.TeamAssistPos] = assistAwakerId
    end
    local school
    for idx, awakerTid in pairs(list) do
      if idx ~= index then
        local awakerCfg = 0 ~= awakerTid and DT.AwakerConfig[math.abs(awakerTid)]
        school = awakerCfg and awakerCfg.School
        if school and not curSchoolMap[school] then
          curSchoolMap[school] = true
          curSchoolCount = curSchoolCount + 1
          if curSchoolCount >= CommonDefine.TeamMixSchoolCount then
            return curSchoolMap
          end
        end
      end
    end
    return allSchoolMap
  end
  
  function views:GetStageLevel()
    do return MainCopyDataUtils.GetStageLevel end
    return MainCopyDataUtils.GetStageLevel, self.stageId
  end
  
  function views:IsAwakerFight_ExceptAssistSlot(awakerId)
    local slotCnt = CommonDefine.TeamAssign.MaxBattleNum - 1
    for nSlot = 1, slotCnt do
      local slotAwakerId = self.curBuildingAwakerTeam[nSlot] or 0
      if slotAwakerId == awakerId then
        return true
      end
    end
    return false
  end
  
  function views:GetStageAjustAwakerLevel()
    local stageGroupId = model.stageCfg and model.stageCfg.BelongGroup
    local adjustLevelList = CopyDataUtils.GetAjustLevelList(stageGroupId)
    return adjustLevelList[1]
  end
  
  function views:GetStageAjustPlayerLevel()
    local stageGroupId = model.stageCfg and model.stageCfg.BelongGroup
    local adjustLevelList = CopyDataUtils.GetAjustLevelList(stageGroupId)
    return adjustLevelList[2]
  end
  
  function views:GetStageAjustAwakerSkillLevel()
    local stageGroupId = model.stageCfg and model.stageCfg.BelongGroup
    local adjustLevelList = CopyDataUtils.GetAjustLevelList(stageGroupId)
    return adjustLevelList[4] or 0
  end
  
  function views:GetStageAjustAwakerTalent1Level()
    local stageGroupId = model.stageCfg and model.stageCfg.BelongGroup
    local adjustLevelList = CopyDataUtils.GetAjustLevelList(stageGroupId)
    return adjustLevelList[5] or 0
  end
  
  function views:GetStageAjustAwakerTalent2Level()
    local stageGroupId = model.stageCfg and model.stageCfg.BelongGroup
    local adjustLevelList = CopyDataUtils.GetAjustLevelList(stageGroupId)
    return adjustLevelList[6] or 0
  end
  
  function views:GetStageAjustAwakerTalent3Level()
    local stageGroupId = model.stageCfg and model.stageCfg.BelongGroup
    local adjustLevelList = CopyDataUtils.GetAjustLevelList(stageGroupId)
    return adjustLevelList[7] or 0
  end
  
  function views:IsPresetFakeAwakerData(awakerData)
    if not awakerData or not awakerData.tid then
      return false
    end
    return awakerData.tid < 0 or awakerData.isFakeAwaker == true
  end
  
  function views:IsPresetFakeAwakerSlot(slot)
    local awakerTid = self:GetTeamAwakerTidBySlot(slot)
    if not awakerTid or 0 == awakerTid then
      return false
    end
    do return self.IsPresetFakeAwakerData, self, self:GetAwakerDataByCfgId(awakerTid) end
    return self.IsPresetFakeAwakerData, self, self:GetAwakerDataByCfgId(awakerTid)
  end
  
  function views:GetAwakerSkillLevelDisplay(awakerData, useStageAdjust)
    if not awakerData or not awakerData.tid then
      return nil
    end
    local targetSkills = awakerData.skills or awakerData.slots
    if not targetSkills or not table.next(targetSkills) then
      return nil
    end
    local awakerSkillAjustLv = useStageAdjust and self:GetStageAjustAwakerSkillLevel() or 0
    local ajustColor = "#5ef2ff"
    
    local function getSkillLevelBySlot(slot)
      local skillData = targetSkills[slot]
      if not skillData then
        for _, skill in pairs(targetSkills) do
          if skill and skill.slot == slot then
            skillData = skill
            break
          end
        end
      end
      local skillLevel = skillData and skillData.level or 1
      if useStageAdjust and awakerSkillAjustLv > 0 and skillLevel < awakerSkillAjustLv then
        do return string.color, awakerSkillAjustLv end
        return string.color, awakerSkillAjustLv, ajustColor, nil, nil, skill.slot
      end
      return skillLevel
    end
    
    local madLevel = getSkillLevelBySlot(CommonDefine.AwakerSkillSlot.Slot_Super)
    local otherSkillLevel = ""
    for slot = CommonDefine.AwakerSkillSlot.Slot_Strike, CommonDefine.AwakerSkillSlot.Slot_Skill2 do
      otherSkillLevel = otherSkillLevel .. "/" .. getSkillLevelBySlot(slot)
    end
    return {otherSkillLevel = otherSkillLevel, madLevel = madLevel}
  end
  
  function views:GetChoosePanelSkillLevelText(awakerData)
    if not awakerData then
      return nil
    end
    local targetSkills = awakerData.skills or awakerData.slots
    local skillList, specialSkill = AwakerDataUtils.GetAwakerSkillsData({skills = targetSkills})
    if not skillList then
      return nil
    end
    table.sort(skillList, function(a, b)
      return a.slot < b.slot
    end)
    local levelList = {}
    for i = 1, 5 do
      local skillData = skillList[i]
      table.insert(levelList, skillData and skillData.level or 1)
    end
    if specialSkill then
      table.insert(levelList, specialSkill.level or 1)
    end
    local skillLv = string.format("<color=#C8C971><size=30>%s</size></color>", levelList[1])
    for i = 2, #levelList do
      skillLv = skillLv .. "/" .. levelList[i]
    end
    return skillLv
  end
  
  function views:IsSlotLevelAjusted(slot)
    if self:IsPresetFakeAwakerSlot(slot) then
      return false
    end
    local adjustLevel = self:GetStageAjustAwakerLevel()
    if not adjustLevel then
      return false
    end
    local realLevel = self:GetSlotRealLevel(slot)
    if not realLevel then
      return false
    end
    return adjustLevel > realLevel
  end
  
  function views:IsAwakerSkillLevelAjusted(slot)
    if self:IsPresetFakeAwakerSlot(slot) then
      return false
    end
    local adjustLevel = self:GetStageAjustAwakerSkillLevel()
    if not adjustLevel then
      return false
    end
    local awakerTid = self:GetTeamAwakerTidBySlot(slot)
    local awakerData = awakerTid and self:GetAwakerDataByCfgId(awakerTid)
    if not awakerData then
      return false
    end
    local realLevel = self:GetSlotRealLevel(slot)
    if not realLevel then
      return false
    end
    local assistAwakerData = self:GetAssistAwaker()
    local targetSkills = awakerData.skills or awakerData.slots
    if slot == CommonDefine.TeamAssign.MaxBattleNum and assistAwakerData then
      targetSkills = assistAwakerData.slots
    end
    local skillList, specialSkill = AwakerDataUtils.GetAwakerSkillsData({skills = targetSkills})
    if specialSkill and adjustLevel > specialSkill.level then
      return true
    end
    for i = 1, 5 do
      local skillData = skillList and skillList[i]
      local skillLevel = skillData and skillData.level or 1
      if adjustLevel > skillLevel then
        return true
      end
    end
  end
  
  function views:IsSlotTalentAjusted(slot)
    if self:IsPresetFakeAwakerSlot(slot) then
      return false
    end
    local adjustLevel = self:GetStageAjustAwakerSkillLevel()
    if not adjustLevel then
      return false
    end
    local awakerTid = self:GetTeamAwakerTidBySlot(slot)
    local awakerData = awakerTid and self:GetAwakerDataByCfgId(awakerTid)
    if not awakerData then
      return false
    end
    local realLevel = self:GetSlotRealLevel(slot)
    if not realLevel then
      return false
    end
    local assistAwakerData = self:GetAssistAwaker()
    local targetTalents = self:GetAwakerTalents(awakerData.tid)
    if slot == CommonDefine.TeamAssign.MaxBattleNum and assistAwakerData then
      targetTalents = assistAwakerData.talents
    end
    local adjustTalentLv1 = self:GetStageAjustAwakerTalent1Level()
    local adjustTalentLv2 = self:GetStageAjustAwakerTalent2Level()
    local awakerTalentLv1, awakerTalentLv2 = TalentDataUtils.GetDisplayTalentLv(targetTalents)
    local showTalentLv1 = adjustTalentLv1 > awakerTalentLv1
    local showTalentLv2 = adjustTalentLv2 > awakerTalentLv2
    return showTalentLv1 or showTalentLv2
  end
  
  function views:GetSlotRealLevel(slot)
    if self:IsAssistSlot(slot) and self:GetAssistAwaker() then
      return self:GetAssistAwaker().level
    end
    local awakerTid = self:GetTeamAwakerTidBySlot(slot)
    local awakerData = awakerTid and self:GetAwakerDataByCfgId(awakerTid)
    if not awakerData then
      return
    end
    return awakerData.level
  end
  
  function views:GetAwakerShowLevelBySlot(slot)
    local realLevel = self:GetSlotRealLevel(slot) or 0
    if self:IsPresetFakeAwakerSlot(slot) then
      return realLevel
    end
    local adjustLevel = self:GetStageAjustAwakerLevel()
    if not adjustLevel then
      return realLevel
    end
    do return math.max, realLevel end
    return math.max, realLevel, adjustLevel
  end
  
  function views:IsAssistSlot(slot)
    return slot == cd.TeamAssign.MaxBattleNum
  end
  
  function views:GetTeamAvergerLevel()
    local totalLevel = 0
    local totalNum = 0
    for slot = 1, 4 do
      local showLevel = self:GetAwakerShowLevelBySlot(slot)
      if showLevel and showLevel > 0 then
        totalNum = totalNum + 1
        totalLevel = totalLevel + showLevel
      end
    end
    return 0 == totalNum and 0 or math.floor(totalLevel / totalNum)
  end
  
  function views:GetStageLevelAjustType()
    return CommonDefine.StageAjustType.AdjustAwakerAndPlayer
  end
  
  function views:GetLevelSuppress()
    local stageLevel = self.stageCfg.StageLevel or 0
    local teamAvergerLevel = self:GetTeamAvergerLevel()
    if stageLevel <= teamAvergerLevel then
      return 0
    end
    local lessLevel = stageLevel - teamAvergerLevel
    local suppressType = self.stageCfg.SuppressionType
    local levelSuppressCfg = DT.LevelSuppression[lessLevel] or {}
    local suppressValue = levelSuppressCfg[suppressType] or 0
    return suppressValue
  end
  
  function views:GetEnabledSchoolList()
    local careerEffectList = self.careerEffectList
    local list = {}
    for _, data in pairs(careerEffectList) do
      if data.enable then
        table.insert(list, data.schoolId)
      end
    end
    return list
  end
  
  function views:GetTeamSchoolList()
    local rst = {}
    for slot, awakerTid in pairs(self.teamAwakerTids) do
      if slot == CommonDefine.TeamAssign.MaxBattleNum and self:GetAssistAwaker() then
        awakerTid = self:GetAssistAwaker().tid
      end
      local schoolId = AwakerCfgUtils.GetCfgField("School", awakerTid)
      if schoolId and not table.contains(rst, schoolId) then
        table.insert(rst, schoolId)
      end
    end
    return rst
  end
  
  function views:CheckIsHideSlot(idx)
    return idx == self.MaxBattleNum and self:GetAssistUid() ~= nil
  end
  
  function views:GetAssistSuggestSchoolId()
    local tidList = table.clone(self.teamAwakerTids)
    local careerList = {}
    for _, config in pairs(DT.SchoolConfig) do
      careerList[config.NameEn] = {
        schoolId = config.ID,
        enable = false
      }
    end
    local awakerNum = 0
    for _, tid in pairs(tidList) do
      local school = self:GetAwakerSchool(tid)
      if school then
        awakerNum = awakerNum + 1
        local schoolCfg = DT.SchoolConfig[school]
        careerList[schoolCfg.NameEn].enable = true
      end
    end
    for _, info in pairs(careerList) do
      local schoolCfg = DT.SchoolConfig[info.schoolId]
      if info.enable and schoolCfg.NameEn ~= CommonDefine.SchoolType.Chaos then
        careerList[CommonDefine.SchoolType.Chaos].enable = false
      end
      info.enable = info.enable and awakerNum >= MaxBattleNum - 1
    end
    for _, data in pairs(careerList) do
      if data.enable then
        return data.schoolId
      end
    end
    return 0
  end
  
  function views:GetActivedBuildSchoolId()
    local buildEffectList = self.buildEffectList
    for _, data in pairs(buildEffectList) do
      if data.enable then
        return data.schoolId
      end
    end
  end
  
  function views:IsBanTid(tid)
    do return TeamDataUtils.IsBanTid, self.stageGroupType, math.abs(tid) end
    return TeamDataUtils.IsBanTid, self.stageGroupType, math.abs(tid)
  end
  
  function views:IsBanUnitByStageType()
    for idx, tid in pairs(self.teamAwakerTids) do
      if idx == self.MaxBattleNum and self:GetAssistUid() ~= nil then
      elseif self:IsBanTid(tid) then
        return true
      end
    end
    for idx, weaponGroup in pairs(model.teamWeaponGroups) do
      if self:CheckIsHideSlot(idx) then
      else
        for _, weaponUid in pairs(weaponGroup) do
          local weaponData = ItemDataUtils.GetItemByUid(weaponUid)
          local weaponTid = weaponData and weaponData.tid or 0
          if 0 ~= weaponTid and TeamDataUtils.IsBanTid(weaponTid) then
            return true
          end
        end
      end
    end
    if self:IsBanTid(self:GetDisplayKeeperSkillItem()) then
      return true
    end
  end
  
  function views:GetBanUnitNamesByStageType()
    local banUnitNames = {}
    for idx, tid in pairs(self.teamAwakerTids) do
      if idx == self.MaxBattleNum and self:GetAssistUid() ~= nil then
      elseif self:IsBanTid(tid) then
        table.insert(banUnitNames, LT.Text(DT.AwakerConfig[math.abs(tid)].Name))
      end
    end
    for idx, weaponGroup in pairs(model.teamWeaponGroups) do
      if self:CheckIsHideSlot(idx) then
      else
        for _, weaponUid in pairs(weaponGroup) do
          local weaponData = ItemDataUtils.GetItemByUid(weaponUid)
          local weaponTid = weaponData and weaponData.tid or 0
          if 0 ~= weaponTid and self:IsBanTid(weaponTid) then
            table.insert(banUnitNames, LT.Text(DT.Item[weaponTid].Name))
          end
        end
      end
    end
    local keepSkillItem = self:GetDisplayKeeperSkillItem()
    if self:IsBanTid(keepSkillItem) then
      table.insert(banUnitNames, LT.Text(DT.Item[keepSkillItem].Name))
    end
    return banUnitNames
  end
  
  function views:IsRecommendSchool()
    local schoolList = self:GetEnabledSchoolList()
    local recommendSchool = self.stageCfg.RecClass or {}
    for schoolId in ipairs(schoolList) do
      if table.contains(recommendSchool, schoolId) then
        return true
      end
    end
  end
  
  function views:HasFakeAwaker(awakerId)
    return model.tFakeAwakerDatas[awakerId * -1] ~= nil
  end
  
  function views:GetCurBuildingAwakerTeam(slot, isAbs)
    if not slot or slot <= 0 then
      return
    end
    local tid = model.curBuildingAwakerTeam[slot]
    if isAbs then
      return tid and math.abs(tid)
    end
    return tid
  end
  
  function views:GetAwakerByTeamAwakerTids(slot)
    return model.teamAwakerTids[slot]
  end
  
  function views:GetSlotByTeamAwakerTids(awakerId)
    for slot, tid in pairs(model.teamAwakerTids) do
      if tid == awakerId then
        return slot
      end
    end
    return 0
  end
  
  function views:GetTeamDataByIdx(index)
    return model.allTeamList[index]
  end
  
  function views:GetAwakerConfig(tid)
    local config = DT.AwakerConfig[math.abs(tid)]
    return config
  end
  
  function views:GetAwakerSchool(tid)
    local config = self:GetAwakerConfig(tid)
    return config and config.School
  end
  
  function views:GetSchoolIcon(tid)
    local config = DT.SchoolConfig[tid]
    return config.Icon
  end
  
  function views:GetEnableSchoolId(schoolList)
    for _, data in pairs(schoolList) do
      if data.enable and 1 ~= data.schoolId then
        return data.schoolId
      end
    end
    return nil
  end
  
  function views:QuickBuildCanSelect(awakerTid)
    if self:IsSpecialTeamAssignBan(awakerTid) then
      return false
    end
    for slot, tid in ipairs(model.curBuildingAwakerTeam) do
      if slot == cd.TeamAssistPos then
        local assistAwakerId = model:GetAssistAwakerId()
        if assistAwakerId and 0 ~= assistAwakerId then
          return false
        end
      end
      if tid == awakerTid then
        return true
      end
    end
  end
  
  function views:IsSpecialTeamAssignBan(awakerTid)
    if model.teamMode ~= eStageTeamMode.Special then
      return false
    end
    if not awakerTid then
      return false
    end
    awakerTid = math.abs(awakerTid)
    local changeFormTid = AwakerDataUtils.GetChangerForm(awakerTid) or 0
    local fakeAwaker = model.tFakeAwakerDatas[awakerTid] or model.tFakeAwakerDatas[changeFormTid]
    if not fakeAwaker then
      return false
    end
    local IsOwnedAwaker = fakeAwaker.IsOwnedAwaker or cd.TeamAssignAwaker.UseConfigData
    if IsOwnedAwaker == cd.TeamAssignAwaker.UseConfigData then
      return true
    end
  end
  
  function views:IsBanPos(slot)
    if model.teamMode ~= eStageTeamMode.Special then
      return false
    end
    return model.tSlotState[slot] == ePosState.BanBattlePos
  end
  
  function views:IsBanAwaker(awakerTid, slot)
    if not awakerTid or 0 == awakerTid then
      return false
    end
    awakerTid = math.abs(awakerTid)
    if table.contains(model.specialTeamForbids, awakerTid) then
      return true
    end
    local isAssistAwaker = slot == CommonDefine.TeamAssign.MaxBattleNum and model:GetAssistAwaker()
    if isAssistAwaker then
      table.contains(model:GetFightedAssistAwakerTids(), awakerTid)
    else
      local fightedAwakers = model:GetFightedStageGroupData()
      if fightedAwakers[awakerTid] then
        return true
      end
    end
    if not isAssistAwaker and self:IsBanTid(awakerTid) then
      return true
    end
    return false
  end
  
  function views:IsSpecAssignAwaker(slot)
    if model.teamMode ~= eStageTeamMode.Special then
      return false
    end
    local slotCfg = TeamAssignDataUtils.GetSpecialSlotCfg(self.stageId, slot)
    local UseConfigAwaker = cd.TeamAssignAwaker.UseConfigData
    if tonumber(slotCfg.AwakerIndex) and (slotCfg.IsOwnedAwaker or UseConfigAwaker) == UseConfigAwaker then
      return true
    end
  end
  
  function views:IsUseCfgAwaker(slot)
    return self.useCfgAwakerSlots[slot]
  end
  
  function views:GetAwakerDataByCfgId(awakerId)
    if not awakerId then
      return {}
    end
    if table.contains({
      eStageTeamMode.Normal,
      eStageTeamMode.Preview
    }, model.teamMode) then
      return model.awakerDataMap[awakerId] or {}
    elseif model.teamMode == eStageTeamMode.Special then
      return model.tFakeAwakerDatas[awakerId * -1] or model.awakerDataMap[awakerId] or {}
    end
  end
  
  function views:GetAwakerDataBySlot(slot)
    local awakerTid = self:GetCurBuildingAwakerTeam(slot)
    return 0 ~= awakerTid and self:GetAwakerDataByCfgId(awakerTid)
  end
  
  function views:IsInSpecialTeamForbids(awakerTid)
    do return table.contains, model.specialTeamForbids end
    return table.contains, model.specialTeamForbids, awakerTid
  end
  
  function views:GetAwakerSlot(list, awakerTid)
    for slot, tid in pairs(list) do
      if tid == awakerTid then
        return slot
      end
    end
    return 0
  end
  
  function views:IsForbidden(awakerTid)
    if not awakerTid then
      return false
    end
    if type(model.forbidden) == "table" and table.contains(model.forbidden, awakerTid) then
      return true
    end
    return false
  end
  
  function views:GetSortTypeName(sortType)
    do return AwakerDataUtils.GetSortTypeTitle end
    return AwakerDataUtils.GetSortTypeTitle, sortType
  end
  
  function views:GetSortTypeTagContent(sortType, awakerData, level)
    if not sortType or not awakerData then
      return
    end
    do return AwakerDataUtils.GetSortTypeTagContent, sortType, awakerData end
    return AwakerDataUtils.GetSortTypeTagContent, sortType, awakerData, level
  end
  
  function views:GetFightAwakerNum(arr)
    if not arr or #arr < 0 then
      return 0
    end
    local num = 0
    for _, tid in ipairs(arr) do
      if 0 ~= tid then
        num = num + 1
      end
    end
    return num
  end
  
  function views:GetTeamSvrIdx()
    local teamType2SendIdxMap = {
      [TeamType.AbyssChallenge] = model.stageCfg and model.stageCfg.BelongGroup or 1,
      [TeamType.Special] = model.stageCfg and model.stageCfg.ID or 1
    }
    if teamType2SendIdxMap[model.teamType] then
      return teamType2SendIdxMap[model.teamType]
    end
    return model.curTeamIndex
  end
  
  function views:IsTeamFull()
    return self.fightAwakerNum == self.MaxBattleNum
  end
  
  function views:IsAssistSlot(slot)
    return slot == CommonDefine.TeamAssign.MaxBattleNum
  end
  
  function views:IsAssistStage()
    local list = DT.GetOriginalConstant("SocializeAllowAwakerSupportLevelType")
    for _, type in ipairs(list) do
      if model.stageGroupType == type then
        return true
      end
    end
    return false
  end
  
  function views:IsForceAssistStage()
    local stageGroupId = model.stageCfg and model.stageCfg.BelongGroup
    do return CopyDataUtils.IsForceAssistStageGroup end
    return CopyDataUtils.IsForceAssistStageGroup, stageGroupId
  end
  
  function views:InTeamAndNotCurSelect(awakerId, isCfgAwaker)
    local curSelectAwaker = self.curBuildingAwakerTeam[self.curAwakerSlot]
    local inTeam = self:IsAwakerInBuildingTeam(awakerId)
    if inTeam then
      if curSelectAwaker ~= awakerId then
        return true
      end
    else
      return false
    end
  end
  
  function views:GetAssistUid()
    return model.assistUid
  end
  
  function views:GetSingleChooseSpecialAwakerMode()
    return model.singleChooseSpecialAwakerMode
  end
  
  function views:GetAssistAwaker()
    if model.assistUid then
      return model.assistAwaker
    else
      return nil
    end
  end
  
  function views:GetAssistItem()
    if model.assistUid then
      do return DBGTeamDataUtils.NormalizeAssistItems end
      return DBGTeamDataUtils.NormalizeAssistItems, model.assistItems
    else
      return nil
    end
  end
  
  function views:GetAssistAwakerId()
    if model.assistUid then
      return model.assistAwaker.tid
    else
      return 0
    end
  end
  
  function views:GetFightedStageGroupData()
    return model.fightedStageGroupData
  end
  
  function views:GetFightedAssistAwakerTids()
    return model.fightedAssistAwakerTids
  end
  
  function views:CheckWeaponIsFighted(checkweaponTid)
    if not checkweaponTid or 0 == checkweaponTid then
      return false
    end
    local fightedDatas = model:GetFightedStageGroupData()
    for _, fightedData in pairs(fightedDatas) do
      for _, usedWeaponTid in pairs(fightedData.weaponTids) do
        if usedWeaponTid == checkweaponTid then
          return true
        end
      end
    end
    if self:IsBanTid(checkweaponTid) then
      return true
    end
    return false
  end
  
  function views:CheckCurWeaponGroupIsFighted()
    for idx, weaponGroup in pairs(model.teamWeaponGroups) do
      if self:CheckIsHideSlot(idx) then
      else
        for _, weaponUid in pairs(weaponGroup) do
          local weaponData = ItemDataUtils.GetItemByUid(weaponUid)
          local weaponTid = weaponData and weaponData.tid or 0
          if 0 ~= weaponTid and model:CheckWeaponIsFighted(weaponTid) then
            return true
          end
        end
      end
    end
    return false
  end
  
  local BaseAttrMap = {
    physique = true,
    atk = true,
    def = true
  }
  
  function views:IsBaseAttr(attrTid)
    local attrConfig = DT.ActorAttrType[attrTid]
    if not attrConfig or not attrConfig.Name then
      return false
    end
    return BaseAttrMap[attrConfig.Name]
  end
  
  function views:CheckIsNormalTeam()
    return model.teamMode == TeamAssign.eStageTeamMode.Normal
  end
  
  function views:GetAwakerTalents(awakerTid)
    if not awakerTid or 0 == awakerTid then
      return {}
    end
    local awakerData = self:GetAwakerDataByCfgId(awakerTid)
    if awakerData and awakerData.talents then
      return awakerData.talents
    end
    return {}
  end
  
  return views
end

local function IsSameAwakerIgnoreForm(tidA, tidB)
  tidA = tidA or 0
  tidB = tidB or 0
  if tidA == tidB then
    return true
  end
  if 0 == tidA or 0 == tidB then
    return false
  end
  return AwakerDataUtils.GetChangerForm(tidA) == tidB or AwakerDataUtils.GetChangerForm(tidB) == tidA
end

local function StripForeignBoundTrinkets(trinketGroup, slotAwakerTid)
  if not trinketGroup then
    return nil
  end
  local cleaned
  for pos, uid in pairs(trinketGroup) do
    if 0 ~= (uid or 0) then
      local boundOwner = AwakerDataUtils.IsTrinketBoundByAnyAwaker(uid)
      if boundOwner and not IsSameAwakerIgnoreForm(boundOwner, slotAwakerTid) then
        cleaned = cleaned or table.clone(trinketGroup)
        cleaned[pos] = 0
      end
    end
  end
  return cleaned
end

local function createDBGTeamBuildModelActions(model)
  local actions = {}
  
  function actions:GetKeeperSkillFightedStageGroupId()
    local keeperSkillItem = self:GetDisplayKeeperSkillItem()
    local curSkillId = KeeperSkillUtils.GetSkillIdByItem(keeperSkillItem)
    local itemTid = KeeperSkillUtils.GetItemIdBySkill(curSkillId)
    local fightedTeamDatas = self:GetFightedStageGroupData()
    for _, fightedTeamData in pairs(fightedTeamDatas) do
      if fightedTeamData.keeperSkillId == itemTid then
        return fightedTeamData.stageGroupId
      end
    end
    if self:IsBanTid(keeperSkillItem) then
      return true
    end
    return nil
  end
  
  function actions:SetTeamAwakerTids(awakerTids, refreshWeapon, refreshTrinket, noRefreshTeamInfo)
    for i = 1, MaxBattleNum do
      if not awakerTids[i] then
        awakerTids[i] = 0
      end
    end
    local oldAwakerTids = table.clone(model.teamAwakerTids)
    local needRefrshWeaponOrTrinket = refreshWeapon or refreshTrinket
    if needRefrshWeaponOrTrinket then
      local newAwakerMap = {}
      for _, tid in ipairs(awakerTids) do
        if 0 ~= tid then
          newAwakerMap[tid] = true
        end
      end
      local awakerWeaponMap = {}
      local emptyWeaponList = {}
      for idx, awakerTid in ipairs(oldAwakerTids) do
        if 0 ~= awakerTid and newAwakerMap[awakerTid] then
          awakerWeaponMap[awakerTid] = {
            weapons = model.teamWeaponGroups[idx],
            trinkets = model.teamTrinketGroups[idx]
          }
        else
          table.insert(emptyWeaponList, {
            weapons = model.teamWeaponGroups[idx],
            trinkets = model.teamTrinketGroups[idx]
          })
        end
      end
      for teamSlot, awakerTid in ipairs(awakerTids) do
        local awakerWeaponInfo = awakerWeaponMap[awakerTid] or table.remove(emptyWeaponList, 1)
        if awakerTid > 0 and awakerWeaponInfo then
          model:SetWeaponsGroupWithTeamSlot(awakerWeaponInfo.weapons, teamSlot)
          model:SetTrinketsGroupWithTeamSlot(awakerWeaponInfo.trinkets, teamSlot)
        else
          model:SetWeaponsGroupWithTeamSlot({0, 0}, teamSlot)
          model:SetTrinketsGroupWithTeamSlot({
            0,
            0,
            0,
            0,
            0,
            0
          }, teamSlot)
        end
      end
    end
    if table.next(AwakerDataUtils.GetMockAwakerMap()) == nil then
      for teamSlot = 1, MaxBattleNum do
        if not IsSameAwakerIgnoreForm(oldAwakerTids[teamSlot] or 0, awakerTids[teamSlot]) then
          local cleanedTrinkets = StripForeignBoundTrinkets(model.teamTrinketGroups[teamSlot], awakerTids[teamSlot])
          if cleanedTrinkets then
            model.teamTrinketGroups[teamSlot] = cleanedTrinkets
          end
        end
      end
    end
    model.teamAwakerTids = awakerTids
    if not noRefreshTeamInfo then
      model:UpdateAwakerTeamInfoWithCurData(model.curTeamIndex)
    end
    EventMgr.Instance.AwakerAttrChangeEvent:Dispatch()
  end
  
  function actions:SetFightedStageGroupData(tbl)
    model.fightedStageGroupData = tbl
  end
  
  function actions:SetFightedAssistAwakerTids(tbl)
    model.fightedAssistAwakerTids = tbl
  end
  
  function actions:SetSpecialAwakerAttrs(awakerTid, attrs)
    local awakerInfo = self:GetAwakerDataByCfgId(awakerTid * -1)
    if awakerInfo then
      awakerInfo.attrs = attrs
      awakerInfo.clientAttrs = AwakerDataUtils.GetAwakerShowAttrs(attrs)
    end
  end
  
  local slotGroup = {
    CommonDefine.WeaponSlotType.Primary,
    CommonDefine.WeaponSlotType.Secondary
  }
  
  function actions:SetTeamWeaponsGroup(weaponsGroup, noRefreshTeamInfo)
    local rst = {}
    for teamIdx, weapons in ipairs(weaponsGroup) do
      rst[teamIdx] = {}
      for _, slot in pairs(slotGroup) do
        local weaponUid = weapons[slot] or 0
        local weaponTid = 0 == weaponUid and 0 or GetItemDataTidByUid(weaponUid)
        if 0 == weaponTid then
          rst[teamIdx][slot] = 0
        else
          rst[teamIdx][slot] = weaponUid
        end
      end
    end
    model.teamWeaponGroups = rst
    if not noRefreshTeamInfo then
      model:UpdateAwakerTeamInfoWithCurData(model.curTeamIndex)
    end
  end
  
  function actions:OnItemDelete(uid)
    for teamIdx, weapons in ipairs(self.teamWeaponGroups) do
      for index, weaponUid in pairs(weapons) do
        if weaponUid == uid then
          weapons[index] = 0
          break
        end
      end
    end
  end
  
  function actions:SetWeaponsGroupWithTeamSlot(weaponGroup, teamSlot)
    for idx = 1, CommonDefine.TeamAssign.MaxBattleNum do
      if idx ~= teamSlot then
        local weaponedGroup = table.clone(model.teamWeaponGroups[idx])
        if weaponedGroup then
          for weaponSlot, weaponedUid in ipairs(weaponedGroup) do
            if 0 == weaponedUid then
            elseif table.contains(weaponGroup, weaponedUid) then
              weaponedGroup[weaponSlot] = 0
            end
          end
          model.teamWeaponGroups[idx] = weaponedGroup
        end
      end
    end
    model.teamWeaponGroups[teamSlot] = weaponGroup
    model:UpdateAwakerTeamInfoWithCurData(model.curTeamIndex)
  end
  
  function actions:SetReactiveNum(numVal)
    model.reactiveNum = numVal
  end
  
  function actions:OnTeamUnlocks(index)
    for i = index, index + 1 do
      if i <= MAX_TEAM_NUM and not model.allTeamList[i] then
        model.allTeamList[i] = GetDefaultTeamTbl()
      end
    end
  end
  
  function actions:SetTeamTrinketsGroup(trinketsGroup, noRefreshTeamInfo)
    model.teamTrinketGroups = trinketsGroup
    if not noRefreshTeamInfo then
      model:UpdateAwakerTeamInfoWithCurData(model.curTeamIndex)
    end
  end
  
  function actions:SetTrinketsGroupWithTeamSlot(trinketGroup, teamSlot)
    model.teamTrinketGroups[teamSlot] = trinketGroup
    model:UpdateAwakerTeamInfoWithCurData(model.curTeamIndex)
  end
  
  function actions:SyncTrinketsFromTeamCache(teamType)
    if teamType and teamType ~= model.teamType then
      return
    end
    if model.teamMode == eStageTeamMode.Preview then
      return
    end
    if not model.allTeamList then
      return
    end
    local sourceTeams = DBGTeamDataUtils.GetDBGTeams(model.teamType)
    local anyChanged = false
    for i, teamTbl in pairs(model.allTeamList) do
      if teamTbl and teamTbl.awakerTidList then
        local dbgTeam = sourceTeams[i] or FindSourceTeamByTidContents(sourceTeams, teamTbl)
        if dbgTeam then
          local newGroup = CreateTrinketsGroup(dbgTeam, teamTbl)
          if not IsSameTrinketsGroup(teamTbl.trinketsGroup, newGroup) then
            teamTbl.trinketsGroup = newGroup
            anyChanged = true
          end
        end
      end
    end
    if not anyChanged then
      return
    end
    local curTeamTbl = model.curTeamIndex and model.allTeamList[model.curTeamIndex]
    if curTeamTbl then
      model:SetTeamTrinketsGroup(curTeamTbl.trinketsGroup)
    end
  end
  
  function actions:ReqSetKeeperSkill(keeperSkill)
    if TeamAssignDataUtils.GetStageSpecialKeeperSkill(self.stageId) then
      return
    end
    model.keeperSkill = keeperSkill
    Logger.ReportApusInfo("DBGTeam SaveTeamToServer ReqSetKeeperSkill ")
    self:SaveTeamToServer(nil, true)
    DBGTeamDataUtils.SetSpecialKeeperSkill(keeperSkill)
    model:UpdateAwakerTeamInfoWithCurData(model.curTeamIndex)
  end
  
  function actions:SetKeeperSkill(keeperSkill, noRefreshTeamInfo)
    if TeamAssignDataUtils.GetStageSpecialKeeperSkill(self.stageId) then
      return
    end
    model.keeperSkill = keeperSkill
    DBGTeamDataUtils.SetSpecialKeeperSkill(keeperSkill)
    if not noRefreshTeamInfo then
      model:UpdateAwakerTeamInfoWithCurData(model.curTeamIndex)
    end
  end
  
  function actions:SetBanClick(Val)
    model.banClick = Val
  end
  
  function actions:SetBuildingTeam(buildingTeam)
    self.buildingTeam = buildingTeam
  end
  
  function actions:SetCurTeamIndex(idx)
    model.curTeamIndex = idx
  end
  
  function actions:SetCurBuildingAwakerTeamBySlot(val, slot)
    model.curBuildingAwakerTeam[slot] = val
  end
  
  function actions:SetUseConfigAwaker(slot, isUseConfig)
    self.useCfgAwakerSlots[slot] = isUseConfig and true or false
  end
  
  function actions:ChooseNewTeam(index)
    for key, teamInfo in pairs(model.allTeamList) do
      if key == index then
        teamInfo.isSelect = true
        model:SetTeamAwakerTids(teamInfo.awakerTidList, nil, nil, true)
        model:SetTeamWeaponsGroup(teamInfo.weaponsGroup, true)
        model:SetTeamTrinketsGroup(teamInfo.trinketsGroup, true)
        model:SetKeeperSkill(teamInfo.keeperSkillTid, true)
        model:SetCurTeamIndex(key)
      else
        teamInfo.isSelect = false
      end
    end
  end
  
  function actions:CreateAwakerEquipData()
    local rst = {}
    for idx, weaponedGroup in pairs(table.clone(model.teamWeaponGroups)) do
      local awakerTid = model.teamAwakerTids[idx]
      if awakerTid and 0 ~= awakerTid then
        if not rst[awakerTid] then
          rst[awakerTid] = {}
        end
        if not rst[awakerTid].weapons then
          rst[awakerTid].weapons = {}
        end
        for weaponSlot, weaponUid in pairs(weaponedGroup) do
          if 0 ~= weaponUid then
            if not rst[awakerTid].weapons[weaponSlot] then
              rst[awakerTid].weapons[weaponSlot] = {}
            end
            rst[awakerTid].weapons[weaponSlot].weaponUid = weaponUid
          end
        end
      end
    end
    for idx, trinketGroup in pairs(table.clone(model.teamTrinketGroups)) do
      local awakerTid = model.teamAwakerTids[idx]
      local isAssistSameTidSlot = idx == MaxBattleNum and model.assistUid and model.assistAwaker and awakerTid == model.assistAwaker.tid
      if awakerTid and 0 ~= awakerTid and not isAssistSameTidSlot then
        if not rst[awakerTid] then
          rst[awakerTid] = {}
        end
        if not rst[awakerTid].trinkets then
          rst[awakerTid].trinkets = {}
        end
        for trinketSlot, trinketUid in pairs(trinketGroup) do
          if type(trinketSlot) == "number" and trinketSlot >= 1 and trinketSlot <= MAX_TRINKGET_NUM and 0 ~= trinketUid and ItemDataUtils.GetItemByUid(trinketUid) then
            rst[awakerTid].trinkets[trinketSlot] = trinketUid
          end
        end
      end
    end
    if model.assistUid and model.assistAwaker then
      local assistTid = model.assistAwaker.tid
      if model.teamAwakerTids[MaxBattleNum] == assistTid then
        if not rst[assistTid] then
          rst[assistTid] = {}
        end
        rst[assistTid].trinkets = {}
        local trinketGroup = model.teamTrinketGroups[MaxBattleNum]
        for trinketSlot = 1, MAX_TRINKGET_NUM do
          local trinketUid = trinketGroup and trinketGroup[trinketSlot] or 0
          if 0 ~= trinketUid and DataCenter.itemData.BagItemData[trinketUid] then
            rst[assistTid].trinkets[trinketSlot] = trinketUid
          end
        end
      end
    end
    return rst
  end
  
  function actions:UpdateAwakerTeamInfo(index, data)
    local teamInfo = model.allTeamList[index]
    if not data or not teamInfo then
      Logger.Warn("UpdateAwakerTeamInfo: index=%s", index)
      return
    end
    for key, value in pairs(data) do
      local dataKey = "awakerTids" == key and "awakerTidList" or key
      teamInfo[dataKey] = value
    end
    model:SetShowAwakerInSertAnim(false)
  end
  
  function actions:UpdateAwakerTeamInfoWithCurData(index, isEmpty)
    local teamData = {isSelect = true}
    if not isEmpty then
      teamData.awakerTidList = model.teamAwakerTids
      teamData.weaponsGroup = model.teamWeaponGroups
      teamData.trinketsGroup = model.teamTrinketGroups
      teamData.keeperSkillTid = model.keeperSkill
    end
    self:UpdateAwakerTeamInfo(index, teamData)
  end
  
  function actions:SetAllTeamList(list)
    model.allTeamList = list
  end
  
  function actions:SetTeamDataWithIdx(idx, tbl)
    model.allTeamList[idx] = tbl
  end
  
  function actions:SetCurSelectSchool(tid)
    model.curSelectSchool = tid
  end
  
  function actions:SetShowAwakerList(list)
    model.showAwakerList = list
  end
  
  function actions:SetDefaultTeamIndex(val)
    model.defaultTeamIndex = val
  end
  
  function actions:SetTeamSchoolTid(val)
    model.teamSchoolTid = val
  end
  
  function actions:SetTeamCreateIndex(val)
    model.teamCreateIndex = val
  end
  
  function actions:SetTeamTempChooseIndex(val)
    model.teamTempChooseIndex = val
  end
  
  function actions:SetCurAwakerSlot(val)
    model.curAwakerSlot = val
  end
  
  function actions:SetCurBuildingNoBanAwakerTeam(list)
    for key, tid in pairs(list) do
      if model:IsForbidden(tid) then
        list[key] = 0
      end
    end
    model.curBuildingAwakerTeam = list
  end
  
  function actions:SetCurBuildingAwakerTeam(list)
    print("-----------set cur building awaker team", table.tostring(list), debug.traceback())
    model.curBuildingAwakerTeam = list
  end
  
  function actions:SetSortType(sortType)
    model.sortType = sortType
  end
  
  function actions:SetSortOrder(sortOrder)
    model.sortOrder = sortOrder
  end
  
  function actions:SetIsStartChallenge(val)
    model.isStartChallenge = val
  end
  
  function actions:SetPage(val)
    model.page = val
  end
  
  function actions:SetShowAwakerInSertAnim(val)
    model.showAwakerInSertAnim = val
  end
  
  function actions:EnableQuickBuildPanel(enable)
    model.isShowQuickBuildPanel = enable
  end
  
  function actions:EnableSortTypePanel(enable)
    model.isShowSortTypePanel = enable
  end
  
  function actions:EnableShowScollBar(enable)
    model.showScollBar = enable
  end
  
  function actions:SaveTeamToServer(confirmFunc, isSilent)
    if table.contains({
      eStageTeamMode.Preview
    }, model.teamMode) then
      if confirmFunc then
        confirmFunc()
      end
      return
    end
    local teamHasChange = false
    local dataCenterTeams = table.clone(DBGTeamDataUtils.GetDBGTeams(model.teamType))
    local sendIdx = model:GetTeamSvrIdx()
    local dataCenterAwakerTids = dataCenterTeams[sendIdx] and dataCenterTeams[sendIdx].awakerTids or {
      0,
      0,
      0,
      0
    }
    for index, tid in pairs(dataCenterAwakerTids) do
      if model.teamAwakerTids[index] ~= tid then
        teamHasChange = true
        break
      end
    end
    local updateTeamData = self:CreateUpdateTeamData(sendIdx, model.curTeamName, table.clone(model.teamAwakerTids), function(teamData)
      self:UpdateAwakerTeamInfo(sendIdx, teamData)
    end)
    if eStageTeamMode.Special == model.teamMode then
      updateTeamData.teamType = TeamType.Special
    end
    if 0 ~= model.defaultTeamIndex then
      DBGTeamDataUtils.UpdateTeam(updateTeamData)
      if confirmFunc then
        confirmFunc()
      end
      return
    end
    if isSilent then
      DBGTeamDataUtils.UpdateTeam(updateTeamData)
      if confirmFunc then
        confirmFunc()
      end
      return
    end
    DBGTeamDataUtils.UpdateTeam(updateTeamData)
    if model.isStartChallenge == false and true == teamHasChange and model.teamMode ~= eStageTeamMode.Special then
      Alert.Show(10518)
    end
    if confirmFunc then
      confirmFunc()
    end
  end
  
  function actions:CreateUpdateTeamData(teamIdx, newName, awakerTids, callback)
    local awakerEquipData = table.clone(self:CreateAwakerEquipData())
    local fakeAwakerTid
    for awakerTid, _ in pairs(awakerEquipData) do
      local awakerTeamData = model:GetAwakerDataByCfgId(awakerTid)
      if awakerTeamData.isFakeAwaker then
        fakeAwakerTid = awakerTid
      end
    end
    if fakeAwakerTid then
      awakerEquipData[fakeAwakerTid] = nil
      for idx = 1, #awakerTids do
        if awakerTids[idx] == fakeAwakerTid then
          awakerTids[idx] = 0
        end
      end
    end
    local updateTeamData = {
      teamType = model.teamType,
      keeperSkill = model.keeperSkill,
      teamIdx = teamIdx,
      name = newName,
      awakerEquipData = awakerEquipData,
      callback = callback,
      awakerTids = table.clone(awakerTids),
      teamMode = model.teamMode
    }
    return updateTeamData
  end
  
  function actions:SetSingleChooseSpecialAwakerMode(boolVal)
    model.singleChooseSpecialAwakerMode = boolVal
  end
  
  function actions:SetAssistData(assistData)
    if model.assistAwaker and nil == assistData then
      Alert.ShowStr(LT.Text("TeamAssistAwakerStepDown"))
    end
    model.assistUid = assistData and assistData.assistUid or nil
    model.assistAwaker = assistData and assistData.awakerData or nil
    model.assistItems = assistData and DBGTeamDataUtils.NormalizeAssistItems(assistData.items) or nil
    if assistData then
      local awakerId = assistData.awakerData.tid
      local changerFormId = AwakerDataUtils.GetChangerForm(awakerId)
      local slot = self:GetAwakerSlot(model.teamAwakerTids, awakerId)
      if 0 == slot then
        slot = self:GetAwakerSlot(model.teamAwakerTids, changerFormId)
      end
      if 0 ~= slot then
        local teamAwakerTids = table.clone(model.teamAwakerTids)
        local oriAwakerTid = teamAwakerTids[slot]
        teamAwakerTids[slot] = teamAwakerTids[MaxBattleNum]
        teamAwakerTids[MaxBattleNum] = oriAwakerTid
        model:SetTeamAwakerTids(teamAwakerTids, true, true)
      end
    end
    EventMgr.Instance.AwakerAttrChangeEvent:Dispatch()
    GlobalDispatcher:Dispatch(NotifyId.OnAssistAwakerChanged)
  end
  
  function actions:MapServerData()
    if model.teamMode == eStageTeamMode.Preview then
      self:InitTeamInfoWithPreviewData()
      return
    end
    local svrLastSelectTeam = DBGTeamDataUtils.GetDBGLastSelectTeam(model.teamType)
    local lastSelectTeam = 1
    if model.teamMode ~= eStageTeamMode.Special then
      lastSelectTeam = not svrLastSelectTeam and 1 or svrLastSelectTeam
    end
    model.defaultTeamIndex = lastSelectTeam
    model.curTeamIndex = lastSelectTeam
    local teams = DBGTeamDataUtils.GetDBGTeams(model.teamType)
    local stageGroupId = model.stageCfg and model.stageCfg.BelongGroup
    local tempTeams = teamType2CreateFuncMap[model.teamType](model.teamType, teams, stageGroupId, model.stageId, model)
    SanitizeTempTeamsOwnedAwakers(tempTeams, teams, model.teamMode, model.tFakeAwakerDatas)
    local teamAwakerTids = tempTeams[lastSelectTeam].awakerTidList
    for idx, tid in pairs(model.fakeAwakerTids or {}) do
      if 0 ~= tid then
        teamAwakerTids[idx] = tid
        self.useCfgAwakerSlots[idx] = true
      end
    end
    tempTeams[lastSelectTeam].awakerTidList = teamAwakerTids
    model:SetAllTeamList(tempTeams)
    model:SetTeamAwakerTids(teamAwakerTids, nil, nil, true)
    model:SetTeamWeaponsGroup(tempTeams[lastSelectTeam].weaponsGroup, true)
    model:SetTeamTrinketsGroup(tempTeams[lastSelectTeam].trinketsGroup, true)
    model:SetCurBuildingAwakerTeam(model.teamAwakerTids)
    model:SetKeeperSkill(tempTeams[lastSelectTeam].keeperSkillTid)
  end
  
  function actions:InitTeamInfoWithPreviewData()
    if model.teamMode ~= eStageTeamMode.Preview then
      return
    end
    local teamAwakerTids = {
      0,
      0,
      0,
      0
    }
    local weaponsGroup = {
      {0, 0},
      {0, 0},
      {0, 0},
      {0, 0}
    }
    local trinketsGroup = {
      {
        0,
        0,
        0,
        0,
        0,
        0
      },
      {
        0,
        0,
        0,
        0,
        0,
        0
      },
      {
        0,
        0,
        0,
        0,
        0,
        0
      },
      {
        0,
        0,
        0,
        0,
        0,
        0
      },
      {
        0,
        0,
        0,
        0,
        0,
        0
      },
      {
        0,
        0,
        0,
        0,
        0,
        0
      }
    }
    for idx, awakerData in pairs(model.previewAwakersData.awakers) do
      teamAwakerTids[idx] = awakerData.tid
    end
    for idx, awakerData in pairs(model.previewAwakersData.awakers) do
      local weaponGroup = {}
      for i = 1, 2 do
        local weaponSlotData = AwakerDataUtils.GetWeaponSlotDataWithType(awakerData, i)
        weaponGroup[i] = weaponSlotData.weaponUid or 0
      end
      weaponsGroup[idx] = weaponGroup
    end
    for idx, awakerData in pairs(model.previewAwakersData.awakers) do
      local trinketGroup = {}
      for i = 1, 6 do
        trinketGroup[i] = awakerData.trinkets[i] or 0
      end
      trinketsGroup[idx] = trinketGroup
    end
    AwakerDataUtils.isPreviewingAwakersData = true
    AwakerDataUtils.InitMockAwakerMap(model.previewAwakersData.awakers)
    ItemDataUtils.InitMockItemData(model.previewAwakersData.items)
    ItemDataUtils.OpenHandleMockDataLock(Urls.DBGTeamBuildMainPanel)
    AwakerDataUtils.OpenHandleMockDataLock(Urls.DBGTeamBuildMainPanel)
    AwakerDataUtils.isPreviewingAwakersData = false
    model:SetKeeperSkill(model.previewAwakersData.keeperSkill)
    model:SetTeamAwakerTids(teamAwakerTids)
    model:SetTeamWeaponsGroup(weaponsGroup)
    model:SetTeamTrinketsGroup(trinketsGroup)
  end
  
  function actions:RefreshTeamAwakerTalent(awakerTid, talentTid, level)
    local awakerData = model.awakerDataMap[awakerTid]
    if awakerData and awakerData.talents and awakerData.talents[talentTid] then
      awakerData.talents[talentTid].lv = level
    end
  end
  
  return actions
end

local function onSetup(binder, model)
  local fightedStageGroupData = {}
  local fightedAssistAwakerTids = {}
  binder:BindToRaw(function()
    model:SetShowAwakerInSertAnim(false)
  end, function()
    return model.careerEffectList
  end)
  binder:BindEvent(EventMgr.Instance.RemoveItemEvent, function(item)
    model:OnItemDelete(item.uid)
  end)
  binder:BindEvent(EventMgr.Instance.OnTeamSpecialAwakerAttr, function(awakerAttrMap)
    for tid, attrs in pairs(awakerAttrMap) do
      model:SetSpecialAwakerAttrs(tid, attrs)
    end
  end)
  
  local function InitBySvrData()
    model:SetFightedStageGroupData(fightedStageGroupData)
    model:SetFightedAssistAwakerTids(fightedAssistAwakerTids)
    model:MapServerData()
    binder:BindToRaw(function()
      local teamIndex = model:GetTeamSvrIdx()
      local teamsData = DBGTeamDataUtils.GetDBGTeams(model.teamType)
      local dbgTeamData = teamsData[teamIndex]
      local defaultKeeperSkill = KeeperSkillUtils.GetDefaultItem()
      local keeperSkill = dbgTeamData and dbgTeamData.keeperSkill or defaultKeeperSkill
      if not dbgTeamData then
        keeperSkill = model.keeperSkill or defaultKeeperSkill
      end
      if keeperSkill ~= model.keeperSkill then
        model:SetKeeperSkill(keeperSkill)
      end
    end, function()
      return model.curTeamIndex
    end)
    if model.teamType == cd.TeamType.Special and model.stageId then
      DBGTeamDataUtils.ReqStageSpecialAwakerDataAttrs(model.stageId)
    end
  end
  
  if not model.fightedStageGroups then
    InitBySvrData()
    return
  end
  
  local function BanAwakerInfoFunc(stageGroupTid, awakerInfo, items, keeperSkill)
    if awakerInfo.assistPlayerId <= 0 then
      local weaponTids = {}
      for _, weaponSlotData in pairs(AwakerDataUtils.GetWeaponSlotData(awakerInfo)) do
        local weaponItemData = items[weaponSlotData.weaponUid]
        if weaponItemData and weaponItemData.tid and weaponItemData.tid > 0 then
          table.insert(weaponTids, weaponItemData.tid)
        end
      end
      fightedStageGroupData[awakerInfo.tid] = {
        awakerTid = awakerInfo.tid,
        stageGroupId = stageGroupTid,
        weaponTids = weaponTids,
        keeperSkillId = keeperSkill
      }
      local changeFormTid = AwakerDataUtils.GetChangerForm(awakerInfo.tid)
      if changeFormTid and 0 ~= changeFormTid then
        fightedStageGroupData[changeFormTid] = {
          awakerTid = changeFormTid,
          stageGroupId = stageGroupTid,
          weaponTids = weaponTids,
          keeperSkillId = keeperSkill
        }
      end
    else
      table.insert(fightedAssistAwakerTids, awakerInfo.tid)
    end
  end
  
  for stageGroupId, stageInfo in pairs(model.fightedStageGroups) do
    if stageInfo.stageTid > 0 then
      for _, awakerInfo in pairs(stageInfo.team.awakers) do
        BanAwakerInfoFunc(stageInfo.stageGroupTid, awakerInfo, stageInfo.team.items, stageInfo.team.keeperSkill)
      end
      if stageInfo.extraPass and stageInfo.teamExtra and stageInfo.teamExtra.awakers then
        for _, awakerInfo in pairs(stageInfo.teamExtra.awakers) do
          BanAwakerInfoFunc(stageInfo.stageGroupTid, awakerInfo, stageInfo.teamExtra.items, stageInfo.teamExtra.keeperSkill)
        end
      end
    end
  end
  InitBySvrData()
end

local DBGTeamBuildModel = Vue.model("DBGTeamBuildModel", createDBGTeamBuildModelState):views(createDBGTeamBuildModelViews):actions(createDBGTeamBuildModelActions):setup(onSetup)
return DBGTeamBuildModel
