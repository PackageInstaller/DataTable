_class("UIActivityN26Const", Object)
UIActivityN26Const = UIActivityN26Const

function UIActivityN26Const:Constructor()
end

function UIActivityN26Const:LoadData(TT, res)
  self._timeModule = GameGlobal.GetModule(SvrTimeModule)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N26, ECampaignN26ComponentID.ECAMPAIGN_N26_CUMULATIVE_LOGIN, ECampaignN26ComponentID.ECAMPAIGN_N26_FIRST_MEET, ECampaignN26ComponentID.ECAMPAIGN_N26_POWER2ITEM, ECampaignN26ComponentID.ECAMPAIGN_N26_LINE_MISSION, ECampaignN26ComponentID.ECAMPAIGN_N26_DIFFICULT_MISSION, ECampaignN26ComponentID.ECAMPAIGN_N26_SHOP, ECampaignN26ComponentID.ECAMPAIGN_N26_NEWYEQR_DINNER)
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
  self._cumulativeLoginComponent = self._localProcess:GetComponent(ECampaignN26ComponentID.ECAMPAIGN_N26_CUMULATIVE_LOGIN)
  self._cumulativeLoginComponentInfo = self._localProcess:GetComponentInfo(ECampaignN26ComponentID.ECAMPAIGN_N26_CUMULATIVE_LOGIN)
  self._fixTeamComponent = self._localProcess:GetComponent(ECampaignN26ComponentID.ECAMPAIGN_N26_FIRST_MEET)
  self._fixTeamCompInfo = self._localProcess:GetComponentInfo(ECampaignN26ComponentID.ECAMPAIGN_N26_FIRST_MEET)
  self._power2itemComponent = self._localProcess:GetComponent(ECampaignN26ComponentID.ECAMPAIGN_N26_POWER2ITEM)
  self._power2itemComponentInfo = self._localProcess:GetComponentInfo(ECampaignN26ComponentID.ECAMPAIGN_N26_POWER2ITEM)
  self._normalLineMissionComponent = self._localProcess:GetComponent(ECampaignN26ComponentID.ECAMPAIGN_N26_LINE_MISSION)
  self._normalLineMissionompInfo = self._localProcess:GetComponentInfo(ECampaignN26ComponentID.ECAMPAIGN_N26_LINE_MISSION)
  self._hardLineMissionComponent = self._localProcess:GetComponent(ECampaignN26ComponentID.ECAMPAIGN_N26_DIFFICULT_MISSION)
  self._hardLineMissionompInfo = self._localProcess:GetComponentInfo(ECampaignN26ComponentID.ECAMPAIGN_N26_DIFFICULT_MISSION)
  self._exchangeItemComponent = self._localProcess:GetComponent(ECampaignN26ComponentID.ECAMPAIGN_N26_SHOP)
  self._exchangeItemComponentInfo = self._localProcess:GetComponentInfo(ECampaignN26ComponentID.ECAMPAIGN_N26_SHOP)
  self._newyearDinnerComponent = self._localProcess:GetComponent(ECampaignN26ComponentID.ECAMPAIGN_N26_NEWYEQR_DINNER)
  self._newyearDinnerCompInfo = self._localProcess:GetComponentInfo(ECampaignN26ComponentID.ECAMPAIGN_N26_NEWYEQR_DINNER)
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
  if nowTime > self._activeEndTime then
    Log.error("Time error!")
    return
  end
end

function UIActivityN26Const:ForceUpdate(TT)
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
end

function UIActivityN26Const:GetCampaign()
  return self._campaign
end

function UIActivityN26Const:GetCampaignId()
  return self._campaign._id
end

function UIActivityN26Const:GetName()
  return self._name
end

function UIActivityN26Const:GetSubName()
  return self._subName
end

function UIActivityN26Const:GetActiveEndTime()
  return self._activeEndTime
end

function UIActivityN26Const:GetPlotId()
  return self._plotId
end

function UIActivityN26Const:CanPlayPlot()
  if self._plotId == nil then
    return false
  end
  if UIActivityN26Helper.GetNewFlagStatus("PLAY_N26_ACTIVITY_FIRST_ENTER_PLOT") then
    return true
  end
  return false
end

function UIActivityN26Const:SetPlayPlotStatus()
  if self._plotId == nil then
    return
  end
  UIActivityN26Helper.SetNewFlagStatus("PLAY_N26_ACTIVITY_FIRST_ENTER_PLOT", false)
end

function UIActivityN26Const:IsActivityEnd()
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

