local RelicGroupMap
local UndefineQualitySort = 999
local RelicSortValueTable
local RELIC_GROUP_LANG_PREFIX = "RelicGroup_"
local RELIC_TYPE_LANG_SUFFIX = "RelicTypeName"
local RelicDataUtils = {}

function RelicDataUtils.ResetAll()
  DataCenter.relicData.CurActivedRelicIds = {}
  DataCenter.relicData.CurActivedRelicDatas = {}
  DataCenter.relicData.NeedShowAddEffectRelicIds = {}
  DataCenter.relicData.RelicSelectEventCourseTips = {}
  DataCenter.relicData.BattleShowRelicCDList = {}
  DataCenter.relicData.RelicDetailDarkMode = false
  DataCenter.relicData.GameCopyKeepRelicDatas = {}
  DataCenter.relicData.GameCopykeepRelicList = {}
  DataCenter.relicData.CurChooseKeepUid = 0
  DataCenter.relicData.EnterCopyKeepRelic = {}
  DataCenter.relicData.CopyKeepRelicSelectCount = 0
end

function RelicDataUtils.AddRelic(addRelicData, playSound)
  local relicUid = addRelicData.uid
  local tid = addRelicData.tid
  local descArgs = addRelicData.descArgs
  if not relicUid or SystemUtils.Contain(DataCenter.relicData.CurActivedRelicIds, relicUid) then
    return
  end
  local rData = {
    uid = relicUid,
    relicTid = tid,
    descArgs = descArgs
  }
  DataCenter.relicData.CurActivedRelicDatas[relicUid] = rData
  DataCenter.relicData.NeedShowAddEffectRelicIds[relicUid] = true
  if playSound and (SceneMgr.Instance:IsInBattle() or SceneMgr.Instance:IsInCopies()) then
    AudioManager.Instance:PostSoundEvent("INGAME_GET_RELIC")
  end
  table.insert(DataCenter.relicData.CurActivedRelicIds, relicUid)
  EventMgr.Instance.OnRelicDataChange:Dispatch(addRelicData)
  EventMgr.Instance.OnRelicAdd:Dispatch(tid)
end

function RelicDataUtils.RemoveRelic(relicUid)
  for index, value in ipairs(DataCenter.relicData.CurActivedRelicIds) do
    if value == relicUid then
      table.remove(DataCenter.relicData.CurActivedRelicIds, index)
      break
    end
  end
  local removeRelicData = DataCenter.relicData.CurActivedRelicDatas[relicUid]
  local tid = removeRelicData and removeRelicData.relicTid
  DataCenter.relicData.CurActivedRelicDatas[relicUid] = nil
  if tid then
    EventMgr.Instance.OnRelicDataChange:Dispatch()
    EventMgr.Instance.OnRelicRemove:Dispatch(tid)
  end
end

function RelicDataUtils.GetAllRelicTids()
  local list = {}
  for _, data in pairs(DataCenter.relicData.CurActivedRelicDatas) do
    table.insert(list, data.relicTid)
  end
  return list
end

function RelicDataUtils.GetUnlockRelics()
  local DRole = DataCenter.playerData.DRole
  local playerLevel = DRole and DRole.level
  local unlockList = {}
  if playerLevel then
    for tid, cfg in pairs(DT.RelicConfig) do
      if cfg.UnlockLevel == playerLevel then
        table.insert(unlockList, tid)
      end
    end
  end
  return unlockList
end

function RelicDataUtils.HasRelic(relicUid)
  for _, value in ipairs(DataCenter.relicData.CurActivedRelicIds) do
    if value == relicUid then
      return true
    end
  end
  return false
end

function RelicDataUtils.GetRelicTid(relicUid)
  if DataCenter.relicData.CurActivedRelicDatas[relicUid] then
    return DataCenter.relicData.CurActivedRelicDatas[relicUid].relicTid
  end
  return 0
end

function RelicDataUtils.GetAllRelics()
  local list = {}
  for _, value in ipairs(DataCenter.relicData.CurActivedRelicIds) do
    table.insert(list, value)
  end
  return list
end

function RelicDataUtils.GetAllRelicDatas()
  local list = {}
  for _, data in pairs(DataCenter.relicData.CurActivedRelicDatas) do
    table.insert(list, data)
  end
  return list
end

