_class("UIActivityN25Const", Object)
UIActivityN25Const = UIActivityN25Const

function UIActivityN25Const:LoadData(TT, res)
  self._timeModule = GameGlobal.GetModule(SvrTimeModule)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  self._campaign = UIActivityCampaign.New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N25, ECampaignN25ComponentID.ECAMPAIGN_N25_CUMULATIVE_LOGIN, ECampaignN25ComponentID.ECAMPAIGN_N25_FIRST_MEET, ECampaignN25ComponentID.ECAMPAIGN_N25_POWER2ITEM, ECampaignN25ComponentID.ECAMPAIGN_N25_LINE_MISSION, ECampaignN25ComponentID.ECAMPAIGN_N25_DIFFICULT_MISSION, ECampaignN25ComponentID.ECAMPAIGN_N25_SHOP, ECampaignN25ComponentID.ECAMPAIGN_N25_BLOODSUCKER, ECampaignN25ComponentID.ECAMPAIGN_N25_IDOL)
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
  local bpRes = AsyncRequestRes:New()
  bpRes:SetSucc(true)
  self._battlepassCampaign = UIActivityCampaign:New()
  self._battlepassCampaign:LoadCampaignInfo(TT, bpRes, ECampaignType.CAMPAIGN_TYPE_BATTLEPASS)
  if not bpRes:GetSucc() then
    Log.info("获取战斗通行证数据失败")
  end
  self._cumulativeLoginComponent = self._localProcess:GetComponent(ECampaignN25ComponentID.ECAMPAIGN_N25_CUMULATIVE_LOGIN)
  self._cumulativeLoginComponentInfo = self._localProcess:GetComponentInfo(ECampaignN25ComponentID.ECAMPAIGN_N25_CUMULATIVE_LOGIN)
  self._fixTeamComponent = self._localProcess:GetComponent(ECampaignN25ComponentID.ECAMPAIGN_N25_FIRST_MEET)
  self._fixTeamCompInfo = self._localProcess:GetComponentInfo(ECampaignN25ComponentID.ECAMPAIGN_N25_FIRST_MEET)
  self._lineComp = self._localProcess:GetComponent(ECampaignN25ComponentID.ECAMPAIGN_N25_LINE_MISSION)
  self._lineCompInfo = self._localProcess:GetComponentInfo(ECampaignN25ComponentID.ECAMPAIGN_N25_LINE_MISSION)
  self._hardComp = self._localProcess:GetComponent(ECampaignN25ComponentID.ECAMPAIGN_N25_DIFFICULT_MISSION)
  self._hardCompInfo = self._localProcess:GetComponentInfo(ECampaignN25ComponentID.ECAMPAIGN_N25_DIFFICULT_MISSION)
  self._power2itemComponent = self._localProcess:GetComponent(ECampaignN25ComponentID.ECAMPAIGN_N25_POWER2ITEM)
  self._power2itemComponentInfo = self._localProcess:GetComponentInfo(ECampaignN25ComponentID.ECAMPAIGN_N25_POWER2ITEM)
  self._exchangeComponent = self._localProcess:GetComponent(ECampaignN25ComponentID.ECAMPAIGN_N25_SHOP)
  self._exchangeComponentInfo = self._localProcess:GetComponentInfo(ECampaignN25ComponentID.ECAMPAIGN_N25_SHOP)
  self._idolMiniGameComponent = self._localProcess:GetComponent(ECampaignN25ComponentID.ECAMPAIGN_N25_IDOL)
  self._idolMiniGameCompInfo = self._localProcess:GetComponentInfo(ECampaignN25ComponentID.ECAMPAIGN_N25_IDOL)
  self._bloodsuckerComponet = self._localProcess:GetComponent(ECampaignN25ComponentID.ECAMPAIGN_N25_BLOODSUCKER)
  self._bloodsuckerComponentInfo = self._localProcess:GetComponentInfo(ECampaignN25ComponentID.ECAMPAIGN_N25_BLOODSUCKER)
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

function UIActivityN25Const:ForceUpdate(TT)
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
end

function UIActivityN25Const:GetCampaign()
  return self._campaign
end

function UIActivityN25Const:GetCampaignId()
  return self._campaign._id
end

function UIActivityN25Const:GetName()
  return self._name
end

function UIActivityN25Const:GetSubName()
  return self._subName
end

function UIActivityN25Const:GetActiveEndTime()
  return self._activeEndTime
end

function UIActivityN25Const:GetStatus()
  return self._status
end

