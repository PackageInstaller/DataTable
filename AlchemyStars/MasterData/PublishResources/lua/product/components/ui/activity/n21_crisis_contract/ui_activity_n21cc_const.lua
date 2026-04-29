_class("UIActivityN21CCConst", Object)
UIActivityN21CCConst = UIActivityN21CCConst

function UIActivityN21CCConst:Constructor()
end

function UIActivityN21CCConst:LoadData(TT, res)
  self._timeModule = GameGlobal.GetModule(SvrTimeModule)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N21_CHALLENGE, ECampaignN21ChallengeComponentID.CHALLENGE, ECampaignN21ChallengeComponentID.PROGRESS)
  if res and not res:GetSucc() then
    return
  end
  if not self._campaign then
    return
  end
  self._localProcess = self._campaign:GetLocalProcess()
  if not self._localProcess then
    return
  end
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  self._challengeComponent = self._localProcess:GetComponent(ECampaignN21ChallengeComponentID.CHALLENGE)
  self._challengeCompInfo = self._localProcess:GetComponentInfo(ECampaignN21ChallengeComponentID.CHALLENGE)
  self._processComponents = {}
  self._processCompInfos = {}
  local progressComponent = self._localProcess:GetComponent(ECampaignN21ChallengeComponentID.PROGRESS)
  local progressCompInfo = self._localProcess:GetComponentInfo(ECampaignN21ChallengeComponentID.PROGRESS)
  if progressComponent and progressCompInfo then
    self._processComponents[#self._processComponents + 1] = progressComponent
    self._processCompInfos[#self._processCompInfos + 1] = progressCompInfo
  end
  progressComponent = self._localProcess:GetComponent(ECampaignN21ChallengeComponentID.PROGRESS2)
  progressCompInfo = self._localProcess:GetComponentInfo(ECampaignN21ChallengeComponentID.PROGRESS2)
  if progressComponent and progressCompInfo then
    self._processComponents[#self._processComponents + 1] = progressComponent
    self._processCompInfos[#self._processCompInfos + 1] = progressCompInfo
  end
  progressComponent = self._localProcess:GetComponent(ECampaignN21ChallengeComponentID.PROGRESS3)
  progressCompInfo = self._localProcess:GetComponentInfo(ECampaignN21ChallengeComponentID.PROGRESS3)
  if progressComponent and progressCompInfo then
    self._processComponents[#self._processComponents + 1] = progressComponent
    self._processCompInfos[#self._processCompInfos + 1] = progressCompInfo
  end
  progressComponent = self._localProcess:GetComponent(ECampaignN21ChallengeComponentID.PROGRESS4)
  progressCompInfo = self._localProcess:GetComponentInfo(ECampaignN21ChallengeComponentID.PROGRESS4)
  if progressComponent and progressCompInfo then
    self._processComponents[#self._processComponents + 1] = progressComponent
    self._processCompInfos[#self._processCompInfos + 1] = progressCompInfo
  end
  progressComponent = self._localProcess:GetComponent(ECampaignN21ChallengeComponentID.PROGRESS5)
  progressCompInfo = self._localProcess:GetComponentInfo(ECampaignN21ChallengeComponentID.PROGRESS5)
  if progressComponent and progressCompInfo then
    self._processComponents[#self._processComponents + 1] = progressComponent
    self._processCompInfos[#self._processCompInfos + 1] = progressCompInfo
  end
  self._rewardDatas = {}
  for i = 1, #self._processCompInfos do
    local data = UIActivityN21CCShopBossData:New(self._processComponents[i], self._processCompInfos[i])
    self._rewardDatas[#self._rewardDatas + 1] = data
  end
  self._levelGroupsData = UIActivityN21CCLevelGroupsData:New(self._challengeComponent:GetComponentCfgId(), self._challengeCompInfo)
  local cfg_campaign = Cfg.cfg_campaign[self._campaign._id]
  self._name = StringTable.Get(cfg_campaign.CampaignName)
  self._subName = StringTable.Get(cfg_campaign.CampaignSubtitle)
  local sample = self._campaign:GetSample()
  if not sample then
    return
  end
  self._activeEndTime = sample.end_time
  local nowTime = self._timeModule:GetServerTime() / 1000
  if nowTime > self._activeEndTime then
    Log.error("Time error!")
    return
  end
end

function UIActivityN21CCConst:ForceUpdate(TT)
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
end

function UIActivityN21CCConst:GetCampaign()
  return self._campaign
end

function UIActivityN21CCConst:GetCampaignId()
  return self._campaign._id
end

function UIActivityN21CCConst:GetName()
  return self._name
end

function UIActivityN21CCConst:GetSubName()
  return self._subName
end

function UIActivityN21CCConst:GetActiveEndTime()
  return self._activeEndTime
end

function UIActivityN21CCConst:GetChallengeComponent()
  return self._challengeComponent, self._challengeCompInfo
end

function UIActivityN21CCConst:GetAllProcessComponents()
  return self._processComponents, self._processCompInfos
end

function UIActivityN21CCConst:IsActivityEnd()
  local nowTime = self._timeModule:GetServerTime() / 1000
  local seconds = math.floor(self._activeEndTime - nowTime)
  if seconds <= 0 then
    return true
  end
  return false
end

function UIActivityN21CCConst:IsChallengeEnable()
  if self:IsActivityEnd() then
    return false
  end
  if not self._challengeComponent then
    return false
  end
  return self._challengeComponent:ComponentIsOpen()
end

function UIActivityN21CCConst:IsProgressEnable()
  if self:IsActivityEnd() then
    return false
  end
  for i = 1, #self._processComponents do
    if self._processComponents[i]:ComponentIsOpen() then
      return true
    end
  end
  return false
end

function UIActivityN21CCConst:GetShopDatas()
  return self._rewardDatas
end

function UIActivityN21CCConst:IsShowEntryNew()
  if UIActivityN21CCConst.GetEnterNewStatus() then
    return true
  end
  if self._levelGroupsData == nil then
    Log.error("New异常情况")
    return false
  end
  local levelGroups = self._levelGroupsData:GetOpenLevelGroups()
  for i = 1, #levelGroups do
    local levelGroup = levelGroups[i]
    if levelGroup:IsShowNew() then
      return true
    end
  end
  return false
end

function UIActivityN21CCConst:IsShowEntryRed()
  if self._levelGroupsData == nil then
    Log.error("红点异常情况")
    return false
  end
  local levelGroups = self._levelGroupsData:GetOpenLevelGroups()
  for i = 1, #levelGroups do
    local levelGroup = levelGroups[i]
    if levelGroup:IsShowRed() then
      return true
    end
  end
  if self:IsShowEventnRed() then
    return true
  end
  return false
end

function UIActivityN21CCConst:IsShowEventnRed()
  if not self:IsProgressEnable() then
    return false
  end
  for i = 1, #self._rewardDatas do
    if self._rewardDatas[i]:HasCanGetReward() then
      return true
    end
  end
  return false
end

function UIActivityN21CCConst.GetNewFlagKey(id)
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  local key = pstId .. "ACTIVITY_N21CC_MODULE_NEW_FLAG" .. id
  return key
end

function UIActivityN21CCConst.GetNewFlagStatus(id)
  local key = UIActivityN21CCConst.GetNewFlagKey(id)
  if not UnityEngine.PlayerPrefs.HasKey(key) then
    return true
  end
  local value = UnityEngine.PlayerPrefs.GetInt(key)
  return value == 0
end

function UIActivityN21CCConst.SetNewFlagStatus(id, status)
  local key = UIActivityN21CCConst.GetNewFlagKey(id)
  if status then
    UnityEngine.PlayerPrefs.SetInt(key, 0)
  else
    UnityEngine.PlayerPrefs.SetInt(key, 1)
  end
end

function UIActivityN21CCConst.GetEnterNewStatus()
  return UIActivityN21CCConst.GetNewFlagStatus("ENTRY_NEW")
end

function UIActivityN21CCConst.ClearEnterNewStatus()
  UIActivityN21CCConst.SetNewFlagStatus("ENTRY_NEW", false)
end

function UIActivityN21CCConst.GetTimeString(seconds)
  local timeStr = ""
  local day = math.floor(seconds / 3600 / 24)
  if 0 < day then
    seconds = seconds - day * 3600 * 24
    local hour = math.floor(seconds / 3600)
    timeStr = StringTable.Get("str_n20_crisis_contract_day", day)
    if 0 < hour then
      timeStr = timeStr .. StringTable.Get("str_n20_crisis_contract_hour", hour)
    end
  elseif 60 <= seconds then
    local hour = math.floor(seconds / 3600)
    seconds = seconds - hour * 3600
    if 0 < hour then
      timeStr = StringTable.Get("str_n20_crisis_contract_hour", hour)
    end
    local minus = math.floor(seconds / 60)
    if minus then
      timeStr = timeStr .. StringTable.Get("str_n20_crisis_contract_minus", minus)
    end
  else
    timeStr = StringTable.Get("str_n20_crisis_contract_less_one_minus")
  end
  return timeStr
end

function UIActivityN21CCConst.GetLevelRedStatus()
  if UIActivityN21CCConst.LEVEL_RED_STATUS == nil then
    UIActivityN21CCConst.LEVEL_RED_STATUS = {}
  end
  return UIActivityN21CCConst.LEVEL_RED_STATUS
end

function UIActivityN21CCConst.SaveTeamInfo(TT, id, name, pets)
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local campaign = UIActivityCampaign:New()
  campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N21_CHALLENGE, ECampaignN21ChallengeComponentID.CHALLENGE)
  if res and not res:GetSucc() then
    campaignModule:CheckErrorCode(res.m_result, campaign._id, nil, nil)
    return false
  end
  local localProcess = campaign:GetLocalProcess()
  if not localProcess then
    return false
  end
  local challengeComponent = localProcess:GetComponent(ECampaignN21ChallengeComponentID.CHALLENGE)
  local teamInfo = ChallengeFormationItem:New()
  teamInfo.id = id
  teamInfo.name = name
  teamInfo.pet_list = pets
  challengeComponent:HandleChallengeChangeFormationReq(TT, res, teamInfo)
  if res:GetSucc() then
    return true
  end
  return false
end

function UIActivityN21CCConst.SaveHistoryScore(missionId)
  if UIActivityN21CCConst.HISTORY_SCORE_CACHE == nil then
    UIActivityN21CCConst.HISTORY_SCORE_CACHE = {}
  end
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local progress = campaignModule:GetCampaignLocalProcess(ECampaignType.CAMPAIGN_TYPE_N21_CHALLENGE)
  local historyScore = 0
  local challengeComponent = progress:GetComponent(ECampaignN21ChallengeComponentID.CHALLENGE)
  local challengeCompInfo = progress:GetComponentInfo(ECampaignN21ChallengeComponentID.CHALLENGE)
  local cfgs = Cfg.cfg_component_challenge_mission({
    ComponentID = challengeComponent:GetComponentCfgId(),
    CampaignMissionId = missionId
  })
  if cfgs == nil or #cfgs <= 0 then
    return
  end
  local cfg = cfgs[1]
  if challengeCompInfo.m_max_score and challengeCompInfo.m_max_score[cfg.LeveIndex] then
    historyScore = challengeCompInfo.m_max_score[cfg.LeveIndex]
  end
  UIActivityN21CCConst.HISTORY_SCORE_CACHE[cfg.LeveIndex] = historyScore
end

function UIActivityN21CCConst.GetHistoryScore(missionId)
  if UIActivityN21CCConst.HISTORY_SCORE_CACHE == nil then
    return 0
  end
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local progress = campaignModule:GetCampaignLocalProcess(ECampaignType.CAMPAIGN_TYPE_N21_CHALLENGE)
  local challengeComponent = progress:GetComponent(ECampaignN21ChallengeComponentID.CHALLENGE)
  local cfgs = Cfg.cfg_component_challenge_mission({
    ComponentID = challengeComponent:GetComponentCfgId(),
    CampaignMissionId = missionId
  })
  if cfgs == nil or #cfgs <= 0 then
    return
  end
  local cfg = cfgs[1]
  if UIActivityN21CCConst.HISTORY_SCORE_CACHE[cfg.LeveIndex] == nil then
    return 0
  end
  return UIActivityN21CCConst.HISTORY_SCORE_CACHE[cfg.LeveIndex]
end

function UIActivityN21CCConst.GetAffixCategoryIcon(type)
  local icons = {
    [UIActivityN21CCAffixGroupType.SelfGain] = "n21_wjyz_ct_icon02",
    [UIActivityN21CCAffixGroupType.EnemyGain] = "n21_wjyz_ct_icon01"
  }
  return icons[type]
end

function UIActivityN21CCConst.ShowRewards(rewards, callback)
  local petIdList = {}
  local mPet = GameGlobal.GetModule(PetModule)
  for _, reward in pairs(rewards) do
    if mPet:IsPetID(reward.assetid) then
      table.insert(petIdList, reward)
    end
  end
  if table.count(petIdList) > 0 then
    GameGlobal.UIStateManager():ShowDialog("UIPetObtain", petIdList, function()
      GameGlobal.UIStateManager():CloseDialog("UIPetObtain")
      GameGlobal.UIStateManager():ShowDialog("UIGetItemController", rewards, function()
        if callback then
          callback()
        end
      end)
    end)
    return
  end
  GameGlobal.UIStateManager():ShowDialog("UIGetItemController", rewards, function()
    if callback then
      callback()
    end
  end)
end

function UIActivityN21CCConst.GetEnterBattleHardIndex()
  return UIActivityN21CCConst.ENTER_BATTLE_HARD_INDEX
end

function UIActivityN21CCConst.SetEnterBattleHardIndex(hardIndex)
  UIActivityN21CCConst.ENTER_BATTLE_HARD_INDEX = hardIndex
end

function UIActivityN21CCConst.GetEnterBattleLevelId()
  return UIActivityN21CCConst.ENTER_BATTLE_LEVEL_ID
end

function UIActivityN21CCConst.SetEnterBattleLeveId(hardIndex)
  UIActivityN21CCConst.ENTER_BATTLE_LEVEL_ID = hardIndex
end

function UIActivityN21CCConst.GetHistoryLevelHard(levelIndex)
  local key = UIActivityN21CCConst.GetHistoryLevelHardKey(levelIndex)
  if not UnityEngine.PlayerPrefs.HasKey(key) then
    return -1
  end
  return UnityEngine.PlayerPrefs.GetInt(key)
end

function UIActivityN21CCConst.SetHistoryLevelHard(levelIndex, hard)
  local key = UIActivityN21CCConst.GetHistoryLevelHardKey(levelIndex)
  UnityEngine.PlayerPrefs.SetInt(key, hard)
end

function UIActivityN21CCConst.GetHistoryLevelHardKey(levelIndex)
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  local key = pstId .. "ACTIVITY_N21CC_MODULE_LEVEL_HARD" .. levelIndex
  return key
end