function RelicDataUtils.IsHaveRelicKey(relicList)
  local relicKeyId = DT.GetConstant("RelicKey")
  for _, data in pairs(relicList or {}) do
    if (data.relicTid or data.tid) == relicKeyId then
      return true
    end
  end
end

function RelicDataUtils.MoveKeyToEndIndex(relicList)
  local relicKeyId = DT.GetConstant("RelicKey")
  local endIndex = CommonDefine.StageRelicGrid
  local relicKeyData
  for index, value in ipairs(relicList) do
    if (value.relicTid or value.tid) == relicKeyId then
      relicKeyData = value
      table.remove(relicList, index)
      break
    end
  end
  for index = #relicList + 1, endIndex do
    table.insert(relicList, index == endIndex and relicKeyData or {})
  end
  return relicList
end

function RelicDataUtils.AfterShowAddRelicEffect(uid)
  local result = DataCenter.relicData.NeedShowAddEffectRelicIds[uid]
  DataCenter.relicData.NeedShowAddEffectRelicIds[uid] = nil
  return result or false
end

function RelicDataUtils.ClearRelics()
  DataCenter.relicData.CurActivedRelicIds = {}
  DataCenter.relicData.CurActivedRelicDatas = {}
  DataCenter.relicData.GameCopykeepRelicList = {}
  DataCenter.relicData.GameCopyKeepRelicDatas = {}
end

function RelicDataUtils.AddRelicSelectEventCourseTipsInfo(tid, isNeedTips)
  DataCenter.relicData.RelicSelectEventCourseTips[tid] = isNeedTips
end

function RelicDataUtils.ClearRelicSelectEventCourseTips()
  DataCenter.relicData.RelicSelectEventCourseTips = {}
end

function RelicDataUtils.UpdateRelic(updateRelicData)
  local relicUid = updateRelicData.uid
  local relic = DataCenter.relicData.CurActivedRelicDatas[relicUid]
  if not relic then
    return
  end
  EventMgr.Instance.OnRelicDataChange:Dispatch(updateRelicData)
end

function RelicDataUtils.GetRelicUidByTid(tid)
  for uid, data in pairs(DataCenter.relicData.CurActivedRelicDatas) do
    if data.relicTid == tid then
      return uid
    end
  end
end

function RelicDataUtils.ShowGainRelicDetailPanel(relics, callback, confirmFunc, giveUpFunc, loadEndCb, forbidCntTip)
  UIManager.Instance:Reopen(Urls.WorldStageShopConfirmPanel, relics, callback, confirmFunc, giveUpFunc, loadEndCb, forbidCntTip)
end

function RelicDataUtils.AddBattleShowRelicCDList(config)
  table.insert(DataCenter.relicData.BattleShowRelicCDList, config)
end

function RelicDataUtils.GetBattleShowRelicCDList()
  return DataCenter.relicData.BattleShowRelicCDList
end

function RelicDataUtils.PopBattleShowRelicCD()
  do return table.remove end
  return table.remove, DataCenter.relicData.BattleShowRelicCDList
end

function RelicDataUtils.IsBattleShowRelicCDEmpty()
  return DataCenter.relicData.BattleShowRelicCDList[1]
end

function RelicDataUtils.GetRelicQulityIcon(tid)
  local config = RelicDataUtils.GetRelicConfig(tid)
  if not config then
    return
  end
  do return RelicDataUtils.GetRelicQulityAsset end
  return RelicDataUtils.GetRelicQulityAsset, config.Quality
end

function RelicDataUtils.GetRelicQulityAsset(quality)
  assert(DT.ItemQuality[quality].ItemQualityFrame, string.format("GetRelicQulityAsset: DT.ItemQuality[%s].ItemQualityFrame is nil", quality))
  return DT.ItemQuality[quality].ItemQualityFrame
end

function RelicDataUtils.ReqCopyChooseGameRelics(tids, callback)
  ProtoManager.Instance:ReqServer("WorldRequest", "OnChooseGameRelics", function(_)
    if callback then
      callback()
    end
  end, nil, tids)
end

function RelicDataUtils.SetDataToKeepRelicDatas(data)
  if not DataCenter.relicData.GameCopyKeepRelicDatas then
    DataCenter.relicData.GameCopyKeepRelicDatas = {}
  end
  for key, value in ipairs(data) do
    DataCenter.relicData.GameCopyKeepRelicDatas[key] = value
  end
end