function UIActivityN26Const:GetLoginComponent()
  return self._cumulativeLoginComponent, self._cumulativeLoginComponentInfo
end

function UIActivityN26Const:GetTryPetComponent()
  return self._fixTeamComponent, self._fixTeamCompInfo
end

function UIActivityN26Const:GetPower2ItemComponent()
  return self._power2itemComponent, self._power2itemComponentInfo
end

function UIActivityN26Const:GetNormalLineMissionComponent()
  return self._normalLineMissionComponent, self._normalLineMissionompInfo
end

function UIActivityN26Const:GetHardLineMissionComponent()
  return self._hardLineMissionComponent, self._hardLineMissionompInfo
end

function UIActivityN26Const:GetShopComponent()
  return self._exchangeItemComponent, self._exchangeItemComponentInfo
end

function UIActivityN26Const:GetMiniGameComponent()
  return self._newyearDinnerComponent, self._newyearDinnerCompInfo
end

function UIActivityN26Const:GetLoginComponentStatus()
  if self:IsActivityEnd() then
    return ActivityComponentStatus.ActivityEnd, 0
  end
  return UIActivityN26Helper.CheckComponentStatus(self._cumulativeLoginComponent)
end

function UIActivityN26Const:GetTryPetComponentStatus()
  if self:IsActivityEnd() then
    return ActivityComponentStatus.ActivityEnd, 0
  end
  return UIActivityN26Helper.CheckComponentStatus(self._fixTeamComponent)
end

function UIActivityN26Const:GetPower2ItemComponentStatus()
  if self:IsActivityEnd() then
    return ActivityComponentStatus.ActivityEnd, 0
  end
  return UIActivityN26Helper.CheckComponentStatus(self._power2itemComponent)
end

function UIActivityN26Const:GetNormalLineMissionComponentStatus()
  if self:IsActivityEnd() then
    return ActivityComponentStatus.ActivityEnd, 0
  end
  return UIActivityN26Helper.CheckComponentStatus(self._normalLineMissionComponent)
end

function UIActivityN26Const:GetHardLineMissionComponentStatus()
  if self:IsActivityEnd() then
    return ActivityComponentStatus.ActivityEnd, 0
  end
  return UIActivityN26Helper.CheckComponentStatus(self._hardLineMissionComponent)
end

function UIActivityN26Const:GetShopComponentStatus()
  if self:IsActivityEnd() then
    return ActivityComponentStatus.ActivityEnd, 0
  end
  return UIActivityN26Helper.CheckComponentStatus(self._exchangeItemComponent)
end

function UIActivityN26Const:GetMovieComponentStatus()
  if self:IsActivityEnd() then
    return ActivityComponentStatus.ActivityEnd, 0
  end
  local nowTime = self._timeModule:GetServerTime() / 1000
  local seconds = math.floor(self._activeEndTime - nowTime)
  return ActivityComponentStatus.Open, seconds
end

function UIActivityN26Const:GetMiniGameComponentStatus()
  if self:IsActivityEnd() then
    return ActivityComponentStatus.ActivityEnd, 0
  end
  return UIActivityN26Helper.CheckComponentStatus(self._newyearDinnerComponent)
end

function UIActivityN26Const:IsShowEntryRed()
  if self:IsActivityEnd() then
    return false
  end
  if self:IsShowLoginRed() then
    return true
  end
  if self:IsShowBattlePassRed() then
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
  if self:IsShowMovieRed() then
    return true
  end
  if self:IsShowMiniGameRed() then
    return true
  end
  return false
end

function UIActivityN26Const:IsShowLoginRed()
  local status, time = self:GetLoginComponentStatus()
  if status ~= ActivityComponentStatus.Open then
    return false
  end
  return self._campaign:CheckComponentRed(ECampaignN26ComponentID.ECAMPAIGN_N26_CUMULATIVE_LOGIN)
end

function UIActivityN26Const:IsShowBattlePassRed()
  if self:IsActivityEnd() then
    return false
  end
  if self._battlepassCampaign then
    return UIActivityHelper.CheckCampaignSampleRedPoint(self._battlepassCampaign)
  end
  return false
end

function UIActivityN26Const:IsShowNormalLineRed()
  local status, time = self:GetNormalLineMissionComponentStatus()
  if status ~= ActivityComponentStatus.Open then
    return false
  end
  local red = false
  red = red or self._localProcess:LineMissionRedDot()
  red = red or self._localProcess:GetFixMissionRedDot()
  return red
end

