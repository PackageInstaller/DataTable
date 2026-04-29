_class("CCampaignN15", ICampaignComponentLocalProcessBase)
CCampaignN15 = CCampaignN15

function CCampaignN15:Constructor()
  self._cumulativeLoginComponent = nil
  self._cumulativeLoginCompInfo = nil
  self._levelCommonComponet = nil
  self._levelCommonCompInfo = nil
  self._fixTeamComponent = nil
  self._fixTeamCompInfo = nil
  self._power2itemComponent = nil
  self._power2itemComponentInfo = nil
  self._lotteryComponent = nil
  self._lotteryCompInfo = nil
  self._campaignObj = nil
end

function CCampaignN15:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_N15
end

function CCampaignN15:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignN15:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetCumulativeLoginComponent()
  self:_GetLevelCommonComponent()
  self:_GetFixTeamComponent()
  self:_GetPower2itemComponent()
  self:_GetLotteryComponent()
end

function CCampaignN15:_GetCumulativeLoginComponent()
  self._cumulativeLoginComponent = self._campaignObj:GetComponent(ECampaignN15ComponentID.ECAMPAIGN_N15_CUMULATIVE_LOGIN)
  if not self._cumulativeLoginComponent then
    return
  end
  self._cumulativeLoginCompInfo = self._cumulativeLoginComponent:ComponentInfo()
end

function CCampaignN15:_GetLevelCommonComponent()
  self._levelCommonComponet = self._campaignObj:GetComponent(ECampaignN15ComponentID.ECAMPAIGN_N15_LEVEL_COMMON)
  if not self._levelCommonComponet then
    return
  end
  self._levelCommonCompInfo = self._levelCommonComponet:ComponentInfo()
end

function CCampaignN15:_GetFixTeamComponent()
  self._fixTeamComponent = self._campaignObj:GetComponent(ECampaignN15ComponentID.ECAMPAIGN_N15_LEVEL_FIXTEAM)
  if not self._fixTeamComponent then
    return
  end
  self._fixTeamCompInfo = self._fixTeamComponent:ComponentInfo()
end

function CCampaignN15:_GetPower2itemComponent()
  self._power2itemComponent = self._campaignObj:GetComponent(ECampaignN15ComponentID.ECAMPAIGN_N15_POWER2ITEM)
  if not self._power2itemComponent then
    return
  end
  self._power2itemComponentInfo = self._power2itemComponent:ComponentInfo()
end

function CCampaignN15:_GetLotteryComponent()
  self._lotteryComponent = self._campaignObj:GetComponent(ECampaignN15ComponentID.ECAMPAIGN_N15_LOTTERY)
  if not self._lotteryComponent then
    return
  end
  self._lotteryCompInfo = self._lotteryComponent:ComponentInfo()
end

function CCampaignN15:GetComponent(componentID)
  if ECampaignN15ComponentID.ECAMPAIGN_N15_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponent
  end
  if ECampaignN15ComponentID.ECAMPAIGN_N15_LEVEL_COMMON == componentID then
    return self._levelCommonComponet
  end
  if ECampaignN15ComponentID.ECAMPAIGN_N15_LEVEL_FIXTEAM == componentID then
    return self._fixTeamComponent
  end
  if ECampaignN15ComponentID.ECAMPAIGN_N15_POWER2ITEM == componentID then
    return self._power2itemComponent
  end
  if ECampaignN15ComponentID.ECAMPAIGN_N15_LOTTERY == componentID then
    return self._lotteryComponent
  end
  return nil
end

