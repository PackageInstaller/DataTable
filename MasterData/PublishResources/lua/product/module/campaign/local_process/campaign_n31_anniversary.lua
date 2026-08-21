_class("CCampaignN31Anniversary", ICampaignComponentLocalProcessBase)
CCampaignN31Anniversary = CCampaignN31Anniversary

function CCampaignN31Anniversary:Constructor()
  self._cumulativeLoginComponent = nil
  self._cumulativeLoginComponentInfo = nil
  self._timeRewardComponent = nil
  self._timeRewardComponentInfo = nil
  self._campaignObj = nil
end

function CCampaignN31Anniversary:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_N31_ANNIVERSARY
end

function CCampaignN31Anniversary:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignN31Anniversary:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetCumulativeLoginComponent()
  self:_GetTimeRewardComponent()
end

function CCampaignN31Anniversary:_GetCumulativeLoginComponent()
  self._cumulativeLoginComponent = self._campaignObj:GetComponent(ECampaignN31AnniversaryComponentID.CUMULATIVE_LOGIN)
  if not self._cumulativeLoginComponent then
    return
  end
  self._cumulativeLoginComponentInfo = self._cumulativeLoginComponent:ComponentInfo()
end

function CCampaignN31Anniversary:_GetTimeRewardComponent()
  self._timeRewardComponent = self._campaignObj:GetComponent(ECampaignN31AnniversaryComponentID.TIME_REWARD)
  if not self._timeRewardComponent then
    return
  end
  self._timeRewardComponentInfo = self._timeRewardComponent:ComponentInfo()
end

function CCampaignN31Anniversary:GetComponent(componentID)
  if ECampaignN31AnniversaryComponentID.CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponent
  end
  if ECampaignN31AnniversaryComponentID.TIME_REWARD == componentID then
    return self._timeRewardComponent
  end
  return nil
end

function CCampaignN31Anniversary:GetComponentInfo(componentID)
  if ECampaignN31AnniversaryComponentID.CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponentInfo
  end
  if ECampaignN31AnniversaryComponentID.TIME_REWARD == componentID then
    return self._timeRewardComponentInfo
  end
  return nil
end

function CCampaignN31Anniversary:GetEntryNew()
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local sample = campaignModule:GetSampleByType(ECampaignType.CAMPAIGN_TYPE_N31_ANNIVERSARY)
  return sample and sample:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_NEW)
end

function CCampaignN31Anniversary:AccumulateLoginReddot()
  return self._cumulativeLoginComponent and self._cumulativeLoginComponent:HaveRedPoint()
end
