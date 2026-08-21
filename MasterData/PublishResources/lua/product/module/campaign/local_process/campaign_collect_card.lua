_class("CCampaignCollectCard", ICampaignComponentLocalProcessBase)
CCampaignCollectCard = CCampaignCollectCard

function CCampaignCollectCard:Constructor()
  self._collectCardComponent = nil
  self._collectCardCompInfo = nil
  self._questComponent1 = nil
  self._questComponentInfo1 = nil
  self._campaignObj = nil
end

function CCampaignCollectCard:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_COLLECT_CARD
end

function CCampaignCollectCard:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignCollectCard:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetVoteComponent()
  self:_GetQuestComponent1()
end

function CCampaignCollectCard:_GetVoteComponent()
  self._collectCardComponent = self._campaignObj:GetComponent(ECampaignCollectCardComponentID.COLLECT_CARD)
  if not self._collectCardComponent then
    return
  end
  self._collectCardCompInfo = self._collectCardComponent:GetComponentInfo()
end

function CCampaignCollectCard:_GetQuestComponent1()
  self._questComponent1 = self._campaignObj:GetComponent(ECampaignCollectCardComponentID.QUEST)
  if not self._questComponent1 then
    return
  end
  self._questComponentInfo1 = self._questComponent1:ComponentInfo()
end

function CCampaignCollectCard:GetComponent(componentID)
  if ECampaignCollectCardComponentID.COLLECT_CARD == componentID then
    return self._collectCardComponent
  end
  if ECampaignCollectCardComponentID.QUEST == componentID then
    return self._questComponent1
  end
  return nil
end

function CCampaignCollectCard:GetComponentInfo(componentID)
  if ECampaignCollectCardComponentID.COLLECT_CARD == componentID then
    return self._collectCardCompInfo
  end
  if ECampaignCollectCardComponentID.QUEST == componentID then
    return self._questComponentInfo1
  end
  return nil
end
