_class("UIActivityN20Const", Object)
UIActivityN20Const = UIActivityN20Const

function UIActivityN20Const:Constructor()
  self.dataAVG = nil
end

function UIActivityN20Const:LoadData(TT, res)
  self._timeModule = GameGlobal.GetModule(SvrTimeModule)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  self.dataAVG = campaignModule:GetN20AVGData()
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N20, ECampaignN20ComponentID.ECAMPAIGN_N20_CUMULATIVE_LOGIN, ECampaignN20ComponentID.ECAMPAIGN_N20_LEVEL_COMMON, ECampaignN20ComponentID.ECAMPAIGN_N20_LEVEL_HARD, ECampaignN20ComponentID.ECAMPAIGN_N20_POWER2ITEM, ECampaignN20ComponentID.ECAMPAIGN_N20_SHOP, ECampaignN20ComponentID.ECAMPAIGN_N20_LEVEL_FIXTEAM, ECampaignN20ComponentID.ECAMPAIGN_N20_MINI_GAME, ECampaignN20ComponentID.ECAMPAIGN_N20_AVG_MINI_GAME)
  if res and not res:GetSucc() then
    campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
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
  self._cumulativeLoginComponent = self._localProcess:GetComponent(ECampaignN20ComponentID.ECAMPAIGN_N20_CUMULATIVE_LOGIN)
  self._cumulativeLoginComponentInfo = self._localProcess:GetComponentInfo(ECampaignN20ComponentID.ECAMPAIGN_N20_CUMULATIVE_LOGIN)
  self._normalLineMissionComponet = self._localProcess:GetComponent(ECampaignN20ComponentID.ECAMPAIGN_N20_LEVEL_COMMON)
  self._normalLineMissionCompInfo = self._localProcess:GetComponentInfo(ECampaignN20ComponentID.ECAMPAIGN_N20_LEVEL_COMMON)
  self._hardlLineMissionComponet = self._localProcess:GetComponent(ECampaignN20ComponentID.ECAMPAIGN_N20_LEVEL_HARD)
  self._hardLineMissionCompInfo = self._localProcess:GetComponentInfo(ECampaignN20ComponentID.ECAMPAIGN_N20_LEVEL_HARD)
  self._lineMissionFixteamComponet = self._localProcess:GetComponent(ECampaignN20ComponentID.ECAMPAIGN_N20_LEVEL_FIXTEAM)
  self._lineMissionFixteamCompInfo = self._localProcess:GetComponentInfo(ECampaignN20ComponentID.ECAMPAIGN_N20_LEVEL_FIXTEAM)
  self._miniGameComponet = self._localProcess:GetComponent(ECampaignN20ComponentID.ECAMPAIGN_N20_MINI_GAME)
  self._miniGameCompInfo = self._localProcess:GetComponentInfo(ECampaignN20ComponentID.ECAMPAIGN_N20_MINI_GAME)
  self._shopComponet = self._localProcess:GetComponent(ECampaignN20ComponentID.ECAMPAIGN_N20_SHOP)
  self._shopCompInfo = self._localProcess:GetComponentInfo(ECampaignN20ComponentID.ECAMPAIGN_N20_SHOP)
  self._power2ItemComponet = self._localProcess:GetComponent(ECampaignN20ComponentID.ECAMPAIGN_N20_POWER2ITEM)
  self._power2ItemCompInfo = self._localProcess:GetComponentInfo(ECampaignN20ComponentID.ECAMPAIGN_N20_POWER2ITEM)
  self._avgMinigameComponent = self._localProcess:GetComponent(ECampaignN20ComponentID.ECAMPAIGN_N20_AVG_MINI_GAME)
  self._avgStoryComponentClientInfo = self._localProcess:GetComponentInfo(ECampaignN20ComponentID.ECAMPAIGN_N20_AVG_MINI_GAME)
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
  local missionEndTime = 0
  if self._normalLineMissionCompInfo then
    missionEndTime = self._normalLineMissionCompInfo.m_close_time
  end
  if nowTime >= missionEndTime then
    self._status = 2
    self._endTime = self._activeEndTime
  else
    self._status = 1
    self._endTime = missionEndTime
  end
  self.dataAVG:RequestCampaign(TT)
  self.dataAVG:Init()
  self.dataAVG:Update()
end

function UIActivityN20Const:ForceUpdate(TT)
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
end

function UIActivityN20Const:GetCampaign()
  return self._campaign
end

function UIActivityN20Const:GetCampaignId()
  return self._campaign._id
end

function UIActivityN20Const:GetName()
  return self._name