function UIActivityN25Const:SetStatus(status)
  self._status = status
end

function UIActivityN25Const:IsActivityEnd()
  if not self._activeEndTime then
    return true
  end
  local nowTime = self._timeModule:GetServerTime() / 1000
  local seconds = math.floor(self._activeEndTime - nowTime)
  if seconds <= 0 then
    return true
  end
  return false
end

function UIActivityN25Const:GetTryPetComponent()
  return self._fixTeamComponent, self._fixTeamCompInfo
end

function UIActivityN25Const:GetShopComponent()
  return self._exchangeComponent, self._exchangeComponentInfo
end

function UIActivityN25Const:GetLineComponent()
  return self._lineComp, self._lineCompInfo
end

function UIActivityN25Const:GetHardComponent()
  return self._hardComp, self._hardCompInfo
end

function UIActivityN25Const:GetIdolComponent()
  return self._idolMiniGameComponent, self._idolMiniGameCompInfo
end

function UIActivityN25Const:GetBloodSuckerComponent()
  return self._bloodsuckerComponet, self._bloodsuckerComponentInfo
end

function UIActivityN25Const:IsTryPetEnable()
  if self:IsActivityEnd() then
    return false
  end
  if not self._fixTeamComponent then
    return false
  end
  return self._fixTeamComponent:ComponentIsOpen()
end

function UIActivityN25Const:IsPower2ItemEnable()
  if self:IsActivityEnd() then
    return false
  end
  if not self._power2itemComponent then
    return false
  end
  return self._power2itemComponent:ComponentIsOpen()
end

function UIActivityN25Const:IsShowEntryNew()
  if self:IsActivityEnd() then
    return false
  end
  local isNew = UIActivityN25Const.GetEnterNewStatus() or self:CheckNewHard() or self:CheckNewNormal() or self:CheckGameIdolNew() or self:CheckGameBloodSuckerNew()
  return isNew
end

function UIActivityN25Const:CheckNewNormal()
  return false
end

function UIActivityN25Const:CheckNewHard()
  if not N25Data.HasPrefs(N25Data.GetPrefsKeyHard()) and self._hardCompInfo and self:GetState(self._hardCompInfo) == UISummerOneEnterBtnState.Normal then
    return true
  end
  return false
end

function UIActivityN25Const:CheckGameIdolNew()
  if not N25Data.HasPrefs(N25Data.GetPrefsKeyGameIdol()) and self._idolMiniGameCompInfo and self:GetState(self._idolMiniGameCompInfo) == UISummerOneEnterBtnState.Normal then
    return true
  end
  return false
end

function UIActivityN25Const:CheckGameBloodSuckerNew()
  if not N25Data.HasPrefs(N25Data.GetPrefsKeyGameBloodSucker()) and self._bloodsuckerComponentInfo and self:GetState(self._bloodsuckerComponentInfo) == UISummerOneEnterBtnState.Normal then
    return true
  end
  return false
end

function UIActivityN25Const:IsShowEntryRed()
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

function UIActivityN25Const:CheckRedAward()
  local red = self._campaign:CheckComponentRed(self._localProcess, ECampaignN25ComponentID.ECAMPAIGN_N25_CUMULATIVE_LOGIN)
  return red
end

function UIActivityN25Const:CheckRedTryPet()
  local state = self:GetStateTryPet()
  if state == UISummerOneEnterBtnState.Normal then
    local red = self._campaign:CheckComponentRed(self._localProcess, ECampaignN25ComponentID.ECAMPAIGN_N25_FIRST_MEET)
    return red
  end
  return false
end

function UIActivityN25Const:CheckRedNormal()
  local state = self:GetStateNormal()
  if state == UISummerOneEnterBtnState.Normal then
    local red = self._campaign:CheckComponentRed(self._localProcess, ECampaignN25ComponentID.ECAMPAIGN_N25_LINE_MISSION)
    return red
  end
  return false
end

function UIActivityN25Const:CheckRedHard()
  local state = self:GetStateHard()
  if state == UISummerOneEnterBtnState.Normal then
    local red = self._campaign:CheckComponentRed(self._localProcess, ECampaignN25ComponentID.ECAMPAIGN_N25_DIFFICULT_MISSION)
    return red
  end
  return false
end

function UIActivityN25Const:CheckRedShop()
  local state = self:GetStateShop()
  if state == UISummerOneEnterBtnState.Normal then
    local red = self._campaign:CheckComponentRed(self._localProcess, self.componentIdShop)
    return red
  end
  return false
