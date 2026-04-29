_class("UIActivityN27Helper", Object)
UIActivityN27Helper = UIActivityN27Helper

function UIActivityN27Helper:LoadData(TT, res)
  self._timeModule = GameGlobal.GetModule(SvrTimeModule)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  self._campaign = UIActivityCampaign.New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N27, ECampaignN27ComponentID.ECAMPAIGN_N27_CUMULATIVE_LOGIN, ECampaignN27ComponentID.ECAMPAIGN_N27_FIRST_MEET, ECampaignN27ComponentID.ECAMPAIGN_N27_POWER2ITEM, ECampaignN27ComponentID.ECAMPAIGN_N27_LINE_MISSION, ECampaignN27ComponentID.ECAMPAIGN_N27_DIFFICULT_MISSION, ECampaignN27ComponentID.ECAMPAIGN_N27_SHOP, ECampaignN27ComponentID.ECAMPAIGN_N27_BLOODSUCKER, ECampaignN27ComponentID.ECAMPAIGN_N27_IDOL)
  if res and not res:GetSucc() then
    return res
  end
  self._localProcess = self._campaign:GetLocalProcess()
  if not self._localProcess then
    return
  end
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  local bpRes = AsyncRequestRes:New()
  bpRes:SetSucc(true)
  self._battlepassCampaign = UIActivityCampaign:New()
  self._battlepassCampaign:LoadCampaignInfo(TT, bpRes, ECampaignType.CAMPAIGN_TYPE_BATTLEPASS)
  if not bpRes:GetSucc() then
    Log.info("获取战斗通行证数据失败")
  end
  self._cumulativeLoginComponent = self._localProcess:GetComponent(ECampaignN27ComponentID.ECAMPAIGN_N27_CUMULATIVE_LOGIN)
  self._cumulativeLoginComponentInfo = self._localProcess:GetComponentInfo(ECampaignN27ComponentID.ECAMPAIGN_N27_CUMULATIVE_LOGIN)
  self._fixTeamComponent = self._localProcess:GetComponent(ECampaignN27ComponentID.ECAMPAIGN_N27_FIRST_MEET)
  self._fixTeamCompInfo = self._localProcess:GetComponentInfo(ECampaignN27ComponentID.ECAMPAIGN_N27_FIRST_MEET)
  self._lineComp = self._localProcess:GetComponent(ECampaignN27ComponentID.ECAMPAIGN_N27_LINE_MISSION)
  self._lineCompInfo = self._localProcess:GetComponentInfo(ECampaignN27ComponentID.ECAMPAIGN_N27_LINE_MISSION)
  self._hardComp = self._localProcess:GetComponent(ECampaignN27ComponentID.ECAMPAIGN_N27_DIFFICULT_MISSION)
  self._hardCompInfo = self._localProcess:GetComponentInfo(ECampaignN27ComponentID.ECAMPAIGN_N27_DIFFICULT_MISSION)
  self._power2itemComponent = self._localProcess:GetComponent(ECampaignN27ComponentID.ECAMPAIGN_N27_POWER2ITEM)
  self._power2itemComponentInfo = self._localProcess:GetComponentInfo(ECampaignN27ComponentID.ECAMPAIGN_N27_POWER2ITEM)
  self._exchangeComponent = self._localProcess:GetComponent(ECampaignN27ComponentID.ECAMPAIGN_N27_SHOP)
  self._exchangeComponentInfo = self._localProcess:GetComponentInfo(ECampaignN27ComponentID.ECAMPAIGN_N27_SHOP)
  self._idolMiniGameComponent = self._localProcess:GetComponent(ECampaignN27ComponentID.ECAMPAIGN_N27_IDOL)
  self._idolMiniGameCompInfo = self._localProcess:GetComponentInfo(ECampaignN27ComponentID.ECAMPAIGN_N27_IDOL)
  self._bloodsuckerComponet = self._localProcess:GetComponent(ECampaignN27ComponentID.ECAMPAIGN_N27_BLOODSUCKER)
  self._bloodsuckerComponentInfo = self._localProcess:GetComponentInfo(ECampaignN27ComponentID.ECAMPAIGN_N27_BLOODSUCKER)
  local cfg_campaign = Cfg.cfg_campaign[self._campaign._id]
  self._name = StringTable.Get(cfg_campaign.CampaignName)
  self._subName = StringTable.Get(cfg_campaign.CampaignSubtitle)
  local sample = self._campaign:GetSample()
  if not sample then
    return
  end
  local nowTime = self._timeModule:GetServerTime() / 1000
  self._activeEndTime = sample.end_time
  local power2itemEndTime = self._power2itemComponentInfo.m_close_time
  if nowTime >= power2itemEndTime then
    self._status = 2
  else
    self._status = 1
    self._endTime = power2itemEndTime
  end
  if nowTime > self._activeEndTime then
    Log.error("Time error!")
    return
  end