function RelicDataUtils.GetKeepRelicIndex(relicUid)
  local index = -1
  for key, value in pairs(DataCenter.relicData.GameCopyKeepRelicDatas) do
    if value == relicUid then
      index = key
      break
    end
  end
  return index
end

function RelicDataUtils.GetCurGameCopyKeepRelicTids()
  local list = {}
  for _, value in pairs(DataCenter.relicData.GameCopyKeepRelicDatas) do
    if value > 0 then
      table.insert(list, value)
    end
  end
  return list
end

function RelicDataUtils.GetKeepRelicByTid(relicTid)
  for _, relic in pairs(DataCenter.relicData.GameCopyKeepRelicDatas) do
    if relic.tid == relicTid then
      return relic
    end
  end
end

function RelicDataUtils.HasChooseRelic(uid)
  for _, value in ipairs(DataCenter.relicData.GameCopykeepRelicList) do
    if value.uid == uid then
      return true
    end
  end
  return false
end

function RelicDataUtils.AddChooseRelic(info)
  table.insert(DataCenter.relicData.GameCopykeepRelicList, info)
end

function RelicDataUtils.GetRelicConfig(tid)
  if not tid then
    return
  end
  return DT.RelicConfig[tid]
end

function RelicDataUtils.GetRelicName(tid)
  local config = RelicDataUtils.GetRelicConfig(tid)
  if not config then
    return
  end
  do return LT.Text end
  return LT.Text, config.Name
end

function RelicDataUtils.GetTypeName(tid)
  local config = RelicDataUtils.GetRelicConfig(tid)
  if not config or not config.Quality then
    return ""
  end
  local langKey = config.Quality .. RELIC_TYPE_LANG_SUFFIX
  do return LT.Text end
  return LT.Text, langKey
end

function RelicDataUtils.GetRelicIcon(tid)
  local config = RelicDataUtils.GetRelicConfig(tid)
  if not config then
    return
  end
  return config.Icon
end

