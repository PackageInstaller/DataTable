_class("UIActivityN28Const", Object)
UIActivityN28Const = UIActivityN28Const

function UIActivityN28Const:Constructor()
  self.dataAVG = nil
end

function UIActivityN28Const:LoadData(TT, res)
  self._timeModule = GameGlobal.GetModule(SvrTimeModule)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  self.dataAVG = campaignModule:GetN28AVGData()
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N42, ECampaignN28ComponentID.ECAMPAIGN_N28_CUMULATIVE_LOGIN, ECampaignN28ComponentID.ECAMPAIGN_N28_AVG_PHASE_2, ECampaignN28ComponentID.ECAMPAIGN_N28_POWER2ITEM, ECampaignN28ComponentID.ECAMPAIGN_N28_LINE_MISSION, ECampaignN28ComponentID.ECAMPAIGN_N28_DIFFICULT_MISSION, ECampaignN28ComponentID.ECAMPAIGN_N28_FIRST_MEET, ECampaignN28ComponentID.ECAMPAIGN_N28_SHOP)
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
  self._cumulativeLoginComponent = self._localProcess:GetComponent(ECampaignN28ComponentID.ECAMPAIGN_N28_CUMULATIVE_LOGIN)
  self._cumulativeLoginComponentInfo = self._localProcess:GetComponentInfo(ECampaignN28ComponentID.ECAMPAIGN_N28_CUMULATIVE_LOGIN)
  self._fixTeamComponent = self._localProcess:GetComponent(ECampaignN28ComponentID.ECAMPAIGN_N28_FIRST_MEET)
  self._fixTeamCompInfo = self._localProcess:GetComponentInfo(ECampaignN28ComponentID.ECAMPAIGN_N28_FIRST_MEET)
  self._power2itemComponent = self._localProcess:GetComponent(ECampaignN28ComponentID.ECAMPAIGN_N28_POWER2ITEM)
  self._power2itemComponentInfo = self._localProcess:GetComponentInfo(ECampaignN28ComponentID.ECAMPAIGN_N28_POWER2ITEM)
  self._normalLineMissionComponent = self._localProcess:GetComponent(ECampaignN28ComponentID.ECAMPAIGN_N28_LINE_MISSION)
  self._normalLineMissionompInfo = self._localProcess:GetComponentInfo(ECampaignN28ComponentID.ECAMPAIGN_N28_LINE_MISSION)
  self._hardLineMissionComponent = self._localProcess:GetComponent(ECampaignN28ComponentID.ECAMPAIGN_N28_DIFFICULT_MISSION)
  self._hardLineMissionompInfo = self._localProcess:GetComponentInfo(ECampaignN28ComponentID.ECAMPAIGN_N28_DIFFICULT_MISSION)
  self._exchangeItemComponent = self._localProcess:GetComponent(ECampaignN28ComponentID.ECAMPAIGN_N28_SHOP)
  self._exchangeItemComponentInfo = self._localProcess:GetComponentInfo(ECampaignN28ComponentID.ECAMPAIGN_N28_SHOP)
  self._N28AVGPHASE2Component = self._localProcess:GetComponent(ECampaignN28ComponentID.ECAMPAIGN_N28_AVG_PHASE_2)
  self._N28AVGPHASE2CompInfo = self._localProcess:GetComponentInfo(ECampaignN28ComponentID.ECAMPAIGN_N28_AVG_PHASE_2)
  local cfg_campaign = Cfg.cfg_campaign[self._campaign._id]
  self._name = StringTable.Get(cfg_campaign.CampaignName)
  self._subName = StringTable.Get(cfg_campaign.CampaignSubtitle)
  local plotIdList = cfg_campaign.FirstEnterStoryID
  self._plotId = nil
  if plotIdList and 0 < #plotIdList then
    self._plotId = plotIdList[1]
  end
  local sample = self._campaign:GetSample()
  if not sample then
    return
  end
  local nowTime = self._timeModule:GetServerTime() / 1000
  self._activeEndTime = sample.end_time
  if nowTime > sample.end_time then
    Log.error("Time error!")
    return
  end
  self.dataAVG:RequestCampaign(TT)
  self.dataAVG:Init()
  self.dataAVG:Update()
end

function UIActivityN28Const:ForceUpdate(TT)
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
end

function UIActivityN28Const:GetCampaign()
  return self._campaign
end

function UIActivityN28Const:GetCampaignId()
  return self._campaign._id
end

function UIActivityN28Const:GetName()
  return self._name
end

function UIActivityN28Const:GetSubName()
  return self._subName
end

function UIActivityN28Const:GetActiveEndTime()
  return self._activeEndTime
end

function UIActivityN28Const:GetPlotId()
  return self._plotId
end

function UIActivityN28Const:CanPlayPlot()
  if self._plotId == nil then
    return false
  end
  if UIActivityN28Helper.GetNewFlagStatus("PLAY_N28_ACTIVITY_FIRST_ENTER_PLOT") then
    return true
  end
  return false
