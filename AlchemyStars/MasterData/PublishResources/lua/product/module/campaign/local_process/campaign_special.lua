_class("CCampaignSpecial", ICampaignComponentLocalProcessBase)
CCampaignSpecial = CCampaignSpecial

function CCampaignSpecial:Constructor()
  self._questComponent = nil
  self._questComponentInfo = nil
  self._campaignObj = nil
end

function CCampaignSpecial:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_SPECIAL
end

function CCampaignSpecial:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignSpecial:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetQuestComponent()
end

function CCampaignSpecial:_GetQuestComponent()
  self._questComponent = self._campaignObj:GetComponent(ECampaignSpecialComponentID.ECAMPAIGN_SPECIAL_QUEST)
  if not self._questComponent then
    return
  end
  self._questComponentInfo = self._questComponent:ComponentInfo()
end

function CCampaignSpecial:GetComponent(componentID)
  if ECampaignSpecialComponentID.ECAMPAIGN_SPECIAL_QUEST == componentID then
    return self._questComponent
  end
  return nil
end

function CCampaignSpecial:GetComponentInfo(componentID)
  if ECampaignSpecialComponentID.ECAMPAIGN_SPECIAL_QUEST == componentID then
    return self._questComponentInfo
  end
  return nil
end

function CCampaignSpecial:GetRedPoint()
  return self._questComponent:HaveRedPoint()
end