function RelicDataUtils.GetRelicDesc(tid, _, stageTid)
  local relicConfig = RelicDataUtils.GetRelicConfig(tid)
  if not relicConfig then
    return ""
  end
  local relicParam = {}
  local desc = LT.Text(relicConfig.Desc)
  if SceneMgr.Instance and SceneMgr.Instance:IsInCopies() or bg.battleScene then
    desc = LT.Text(relicConfig.BattleDesc)
  end
  local isGotRelicParam = false
  local cmdParser
  if bg.isReplay and bg.battleDataCenter and relicConfig.StateTarget1 and relicConfig.State1 and #relicConfig.State1 > 0 then
    local stateId = relicConfig.State1[1]
    local targetUid
    if relicConfig.StateTarget1 == "PlayerRole" then
      local playerRole = bg.battleDataCenter:GetPlayerRoleDataModel()
      if playerRole then
        targetUid = playerRole.uid
      end
    end
    if targetUid and stateId then
      local stateData = bg.battleDataCenter.stateData:GetRoleState(targetUid, stateId)
      if stateData and stateData.stateParams then
        isGotRelicParam = true
        relicParam = stateData.stateParams
      end
    end
  end
  if not isGotRelicParam then
    local parserEnv = {}
    cmdParser = BattleCmdParserClient(parserEnv)
    if stageTid then
      cmdParser:SetMemberValue(CommonDefine.OutsideStageMemberField, stageTid)
    end
    for _, valueStr in ipairs(relicConfig.StatePara or {}) do
      table.insert(relicParam, cmdParser:GetValueByCmd(valueStr))
    end
  else
    local parserEnv = {}
    cmdParser = BattleCmdParserClient(parserEnv)
    if stageTid then
      cmdParser:SetMemberValue(CommonDefine.OutsideStageMemberField, stageTid)
    end
  end
  for valueStr in string.gmatch(desc, "%b[]") do
    local innerStr = string.match(valueStr, "%[(.+)]")
    if innerStr then
      local subStrs = string.split(innerStr, ":")
      local tagStr = #subStrs > 1 and subStrs[1] or nil
      local argStr = subStrs[#subStrs]
      local argIndex = tonumber(string.match(argStr, "Arg(%d+)"))
      local value = 0
      if argIndex and relicParam[argIndex] then
        value = relicParam[argIndex]
        if "Float" ~= tagStr then
          value = math.ceil(value)
        end
        value = SkillUtils.GetShowValue(cmdParser, tagStr, value)
        local escapedStr = string.gsub(valueStr, "([%%%[%]%(%)%.%+%-%*%?%^%$])", "%%%1")
        desc = string.gsub(desc, escapedStr, tostring(value), 1)
      end
    end
  end
  if cmdParser and stageTid then
    cmdParser:SetMemberValue(CommonDefine.OutsideStageMemberField, nil)
  end
  return desc
end

function RelicDataUtils.GetRelicCfgByField(field, tid)
  local config = RelicDataUtils.GetRelicConfig(tid)
  if not config then
    return
  end
  return config[field]
end

function RelicDataUtils.GetStoryDesc(tid)
  local config = RelicDataUtils.GetRelicConfig(tid)
  if not config or not config.StoryDesc then
    return ""
  end
  do return LT.Text end
  return LT.Text, config.StoryDesc
end

function RelicDataUtils.GetRelicSortValue(quality)
  if not quality then
    return UndefineQualitySort
  end
  if RelicSortValueTable then
    return RelicSortValueTable[quality] or UndefineQualitySort
  end
  RelicSortValueTable = {}
  local sortValueTable = DT.GetOriginalConstant("RelicGroupCollation")
  for sortValue, _quality in ipairs(sortValueTable) do
    RelicSortValueTable[_quality] = sortValue
  end
  return RelicSortValueTable[quality] or UndefineQualitySort
end

function RelicDataUtils.GetRelicListByGroup(group)
  if not group then
    return {}
  end
  local orinRelicList = RelicDataUtils._GetRelicListByGroup(group)
  local retRelicList = {}
  for _, relicTid in pairs(orinRelicList) do
    local relicCfg = DT.RelicConfig[relicTid]
    if relicCfg and (not relicCfg.DisplayDate or relicCfg.DisplayDate <= TimeUtils.GetServerTime()) then
      table.insert(retRelicList, relicTid)
    end
  end
  return retRelicList
end

function RelicDataUtils._GetRelicListByGroup(group)
  if not group then
    return {}
  end
  if RelicGroupMap then
    return RelicGroupMap[group] or {}
  end
  RelicGroupMap = {}
  local forbidRelicMap = AwakerDataUtils.GetForbidRelicMap()
  for relicTid, config in pairs(DT.RelicConfig) do
    if not config or not config.RelicGroup then
    elseif forbidRelicMap[relicTid] then
    else
      if not RelicGroupMap[config.RelicGroup] then
        RelicGroupMap[config.RelicGroup] = {}
      end
      table.insert(RelicGroupMap[config.RelicGroup], relicTid)
    end
  end
  for _, list in pairs(RelicGroupMap) do
    if #list > 1 then
      table.sort(list, function(a, b)
        local configA = RelicDataUtils.GetRelicConfig(a)
        local configB = RelicDataUtils.GetRelicConfig(b)
        local qualityA = configA and configA.Quality or ""
        local qualityB = configB and configB.Quality or ""
        local sortValueA = RelicDataUtils.GetRelicSortValue(qualityA)
        local sortValueB = RelicDataUtils.GetRelicSortValue(qualityB)
        if sortValueA == sortValueB then
          return configA.BaseSortID < configB.BaseSortID
        end
        return sortValueA < sortValueB
      end)
    end
  end
  return RelicGroupMap[group] or {}
end

function RelicDataUtils.GetRelicGroupName(group)
  if not group then
    return
  end
  local langKey = RELIC_GROUP_LANG_PREFIX .. group
  do return LT.Text end
  return LT.Text, langKey
end

function RelicDataUtils.SortRelics(relicList)
  local rst = {}
  for k, v in pairs(relicList) do
    table.insert(rst, v)
  end
  table.sort(rst, function(a, b)
    return a.uid < b.uid
  end)
  return rst
end

function RelicDataUtils.GetStrengthRelictList()
  local rst = {}
  local relicList = RelicDataUtils.SortRelics(RelicDataUtils.GetAllRelicDatas())
  for _, relicData in ipairs(relicList) do
    local relicTid = relicData.relicTid
    if RelicDataUtils.CheckRelicCanUpgrade(relicTid) then
      table.insert(rst, relicData)
    end
  end
  return rst
end

function RelicDataUtils.CheckRelicCanUpgrade(relicTid)
  do return RelicCfgUtils.GetCfgField, "RelicUpgrade" end
  return RelicCfgUtils.GetCfgField, "RelicUpgrade", relicTid
end

return RelicDataUtils
