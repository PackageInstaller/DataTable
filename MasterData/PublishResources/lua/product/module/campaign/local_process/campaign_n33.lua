_class("CCampaignN33", ICampaignComponentLocalProcessBase)
CCampaignN33 = CCampaignN33

function CCampaignN33:Constructor()
  self._cumulativeLoginComponent = nil
  self._cumulativeLoginCompInfo = nil
  self._lineMissionComponent = nil
  self._lineMissionCompInfo = nil
  self._levelHardComponent = nil
  self._levelHardCompInfo = nil
  self._power2itemComponent = nil
  self._power2itemComponentInfo = nil
  self._lotteryComponent = nil
  self._lotteryCompInfo = nil
  self._simulationOperationComponent = nil
  self._simulationOperationComInfo = nil
  self._campaignObj = nil
end

function CCampaignN33:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_N33
end

function CCampaignN33:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignN33:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetCumulativeLoginComponent()
  self:_GetDifficultMissionComponent()
  self:_GetLineMissionComponent()
  self:_GetPower2ItemComponent()
  self:_GetLotteryComponent()
  self:_GetSimulationOperationComponent()
end

function CCampaignN33:_GetSimulationOperationComponent()
  self._simulationOperationComponent = self._campaignObj:GetComponent(ECampaignN33ComponentID.ECAMPAIGN_N33_SIMULATION_OPERATION)
  if not self._simulationOperationComponent then
    return
  end
  self._simulationOperationComInfo = self._simulationOperationComponent:ComponentInfo()
end

function CCampaignN33:_GetCumulativeLoginComponent()
  self._cumulativeLoginComponent = self._campaignObj:GetComponent(ECampaignN33ComponentID.ECAMPAIGN_N33_CUMULATIVE_LOGIN)
  if not self._cumulativeLoginComponent then
    return
  end
  self._cumulativeLoginComponentInfo = self._cumulativeLoginComponent:ComponentInfo()
end

function CCampaignN33:_GetDifficultMissionComponent()
  self._levelHardComponent = self._campaignObj:GetComponent(ECampaignN33ComponentID.ECAMPAIGN_N33_DIFFICULT_MISSION)
  if not self._levelHardComponent then
    return
  end
  self._levelHardCompInfo = self._levelHardComponent:ComponentInfo()
end

function CCampaignN33:_GetLineMissionComponent()
  self._lineMissionComponent = self._campaignObj:GetComponent(ECampaignN33ComponentID.ECAMPAIGN_N33_LINE_MISSION)
  if not self._lineMissionComponent then
    return
  end
  self._lineMissionCompInfo = self._lineMissionComponent:ComponentInfo()
end

function CCampaignN33:_GetPower2ItemComponent()
  self._power2itemComponent = self._campaignObj:GetComponent(ECampaignN33ComponentID.ECAMPAIGN_N33_POWER2ITEM)
  if not self._power2itemComponent then
    return
  end
  self._power2itemComponentInfo = self._power2itemComponent:ComponentInfo()
end

function CCampaignN33:_GetLotteryComponent()
  self._lotteryComponent = self._campaignObj:GetComponent(ECampaignN33ComponentID.ECAMPAIGN_N33_LOTTERY)
  if not self._lotteryComponent then
    return
  end
  self._lotteryCompInfo = self._lotteryComponent:ComponentInfo()
end

function CCampaignN33:GetComponent(componentID)
  if ECampaignN33ComponentID.ECAMPAIGN_N33_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponent
  end
  if ECampaignN33ComponentID.ECAMPAIGN_N33_DIFFICULT_MISSION == componentID then
    return self._levelHardComponent
  end
  if ECampaignN33ComponentID.ECAMPAIGN_N33_LINE_MISSION == componentID then
    return self._lineMissionComponent
  end
  if ECampaignN33ComponentID.ECAMPAIGN_N33_POWER2ITEM == componentID then
    return self._power2itemComponent
  end
  if ECampaignN33ComponentID.ECAMPAIGN_N33_LOTTERY == componentID then
    return self._lotteryComponent
  end
  if ECampaignN33ComponentID.ECAMPAIGN_N33_SIMULATION_OPERATION == componentID then
    return self._simulationOperationComponent
  end
  return nil
end

function CCampaignN33:GetComponentInfo(componentID)
  if ECampaignN33ComponentID.ECAMPAIGN_N33_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponentInfo
  end
  if ECampaignN33ComponentID.ECAMPAIGN_N33_DIFFICULT_MISSION == componentID then
    return self._levelHardCompInfo
  end
  if ECampaignN33ComponentID.ECAMPAIGN_N33_LINE_MISSION == componentID then
    return self._lineMissionCompInfo
  end
  if ECampaignN33ComponentID.ECAMPAIGN_N33_POWER2ITEM == componentID then
    return self._power2itemComponentInfo
  end
  if ECampaignN33ComponentID.ECAMPAIGN_N33_LOTTERY == componentID then
    return self._lotteryCompInfo
  end
  if ECampaignN33ComponentID.ECAMPAIGN_N33_SIMULATION_OPERATION == componentID then
    return self._simulationOperationComInfo
  end
  return nil
end

function CCampaignN33:GetEntryNew()
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local sample = campaignModule:GetSampleByType(ECampaignType.CAMPAIGN_TYPE_N33)
  return sample and sample:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_NEW)
end

function CCampaignN33:GetEntryRedDot()
  return self:HardLineMissionRedDot() or self:AccumulateLoginReddot() or self:LineMissionRedDot() or self:LotteryShopReddot() or self:SimulationOperationReddot()
end

function CCampaignN33:SimulationOperationReddot()
  return self._simulationOperationComponent and self._cumulativeLoginComponent:HaveRedPoint()
end

function CCampaignN33:AccumulateLoginReddot()
  return self._cumulativeLoginComponent and self._cumulativeLoginComponent:HaveRedPoint()
end

function CCampaignN33:BattlePassRedPoint(battlePassCampaign)
  return UIActivityBattlePassHelper.CheckCampaignRedPoint(battlePassCampaign)
end

function CCampaignN33:HardLineMissionRedDot()
  if not self._levelHardComponent:ComponentIsOpen() then
    return false
  end
  return self._levelHardComponent:HaveRedPoint()
end

function CCampaignN33:LineMissionRedDot()
  if not self._lineMissionComponent:ComponentIsOpen() then
    return false
  end
  return self._lineMissionComponent:HaveRedPoint()
end

function CCampaignN33:LotteryShopReddot()
  if self._lotteryCompInfo and self._lotteryComponent:ComponentIsOpen() then
    local costCount = self._lotteryCompInfo.m_cost_count * self._lotteryCompInfo.m_multi_lottery
    local curCount = ClientCampaignDrawShop.GetMoney(self._lotteryCompInfo.m_cost_item_id)
    return costCount <= curCount and self:_JackPotCanLottery()
  end
  return false
end

function CCampaignN33:_JackPotCanLottery()
  if self._lotteryCompInfo then
    for key, value in pairs(self._lotteryCompInfo.m_unlock_jackpots) do
      local remainCount = 0
      local jackpots = self._lotteryCompInfo.m_jackpots[value]
      if jackpots then
        for _, awardinfo in pairs(jackpots) do
          remainCount = remainCount + awardinfo.m_lottery_count
        end
        if remainCount >= self._lotteryCompInfo.m_multi_lottery then
          return true
        end
      end
    end
  end
  return false
end
