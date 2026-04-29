_class("CCampaignVote", ICampaignComponentLocalProcessBase)
CCampaignVote = CCampaignVote

function CCampaignVote:Constructor()
  self._voteComponent = nil
  self._voteCompInfo = nil
  self._questComponent1 = nil
  self._questComponentInfo1 = nil
  self._questComponent2 = nil
  self._questComponentInfo2 = nil
  self._campaignObj = nil
end

function CCampaignVote:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_INLAND_VOTE
end

function CCampaignVote:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignVote:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetVoteComponent()
  self:_GetQuestComponent1()
  self:_GetQuestComponent2()
end

function CCampaignVote:_GetVoteComponent()
  self._voteComponent = self._campaignObj:GetComponent(ECampaignVoteComponentID.ECAMPAIGN_VOTE)
  if not self._voteComponent then
    return
  end
  self._voteCompInfo = self._voteComponent:GetComponentInfo()
end

function CCampaignVote:_GetQuestComponent1()
  self._questComponent1 = self._campaignObj:GetComponent(ECampaignVoteComponentID.ECAMPAIGN_QUEST1)
  if not self._questComponent1 then
    return
  end
  self._questComponentInfo1 = self._questComponent1:ComponentInfo()
end

function CCampaignVote:_GetQuestComponent2()
  self._questComponent2 = self._campaignObj:GetComponent(ECampaignVoteComponentID.ECAMPAIGN_QUEST2)
  if not self._questComponent2 then
    return
  end
  self._questComponentInfo2 = self._questComponent2:ComponentInfo()
end

function CCampaignVote:GetComponent(componentID)
  if ECampaignVoteComponentID.ECAMPAIGN_VOTE == componentID then
    return self._voteComponent
  end
  if ECampaignVoteComponentID.ECAMPAIGN_QUEST1 == componentID then
    return self._questComponent1
  end
  if ECampaignVoteComponentID.ECAMPAIGN_QUEST2 == componentID then
    return self._questComponent2
  end
  return nil
end

function CCampaignVote:GetComponentInfo(componentID)
  if ECampaignVoteComponentID.ECAMPAIGN_VOTE == componentID then
    return self._voteCompInfo
  end
  if ECampaignVoteComponentID.ECAMPAIGN_QUEST1 == componentID then
    return self._questComponentInfo1
  end
  if ECampaignVoteComponentID.ECAMPAIGN_QUEST2 == componentID then
    return self._questComponentInfo2
  end
  return nil
end
