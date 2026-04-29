_class("CCampaignN25NewYear", ICampaignComponentLocalProcessBase)
CCampaignN25NewYear = CCampaignN25NewYear

function CCampaignN25NewYear:Constructor()
  self._cumulativeLoginComponent = nil
  self._cumulativeLoginComponentInfo = nil
  self._timeRewardComponent = nil
  self._timeRewardComponentInfo = nil
  self._campaignObj = nil
end

function CCampaignN25NewYear:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_N25_NEW_YEAR
end

function CCampaignN25NewYear:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignN25NewYear:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetCumulativeLoginComponent()
  self:_GetTimeRewardComponent()
end

function CCampaignN25NewYear:_GetCumulativeLoginComponent()
  self._cumulativeLoginComponent = self._campaignObj:GetComponent(ECampaignN25NewYearComponentID.CUMULATIVE_LOGIN)
  if not self._cumulativeLoginComponent then
    return
  end
  self._cumulativeLoginComponentInfo = self._cumulativeLoginComponent:ComponentInfo()
end

function CCampaignN25NewYear:_GetTimeRewardComponent()
  self._timeRewardComponent = self._campaignObj:GetComponent(ECampaignN25NewYearComponentID.TIME_REWARD)
  if not self._timeRewardComponent then
    return
  end
  self._timeRewardComponentInfo = self._timeRewardComponent:ComponentInfo()
end

function CCampaignN25NewYear:GetComponent(componentID)
  if ECampaignN25NewYearComponentID.CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponent
  end
  if ECampaignN25NewYearComponentID.TIME_REWARD == componentID then
    return self._timeRewardComponent
  end
  return nil
end

function CCampaignN25NewYear:GetComponentInfo(componentID)
  if ECampaignN25NewYearComponentID.CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponentInfo
  end
  if ECampaignN25NewYearComponentID.TIME_REWARD == componentID then
    return self._timeRewardComponentInfo
  end
  return nil
end

function CCampaignN25NewYear:GetEntryNew()
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local sample = campaignModule:GetSampleByType(ECampaignType.CAMPAIGN_TYPE_N25_NEW_YEAR)
  return sample and sample:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_NEW)
end

function CCampaignN25NewYear:AccumulateLoginReddot()
  return self._cumulativeLoginComponent and self._cumulativeLoginComponent:HaveRedPoint()
end