end

function UIActivityN20Const:GetSubName()
  return self._subName
end

function UIActivityN20Const:GetStatus()
  return self._status
end

function UIActivityN20Const:SetStatus(status)
  self._status = status
end

function UIActivityN20Const:GetEndTime()
  return self._endTime
end

function UIActivityN20Const:GetActiveEndTime()
  return self._activeEndTime
end

function UIActivityN20Const:GetBattlePassCampaign()
  return self._battlepassCampaign
end

function UIActivityN20Const:GetLoginComponent()
  return self._cumulativeLoginComponent, self._cumulativeLoginComponentInfo
end

function UIActivityN20Const:GetNormalLineComponent()
  return self._normalLineMissionComponet, self._normalLineMissionCompInfo
end

function UIActivityN20Const:GetHardLineComponent()
  return self._hardlLineMissionComponet, self._hardLineMissionCompInfo
end

function UIActivityN20Const:GetLineMissionFixteamComponet()
  return self._lineMissionFixteamComponet, self._lineMissionFixteamCompInfo
end

function UIActivityN20Const:GetMiniGameComponent()
  return self._miniGameComponet, self._miniGameCompInfo
end

function UIActivityN20Const:GetShopComponent()
  return self._shopComponet, self._shopCompInfo
end

function UIActivityN20Const:GetPower2itemComponent()
  return self._power2ItemComponet, self._power2ItemCompInfo
end

function UIActivityN20Const:GetPower2itemComponent()
  return self._avgMinigameComponent, self._avgStoryComponentClientInfo
end

function UIActivityN20Const:IsActivityEnd()
  local nowTime = self._timeModule:GetServerTime() / 1000
  local seconds = math.floor(self._activeEndTime - nowTime)
  if seconds <= 0 then
    return true
  end
  return false
end

function UIActivityN20Const:IsLoginEnable()
  if self:IsActivityEnd() then
    return false
  end
  if not self._cumulativeLoginComponentInfo then
    return false
  end
  local curTime = math.floor(self._timeModule:GetServerTime() * 0.001)
  local result = curTime >= self._cumulativeLoginComponentInfo.m_unlock_time and curTime <= self._cumulativeLoginComponentInfo.m_close_time
  return result and self._cumulativeLoginComponentInfo.m_b_unlock
end

function UIActivityN20Const:IsNormalMissionEnable()
  if self:IsActivityEnd() then
    return false
  end
  if not self._normalLineMissionCompInfo then
    return false
  end
  local curTime = math.floor(self._timeModule:GetServerTime() * 0.001)
  local result = curTime >= self._normalLineMissionCompInfo.m_unlock_time and curTime <= self._normalLineMissionCompInfo.m_close_time
  return result and self._normalLineMissionCompInfo.m_b_unlock
end

function UIActivityN20Const:GetNormalMissionOpenTime()
  return self._normalLineMissionCompInfo.m_unlock_time
end

function UIActivityN20Const:IsNormalMissionClose()
  if self:IsActivityEnd() then
    return true
  end
  local curTime = math.floor(self._timeModule:GetServerTime() * 0.001)
  if curTime > self._normalLineMissionCompInfo.m_close_time then
    return true
  end
  return false
end

function UIActivityN20Const:IsHardMissionEnable()
  if self:IsActivityEnd() then
    return false
  end
  if not self._hardLineMissionCompInfo then
    return false
  end
  local curTime = math.floor(self._timeModule:GetServerTime() * 0.001)
  local result = curTime >= self._hardLineMissionCompInfo.m_unlock_time and curTime <= self._hardLineMissionCompInfo.m_close_time
  return result and self._hardLineMissionCompInfo.m_b_unlock
end

function UIActivityN20Const:IsHardMissionTimeOpen()
  local curTime = math.floor(self._timeModule:GetServerTime() * 0.001)
  local isOpen = curTime >= self._hardLineMissionCompInfo.m_unlock_time and curTime <= self._hardLineMissionCompInfo.m_close_time
  return isOpen
end

function UIActivityN20Const:IsHardMissionClose()
  if self:IsActivityEnd() then
    return true
  end
  local curTime = math.floor(self._timeModule:GetServerTime() * 0.001)
  if curTime > self._hardLineMissionCompInfo.m_close_time then
    return true
  end
  return false
end

function UIActivityN20Const:GetHardMissionOpenTime()
  return self._hardLineMissionCompInfo.m_unlock_time
end

