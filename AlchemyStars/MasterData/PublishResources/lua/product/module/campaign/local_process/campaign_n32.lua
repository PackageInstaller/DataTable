_class("CCampaignN32", ICampaignComponentLocalProcessBase)
CCampaignN32 = CCampaignN32

function CCampaignN32:Constructor()
  self._cumulativeLoginComponent = nil
  self._cumulativeLoginCompInfo = nil
  self._levelHardComponent = nil
  self._levelHardCompInfo = nil
  self._blackHardComponent = nil
  self._blackHardCompInfo = nil
  self._power2itemComponent = nil
  self._power2itemComponentInfo = nil
  self._lotteryComponent = nil
  self._lotteryCompInfo = nil
  self._multilineComponent = nil
  self._multilineCompInfo = nil
  self._campaignObj = nil
end

function CCampaignN32:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_N32
end

function CCampaignN32:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignN32:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetCumulativeLoginComponent()
  self:_GetDifficultMissionComponent()
  self:_GetPower2ItemComponent()
  self:_GetLotteryComponent()
  self:_GetBlackDifficultMissionComponent()
  self:_GetMultiLineMissionComponent()
end

function CCampaignN32:_GetCumulativeLoginComponent()
  self._cumulativeLoginComponent = self._campaignObj:GetComponent(ECampaignN32ComponentID.ECAMPAIGN_N32_CUMULATIVE_LOGIN)
  if not self._cumulativeLoginComponent then
    return
  end
  self._cumulativeLoginComponentInfo = self._cumulativeLoginComponent:ComponentInfo()
end

function CCampaignN32:_GetDifficultMissionComponent()
  self._levelHardComponent = self._campaignObj:GetComponent(ECampaignN32ComponentID.ECAMPAIGN_N32_DIFFICULT_MISSION)
  if not self._levelHardComponent then
    return
  end
  self._levelHardCompInfo = self._levelHardComponent:ComponentInfo()
end

function CCampaignN32:_GetBlackDifficultMissionComponent()
  self._blackHardComponent = self._campaignObj:GetComponent(ECampaignN32ComponentID.ECAMPAIGN_N32_BLACK_DIFFICULT_MISSION)
  if not self._blackHardComponent then
    return
  end
  self._blackHardCompInfo = self._blackHardComponent:ComponentInfo()
end

function CCampaignN32:_GetMultiLineMissionComponent()
  self._multilineComponent = self._campaignObj:GetComponent(ECampaignN32ComponentID.ECAMPAIGN_N32_MULTILINE_MISSION)
  if not self._multilineComponent then
    return
  end
  self._multilineCompInfo = self._multilineComponent:ComponentInfo()
end

function CCampaignN32:_GetPower2ItemComponent()
  self._power2itemComponent = self._campaignObj:GetComponent(ECampaignN32ComponentID.ECAMPAIGN_N32_POWER2ITEM)
  if not self._power2itemComponent then
    return
  end
  self._power2itemComponentInfo = self._power2itemComponent:ComponentInfo()
end

function CCampaignN32:_GetLotteryComponent()
  self._lotteryComponent = self._campaignObj:GetComponent(ECampaignN32ComponentID.ECAMPAIGN_N32_LOTTERY)
  if not self._lotteryComponent then
    return
  end
  self._lotteryCompInfo = self._lotteryComponent:ComponentInfo()
end

function CCampaignN32:GetComponent(componentID)
  if ECampaignN32ComponentID.ECAMPAIGN_N32_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponent
  end
  if ECampaignN32ComponentID.ECAMPAIGN_N32_DIFFICULT_MISSION == componentID then
    return self._levelHardComponent
  end
  if ECampaignN32ComponentID.ECAMPAIGN_N32_BLACK_DIFFICULT_MISSION == componentID then
    return self._blackHardComponent
  end
  if ECampaignN32ComponentID.ECAMPAIGN_N32_POWER2ITEM == componentID then
    return self._power2itemComponent
  end
  if ECampaignN32ComponentID.ECAMPAIGN_N32_LOTTERY == componentID then
    return self._lotteryComponent
  end
  if ECampaignN32ComponentID.ECAMPAIGN_N32_MULTILINE_MISSION == componentID then
    return self._multilineComponent
  end
  return nil
end

function CCampaignN32:GetComponentInfo(componentID)
  if ECampaignN32ComponentID.ECAMPAIGN_N32_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponentInfo
  end
  if ECampaignN32ComponentID.ECAMPAIGN_N32_DIFFICULT_MISSION == componentID then
    return self._levelHardCompInfo
  end
  if ECampaignN32ComponentID.ECAMPAIGN_N32_BLACK_DIFFICULT_MISSION == componentID then
    return self._blackHardCompInfo
  end
  if ECampaignN32ComponentID.ECAMPAIGN_N32_POWER2ITEM == componentID then
    return self._power2itemComponentInfo
  end
  if ECampaignN32ComponentID.ECAMPAIGN_N32_LOTTERY == componentID then
    return self._lotteryCompInfo
  end
  if ECampaignN32ComponentID.ECAMPAIGN_N32_MULTILINE_MISSION == componentID then
    return self._multilineCompInfo
  end
  return nil
end

function CCampaignN32:GetEntryNew()
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local sample = campaignModule:GetSampleByType(ECampaignType.CAMPAIGN_TYPE_N32)
  return sample and sample:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_NEW)
end

function CCampaignN32:GetEntryRedDot()
  return self:BlackHardLineMissionRedDot() or self:HardLineMissionRedDot() or self:AccumulateLoginReddot() or self:LotteryShopReddot() or self:MultiLineMissionRedDot()
end

function CCampaignN32:AccumulateLoginReddot()
  return self._cumulativeLoginComponent and self._cumulativeLoginComponent:HaveRedPoint()
end

function CCampaignN32:BattlePassRedPoint(battlePassCampaign)
  return UIActivityBattlePassHelper.CheckCampaignRedPoint(battlePassCampaign)
end

function CCampaignN32:HardLineMissionRedDot()
  if not self._levelHardComponent:ComponentIsOpen() then
    return false
  end
  return self._levelHardComponent:HaveRedPoint()
end

function CCampaignN32:BlackHardLineMissionRedDot()
  if not self._blackHardComponent:ComponentIsOpen() then
    return false
  end
  return self._blackHardComponent:HaveRedPoint()
end

function CCampaignN32:MultiLineMissionRedDot()
  if not self._multilineComponent:ComponentIsOpen() then
    return false
  end
  return self._multilineComponent:HaveRedPoint()
end

function CCampaignN32:LotteryShopReddot()
  if self._lotteryCompInfo and self._lotteryComponent:ComponentIsOpen() then
    local costCount = self._lotteryCompInfo.m_cost_count * self._lotteryCompInfo.m_multi_lottery
    local curCount = ClientCampaignDrawShop.GetMoney(self._lotteryCompInfo.m_cost_item_id)
    return costCount <= curCount and self:_JackPotCanLottery()
  end
  return false
end

function CCampaignN32:_JackPotCanLottery()
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
