_class("UIActivityN24Const", Object)
UIActivityN24Const = UIActivityN24Const

function UIActivityN24Const:Constructor()
end

function UIActivityN24Const:LoadData(TT, res)
  self._timeModule = GameGlobal.GetModule(SvrTimeModule)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N24, ECampaignN24ComponentID.ECAMPAIGN_N24_CUMULATIVE_LOGIN, ECampaignN24ComponentID.ECAMPAIGN_N24_FIRST_MEET, ECampaignN24ComponentID.ECAMPAIGN_N24_POWER2ITEM, ECampaignN24ComponentID.ECAMPAIGN_N24_LOTTERY, ECampaignN24ComponentID.ECAMPAIGN_N24_PANGOLIN)
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
  self._cumulativeLoginComponent = self._localProcess:GetComponent(ECampaignN24ComponentID.ECAMPAIGN_N24_CUMULATIVE_LOGIN)
  self._cumulativeLoginComponentInfo = self._localProcess:GetComponentInfo(ECampaignN24ComponentID.ECAMPAIGN_N24_CUMULATIVE_LOGIN)
  self._fixTeamComponent = self._localProcess:GetComponent(ECampaignN24ComponentID.ECAMPAIGN_N24_FIRST_MEET)
  self._fixTeamCompInfo = self._localProcess:GetComponentInfo(ECampaignN24ComponentID.ECAMPAIGN_N24_FIRST_MEET)
  self._power2itemComponent = self._localProcess:GetComponent(ECampaignN24ComponentID.ECAMPAIGN_N24_POWER2ITEM)
  self._power2itemComponentInfo = self._localProcess:GetComponentInfo(ECampaignN24ComponentID.ECAMPAIGN_N24_POWER2ITEM)
  self._lotteryComponent = self._localProcess:GetComponent(ECampaignN24ComponentID.ECAMPAIGN_N24_LOTTERY)
  self._lotteryCompInfo = self._localProcess:GetComponentInfo(ECampaignN24ComponentID.ECAMPAIGN_N24_LOTTERY)
  self._pangolinComponent = self._localProcess:GetComponent(ECampaignN24ComponentID.ECAMPAIGN_N24_PANGOLIN)
  self._pangolinCompInfo = self._localProcess:GetComponentInfo(ECampaignN24ComponentID.ECAMPAIGN_N24_PANGOLIN)
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
    self._endTime = self._lotteryCompInfo.m_close_time
  else
    self._status = 1
    self._endTime = power2itemEndTime
  end
  if nowTime > self._activeEndTime then
    Log.error("Time error!")
    return
  end
end

function UIActivityN24Const:ForceUpdate(TT)
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
end

function UIActivityN24Const:GetCampaign()
  return self._campaign
end

function UIActivityN24Const:GetCampaignId()
  return self._campaign._id
end

function UIActivityN24Const:GetName()
  return self._name
end

function UIActivityN24Const:GetSubName()
  return self._subName
end

function UIActivityN24Const:GetActiveEndTime()
  return self._activeEndTime
end

function UIActivityN24Const:GetStatus()
  return self._status
end

function UIActivityN24Const:SetStatus(status)
  self._status = status
end

function UIActivityN24Const:IsActivityEnd()
  local nowTime = self._timeModule:GetServerTime() / 1000
  local seconds = math.floor(self._activeEndTime - nowTime)
  if seconds <= 0 then
    return true
  end
  return false
end

function UIActivityN24Const:GetTryPetComponent()
  return self._fixTeamComponent, self._fixTeamCompInfo
end

function UIActivityN24Const:GetShopComponent()
  return self._lotteryComponent, self._lotteryCompInfo
end

function UIActivityN24Const:IsLoginEnable()
  if self:IsActivityEnd() then
    return false
  end
  if not self._cumulativeLoginComponent then
    return false
  end
  return self._cumulativeLoginComponent:ComponentIsOpen()
end

function UIActivityN24Const:IsTryPetEnable()
  if self:IsActivityEnd() then
    return false
  end
  if not self._fixTeamComponent then
    return false
  end
  return self._fixTeamComponent:ComponentIsOpen()
end

function UIActivityN24Const:IsPower2ItemEnable()
  if self:IsActivityEnd() then
    return false
  end
  if not self._power2itemComponent then
    return false
  end
  return self._power2itemComponent:ComponentIsOpen()
end

function UIActivityN24Const:IsShopEnable()
  if self:IsActivityEnd() then
    return false
  end
  if not self._lotteryComponent then
    return false
  end
  return self._lotteryComponent:ComponentIsOpen()
end

function UIActivityN24Const:IsHomelandTaskEnd()
  if self:IsActivityEnd() then
    return true
  end
  if not self._pangolinCompInfo then
    return true
  end
  local curTime = math.floor(self._timeModule:GetServerTime() * 0.001)
  if curTime >= self._pangolinCompInfo.m_close_time then
    return true
  end
  return false
end