function UIActivityN20Const:IsAVGEnable()
  if self:IsActivityEnd() then
    return false
  end
  if not self._avgStoryComponentClientInfo then
    return false
  end
  local curTime = math.floor(self._timeModule:GetServerTime() * 0.001)
  local result = curTime >= self._avgStoryComponentClientInfo.m_unlock_time and curTime <= self._avgStoryComponentClientInfo.m_close_time
  return result and self._avgStoryComponentClientInfo.m_b_unlock
end

function UIActivityN20Const:IsAVGClose()
  if self:IsActivityEnd() then
    return true
  end
  local curTime = math.floor(self._timeModule:GetServerTime() * 0.001)
  if curTime > self._avgStoryComponentClientInfo.m_close_time then
    return true
  end
  return false
end

function UIActivityN20Const:GetAVGOpenTime()
  return self._avgStoryComponentClientInfo.m_unlock_time
end

function UIActivityN20Const:IsAVGTimeOpen()
  local curTime = math.floor(self._timeModule:GetServerTime() * 0.001)
  local isOpen = curTime >= self._avgStoryComponentClientInfo.m_unlock_time and curTime <= self._avgStoryComponentClientInfo.m_close_time
  return isOpen
end

function UIActivityN20Const:IsPetEnable()
  if self:IsActivityEnd() then
    return false
  end
  if not self._lineMissionFixteamCompInfo then
    return false
  end
  local curTime = math.floor(self._timeModule:GetServerTime() * 0.001)
  local result = curTime >= self._lineMissionFixteamCompInfo.m_unlock_time and curTime <= self._lineMissionFixteamCompInfo.m_close_time
  return result and self._lineMissionFixteamCompInfo.m_b_unlock
end

function UIActivityN20Const:IsMiniGameEnable()
  if self:IsActivityEnd() then
    return false
  end
  if not self._miniGameCompInfo then
    return false
  end
  local curTime = math.floor(self._timeModule:GetServerTime() * 0.001)
  local result = curTime >= self._miniGameCompInfo.m_unlock_time and curTime <= self._miniGameCompInfo.m_close_time
  return result
end

function UIActivityN20Const:IsMiniGameClose()
  if self:IsActivityEnd() then
    return true
  end
  local curTime = math.floor(self._timeModule:GetServerTime() * 0.001)
  if curTime > self._miniGameCompInfo.m_close_time then
    return true
  end
  return false
end

function UIActivityN20Const:GetMiniGameOpenTime()
  return self._miniGameCompInfo.m_unlock_time
end

function UIActivityN20Const:IsShopEnable()
  if self:IsActivityEnd() then
    return false
  end
  if not self._shopCompInfo then
    return false
  end
  local curTime = math.floor(self._timeModule:GetServerTime() * 0.001)
  local result = curTime >= self._shopCompInfo.m_unlock_time and curTime <= self._shopCompInfo.m_close_time
  return result and self._shopCompInfo.m_b_unlock
end

function UIActivityN20Const:GetShopCloseTime()
  return self._shopCompInfo.m_close_time
end

function UIActivityN20Const:IsPower2ItemEnable()
  if self:IsActivityEnd() then
    return false
  end
  if not self._power2ItemCompInfo then
    return false
  end
  local curTime = math.floor(self._timeModule:GetServerTime() * 0.001)
  local result = curTime >= self._power2ItemCompInfo.m_unlock_time and curTime <= self._power2ItemCompInfo.m_close_time
  return result and self._power2ItemCompInfo.m_b_unlock
end

function UIActivityN20Const:IsShowLoginRed()
  if not self:IsLoginEnable() then
    return false
  end
  return self._campaign:CheckComponentRed(ECampaignN20ComponentID.ECAMPAIGN_N20_CUMULATIVE_LOGIN)
end

function UIActivityN20Const:IsShowEventRed()
  if self._battlepassCampaign then
    return UIActivityHelper.CheckCampaignSampleRedPoint(self._battlepassCampaign)
  end
  return false
end

function UIActivityN20Const:IsShowNormalMissionRed()
  if not self:IsNormalMissionEnable() then
    return false
  end
  return self._localProcess:GetEasyMissionRedDot()
end

function UIActivityN20Const:IsShowHardMissionRed()
  if not self:IsHardMissionEnable() then
    return false
  end
  return self._localProcess:GetHardMissionRedDot()
end

function UIActivityN20Const:IsShowAVGRed()
  if not self:IsAVGEnable() then
    return false
  end
  local avgRed = self.dataAVG:HasRed()
  return avgRed
end

function UIActivityN20Const:IsShowMiniGameRed()
  if not self:IsMiniGameEnable() then
    return false
  end
  return self._campaign:CheckComponentRed(ECampaignN20ComponentID.ECAMPAIGN_N20_MINI_GAME)