end

function UIActivityN27Helper:ForceRefresh(TT)
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
end

function UIActivityN27Helper:GetCampaign()
  return self._campaign
end

function UIActivityN27Helper:GetCampaignId()
  return self._campaign._id
end

function UIActivityN27Helper:GetName()
  return self._name
end

function UIActivityN27Helper:GetSubName()
  return self._subName
end

function UIActivityN27Helper:GetActiveEndTime()
  return self._activeEndTime
end

function UIActivityN27Helper:GetStatus()
  return self._status
end

function UIActivityN27Helper:SetStatus(status)
  self._status = status
end

function UIActivityN27Helper:IsActivityEnd()
  local nowTime = self._timeModule:GetServerTime() / 1000
  local seconds = math.floor(self._activeEndTime - nowTime)
  if seconds <= 0 then
    return true
  end
  return false
end

function UIActivityN27Helper:GetTryPetComponent()
  return self._fixTeamComponent, self._fixTeamCompInfo
end

function UIActivityN27Helper:GetShopComponent()
  return self._exchangeComponent, self._exchangeComponentInfo
end

function UIActivityN27Helper:GetLineComponent()
  return self._lineComp, self._lineCompInfo
end

function UIActivityN27Helper:GetHardComponent()
  return self._hardComp, self._hardCompInfo
end

function UIActivityN27Helper:GetIdolComponent()
  return self._idolMiniGameComponent, self._idolMiniGameCompInfo
end

function UIActivityN27Helper:GetBloodSuckerComponent()
  return self._bloodsuckerComponet, self._bloodsuckerComponentInfo
end

function UIActivityN27Helper:IsTryPetEnable()
  if self:IsActivityEnd() then
    return false
  end
  if not self._fixTeamComponent then
    return false
  end
  return self._fixTeamComponent:ComponentIsOpen()
end

function UIActivityN27Helper:IsPower2ItemEnable()
  if self:IsActivityEnd() then
    return false
  end
  if not self._power2itemComponent then
    return false
  end
  return self._power2itemComponent:ComponentIsOpen()
end

function UIActivityN27Helper:IsShowEntryNew()
  if self:IsActivityEnd() then
    return false
  end
  local isNew = UIActivityN27Helper.GetEnterNewStatus() or self:CheckNewHard() or self:CheckNewNormal() or self:CheckGameIdolNew() or self:CheckGameBloodSuckerNew()
  return isNew
end

function UIActivityN27Helper:CheckNewNormal()
  return false
end

function UIActivityN27Helper:CheckNewHard()
  if not N27Data.HasPrefs(N27Data.GetPrefsKeyHard()) and self._hardCompInfo and self:GetState(self._hardCompInfo) == UISummerOneEnterBtnState.Normal then
    return true
  end
  return false
end

function UIActivityN27Helper:CheckGameIdolNew()
  if not N27Data.HasPrefs(N27Data.GetPrefsKeyGameIdol()) and self._idolMiniGameCompInfo and self:GetState(self._idolMiniGameCompInfo) == UISummerOneEnterBtnState.Normal then
    return true
  end
  return false
end

function UIActivityN27Helper:CheckGameBloodSuckerNew()
  if not N27Data.HasPrefs(N27Data.GetPrefsKeyGameBloodSucker()) and self._bloodsuckerComponentInfo and self:GetState(self._bloodsuckerComponentInfo) == UISummerOneEnterBtnState.Normal then
    return true
  end
  return false
end

function UIActivityN27Helper:IsShowEntryRed()
  if self:IsActivityEnd() then
    return false
  end
  if self:CheckRedTryPet() then
    return true
  end
  if self:CheckRedShop() then
    return true
  end
  if self:CheckRedHard() then
    return true
  end
  if self:CheckRedAward() then
    return true
  end
  if self:CheckGameIdolRed() then
    return true
  end
  if self:CheckGameBloodSuckerRed() then
    return true
  end
  return false
end