function UIActivityN24Const:IsHomelandTaskEnable()
  if self:IsActivityEnd() then
    return false
  end
  if not self._pangolinCompInfo then
    return false
  end
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local isOpen = curTime >= self._pangolinCompInfo.m_unlock_time and curTime <= self._pangolinCompInfo.m_close_time
  return isOpen
end

function UIActivityN24Const:GetHomelandRemaindOpenSeconds()
  local curTime = math.floor(self._timeModule:GetServerTime() * 0.001)
  local seconds = math.floor(self._pangolinCompInfo.m_unlock_time - curTime)
  if seconds <= 0 then
    seconds = 0
  end
  return seconds
end

function UIActivityN24Const:IsShowEntryNew()
  local enterNew = UIActivityN24Const.GetEnterNewStatus()
  if enterNew then
    return true
  end
  return self:IsShowHomelandTaskNew()
end

function UIActivityN24Const:IsShowHomelandTaskNew()
  if not self:IsHomelandTaskEnable() then
    return false
  end
  return UIActivityN24Const.GetHomelandTaskNewStatus()
end

function UIActivityN24Const:IsShowEntryRed()
  if self:IsActivityEnd() then
    return false
  end
  if self:IsShowLoginRed() then
    return true
  end
  if self:IsShowHomelandTaskRed() then
    return true
  end
  if self:IsShowTryPetRed() then
    return true
  end
  if self:IsShowShopRed() then
    return true
  end
  return false
end

function UIActivityN24Const:IsShowTryPetRed()
  if not self:IsTryPetEnable() then
    return false
  end
  return self._campaign:CheckComponentRed(ECampaignN24ComponentID.ECAMPAIGN_N24_FIRST_MEET)
end

function UIActivityN24Const:IsShowLoginRed()
  if not self:IsLoginEnable() then
    return false
  end
  return self._campaign:CheckComponentRed(ECampaignN24ComponentID.ECAMPAIGN_N24_CUMULATIVE_LOGIN)
end

function UIActivityN24Const:IsShowShopRed()
  if not self:IsShopEnable() then
    return false
  end
  return self._campaign:CheckComponentRed(ECampaignN24ComponentID.ECAMPAIGN_N24_LOTTERY)
end

function UIActivityN24Const:IsShowHomelandTaskRed()
  if not self:IsHomelandTaskEnable() then
    return false
  end
  return self._campaign:CheckComponentRed(ECampaignN24ComponentID.ECAMPAIGN_N24_PANGOLIN)
end

function UIActivityN24Const:IsShowBattlePassRed()
  if self._battlepassCampaign then
    return UIActivityHelper.CheckCampaignSampleRedPoint(self._battlepassCampaign)
  end
  return false
end

function UIActivityN24Const.GetNewFlagKey(id)
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  local key = pstId .. "ACTIVITY_N24_MODULE_NEW_FLAG" .. id
  return key
end

function UIActivityN24Const.GetNewFlagStatus(id)
  local key = UIActivityN24Const.GetNewFlagKey(id)
  if not UnityEngine.PlayerPrefs.HasKey(key) then
    return true
  end
  local value = UnityEngine.PlayerPrefs.GetInt(key)
  return value == 0
end

function UIActivityN24Const.SetNewFlagStatus(id, status)
  local key = UIActivityN24Const.GetNewFlagKey(id)
  if status then
    UnityEngine.PlayerPrefs.SetInt(key, 0)
  else
    UnityEngine.PlayerPrefs.SetInt(key, 1)
  end
end

function UIActivityN24Const.GetEnterNewStatus()
  return UIActivityN24Const.GetNewFlagStatus("ENTRY_NEW")
end

function UIActivityN24Const.ClearEnterNewStatus()
  UIActivityN24Const.SetNewFlagStatus("ENTRY_NEW", false)
end

function UIActivityN24Const.GetHomelandTaskNewStatus()
  return UIActivityN24Const.GetNewFlagStatus("HOMELAND_TASK_NEW")
end

function UIActivityN24Const.ClearHomelandTaskNewStatus()
  UIActivityN24Const.SetNewFlagStatus("HOMELAND_TASK_NEW", false)
end

function UIActivityN24Const.GetTimeString(seconds)
  local timeStr = ""
  local day = math.floor(seconds / 3600 / 24)
  if 0 < day then
    seconds = seconds - day * 3600 * 24
    local hour = math.floor(seconds / 3600)
    timeStr = StringTable.Get("str_n24_day", day)
    if 0 < hour then
      timeStr = timeStr .. StringTable.Get("str_n24_hour", hour)
    end
  elseif 60 <= seconds then
    local hour = math.floor(seconds / 3600)
    seconds = seconds - hour * 3600
    if 0 < hour then
      timeStr = StringTable.Get("str_n24_hour", hour)
    end
    local minus = math.floor(seconds / 60)
    if minus then
      timeStr = timeStr .. StringTable.Get("str_n24_minus", minus)
    end
  else
    timeStr = StringTable.Get("str_n24_less_one_minus")
  end
  return timeStr
end

function UIActivityN24Const.GetItemCountStr(count, preColor, countColor)
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

function UIActivityN24Const.ShowRewards(rewards, callback)
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