end

function UIActivityN28Const:SetPlayPlotStatus()
  if self._plotId == nil then
    return
  end
  UIActivityN28Helper.SetNewFlagStatus("PLAY_N28_ACTIVITY_FIRST_ENTER_PLOT", false)
end

function UIActivityN28Const:IsActivityEnd()
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

function UIActivityN28Const:GetLoginComponent()
  return self._cumulativeLoginComponent, self._cumulativeLoginComponentInfo
end

function UIActivityN28Const:GetTryPetComponent()
  return self._fixTeamComponent, self._fixTeamCompInfo
end

function UIActivityN28Const:GetPower2ItemComponent()
  return self._power2itemComponent, self._power2itemComponentInfo
end

function UIActivityN28Const:GetNormalLineMissionComponent()
  return self._normalLineMissionComponent, self._normalLineMissionompInfo
end

function UIActivityN28Const:GetHardLineMissionComponent()
  return self._hardLineMissionComponent, self._hardLineMissionompInfo
end

function UIActivityN28Const:GetShopComponent()
  return self._exchangeItemComponent, self._exchangeItemComponentInfo
end

function UIActivityN28Const:GetAVGGameComponent()
  return self._N28AVGPHASE2Component, self._N28AVGPHASE2CompInfo
end

function UIActivityN28Const:GetLoginComponentStatus()
  if self:IsActivityEnd() then
    return ActivityN28ComponentStatus.ActivityEnd, 0
  end
  return UIActivityN28Helper.CheckComponentStatus(self._cumulativeLoginComponent)
end

function UIActivityN28Const:GetTryPetComponentStatus()
  if self:IsActivityEnd() then
    return ActivityN28ComponentStatus.ActivityEnd, 0
  end
  return UIActivityN28Helper.CheckComponentStatus(self._fixTeamComponent)
end

function UIActivityN28Const:GetPower2ItemComponentStatus()
  if self:IsActivityEnd() then
    return ActivityN28ComponentStatus.ActivityEnd, 0
  end
  return UIActivityN28Helper.CheckComponentStatus(self._power2itemComponent)
end

function UIActivityN28Const:GetNormalLineMissionComponentStatus()
  if self:IsActivityEnd() then
    return ActivityN28ComponentStatus.ActivityEnd, 0
  end
  return UIActivityN28Helper.CheckComponentStatus(self._normalLineMissionComponent)
end

function UIActivityN28Const:GetHardLineMissionComponentStatus()
  if self:IsActivityEnd() then
    return ActivityN28ComponentStatus.ActivityEnd, 0
  end
  return UIActivityN28Helper.CheckComponentStatus(self._hardLineMissionComponent)
end

function UIActivityN28Const:EnterGetHardLineMissionComponentStatus()
  if self:IsActivityEnd() then
    return ActivityN28ComponentStatus.ActivityEnd, 0
  end
  return UIActivityN28Helper.CheckHard(self._hardLineMissionComponent)
end

function UIActivityN28Const:GetShopComponentStatus()
  if self:IsActivityEnd() then
    return ActivityN28ComponentStatus.ActivityEnd, 0
  end
  return UIActivityN28Helper.CheckComponentStatus(self._exchangeItemComponent)
end

function UIActivityN28Const:GetAVGGameComponentStatus()
  if self:IsActivityEnd() then
    return ActivityN28ComponentStatus.ActivityEnd, 0
  end
  return UIActivityN28Helper.CheckComponentStatus(self._N28AVGPHASE2Component)
end

function UIActivityN28Const:IsShowEntryRed()
  if self:IsActivityEnd() then
    return false
  end
  if self:IsShowLoginRed() then
    return true
  end
  if self:IsShowNormalLineRed() then
    return true
  end
  if self:IsShowHardLineRed() then
    return true
  end
  if self:IsShowShopRed() then
    return true
  end
  if self:IsShowAVGGameRed() then
    return true
  end
  return false
end

function UIActivityN28Const:IsShowLoginRed()
  local status, time = self:GetLoginComponentStatus()
  if status ~= ActivityN28ComponentStatus.Open then
    return false
  end
  return self._campaign:CheckComponentRed(ECampaignN28ComponentID.ECAMPAIGN_N28_CUMULATIVE_LOGIN)
end

function UIActivityN28Const:IsShowBattlePassRed()
  if self:IsActivityEnd() then
    return false
  end
  if self._battlepassCampaign then
    return UIActivityHelper.CheckCampaignSampleRedPoint(self._battlepassCampaign)
  end
  return false
end

function UIActivityN28Const:IsShowNormalLineRed()
  local status, time = self:GetNormalLineMissionComponentStatus()
  if status ~= ActivityN28ComponentStatus.Open then
    return false
  end
  local red = false
  red = red or self._localProcess:LineMissionRedDot()
  local isCross = UIActivityN28Helper.LocalDB_Get_CrossDay("line", "Red")
  return red and isCross
