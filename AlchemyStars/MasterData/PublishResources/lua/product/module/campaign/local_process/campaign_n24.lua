_class("CCampaignN24", ICampaignComponentLocalProcessBase)
CCampaignN24 = CCampaignN24

function CCampaignN24:Constructor()
  self._cumulativeLoginComponent = nil
  self._cumulativeLoginCompInfo = nil
  self._fixTeamComponent = nil
  self._fixTeamCompInfo = nil
  self._power2itemComponent = nil
  self._power2itemComponentInfo = nil
  self._pangolinComponent = nil
  self._pangolinCompInfo = nil
  self._lotteryComponent = nil
  self._lotteryCompInfo = nil
  self._campaignObj = nil
end

function CCampaignN24:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_N24
end

function CCampaignN24:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignN24:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetCumulativeLoginComponent()
  self:_GetFixTeamComponent()
  self:_GetPower2ItemComponent()
  self:_GetPangolinComponent()
  self:_GetLotteryComponent()
end

function CCampaignN24:_GetCumulativeLoginComponent()
  self._cumulativeLoginComponent = self._campaignObj:GetComponent(ECampaignN24ComponentID.ECAMPAIGN_N24_CUMULATIVE_LOGIN)
  if not self._cumulativeLoginComponent then
    return
  end
  self._cumulativeLoginComponentInfo = self._cumulativeLoginComponent:ComponentInfo()
end

function CCampaignN24:_GetFixTeamComponent()
  self._fixTeamComponent = self._campaignObj:GetComponent(ECampaignN24ComponentID.ECAMPAIGN_N24_FIRST_MEET)
  if not self._fixTeamComponent then
    return
  end
  self._fixTeamCompInfo = self._fixTeamComponent:ComponentInfo()
end

function CCampaignN24:_GetPower2ItemComponent()
  self._power2itemComponent = self._campaignObj:GetComponent(ECampaignN24ComponentID.ECAMPAIGN_N24_POWER2ITEM)
  if not self._power2itemComponent then
    return
  end
  self._power2itemComponentInfo = self._power2itemComponent:ComponentInfo()
end

function CCampaignN24:_GetLotteryComponent()
  self._lotteryComponent = self._campaignObj:GetComponent(ECampaignN24ComponentID.ECAMPAIGN_N24_LOTTERY)
  if not self._lotteryComponent then
    return
  end
  self._lotteryCompInfo = self._lotteryComponent:ComponentInfo()
end

function CCampaignN24:GetComponent(componentID)
  if ECampaignN24ComponentID.ECAMPAIGN_N24_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponent
  end
  if ECampaignN24ComponentID.ECAMPAIGN_N24_FIRST_MEET == componentID then
    return self._fixTeamComponent
  end
  if ECampaignN24ComponentID.ECAMPAIGN_N24_POWER2ITEM == componentID then
    return self._power2itemComponent
  end
  if ECampaignN24ComponentID.ECAMPAIGN_N24_PANGOLIN == componentID then
    return self._pangolinComponent
  end
  if ECampaignN24ComponentID.ECAMPAIGN_N24_LOTTERY == componentID then
    return self._lotteryComponent
  end
  return nil
end

function CCampaignN24:GetComponentInfo(componentID)
  if ECampaignN24ComponentID.ECAMPAIGN_N24_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponentInfo
  end
  if ECampaignN24ComponentID.ECAMPAIGN_N24_FIRST_MEET == componentID then
    return self._fixTeamCompInfo
  end
  if ECampaignN24ComponentID.ECAMPAIGN_N24_POWER2ITEM == componentID then
    return self._power2itemComponentInfo
  end
  if ECampaignN24ComponentID.ECAMPAIGN_N24_PANGOLIN == componentID then
    return self._pangolinCompInfo
  end
  if ECampaignN24ComponentID.ECAMPAIGN_N24_LOTTERY == componentID then
    return self._lotteryCompInfo
  end
  return nil
end

function CCampaignN24:GetEntryNew()
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local sample = campaignModule:GetSampleByType(ECampaignType.CAMPAIGN_TYPE_N24)
  return sample and sample:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_NEW)
end

function CCampaignN24:GetEntryRedDot()
  return self:GetFixMissionRedDot() or self:HardLineMissionRedDot() or self:AccumulateLoginReddot() or self:GetEntrustMissionRedDot() or self:LineMissionRedDot()
end

function CCampaignN24:AccumulateLoginReddot()
  return self._cumulativeLoginComponent and self._cumulativeLoginComponent:HaveRedPoint()
end

function CCampaignN24:GetFixMissionRedDot()
  if not (self._fixTeamComponent and self._fixTeamCompInfo) or not self._fixTeamComponent:ComponentIsOpen() then
    return false
  end
  local cfgs = Cfg.cfg_campaign_pet_try({
    CampaignId = ECampaignType.CAMPAIGN_TYPE_N24
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

function CCampaignN24:BattlePassRedPoint(battlePassCampaign)
  return UIActivityBattlePassHelper.CheckCampaignRedPoint(battlePassCampaign)
end

function CCampaignN24:_GetPangolinComponent()
  self._pangolinComponent = self._campaignObj:GetComponent(ECampaignN24ComponentID.ECAMPAIGN_N24_PANGOLIN)
  if not self._pangolinComponent then
    return
  end
  self._pangolinCompInfo = self._pangolinComponent:ComponentInfo()
end

function CCampaignN24:LotteryShopReddot()
  if self._lotteryCompInfo and self._lotteryComponent:ComponentIsOpen() then
    local costCount = self._lotteryCompInfo.m_cost_count * self._lotteryCompInfo.m_multi_lottery
    local curCount = ClientCampaignDrawShop.GetMoney(self._lotteryCompInfo.m_cost_item_id)
    return costCount <= curCount and self:_JackPotCanLottery()
  end
  return false
end

function CCampaignN24:_JackPotCanLottery()
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