end

function UIActivityN20Const:IsShowShopNew()
  if not self:IsShopEnable() then
    return false
  end
  return self:GetNewFlagStatus(5)
end

function UIActivityN20Const:ClearShopNew()
  self:SetNewFlagStatus(5, false)
end

function UIActivityN20Const:IsShowNormalMissionNew()
  if not self:IsNormalMissionEnable() then
    return false
  end
  return self:GetNewFlagStatus(1)
end

function UIActivityN20Const:ClearNormalMissionNew()
  self:SetNewFlagStatus(1, false)
end

function UIActivityN20Const:IsShowHardMissionNew()
  if not self:IsHardMissionEnable() then
    return false
  end
  return self:GetNewFlagStatus(2)
end

function UIActivityN20Const:ClearHardMissionNew()
  self:SetNewFlagStatus(2, false)
end

function UIActivityN20Const:IsShowAVGNew()
  if not self:IsAVGEnable() then
    return false
  end
  local newFlag = self:GetNewFlagStatus(3)
  local avgNew = self.dataAVG:HasNew()
  return newFlag or avgNew
end

function UIActivityN20Const:ClearAVGNew()
  self:SetNewFlagStatus(3, false)
end

function UIActivityN20Const:IsShowMiniGameNew()
  if not self:IsMiniGameEnable() then
    return false
  end
  if not self._miniGameCompInfo then
    return false
  end
  local mLogin = GameGlobal.GetModule(LoginModule)
  local str = LocalDB.GetString("N20MiniGameNewStage" .. mLogin:GetRoleShowID())
  local ids = string.split(str, ",")
  local nowTimestamp = UICommonHelper.GetNowTimestamp()
  local newStage = false
  for key, value in pairs(self._miniGameCompInfo.mission_info_list) do
    if nowTimestamp >= value.unlock_time then
      local record = false
      for j = 1, #ids do
        if ids[j] == tostring(key) then
          record = true
          break
        end
      end
      if not record then
        newStage = true
        break
      end
    end
  end
  return newStage
end

function UIActivityN20Const:ClearMiniGameNew()
  self:SetNewFlagStatus(4, false)
end

function UIActivityN20Const:IsShowMainEntryNew()
  return self:GetNewFlagStatus(6) or self:IsShowHardMissionNew() or self:IsShowMiniGameNew() or self:IsShowAVGNew() or self:IsShowNormalMissionNew()
end

function UIActivityN20Const:ClearMainEntryNew()
  self:SetNewFlagStatus(6, false)
end

function UIActivityN20Const:IsShowMainEntryRed()
  return self:IsShowAVGRed() or self:IsShowMiniGameRed() or self:IsShowHardMissionRed() or self:IsShowLoginRed() or self:IsShowNormalMissionRed() or self:IsShowShopNew()
end

function UIActivityN20Const:GetNewFlagKey(id)
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  local key = pstId .. "ACTIVITY_N20_MODULE_NEW_FLAG" .. id
  return key
end

function UIActivityN20Const:GetNewFlagStatus(id)
  local key = self:GetNewFlagKey(id)
  if not UnityEngine.PlayerPrefs.HasKey(key) then
    return true
  end
  local value = UnityEngine.PlayerPrefs.GetInt(key)
  return value == 0
end

function UIActivityN20Const:SetNewFlagStatus(id, status)
  local key = self:GetNewFlagKey(id)
  if status then
    UnityEngine.PlayerPrefs.SetInt(key, 0)
  else
    UnityEngine.PlayerPrefs.SetInt(key, 1)
  end
end

function UIActivityN20Const:GetTimeString(seconds)
  local timeStr = ""
  local day = math.floor(seconds / 3600 / 24)
  if 0 < day then
    seconds = seconds - day * 3600 * 24
    local hour = math.floor(seconds / 3600)
    timeStr = StringTable.Get("str_n20_day", day)
    if 0 < hour then
      timeStr = timeStr .. StringTable.Get("str_n20_hour", hour)
    end
  elseif 60 <= seconds then
    local hour = math.floor(seconds / 3600)
    seconds = seconds - hour * 3600
    if 0 < hour then
      timeStr = StringTable.Get("str_n20_hour", hour)
    end
    local minus = math.floor(seconds / 60)
    if minus then
      timeStr = timeStr .. StringTable.Get("str_n20_minus", minus)
    end
  else
    timeStr = StringTable.Get("str_n20_less_one_minus")
  end
  return timeStr
end
