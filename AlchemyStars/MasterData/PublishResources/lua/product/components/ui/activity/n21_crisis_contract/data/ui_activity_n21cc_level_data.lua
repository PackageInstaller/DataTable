local UIActivityN21CCLevelStatus = {
  None = 0,
  Lock = 1,
  Open = 2
}
_enum("UIActivityN21CCLevelStatus", UIActivityN21CCLevelStatus)
_class("UIActivityN21CCLevelData", Object)
UIActivityN21CCLevelData = UIActivityN21CCLevelData

function UIActivityN21CCLevelData:Constructor(cfg, missionComponentInfo)
  self._missionComponentInfo = missionComponentInfo
  self._timeModule = GameGlobal.GetModule(SvrTimeModule)
  self._monsterIcon = cfg.MonsterIcon
  self._monsterIcon1 = cfg.MonsterIcon1
  if not self._monsterIcon1 then
    self._monsterIcon1 = ""
  end
  self._monsterName = StringTable.Get(cfg.MonsterName)
  self._recommendAwaken = cfg.RecommendAwaken
  self._recommendLV = cfg.RecommendLV
  self._missionId = cfg.CampaignMissionId
  self._levelIndex = cfg.LeveIndex
  self._hardId = cfg.HardID
  self._elementIcon1 = cfg.ElementIcon1
  self._elementIcon2 = cfg.ElementIcon2
  local cfgs = Cfg.cfg_campaign_mission({
    CampaignMissionId = self._missionId
  })
  if cfgs and 0 < #cfgs then
    local misionCfg = cfgs[1]
    self._fightId = misionCfg.FightLevel
    self._name = StringTable.Get(misionCfg.Name)
    self._des = StringTable.Get(misionCfg.Desc)
  end
  self._affixGroups = {}
  local affixs = cfg.Affix
  for i = 1, #affixs do
    local selectIds
    if self._missionComponentInfo.m_select_affix and self._missionComponentInfo.m_select_affix[self._missionId] then
      selectIds = self._missionComponentInfo.m_select_affix[self._missionId]
    end
    self._affixGroups[#self._affixGroups + 1] = UIActivityN21CCAffixGroupsData:New(affixs[i], selectIds)
  end
  self._unlockScore = cfg.UnlockScore
  self._baseScore = cfg.BaseScore
  self._status = UIActivityN21CCLevelStatus.None
  self:Refresh()
end

function UIActivityN21CCLevelData:Refresh()
  self._maxScore = 0
  if self._missionComponentInfo.m_max_score and self._missionComponentInfo.m_max_score[self._levelIndex] then
    self._maxScore = self._missionComponentInfo.m_max_score[self._levelIndex]
  end
  local unlockTime = 0
  if self._missionComponentInfo.m_challenge_unlock_time and self._missionComponentInfo.m_challenge_unlock_time[self._missionId] then
    unlockTime = self._missionComponentInfo.m_challenge_unlock_time[self._missionId]
  end
  local nowTime = self._timeModule:GetServerTime() / 1000
  if unlockTime <= nowTime and self._maxScore >= self._unlockScore then
    self._status = UIActivityN21CCLevelStatus.Open
  else
    self._status = UIActivityN21CCLevelStatus.Lock
  end
end

function UIActivityN21CCLevelData:GetMonsterIcon()
  return self._monsterIcon1
end

function UIActivityN21CCLevelData:GetMonsterBigIcon()
  return self._monsterIcon
end

function UIActivityN21CCLevelData:GetMonsterName()
  return self._monsterName
end

function UIActivityN21CCLevelData:GetRecommendAwaken()
  return self._recommendAwaken
end

function UIActivityN21CCLevelData:GetRecommendLV()
  return self._recommendLV
end

function UIActivityN21CCLevelData:GetMissionId()
  return self._missionId
end

function UIActivityN21CCLevelData:GetIndex()
  return self._levelIndex
end

function UIActivityN21CCLevelData:GetHardId()
  return self._hardId
end

function UIActivityN21CCLevelData:GetFightId()
  return self._fightId
end

function UIActivityN21CCLevelData:GetName()
  return self._name
end

function UIActivityN21CCLevelData:GetDes()
  return self._des
end

function UIActivityN21CCLevelData:GetAffixGroups()
  return self._affixGroups
end

function UIActivityN21CCLevelData:GetCommonAffixGroups()
  local groups = {}
  for i = 1, #self._affixGroups do
    local group = self._affixGroups[i]
    if group:GetUnLockScore() <= 0 then
      groups[#groups + 1] = group
    end
  end
  return groups
end

function UIActivityN21CCLevelData:GetScoreUnLockAffixGroups()
  local groups = {}
  local tmp = {}
  for i = 1, #self._affixGroups do
    local group = self._affixGroups[i]
    local unlockScore = group:GetUnLockScore()
    if 0 < unlockScore then
      local t = tmp[unlockScore]
      if t == nil then
        t = {}
        tmp[unlockScore] = t
      end
      t[#t + 1] = group
    end
  end
  for k, v in pairs(tmp) do
    groups[#groups + 1] = v
  end
  table.sort(groups, function(a, b)
    return a[1]:GetUnLockScore() < b[1]:GetUnLockScore()
  end)
  return groups
end

function UIActivityN21CCLevelData:GetUnLockScore()
  return self._unlockScore
end

function UIActivityN21CCLevelData:GetBaseScore()
  return self._baseScore
end

function UIActivityN21CCLevelData:GetStatus()
  return self._status
end

function UIActivityN21CCLevelData:IsLevelOpen()
  return self._status == UIActivityN21CCLevelStatus.Open
end

function UIActivityN21CCLevelData:GetMaxScore()
  return self._maxScore
end

function UIActivityN21CCLevelData:GetUnlockTime()
  local unlockTime = 0
  if self._missionComponentInfo.m_challenge_unlock_time and self._missionComponentInfo.m_challenge_unlock_time[self._missionId] then
    unlockTime = self._missionComponentInfo.m_challenge_unlock_time[self._missionId]
  end
  return unlockTime
end

function UIActivityN21CCLevelData:GetElementIcon1()
  return self._elementIcon1
end

function UIActivityN21CCLevelData:GetElementIcon2()
  return self._elementIcon2
end
