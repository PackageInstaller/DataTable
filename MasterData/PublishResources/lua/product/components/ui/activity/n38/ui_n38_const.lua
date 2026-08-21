_class("UIN38Const", Object)
UIN38Const = UIN38Const

function UIN38Const:Constructor()
end

function UIN38Const:LoadData(TT, res)
  self._timeModule = GameGlobal.GetModule(SvrTimeModule)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_INLAND_N9, ECampaignCN9ComponentID.ECAMPAIGN_N9_CUMULATIVE_LOGIN, ECampaignCN9ComponentID.ECAMPAIGN_N9_POWER2ITEM, ECampaignCN9ComponentID.ECAMPAIGN_N9_LINE_MISSION, ECampaignCN9ComponentID.ECAMPAIGN_N9_DIFFICULT_MISSION, ECampaignCN9ComponentID.ECAMPAIGN_N9_SHOP, ECampaignCN9ComponentID.ECAMPAIGN_N9_SHARED, ECampaignCN9ComponentID.ECAMPAIGN_N9_HEIXIA)
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
  self._cumulativeLoginComponent = self._localProcess:GetComponent(ECampaignCN9ComponentID.ECAMPAIGN_N9_CUMULATIVE_LOGIN)
  self._cumulativeLoginComponentInfo = self._localProcess:GetComponentInfo(ECampaignCN9ComponentID.ECAMPAIGN_N9_CUMULATIVE_LOGIN)
  self._power2itemComponent = self._localProcess:GetComponent(ECampaignCN9ComponentID.ECAMPAIGN_N9_POWER2ITEM)
  self._power2itemComponentInfo = self._localProcess:GetComponentInfo(ECampaignCN9ComponentID.ECAMPAIGN_N9_POWER2ITEM)
  self._normalLineMissionComponent = self._localProcess:GetComponent(ECampaignCN9ComponentID.ECAMPAIGN_N9_LINE_MISSION)
  self._normalLineMissionompInfo = self._localProcess:GetComponentInfo(ECampaignCN9ComponentID.ECAMPAIGN_N9_LINE_MISSION)
  self._hardLineMissionComponent = self._localProcess:GetComponent(ECampaignCN9ComponentID.ECAMPAIGN_N9_DIFFICULT_MISSION)
  self._hardLineMissionompInfo = self._localProcess:GetComponentInfo(ECampaignCN9ComponentID.ECAMPAIGN_N9_DIFFICULT_MISSION)
  self._exchangeItemComponent = self._localProcess:GetComponent(ECampaignCN9ComponentID.ECAMPAIGN_N9_SHOP)
  self._exchangeItemComponentInfo = self._localProcess:GetComponentInfo(ECampaignCN9ComponentID.ECAMPAIGN_N9_SHOP)
  self._diffcultyMissionComponent = self._localProcess:GetComponent(ECampaignCN9ComponentID.ECAMPAIGN_N9_HEIXIA)
  self._difficultyMissionCompInfo = self._localProcess:GetComponentInfo(ECampaignCN9ComponentID.ECAMPAIGN_N9_HEIXIA)
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

function UIN38Const:ForceUpdate(TT)
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
end

function UIN38Const:GetCampaign()
  return self._campaign
end

function UIN38Const:GetCampaignId()
  return self._campaign._id
end

function UIN38Const:GetName()
  return self._name
end

function UIN38Const:GetSubName()
  return self._subName
end

function UIN38Const:GetActiveEndTime()
  return self._activeEndTime
end

function UIN38Const:GetPlotId()
  return self._plotId
end

function UIN38Const:CanPlayPlot()
  if self._plotId == nil then
    return false
  end
  if UIN38Helper.GetNewFlagStatus("PLAY_N38_ACTIVITY_FIRST_ENTER_PLOT") then
    return true
  end
  return false
end

function UIN38Const:SetPlayPlotStatus()
  if self._plotId == nil then
    return
  end
  UIN38Helper.SetNewFlagStatus("PLAY_N38_ACTIVITY_FIRST_ENTER_PLOT", false)
end

function UIN38Const:IsActivityEnd()
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

function UIN38Const:GetLoginComponent()
  return self._cumulativeLoginComponent, self._cumulativeLoginComponentInfo
end

function UIN38Const:GetPower2ItemComponent()
  return self._power2itemComponent, self._power2itemComponentInfo
end

function UIN38Const:GetNormalLineMissionComponent()
  return self._normalLineMissionComponent, self._normalLineMissionompInfo
end

function UIN38Const:GetHardLineMissionComponent()
  return self._hardLineMissionComponent, self._hardLineMissionompInfo
end

function UIN38Const:GetShopComponent()
  return self._exchangeItemComponent, self._exchangeItemComponentInfo
end

function UIN38Const:GetLoginComponentStatus()
  if self:IsActivityEnd() then
    return ActivityComponentStatus.ActivityEnd, 0
  end
  return UIN38Helper.CheckComponentStatus(self._cumulativeLoginComponent)
end

function UIN38Const:GetTryPetComponentStatus()
  if self:IsActivityEnd() then
    return ActivityComponentStatus.ActivityEnd, 0
  end
  return UIN38Helper.CheckComponentStatus(self._fixTeamComponent)
end

function UIN38Const:GetPower2ItemComponentStatus()
  if self:IsActivityEnd() then
    return ActivityComponentStatus.ActivityEnd, 0
  end
  return UIN38Helper.CheckComponentStatus(self._power2itemComponent)
end

function UIN38Const:GetNormalLineMissionComponentStatus()
  if self:IsActivityEnd() then
    return ActivityComponentStatus.ActivityEnd, 0
  end
  return UIN38Helper.CheckComponentStatus(self._normalLineMissionComponent)