function UIActivityN27Helper:CheckRedAward()
  local red = self._campaign:CheckComponentRed(self._localProcess, ECampaignN27ComponentID.ECAMPAIGN_N27_CUMULATIVE_LOGIN)
  return red
end

function UIActivityN27Helper:CheckRedTryPet()
  local state = self:GetStateTryPet()
  if state == UISummerOneEnterBtnState.Normal then
    local red = self._campaign:CheckComponentRed(self._localProcess, ECampaignN27ComponentID.ECAMPAIGN_N27_FIRST_MEET)
    return red
  end
  return false
end

function UIActivityN27Helper:CheckRedNormal()
  local state = self:GetStateNormal()
  if state == UISummerOneEnterBtnState.Normal then
    local red = self._campaign:CheckComponentRed(self._localProcess, ECampaignN27ComponentID.ECAMPAIGN_N27_LINE_MISSION)
    return red
  end
  return false
end

function UIActivityN27Helper:CheckRedHard()
  local state = self:GetStateHard()
  if state == UISummerOneEnterBtnState.Normal then
    local red = self._campaign:CheckComponentRed(self._localProcess, ECampaignN27ComponentID.ECAMPAIGN_N27_DIFFICULT_MISSION)
    return red
  end
  return false
end

function UIActivityN27Helper:CheckRedShop()
  local state = self:GetStateShop()
  if state == UISummerOneEnterBtnState.Normal then
    local red = self._campaign:CheckComponentRed(self._localProcess, self.componentIdShop)
    return red
  end
  return false
end

function UIActivityN27Helper:IsShowBattlePassRed()
  if self._battlepassCampaign then
    return UIActivityHelper.CheckCampaignSampleRedPoint(self._battlepassCampaign)
  end
  return false
end

function UIActivityN27Helper:CheckGameIdolRed()
  local state = self:GetStateGameIdol()
  if state == UISummerOneEnterBtnState.Normal then
    local red = self._campaign:CheckComponentRed(self._localProcess, ECampaignN27ComponentID.ECAMPAIGN_N27_IDOL)
    return red
  end
  return false
end

function UIActivityN27Helper:CheckGameBloodSuckerRed()
  return false
end

function UIActivityN27Helper.GetNewFlagKey(id)
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  local key = pstId .. "ACTIVITY_N27_MODULE_NEW_FLAG" .. id
  return key
end

function UIActivityN27Helper.GetNewFlagStatus(id)
  local key = UIActivityN27Helper.GetNewFlagKey(id)
  if not UnityEngine.PlayerPrefs.HasKey(key) then
    return true
  end
  local value = UnityEngine.PlayerPrefs.GetInt(key)
  return value == 0
end

function UIActivityN27Helper.SetNewFlagStatus(id, status)
  local key = UIActivityN27Helper.GetNewFlagKey(id)
  if status then
    UnityEngine.PlayerPrefs.SetInt(key, 0)
  else
    UnityEngine.PlayerPrefs.SetInt(key, 1)
  end
end

function UIActivityN27Helper.GetEnterNewStatus()
  return UIActivityN27Helper.GetNewFlagStatus("ENTRY_NEW")
end

function UIActivityN27Helper.ClearEnterNewStatus()
  UIActivityN27Helper.SetNewFlagStatus("ENTRY_NEW", false)
end

function UIActivityN27Helper:GetStateShop()
  if self._exchangeComponentInfo then
    return self:GetState(self._exchangeComponentInfo)
  end
end

function UIActivityN27Helper:GetStateNormal()
  if self._lineCompInfo then
    return self:GetState(self._lineCompInfo)
  end
end

function UIActivityN27Helper:GetStateHard()
  if self._hardCompInfo then
    return self:GetState(self._hardCompInfo)
  end
end

function UIActivityN27Helper:GetStateTryPet()
  if self._fixTeamCompInfo then
    return self:GetState(self._fixTeamCompInfo)
  end
end

function UIActivityN27Helper:GetStateGameIdol()
  if self._idolMiniGameCompInfo then
    return self:GetState(self._idolMiniGameCompInfo)
  end
end

function UIActivityN27Helper:GetStateGameBloodSucker()
  if self._bloodsuckerComponentInfo then
    return self:GetState(self._bloodsuckerComponentInfo)
  end
end

