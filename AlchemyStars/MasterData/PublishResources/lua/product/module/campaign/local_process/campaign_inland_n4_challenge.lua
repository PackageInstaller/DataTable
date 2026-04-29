_class("CCampaignInlandN4Challenge", ICampaignComponentLocalProcessBase)
CCampaignInlandN4Challenge = CCampaignInlandN4Challenge

function CCampaignInlandN4Challenge:Constructor()
  self._challengeMissionComponent = nil
  self._challengeMissionCompInfo = nil
  self._questComponent = nil
  self._questComponentInfo = nil
  self._campaignObj = nil
end

function CCampaignInlandN4Challenge:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_INLAND_N4_CHALLENGE
end

function CCampaignInlandN4Challenge:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignInlandN4Challenge:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetChallengeComponent()
  self:_GetQuestComponent()
end

function CCampaignInlandN4Challenge:_GetChallengeComponent()
  self._challengeMissionComponent = self._campaignObj:GetComponent(ECCampaignInlandN4ChallengeComponentID.CHALLENGE)
  if not self._challengeMissionComponent then
    return
  end
  self._challengeMissionCompInfo = self._challengeMissionComponent:ComponentInfo()
end

function CCampaignInlandN4Challenge:_GetQuestComponent()
  self._questComponent = self._campaignObj:GetComponent(ECCampaignInlandN4ChallengeComponentID.QUEST)
  if not self._questComponent then
    return
  end
  self._questComponentInfo = self._questComponent:ComponentInfo()
end

function CCampaignInlandN4Challenge:GetComponent(componentID)
  if ECCampaignInlandN4ChallengeComponentID.CHALLENGE == componentID then
    return self._challengeMissionComponent
  end
  if ECCampaignInlandN4ChallengeComponentID.QUEST == componentID then
    return self._questComponent
  end
  return nil
end

function CCampaignInlandN4Challenge:GetComponentInfo(componentID)
  if ECCampaignInlandN4ChallengeComponentID.CHALLENGE == componentID then
    return self._challengeMissionCompInfo
  end
  if ECCampaignInlandN4ChallengeComponentID.QUEST == componentID then
    return self._questComponentInfo
  end
  return nil
end