end

function UIActivityN28Const:IsShowHardLineRed()
  local status, time = self:GetHardLineMissionComponentStatus()
  if status ~= ActivityN28ComponentStatus.Open then
    return false
  end
  local isCross = UIActivityN28Helper.LocalDB_Get_CrossDay("hard", "Red")
  local red = false
  red = red or self._localProcess:HardLineMissionRedDot()
  red = red or self._localProcess:GetFixMissionRedDot()
  return red and isCross
end

function UIActivityN28Const:IsShowShopRed()
  local status, time = self:GetShopComponentStatus()
  if status ~= ActivityN28ComponentStatus.Open then
    return false
  end
  return self._campaign:CheckComponentRed(ECampaignN28ComponentID.ECAMPAIGN_N28_SHOP)
end

function UIActivityN28Const:IsShowAVGGameRed()
  local status, time = self:GetAVGGameComponentStatus()
  if status ~= ActivityN28ComponentStatus.Open then
    return false
  end
  local avgRed = self.dataAVG:HasRed()
  return avgRed
end

function UIActivityN28Const:IsShowEntryNew()
  local enterNew = UIActivityN28Helper.GetNewFlagStatus("PLAY_N28_ACTIVITY_ENTER_NEW")
  if enterNew then
    return true
  end
  if self:IsShowNormalLineNew() then
    return true
  end
  if self:IsShowHardLineNew() then
    return true
  end
  if self:IsShowShopNew() then
    return true
  end
  if self:IsShowAVGGameNew() then
    return true
  end
  return false
end

function UIActivityN28Const:ClearEnterNew()
  UIActivityN28Helper.SetNewFlagStatus("PLAY_N28_ACTIVITY_ENTER_NEW", false)
end

function UIActivityN28Const:IsShowNormalLineNew()
  local status, time = self:GetNormalLineMissionComponentStatus()
  if status ~= ActivityN28ComponentStatus.Open then
    return false
  end
  return UIActivityN28Helper.GetNewFlagStatus("PLAY_N28_ACTIVITY_NORMAL_LINE_NEW")
end

function UIActivityN28Const:ClearNormalLineNew()
  UIActivityN28Helper.SetNewFlagStatus("PLAY_N28_ACTIVITY_NORMAL_LINE_NEW", false)
end

function UIActivityN28Const:IsShowHardLineNew()
  local status, time = self:GetHardLineMissionComponentStatus()
  if status ~= ActivityN28ComponentStatus.Open then
    return false
  end
  local status1, time1 = self:GetTryPetComponentStatus()
  if status1 == ActivityN28ComponentStatus.Open then
    return UIActivityN28Helper.GetNewFlagStatus("PLAY_N28_ACTIVITY_HARD_LINE2_NEW")
  end
  return UIActivityN28Helper.GetNewFlagStatus("PLAY_N28_ACTIVITY_HARD_LINE_NEW")
end

function UIActivityN28Const:ClearHardLineNew()
  UIActivityN28Helper.SetNewFlagStatus("PLAY_N28_ACTIVITY_HARD_LINE_NEW", false)
  local status, time = self:GetTryPetComponentStatus()
  if status == ActivityN28ComponentStatus.Open then
    UIActivityN28Helper.SetNewFlagStatus("PLAY_N28_ACTIVITY_HARD_LINE2_NEW", false)
  end
end

function UIActivityN28Const:IsShowShopNew()
  local status, time = self:GetShopComponentStatus()
  if status ~= ActivityN28ComponentStatus.Open then
    return false
  end
  return UIActivityN28Helper.GetNewFlagStatus("PLAY_N28_ACTIVITY_SHOP_NEW")
end

function UIActivityN28Const:ClearShopNew()
  UIActivityN28Helper.SetNewFlagStatus("PLAY_N28_ACTIVITY_SHOP_NEW", false)
end

function UIActivityN28Const:IsShowAVGGameNew()
  local status, time = self:GetAVGGameComponentStatus()
  if status ~= ActivityN28ComponentStatus.Open then
    return false
  end
  local newFlag = UIActivityN28Helper.GetNewFlagStatus("PLAY_N28_AVG_Game_NEW")
  local avgNew = self.dataAVG:HasNew()
  return newFlag or avgNew
end

function UIActivityN28Const:ClearAVGGameNew()
  UIActivityN28Helper.SetNewFlagStatus("PLAY_N28_AVG_Game_NEW", false)
end

function UIActivityN28Const:IsShowLoginNew()
  local status, time = self:GetLoginComponentStatus()
  if status ~= ActivityN28ComponentStatus.Open then
    return false
  end
  return UIActivityN28Helper.GetNewFlagStatus("PLAY_N28_ACTIVITY_LOGIN_NEW")
end

function UIActivityN28Const:ClearLoginNew()
  UIActivityN28Helper.SetNewFlagStatus("PLAY_N28_ACTIVITY_LOGIN_NEW", false)
end