function UIActivityN26Const:IsShowHardLineRed()
  local status, time = self:GetHardLineMissionComponentStatus()
  if status ~= ActivityComponentStatus.Open then
    return false
  end
  return self._localProcess:HardLineMissionRedDot()
end

function UIActivityN26Const:IsShowShopRed()
  local status, time = self:GetShopComponentStatus()
  if status ~= ActivityComponentStatus.Open then
    return false
  end
  return self._campaign:CheckComponentRed(ECampaignN26ComponentID.ECAMPAIGN_N26_SHOP)
end

function UIActivityN26Const:IsShowMovieRed()
  local status, time = self:GetMovieComponentStatus()
  if status ~= ActivityComponentStatus.Open then
    return false
  end
  return UIActivityN26Helper.ShowOrNot()
end

function UIActivityN26Const:IsShowMiniGameRed()
  local status, time = self:GetMiniGameComponentStatus()
  if status ~= ActivityComponentStatus.Open then
    return false
  end
  return UIN26CookData.CheckRed_MatRequire(self._newyearDinnerCompInfo) or UIN26CookData.CheckRed_Collect(self._newyearDinnerCompInfo) or UIN26CookData.CheckRed_CookBook(self._newyearDinnerCompInfo)
end

function UIActivityN26Const:IsShowEntryNew()
  local enterNew = UIActivityN26Helper.GetNewFlagStatus("PLAY_N26_ACTIVITY_ENTER_NEW")
  if enterNew then
    return true
  end
  if self:IsShowNormalLineNew() then
    return true
  end
  if self:IsShowHardLineNew() then
    return true
  end
  if self:IsShowMovieNew() then
    return true
  end
  if self:IsShowShopNew() then
    return true
  end
  if self:IsShowMiniGameNew() then
    return true
  end
  return false
end

function UIActivityN26Const:ClearEnterNew()
  UIActivityN26Helper.SetNewFlagStatus("PLAY_N26_ACTIVITY_ENTER_NEW", false)
end

function UIActivityN26Const:IsShowNormalLineNew()
  local status, time = self:GetNormalLineMissionComponentStatus()
  if status ~= ActivityComponentStatus.Open then
    return false
  end
  return UIActivityN26Helper.GetNewFlagStatus("PLAY_N26_ACTIVITY_NORMAL_LINE_NEW")
end

function UIActivityN26Const:ClearNormalLineNew()
  UIActivityN26Helper.SetNewFlagStatus("PLAY_N26_ACTIVITY_NORMAL_LINE_NEW", false)
end

function UIActivityN26Const:IsShowHardLineNew()
  local status, time = self:GetHardLineMissionComponentStatus()
  if status ~= ActivityComponentStatus.Open then
    return false
  end
  return UIActivityN26Helper.GetNewFlagStatus("PLAY_N26_ACTIVITY_HARD_LINE_NEW")
end

function UIActivityN26Const:ClearHardLineNew()
  UIActivityN26Helper.SetNewFlagStatus("PLAY_N26_ACTIVITY_HARD_LINE_NEW", false)
end

function UIActivityN26Const:IsShowShopNew()
  local status, time = self:GetShopComponentStatus()
  if status ~= ActivityComponentStatus.Open then
    return false
  end
  return UIActivityN26Helper.GetNewFlagStatus("PLAY_N26_ACTIVITY_SHOP_NEW")
end

function UIActivityN26Const:ClearShopNew()
  UIActivityN26Helper.SetNewFlagStatus("PLAY_N26_ACTIVITY_SHOP_NEW", false)
end

function UIActivityN26Const:IsShowMovieNew()
  local status, time = self:GetMovieComponentStatus()
  if status ~= ActivityComponentStatus.Open then
    return false
  end
  return UIActivityN26Helper.GetNewFlagStatus("PLAY_N26_ACTIVITY_MOVIE_NEW")
end

function UIActivityN26Const:ClearMovieNew()
  UIActivityN26Helper.SetNewFlagStatus("PLAY_N26_ACTIVITY_MOVIE_NEW", false)
end

function UIActivityN26Const:IsShowMiniGameNew()
  local status, time = self:GetMiniGameComponentStatus()
  if status ~= ActivityComponentStatus.Open then
    return false
  end
  return UIActivityN26Helper.GetNewFlagStatus("PLAY_N26_ACTIVITY_MINGAME_NEW") or UIN26CookData.CheckNew_CookBook(self._newyearDinnerCompInfo)
end

function UIActivityN26Const:ClearMiniGameNew()
  UIActivityN26Helper.SetNewFlagStatus("PLAY_N26_ACTIVITY_MINGAME_NEW", false)
end