end

function UIN38Const:GetHardLineMissionComponentStatus()
  if self:IsActivityEnd() then
    return ActivityComponentStatus.ActivityEnd, 0
  end
  return UIN38Helper.CheckComponentStatus(self._hardLineMissionComponent)
end

function UIN38Const:GetBlackMissionComponentStatus()
  if self:IsActivityEnd() then
    return ActivityComponentStatus.ActivityEnd, 0
  end
  return UIN38Helper.CheckComponentStatus(self._diffcultyMissionComponent)
end

function UIN38Const:GetShopComponentStatus()
  if self:IsActivityEnd() then
    return ActivityComponentStatus.ActivityEnd, 0
  end
  return UIN38Helper.CheckComponentStatus(self._exchangeItemComponent)
end

function UIN38Const:IsShowEntryRed()
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
  if self:IsShowBlackRed() then
    return true
  end
  if self:IsShowShopRed() then
    return true
  end
  return false
end

function UIN38Const:IsShowLoginRed()
  local status, time = self:GetLoginComponentStatus()
  if status ~= ActivityComponentStatus.Open then
    return false
  end
  return self._campaign:CheckComponentRed(ECampaignCN9ComponentID.ECAMPAIGN_N9_CUMULATIVE_LOGIN)
end

function UIN38Const:IsShowBattlePassRed()
  if self:IsActivityEnd() then
    return false
  end
  if self._battlepassCampaign then
    return UIActivityHelper.CheckCampaignSampleRedPoint(self._battlepassCampaign)
  end
  return false
end

function UIN38Const:IsShowNormalLineRed()
  local status, time = self:GetNormalLineMissionComponentStatus()
  if status ~= ActivityComponentStatus.Open then
    return false
  end
  return self._localProcess and self._localProcess:LineMissionRedDot() and UIN38Helper.IsFirstTimeEnterToday("UIN38Helper_EnterTime_")
end

function UIN38Const:IsShowHardLineRed()
  local status, time = self:GetHardLineMissionComponentStatus()
  if status ~= ActivityComponentStatus.Open then
    return false
  end
  return self._localProcess and self._localProcess:HardLineMissionRedDot() and UIN38Helper.IsFirstTimeEnterToday("UIN38Helper_EnterTime_Hard")
end

function UIN38Const:IsShowBlackRed()
  local status, time = self:GetBlackMissionComponentStatus()
  if status ~= ActivityComponentStatus.Open then
    return false
  end
  return self._localProcess and self._localProcess:DifficultyMissionRedDot()
end

function UIN38Const:IsShowShopRed()
  local status, time = self:GetShopComponentStatus()
  if status ~= ActivityComponentStatus.Open then
    return false
  end
  return self._campaign:CheckComponentRed(ECampaignCN9ComponentID.ECAMPAIGN_N9_SHOP)
end

function UIN38Const:IsShowEntryNew()
  local enterNew = UIN38Helper.GetNewFlagStatus("PLAY_N38_ACTIVITY_ENTER_NEW")
  if enterNew then
    return true
  end
  if not UIN38Helper.LocalDB_Has("LoginBtn", "New") then
    return true
  end
  if self:IsShowNormalLineNew() then
    return true
  end
  if self:IsShowHardLineNew() then
    return true
  end
  if self:IsShowBlackNew() then
    return true
  end
  if self:IsShowShopNew() then
    return true
  end
  return false
end

function UIN38Const:ClearEnterNew()
  UIN38Helper.SetNewFlagStatus("PLAY_N38_ACTIVITY_ENTER_NEW", false)
end

function UIN38Const:IsShowNormalLineNew()
  local status, time = self:GetNormalLineMissionComponentStatus()
  if status ~= ActivityComponentStatus.Open then
    return false
  end
  return UIN38Helper.GetNewFlagStatus("PLAY_N38_ACTIVITY_NORMAL_LINE_NEW")
end

function UIN38Const:ClearNormalLineNew()
  UIN38Helper.SetNewFlagStatus("PLAY_N38_ACTIVITY_NORMAL_LINE_NEW", false)
end

function UIN38Const:IsShowHardLineNew()
  local status, time = self:GetHardLineMissionComponentStatus()
  if status ~= ActivityComponentStatus.Open then
    return false
  end
  return UIN38Helper.GetNewFlagStatus("PLAY_N38_ACTIVITY_HARD_LINE_NEW")
end

function UIN38Const:ClearHardLineNew()
  UIN38Helper.SetNewFlagStatus("PLAY_N38_ACTIVITY_HARD_LINE_NEW", false)
end

function UIN38Const:IsShowBlackNew()
  local status, time = self:GetBlackMissionComponentStatus()
  if status ~= ActivityComponentStatus.Open then
    return false
  end
  return UIN38Helper.GetNewFlagStatus("PLAY_N38_ACTIVITY_BLACK_NEW")
end

function UIN38Const:ClearBlackNew()
  UIN38Helper.SetNewFlagStatus("PLAY_N38_ACTIVITY_BLACK_NEW", false)
end

function UIN38Const:IsShowShopNew()
  local status, time = self:GetShopComponentStatus()
  if status ~= ActivityComponentStatus.Open then
    return false
  end
  return UIN38Helper.GetNewFlagStatus("PLAY_N38_ACTIVITY_SHOP_NEW")
end

function UIN38Const:ClearShopNew()
  UIN38Helper.SetNewFlagStatus("PLAY_N38_ACTIVITY_SHOP_NEW", false)
end
