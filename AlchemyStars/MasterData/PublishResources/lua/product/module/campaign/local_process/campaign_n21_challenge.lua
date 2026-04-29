_class("CCampaignN21Challenge", ICampaignComponentLocalProcessBase)
CCampaignN21Challenge = CCampaignN21Challenge

function CCampaignN21Challenge:Constructor()
  self._challengeComponent = nil
  self._challengeCompInfo = nil
  self._progressComponent1 = nil
  self._progressCompInfo1 = nil
  self._progressComponent2 = nil
  self._progressCompInfo2 = nil
  self._progressComponent3 = nil
  self._progressCompInfo3 = nil
  self._progressComponent4 = nil
  self._progressCompInfo4 = nil
  self._progressComponent5 = nil
  self._progressCompInfo5 = nil
  self._campaignObj = nil
end

function CCampaignN21Challenge:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_N21_CHALLENGE
end

function CCampaignN21Challenge:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignN21Challenge:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetChallengeComponent()
  self:_GetProgressComponent()
end

function CCampaignN21Challenge:_GetChallengeComponent()
  self._challengeComponent = self._campaignObj:GetComponent(ECampaignN21ChallengeComponentID.CHALLENGE)
  if not self._challengeComponent then
    return
  end
  self._challengeCompInfo = self._challengeComponent:ComponentInfo()
end

function CCampaignN21Challenge:_GetProgressComponent()
  self._progressComponent1 = self._campaignObj:GetComponent(ECampaignN21ChallengeComponentID.PROGRESS)
  if self._progressComponent1 then
    self._progressCompInfo1 = self._progressComponent1:ComponentInfo()
  end
  self._progressComponent2 = self._campaignObj:GetComponent(ECampaignN21ChallengeComponentID.PROGRESS2)
  if self._progressComponent2 then
    self._progressCompInfo2 = self._progressComponent2:ComponentInfo()
  end
  self._progressComponent3 = self._campaignObj:GetComponent(ECampaignN21ChallengeComponentID.PROGRESS3)
  if self._progressComponent3 then
    self._progressCompInfo3 = self._progressComponent3:ComponentInfo()
  end
  self._progressComponent4 = self._campaignObj:GetComponent(ECampaignN21ChallengeComponentID.PROGRESS4)
  if self._progressComponent4 then
    self._progressCompInfo4 = self._progressComponent4:ComponentInfo()
  end
  self._progressComponent5 = self._campaignObj:GetComponent(ECampaignN21ChallengeComponentID.PROGRESS5)
  if self._progressComponent5 then
    self._progressCompInfo5 = self._progressComponent5:ComponentInfo()
  end
end

function CCampaignN21Challenge:GetComponent(componentID)
  if ECampaignN21ChallengeComponentID.CHALLENGE == componentID then
    return self._challengeComponent
  end
  if ECampaignN21ChallengeComponentID.PROGRESS == componentID then
    return self._progressComponent1
  end
  if ECampaignN21ChallengeComponentID.PROGRESS2 == componentID then
    return self._progressComponent2
  end
  if ECampaignN21ChallengeComponentID.PROGRESS3 == componentID then
    return self._progressComponent3
  end
  if ECampaignN21ChallengeComponentID.PROGRESS4 == componentID then
    return self._progressComponent4
  end
  if ECampaignN21ChallengeComponentID.PROGRESS5 == componentID then
    return self._progressComponent5
  end
  return nil
end

function CCampaignN21Challenge:GetComponentInfo(componentID)
  if ECampaignN21ChallengeComponentID.CHALLENGE == componentID then
    return self._challengeCompInfo
  end
  if ECampaignN21ChallengeComponentID.PROGRESS == componentID then
    return self._progressCompInfo1
  end
  if ECampaignN21ChallengeComponentID.PROGRESS2 == componentID then
    return self._progressCompInfo2
  end
  if ECampaignN21ChallengeComponentID.PROGRESS3 == componentID then
    return self._progressCompInfo3
  end
  if ECampaignN21ChallengeComponentID.PROGRESS4 == componentID then
    return self._progressCompInfo4
  end
  if ECampaignN21ChallengeComponentID.PROGRESS5 == componentID then
    return self._progressCompInfo5
  end
  return nil
end