function CCampaignN15:GetComponentInfo(componentID)
  if ECampaignN15ComponentID.ECAMPAIGN_N15_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginCompInfo
  end
  if ECampaignN15ComponentID.ECAMPAIGN_N15_LEVEL_COMMON == componentID then
    return self._levelCommonCompInfo
  end
  if ECampaignN15ComponentID.ECAMPAIGN_N15_LEVEL_FIXTEAM == componentID then
    return self._fixTeamCompInfo
  end
  if ECampaignN15ComponentID.ECAMPAIGN_N15_POWER2ITEM == componentID then
    return self._power2itemComponentInfo
  end
  if ECampaignN15ComponentID.ECAMPAIGN_N15_LOTTERY == componentID then
    return self._lotteryCompInfo
  end
  return nil
end

function CCampaignN15:GetStepStatusNew()
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local sample = campaignModule:GetSampleByType(ECampaignType.CAMPAIGN_TYPE_N15)
  return sample and sample:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_NEW)
end

function CCampaignN15:GetLottleryNew()
  if not self._lotteryComponent:ComponentIsOpen() then
    return false
  end
  local dbStr = N15ToolFunctions.GetLottleryNewName()
  local hadSave = not LocalDB.HasKey(dbStr)
  return hadSave
end

function CCampaignN15:GetEntryRedDot()
  return self:GetFixMissionRedDot() or self:GetLoginAwardRedDot() or self:GetLottleryRedDot()
end

function CCampaignN15:GetLottleryRedDot()
  local jackpots_info, lottery_times = self._lotteryComponent:RandEventInfo()
  local poltRedFlag = false
  for _, v in pairs(jackpots_info) do
    if v.is_unlock then
      local dbStr = N15ToolFunctions.GetLocalPoltNewName(v.event_id)
      if v.is_unlock and not LocalDB.HasKey(dbStr) then
        poltRedFlag = true
      end
    end
  end
  local remain_count = 0
  for idx, v in pairs(self._lotteryCompInfo.m_jackpots) do
    local rest, total = self._lotteryComponent:GetLotteryCount(idx)
    if rest ~= 0 and table.icontains(self._lotteryCompInfo.m_unlock_jackpots, idx) then
      remain_count = rest
    end
  end
  if self._lotteryCompInfo and self._lotteryComponent:ComponentIsOpen() then
    local costCount = self._lotteryCompInfo.m_cost_count * self._lotteryCompInfo.m_multi_lottery
    local singleCost = self._lotteryCompInfo.m_cost_count
    local curCount = ClientCampaignDrawShop.GetMoney(self._lotteryCompInfo.m_cost_item_id)
    return remain_count ~= 0 and singleCost <= curCount or poltRedFlag
  end
  return false
end

function CCampaignN15:GetPoltRedDot()
  local jackpots_info, lottery_times = self._lotteryComponent:RandEventInfo()
  local poltRedFlag = false
  for _, v in pairs(jackpots_info) do
    if v.is_unlock then
      local dbStr = N15ToolFunctions.GetLocalPoltNewName(v.event_id)
      if v.is_unlock and not LocalDB.HasKey(dbStr) then
        poltRedFlag = true
      end
    end
  end
  return poltRedFlag
end

function CCampaignN15:GetLoginAwardRedDot()
  if not self._cumulativeLoginComponent:ComponentIsOpen() then
    return false
  end
  local info = self._cumulativeLoginCompInfo.m_cumulative_info
  for k, v in pairs(info) do
    if v.m_reward_status == ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_CAN_RECV then
      return true
    end
  end
  return false
end

function CCampaignN15:GetEasyMissionRedDot()
  return true
end

function CCampaignN15:GetFixMissionRedDot()
  if not (self._fixTeamComponent and self._fixTeamCompInfo) or not self._fixTeamComponent:ComponentIsOpen() then
    return false
  end
  local cfgs = Cfg.cfg_campaign_pet_try({
    CampaignId = ECampaignType.CAMPAIGN_TYPE_N15
  })
  local lock = false
  if cfgs then
    for key, value in pairs(cfgs) do
      if not self._fixTeamComponent:IsPassCamMissionID(value.CampaignMissionId) then
        lock = true
        break
      end
    end
  end
  return self._fixTeamCompInfo.m_b_unlock and lock
end