end

function UIActivityN25Const:IsShowBattlePassRed()
  if self._battlepassCampaign then
    return UIActivityHelper.CheckCampaignSampleRedPoint(self._battlepassCampaign)
  end
  return false
end

function UIActivityN25Const:CheckGameIdolRed()
  local state = self:GetStateGameIdol()
  if state == UISummerOneEnterBtnState.Normal then
    local red = self._campaign:CheckComponentRed(self._localProcess, ECampaignN25ComponentID.ECAMPAIGN_N25_IDOL)
    return red
  end
  return false
end

function UIActivityN25Const:CheckGameBloodSuckerRed()
  return false
end

function UIActivityN25Const.GetNewFlagKey(id)
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  local key = pstId .. "ACTIVITY_N25_MODULE_NEW_FLAG" .. "fk" .. id
  return key
end

function UIActivityN25Const.GetNewFlagStatus(id)
  local key = UIActivityN25Const.GetNewFlagKey(id)
  if not UnityEngine.PlayerPrefs.HasKey(key) then
    return true
  end
  local value = UnityEngine.PlayerPrefs.GetInt(key)
  return value == 0
end

function UIActivityN25Const.SetNewFlagStatus(id, status)
  local key = UIActivityN25Const.GetNewFlagKey(id)
  if status then
    UnityEngine.PlayerPrefs.SetInt(key, 0)
  else
    UnityEngine.PlayerPrefs.SetInt(key, 1)
  end
end

function UIActivityN25Const.GetEnterNewStatus()
  return UIActivityN25Const.GetNewFlagStatus("ENTRY_NEW")
end

function UIActivityN25Const.ClearEnterNewStatus()
  UIActivityN25Const.SetNewFlagStatus("ENTRY_NEW", false)
end

function UIActivityN25Const:GetStateShop()
  if self._exchangeComponentInfo then
    return self:GetState(self._exchangeComponentInfo)
  end
end

function UIActivityN25Const:GetStateNormal()
  if self._lineCompInfo then
    return self:GetState(self._lineCompInfo)
  end
end

function UIActivityN25Const:GetStateHard()
  if self._hardCompInfo then
    return self:GetState(self._hardCompInfo)
  end
end

function UIActivityN25Const:GetStateTryPet()
  if self._fixTeamCompInfo then
    return self:GetState(self._fixTeamCompInfo)
  end
end

function UIActivityN25Const:GetStateGameIdol()
  if self._idolMiniGameCompInfo then
    return self:GetState(self._idolMiniGameCompInfo)
  end
end

function UIActivityN25Const:GetStateGameBloodSucker()
  if self._bloodsuckerComponentInfo then
    return self:GetState(self._bloodsuckerComponentInfo)
  end
end

function UIActivityN25Const:GetState(cInfo)
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

function UIActivityN25Const.GetTimeString(seconds)
  local timeStr = ""
  local day = math.floor(seconds / 3600 / 24)
  if 0 < day then
    seconds = seconds - day * 3600 * 24
    local hour = math.floor(seconds / 3600)
    timeStr = StringTable.Get("str_n25_day", day)
    if 0 < hour then
      timeStr = timeStr .. StringTable.Get("str_n25_hour", hour)
    end
  elseif 60 <= seconds then
    local hour = math.floor(seconds / 3600)
    seconds = seconds - hour * 3600
    if 0 < hour then
      timeStr = StringTable.Get("str_n25_hour", hour)
    end
    local minus = math.floor(seconds / 60)
    if minus then
      timeStr = timeStr .. StringTable.Get("str_n25_minus", minus)
    end
  else
    timeStr = StringTable.Get("str_n25_less_one_minus")
  end
  return timeStr
end

function UIActivityN25Const.GetItemCountStr(count, preColor, countColor)
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

function UIActivityN25Const.ShowRewards(rewards, callback)
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

function UIActivityN25Const:GetSpineAndBgm()
  local cfg = Cfg.cfg_n25_const[1]
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

function UIActivityN25Const:CheckBloodSuckerMissionPassed(missionId)
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

function UIActivityN25Const:CheckBloodSuckerMissionJoind(missionId)
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

function UIActivityN25Const:GetTaskRedPoint()
  self._questComponent = self._localProcess:GetComponent(ECampaignN25ComponentID.ECAMPAIGN_N25_QUEST)
  if not self._questComponent then
    return false
  end
  return self._questComponent:HaveRedPoint()
end

function UIActivityN25Const:GetShowFirstTaskIndex()
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
