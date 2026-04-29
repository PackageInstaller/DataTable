_class("CCampaignN30", ICampaignComponentLocalProcessBase)
CCampaignN30 = CCampaignN30

function CCampaignN30:Constructor()
  self._cumulativeLoginComponent = nil
  self._cumulativeLoginCompInfo = nil
  self._fixTeamComponent = nil
  self._fixTeamCompInfo = nil
  self._power2itemComponent = nil
  self._power2itemComponentInfo = nil
  self._lotteryComponent = nil
  self._lotteryCompInfo = nil
  self._entrustComponent = nil
  self._entrustCompInfo = nil
  self._campaignObj = nil
end

function CCampaignN30:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_N30
end

function CCampaignN30:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignN30:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetCumulativeLoginComponent()
  self:_GetFixTeamComponent()
  self:_GetPower2ItemComponent()
  self:_GetLotteryComponent()
  self:_GetEntrustComponent()
end

function CCampaignN30:_GetCumulativeLoginComponent()
  self._cumulativeLoginComponent = self._campaignObj:GetComponent(ECampaignN30ComponentID.ECAMPAIGN_N30_CUMULATIVE_LOGIN)
  if not self._cumulativeLoginComponent then
    return
  end
  self._cumulativeLoginComponentInfo = self._cumulativeLoginComponent:ComponentInfo()
end

function CCampaignN30:_GetFixTeamComponent()
  self._fixTeamComponent = self._campaignObj:GetComponent(ECampaignN30ComponentID.ECAMPAIGN_N30_FIRST_MEET)
  if not self._fixTeamComponent then
    return
  end
  self._fixTeamCompInfo = self._fixTeamComponent:ComponentInfo()
end

function CCampaignN30:_GetPower2ItemComponent()
  self._power2itemComponent = self._campaignObj:GetComponent(ECampaignN30ComponentID.ECAMPAIGN_N30_POWER2ITEM)
  if not self._power2itemComponent then
    return
  end
  self._power2itemComponentInfo = self._power2itemComponent:ComponentInfo()
end

function CCampaignN30:_GetLotteryComponent()
  self._lotteryComponent = self._campaignObj:GetComponent(ECampaignN30ComponentID.ECAMPAIGN_N30_LOTTERY)
  if not self._lotteryComponent then
    return
  end
  self._lotteryCompInfo = self._lotteryComponent:ComponentInfo()
end

function CCampaignN30:_GetEntrustComponent()
  self._entrustComponent = self._campaignObj:GetComponent(ECampaignN30ComponentID.ECAMPAIGN_N30_ENTRUST)
  if not self._entrustComponent then
    return
  end
  self._entrustCompInfo = self._entrustComponent:ComponentInfo()
end

function CCampaignN30:GetComponent(componentID)
  if ECampaignN30ComponentID.ECAMPAIGN_N30_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponent
  end
  if ECampaignN30ComponentID.ECAMPAIGN_N30_FIRST_MEET == componentID then
    return self._fixTeamComponent
  end
  if ECampaignN30ComponentID.ECAMPAIGN_N30_POWER2ITEM == componentID then
    return self._power2itemComponent
  end
  if ECampaignN30ComponentID.ECAMPAIGN_N30_LOTTERY == componentID then
    return self._lotteryComponent
  end
  if ECampaignN30ComponentID.ECAMPAIGN_N30_ENTRUST == componentID then
    return self._entrustComponent
  end
  return nil
end

function CCampaignN30:GetComponentInfo(componentID)
  if ECampaignN30ComponentID.ECAMPAIGN_N30_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponentInfo
  end
  if ECampaignN30ComponentID.ECAMPAIGN_N30_FIRST_MEET == componentID then
    return self._fixTeamCompInfo
  end
  if ECampaignN30ComponentID.ECAMPAIGN_N30_POWER2ITEM == componentID then
    return self._power2itemComponentInfo
  end
  if ECampaignN30ComponentID.ECAMPAIGN_N30_LOTTERY == componentID then
    return self._lotteryCompInfo
  end
  if ECampaignN30ComponentID.ECAMPAIGN_N30_ENTRUST == componentID then
    return self._entrustCompInfo
  end
  return nil
end

function CCampaignN30:GetEntryNew()
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local sample = campaignModule:GetSampleByType(ECampaignType.CAMPAIGN_TYPE_N30)
  return sample and sample:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_NEW)
end

function CCampaignN30:GetEntryRedDot()
  return self:GetFixMissionRedDot() or self:AccumulateLoginReddot()
end

function CCampaignN30:AccumulateLoginReddot()
  return self._cumulativeLoginComponent and self._cumulativeLoginComponent:HaveRedPoint()
end

function CCampaignN30:GetFixMissionRedDot()
  if not (self._fixTeamComponent and self._fixTeamCompInfo) or not self._fixTeamComponent:ComponentIsOpen() then
    return false
  end
  local cfgs = Cfg.cfg_campaign_pet_try({
    CampaignId = ECampaignType.CAMPAIGN_TYPE_N30
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
