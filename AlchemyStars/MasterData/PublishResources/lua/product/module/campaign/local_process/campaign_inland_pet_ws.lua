_class("CCampaignInlandPetWS", ICampaignComponentLocalProcessBase)
CCampaignInlandPetWS = CCampaignInlandPetWS

function CCampaignInlandPetWS:Constructor()
  self._questComponent = nil
  self._questComponentInfo = nil
  self._campaignObj = nil
end

function CCampaignInlandPetWS:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_INLAND_PET_WS
end

function CCampaignInlandPetWS:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignInlandPetWS:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetQuestComponent()
end

function CCampaignInlandPetWS:_GetQuestComponent()
  self._questComponent = self._campaignObj:GetComponent(ECCampaignInlandPetWSComponentID.QUEST)
  if not self._questComponent then
    return
  end
  self._questComponentInfo = self._questComponent:ComponentInfo()
end

function CCampaignInlandPetWS:GetComponent(componentID)
  if ECCampaignInlandPetWSComponentID.QUEST == componentID then
    return self._questComponent
  end
  return nil
end

function CCampaignInlandPetWS:GetComponentInfo(componentID)
  if ECCampaignInlandPetWSComponentID.QUEST == componentID then
    return self._questComponentInfo
  end
  return nil
end
