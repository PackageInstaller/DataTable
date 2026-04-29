local UISummerActivity2LevelType = {
  Normal = 1,
  Affix = 2,
  Boss = 3
}
_enum("UISummerActivity2LevelType", UISummerActivity2LevelType)
local UISummerActivityTwoLevelStatus = {
  UnOpen = 1,
  Complete = 2,
  UnComplete = 3
}
_enum("UISummerActivityTwoLevelStatus", UISummerActivityTwoLevelStatus)
_class("UISummerActivityTwoEntryData", Object)
UISummerActivityTwoEntryData = UISummerActivityTwoEntryData

function UISummerActivityTwoEntryData:Constructor(id, scoreRatio)
  local cfgs = Cfg.cfg_affix({ID = id})
  if cfgs == nil or #cfgs <= 0 then
    return
  end
  local cfg = cfgs[1]
  local paramsCfg = cfg.EntryParam
  local params = {}
  if paramsCfg and paramsCfg[1] then
    local p = paramsCfg[1]
    for k, v in ipairs(p) do
      if type(v) == "string" then
        params[#params + 1] = StringTable.Get(v)
      elseif type(v) == "number" then
        params[#params + 1] = v
      end
    end
  end
  self._des = StringTable.Get(cfg.Desc, table.unpack(params))
  self._id = id
  self._type = cfg.Type
  self._scoreRatio = 0
  if scoreRatio then
    self._scoreRatio = scoreRatio
  end
  self._isSelected = false
  self._level = 0
  if cfg.Level then
    self._level = cfg.Level
  end
end

function UISummerActivityTwoEntryData:GetId()
  return self._id
end

function UISummerActivityTwoEntryData:GetLevel()
  return self._level
end

function UISummerActivityTwoEntryData:GetType()
  return self._type
end

function UISummerActivityTwoEntryData:GetDes()
  return self._des
end

function UISummerActivityTwoEntryData:SetSelectedStatus(status)
  self._isSelected = status
end

function UISummerActivityTwoEntryData:IsSelected()
  return self._isSelected
end

function UISummerActivityTwoEntryData:GetScroeRatio()
  return self._scoreRatio
end

function UISummerActivityTwoEntryData:GetScroeRatioStr()
  local a, b = math.modf(self._scoreRatio / 10)
  if b == 0 then
    return StringTable.Get("str_summer_activity_two_score_ratio_str", a)
  end
  return StringTable.Get("str_summer_activity_two_score_ratio_str", self._scoreRatio / 10)
end

_class("UISummerActivityTwoEntryGroupsData", Object)
UISummerActivityTwoEntryGroupsData = UISummerActivityTwoEntryGroupsData

function UISummerActivityTwoEntryGroupsData:Constructor(affixAndScore)
  self._entryGroupDatas = {}
  if not affixAndScore then
    return
  end
  local entryDatas = {}
  for i = 1, #affixAndScore do
    local entryData = UISummerActivityTwoEntryData:New(affixAndScore[i][1], affixAndScore[i][2])
    local type = entryData:GetType()
    local entryGroup = entryDatas[type]
    if entryGroup == nil then
      entryGroup = {}
      entryDatas[type] = entryGroup
    end
    entryGroup[#entryGroup + 1] = entryData
  end
  for k, v in pairs(entryDatas) do
    table.sort(v, function(a, b)
      local aLevel = a:GetLevel()
      local bLevel = b:GetLevel()
      if aLevel < bLevel then
        return true
      elseif aLevel > bLevel then
        return false
      end
      return a:GetId() < b:GetId()
    end)
    self._entryGroupDatas[#self._entryGroupDatas + 1] = v
  end
  table.sort(self._entryGroupDatas, function(a, b)
    return a[1]:GetType() < b[1]:GetType()
  end)
end

function UISummerActivityTwoEntryGroupsData:GetEntryGroups()
  return self._entryGroupDatas
end

function UISummerActivityTwoEntryGroupsData:GetGroupCount()
  return #self._entryGroupDatas
end

function UISummerActivityTwoEntryGroupsData:GetEntryCount()
  local count = 0
  for i = 1, #self._entryGroupDatas do
    count = count + #self._entryGroupDatas[i]
  end
  return count
end

function UISummerActivityTwoEntryGroupsData:GetEntryDataById(entryId)
  for i = 1, #self._entryGroupDatas do
    for j = 1, #self._entryGroupDatas[i] do
      if self._entryGroupDatas[i][j]:GetId() == entryId then
        return self._entryGroupDatas[i][j]
      end
    end
  end
end

_class("UISummerActivityTwoEntryLevelData", Object)
UISummerActivityTwoEntryLevelData = UISummerActivityTwoEntryLevelData

function UISummerActivityTwoEntryLevelData:Constructor(cfg)
  self._level = cfg[1]
  self._levelScore = cfg[2]
  self._levelName = StringTable.Get("str_summer_activity_two_entry_level_name_" .. self._level)
  self._levelStr = StringTable.Get("str_summer_activity_two_entry_level_" .. self._level)
  self._suggestAwake = cfg[4]
  self._suggestLevel = cfg[5]
  self._isSelected = false
end

function UISummerActivityTwoEntryLevelData:IsSelected()
  return self._isSelected
end

function UISummerActivityTwoEntryLevelData:SetSelectedStatus(status)
  self._isSelected = status
end

function UISummerActivityTwoEntryLevelData:GetSuggestLevel()
  return self._suggestLevel
end

function UISummerActivityTwoEntryLevelData:GetSuggestAwake()
  return self._suggestAwake
end

function UISummerActivityTwoEntryLevelData:GetLevel()
  return self._level
end

function UISummerActivityTwoEntryLevelData:GetLevelScore()
  return self._levelScore
end

function UISummerActivityTwoEntryLevelData:GetLevelName()
  return self._levelName
end

function UISummerActivityTwoEntryLevelData:GetLevelStr()
  return self._levelStr
end

_class("UISummerActivityTwoEntryLevelGroupData", Object)
UISummerActivityTwoEntryLevelGroupData = UISummerActivityTwoEntryLevelGroupData

function UISummerActivityTwoEntryLevelGroupData:Constructor(baseScore)
  self._entryLevelDatas = {}
  if not baseScore then
    return
  end
  for i = 1, #baseScore do
    self._entryLevelDatas[#self._entryLevelDatas + 1] = UISummerActivityTwoEntryLevelData:New(baseScore[i])
  end
end

function UISummerActivityTwoEntryLevelGroupData:GetEntryLevelDatas()
  return self._entryLevelDatas
end

function UISummerActivityTwoEntryLevelGroupData:GetEntryLevelDataByLevel(level)
  for i = 1, #self._entryLevelDatas do
    if self._entryLevelDatas[i]:GetLevel() == level then
      return self._entryLevelDatas[i]
    end
  end
  return nil
end

_class("UISummerActivityTwoLevelData", Object)
UISummerActivityTwoLevelData = UISummerActivityTwoLevelData

function UISummerActivityTwoLevelData:Constructor(cfg, missionComponentInfo)
  self._timeModule = GameGlobal.GetModule(SvrTimeModule)
  self._monsterIcon = cfg.MonsterIcon
  self._monsterName = ""
  if cfg.MonsterName then
    self._monsterName = StringTable.Get(cfg.MonsterName)
  end
  self._missionId = cfg.CampaignMissionId
  self._levelType = cfg.LevelType
  self._levelGroup = cfg.LevelGroup
  self._sortIndex = cfg.SortIndex
  self._index = cfg.Index
  self._isShow = cfg.IsShow
  self._needMissionList = cfg.NeedMissionList
  self._recommendAwaken = cfg.RecommendAwaken
  self._recommendLV = cfg.RecommendLV
  self._levelIconUnOpen = cfg.LevelIconUnOpen
  self._levelIconComplete = cfg.LevelIconComplete
  self._levelIconUnComplete = cfg.LevelIconUnComplete
  self._affixTitle = ""
  if cfg.AffixTitle then
    self._affixTitle = StringTable.Get(cfg.AffixTitle)
  end
  self._affixTitleIcon = cfg.AffixTitleIcon
  self._affixAndScore = UISummerActivityTwoEntryGroupsData:New(cfg.AffixAndRatioScore)
  local cfgs = Cfg.cfg_campaign_mission({
    CampaignMissionId = self._missionId
  })
  if cfgs == nil or #cfgs <= 0 then
    return
  end
  local misionCfg = cfgs[1]
  self._fightId = misionCfg.FightLevel
  self._firstDropId = misionCfg.FirstDropId
  self._name = StringTable.Get(misionCfg.Name)
  self._des = StringTable.Get(misionCfg.Desc)
  self._entryLevelDatas = UISummerActivityTwoEntryLevelGroupData:New(cfg.BaseScore)
  if self._levelType == UISummerActivity2LevelType.Normal then
    self._maxScore = 0
  else
    self._maxScore = 0
    local passHards = missionComponentInfo.m_pass_hard
    local passAfixs = missionComponentInfo.m_pass_afix
    local passAfix = passAfixs[self._missionId]
    local passHard = passHards[self._missionId]
    if passAfix and passHard then
      local entryLevelData = self._entryLevelDatas:GetEntryLevelDataByLevel(passHard)
      local entryDatas = {}
      for k = 1, #passAfix do
        local entryId = passAfix[k]
        local entryData = self._affixAndScore:GetEntryDataById(entryId)
        if entryData then
          entryDatas[#entryDatas + 1] = entryData
        end
      end
      local ratio, totalScore = UISummerActivityTwoLevelDatas.CalcScore(entryLevelData, entryDatas)
      self._maxScore = totalScore
    end
  end
  local unlockTimes = missionComponentInfo.m_mission_unlock_time
  local unlockTime = unlockTimes[self._missionId]
  self._times = 0
  if unlockTime then
    self._times = unlockTime
  end
  local passMissionInfo = missionComponentInfo.m_pass_mission_info
  if passMissionInfo and passMissionInfo[self._missionId] then
    self._status = UISummerActivityTwoLevelStatus.Complete
  else
    self._status = UISummerActivityTwoLevelStatus.UnOpen
  end
  self:CalStatus()
end

function UISummerActivityTwoLevelData:CalStatus()
  if self._status ~= UISummerActivityTwoLevelStatus.UnOpen then
    return
  end
  if self._times then
    local nowTime = self._timeModule:GetServerTime() / 1000
    if nowTime >= self._times then
      self._status = UISummerActivityTwoLevelStatus.UnComplete
    end
  end
  if self._needMissionList and #self._needMissionList > 0 then
    self._status = UISummerActivityTwoLevelStatus.UnOpen
  end
end

function UISummerActivityTwoLevelData:Refresh(levelDatas)
  if self._status == UISummerActivityTwoLevelStatus.UnOpen and self._needMissionList and #self._needMissionList > 0 then
    self._status = UISummerActivityTwoLevelStatus.UnComplete
    for i = 1, #self._needMissionList do
      local levelData = levelDatas:GetLevelDataById(self._needMissionList[i])
      if levelData and levelData:GetStatus() ~= UISummerActivityTwoLevelStatus.Complete then
        self._status = UISummerActivityTwoLevelStatus.UnOpen
      end
    end
  end
end

function UISummerActivityTwoLevelData:GetLevelIconUnOpen()
  return self._levelIconUnOpen
end

function UISummerActivityTwoLevelData:GetLevelIconComplete()
  return self._levelIconComplete
end

function UISummerActivityTwoLevelData:GetLevelIconUnComplete()
  return self._levelIconUnComplete
end

function UISummerActivityTwoLevelData:GetRecommendAwaken()
  return self._recommendAwaken
end

function UISummerActivityTwoLevelData:GetRecommendLV()
  return self._recommendLV
end

function UISummerActivityTwoLevelData:GetAffixTitle()
  return self._affixTitle
end

function UISummerActivityTwoLevelData:GetAffixTitleIcon()
  return self._affixTitleIcon
end

function UISummerActivityTwoLevelData:GetEntryLevelDatas()
  return self._entryLevelDatas
end

function UISummerActivityTwoLevelData:IsPreLevelCondition()
  if self._needMissionList and #self._needMissionList > 0 then
    return true
  end
  return false
end

function UISummerActivityTwoLevelData:GetFirstDropId()
  return self._firstDropId
end

function UISummerActivityTwoLevelData:IsShow()
  return self._isShow
end

function UISummerActivityTwoLevelData:GetMonsterIcon()
  return self._monsterIcon
end

function UISummerActivityTwoLevelData:GetMonsterName()
  return self._monsterName
end

function UISummerActivityTwoLevelData:GetIndex()
  return self._index
end

function UISummerActivityTwoLevelData:GetMissionId()
  return self._missionId
end

function UISummerActivityTwoLevelData:GetLevelType()
  return self._levelType
end

function UISummerActivityTwoLevelData:GetLevelGroup()
  return self._levelGroup
end

function UISummerActivityTwoLevelData:GetSortIndex()
  return self._sortIndex
end

function UISummerActivityTwoLevelData:GetNeedMissionList()
  return self._needMissionList
end

function UISummerActivityTwoLevelData:GetAffixAndScore()
  return self._affixAndScore
end

function UISummerActivityTwoLevelData:GetFightId()
  return self._fightId
end

function UISummerActivityTwoLevelData:GetName()
  return self._name
end

function UISummerActivityTwoLevelData:GetDes()
  return self._des
end

function UISummerActivityTwoLevelData:GetStatus()
  return self._status
end

function UISummerActivityTwoLevelData:GetMaxScore()
  if self._status == UISummerActivityTwoLevelStatus.Complete then
    return self._maxScore
  end
  return 0
end

function UISummerActivityTwoLevelData:GetTimes()
  return self._times
end

_class("UISummerActivityTwoLevelDatas", Object)
UISummerActivityTwoLevelDatas = UISummerActivityTwoLevelDatas

function UISummerActivityTwoLevelDatas:Constructor(missionComponentInfo)
  self._levelDatas = {}
  self._unShowLevelDatas = {}
  self._bossLevel = nil
  local cfgs = Cfg.cfg_component_summer_ii_mission({})
  for i = 1, #cfgs do
    local cfg = cfgs[i]
    if cfg.IsShow == 1 then
      local levelType = cfg.LevelType
      if levelType == UISummerActivity2LevelType.Boss then
        self._bossLevel = UISummerActivityTwoLevelData:New(cfg, missionComponentInfo)
      else
        local levelGroup = cfg.LevelGroup
        local levelData = UISummerActivityTwoLevelData:New(cfg, missionComponentInfo)
        local levelDatas = self._levelDatas[levelGroup]
        if levelDatas == nil then
          levelDatas = {}
          self._levelDatas[levelGroup] = levelDatas
        end
        levelDatas[#levelDatas + 1] = levelData
      end
    else
      self._unShowLevelDatas[#self._unShowLevelDatas + 1] = UISummerActivityTwoLevelData:New(cfg, missionComponentInfo)
    end
  end
  for k, v in pairs(self._levelDatas) do
    table.sort(v, function(a, b)
      return a:GetSortIndex() < b:GetSortIndex()
    end)
    for i = 1, #v do
      v[i]:Refresh(self)
    end
  end
  if self._bossLevel then
    self._bossLevel:Refresh(self)
  end
  for i = 1, #self._unShowLevelDatas do
    self._unShowLevelDatas[i]:Refresh(self)
  end
end

function UISummerActivityTwoLevelDatas:GetLevelDatas()
  return self._levelDatas
end

function UISummerActivityTwoLevelDatas:GetBossLevelData()
  return self._bossLevel
end

function UISummerActivityTwoLevelDatas:GetLevelDataById(missionId)
  for k, v in pairs(self._levelDatas) do
    for i = 1, #v do
      if v[i]:GetMissionId() == missionId then
        return v[i]
      end
    end
  end
  if self._bossLevel and self._bossLevel:GetMissionId() == missionId then
    return self._bossLevel
  end
  for i = 1, #self._unShowLevelDatas do
    if self._unShowLevelDatas[i]:GetMissionId() == missionId then
      return self._unShowLevelDatas[i]
    end
  end
  return nil
end

function UISummerActivityTwoLevelDatas:GetLevelRedStatus()
  for i = 1, #self._levelDatas do
    local levelGroup = self._levelDatas[i]
    for j = 1, #levelGroup do
      local levelData = levelGroup[j]
      if levelData:GetStatus() == UISummerActivityTwoLevelStatus.UnComplete then
        return true
      end
    end
  end
  if self._bossLevel and self._bossLevel:GetStatus() == UISummerActivityTwoLevelStatus.UnComplete then
    return true
  end
  return false
end

function UISummerActivityTwoLevelDatas:GetEntryLevelData()
  local datas = {}
  for i = 1, #self._levelDatas do
    local levelGroup = self._levelDatas[i]
    for j = 1, #levelGroup do
      if levelGroup[j]:GetLevelType() ~= UISummerActivity2LevelType.Normal then
        datas[#datas + 1] = levelGroup[j]
      end
    end
  end
  if self._bossLevel then
    datas[#datas + 1] = self._bossLevel
  end
  return datas
end

function UISummerActivityTwoLevelDatas:IsLevelComplete(missionId)
  if not missionId then
    return false
  end
  local levelData = self:GetLevelDataById(missionId)
  if not levelData then
    return false
  end
  return levelData:GetStatus() == UISummerActivityTwoLevelStatus.Complete
end

function UISummerActivityTwoLevelDatas.CalcScore(entryLevelData, entryDatas)
  local baseScore = entryLevelData:GetLevelScore()
  local ratio = 0
  for i = 1, #entryDatas do
    local entryData = entryDatas[i]
    ratio = ratio + entryData:GetScroeRatio()
  end
  local a, b = math.modf(baseScore * (1 + ratio / 1000))
  local totalScore = a
  if 0.5 <= b then
    totalScore = totalScore + 1
  end
  return ratio, totalScore
end

function UISummerActivityTwoLevelDatas.CalcScoreByCfg(hardId, affixList, cfg)
  local baseScore = 0
  local baseScoreCfg = cfg.BaseScore
  if baseScoreCfg and hardId then
    for i = 1, #baseScoreCfg do
      if baseScoreCfg[i][1] == hardId then
        baseScore = baseScoreCfg[i][2]
        break
      end
    end
  end
  local ratio = 0
  if affixList then
    local affixAndScore = cfg.AffixAndRatioScore
    for i = 1, #affixList do
      for k = 1, #affixAndScore do
        if affixAndScore[k][1] == affixList[i] then
          ratio = ratio + affixAndScore[k][2]
          break
        end
      end
    end
  end
  local a, b = math.modf(baseScore * (1 + ratio / 1000))
  local totalScore = a
  if 0.5 <= b then
    totalScore = totalScore + 1
  end
  return totalScore
end
