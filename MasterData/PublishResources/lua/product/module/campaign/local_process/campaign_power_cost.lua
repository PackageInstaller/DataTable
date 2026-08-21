_class("CCampaingPowerCost", ICampaignComponentLocalProcessBase)
CCampaingPowerCost = CCampaingPowerCost

function CCampaingPowerCost:Constructor()
  self._questComponent = nil
  self._questComponentInfo = nil
  self._campaignObj = nil
end

function CCampaingPowerCost:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_POWERCOST
end

function CCampaingPowerCost:CampaignObjInfo()
  return self._campaignObj
end

function CCampaingPowerCost:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetQuestComponent()
end

function CCampaingPowerCost:_GetQuestComponent()
  self._questComponent = self._campaignObj:GetComponent(ECampaignPowerCostComponentID.ECAMPAIGN_POWERCOST_QUEST)
  if not self._questComponent then
    return
  end
  self._questComponentInfo = self._questComponent:ComponentInfo()
end

function CCampaingPowerCost:GetComponent(componentID)
  if ECampaignPowerCostComponentID.ECAMPAIGN_POWERCOST_QUEST == componentID then
    return self._questComponent
  end
  return nil
end

function CCampaingPowerCost:GetComponentInfo(componentID)
  if ECampaignPowerCostComponentID.ECAMPAIGN_POWERCOST_QUEST == componentID then
    return self._questComponentInfo
  end
  return nil
end
