_class("CCampaignGamble", ICampaignComponentLocalProcessBase)
CCampaignGamble = CCampaignGamble

function CCampaignGamble:Constructor()
  self._questComponent = nil
  self._questComponentInfo = nil
  self._campaignObj = nil
end

function CCampaignGamble:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_INLAND_GAMBLE
end

function CCampaignGamble:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignGamble:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetQuestComponent()
end

function CCampaignGamble:_GetQuestComponent()
  self._questComponent = self._campaignObj:GetComponent(ECampaignGambleComponentID.ECAMPAIGN_Gamble_QUEST)
  if not self._questComponent then
    return
  end
  self._questComponentInfo = self._questComponent:ComponentInfo()
end

function CCampaignGamble:GetComponent(componentID)
  if ECampaignGambleComponentID.ECAMPAIGN_Gamble_QUEST == componentID then
    return self._questComponent
  end
  return nil
end

function CCampaignGamble:GetComponentInfo(componentID)
  if ECampaignGambleComponentID.ECAMPAIGN_Gamble_QUEST == componentID then
    return self._questComponentInfo
  end
  return nil
end