function UIActivityN27Helper:GetState(cInfo)
  local nowTimestamp = UICommonHelper.GetNowTimestamp()
  if nowTimestamp < cInfo.m_unlock_time then
    return UISummerOneEnterBtnState.NotOpen
  elseif nowTimestamp > cInfo.m_close_time then
    return UISummerOneEnterBtnState.Closed
  elseif cInfo.m_b_unlock then
    return UISummerOneEnterBtnState.Normal
  else
    local cfgv = Cfg.cfg_campaign_mission[cInfo.m_need_mission_id]
    if cfgv then
      return UISummerOneEnterBtnState.Locked
    else
      return UISummerOneEnterBtnState.Normal
    end
  end
end

function UIActivityN27Helper.GetTimeString(seconds)
  local timeStr = ""
  local day = math.floor(seconds / 3600 / 24)
  if 0 < day then
    seconds = seconds - day * 3600 * 24
    local hour = math.floor(seconds / 3600)
    timeStr = StringTable.Get("str_N27_day", day)
    if 0 < hour then
      timeStr = timeStr .. StringTable.Get("str_N27_hour", hour)
    end
  elseif 60 <= seconds then
    local hour = math.floor(seconds / 3600)
    seconds = seconds - hour * 3600
    if 0 < hour then
      timeStr = StringTable.Get("str_N27_hour", hour)
    end
    local minus = math.floor(seconds / 60)
    if minus then
      timeStr = timeStr .. StringTable.Get("str_N27_minus", minus)
    end
  else
    timeStr = StringTable.Get("str_N27_less_one_minus")
  end
  return timeStr
end

function UIActivityN27Helper.GetItemCountStr(count, preColor, countColor)
  local dight = 0
  local tmpCount = count
  if tmpCount < 0 then
    tmpCount = -tmpCount
  end
  while 0 < tmpCount do
    tmpCount = math.floor(tmpCount / 10)
    dight = dight + 1
  end
  local pre = ""
  if 0 <= count then
    for i = 1, 7 - dight do
      pre = pre .. "0"
    end
  else
    for i = 1, 7 - dight - 1 do
      pre = pre .. "0"
    end
  end
  if 0 < count then
    return string.format("<color=" .. preColor .. ">%s</color><color=" .. countColor .. ">%s</color>", pre, count)
  elseif count == 0 then
    return string.format("<color=" .. preColor .. ">%s</color>", pre)
  else
    return string.format("<color=" .. preColor .. ">%s</color><color=" .. countColor .. ">%s</color>", pre, count)
  end
end

function UIActivityN27Helper.ShowRewards(rewards, callback)
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

function UIActivityN27Helper:GetSpineAndBgm()
  local cfg = Cfg.cfg_N27_const[1]
  if self._lineCompInfo and cfg then
    local missionModule = GameGlobal.GetModule(MissionModule)
    local passInfo = self._lineCompInfo.m_pass_mission_info
    for _, info in pairs(passInfo) do
      local storyId = missionModule:GetStoryByStageIdStoryType(info.mission_id, StoryTriggerType.Node)
      if storyId == cfg.StoryID then
        return cfg.Spine2, cfg.Bgm2
      end
    end
    return cfg.Spine1, cfg.Bgm1
  end
  return nil, nil
end

function UIActivityN27Helper:CheckBloodSuckerMissionPassed(missionId)
  if not self._bloodsuckerComponentInfo then
    return false
  end
  if self._bloodsuckerComponentInfo.mission_infos then
    for index, value in pairs(self._bloodsuckerComponentInfo.mission_infos) do
      if index == missionId then
        return value.is_pass == 1
      end
    end
  end
  return false
end

function UIActivityN27Helper:CheckBloodSuckerMissionJoind(missionId)
  if not self._bloodsuckerComponentInfo then
    return false
  end
  if self._bloodsuckerComponentInfo.join_mission_list then
    for index, value in pairs(self._bloodsuckerComponentInfo.join_mission_list) do
      if value == missionId then
        return true
      end
    end
  end
  return false
end

function UIActivityN27Helper:GetTaskRedPoint()
  self._questComponent = self._localProcess:GetComponent(ECampaignN27ComponentID.ECAMPAIGN_N27_QUEST)
  if not self._questComponent then
    return false
  end
  return self._questComponent:HaveRedPoint()
end

function UIActivityN27Helper:GetShowFirstTaskIndex()
  local firstShow = 1
  if not self._bloodsuckerComponentInfo then
    return firstShow
  end
  if self._bloodsuckerComponentInfo.mission_infos then
    for index, value in pairs(self._bloodsuckerComponentInfo.mission_infos) do
      if value.is_pass == 1 then
        firstShow = firstShow + 1
      end
    end
  end
  return firstShow
end
