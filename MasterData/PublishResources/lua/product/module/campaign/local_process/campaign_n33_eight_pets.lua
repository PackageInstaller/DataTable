_class("CCampaignN33EightPetsMission", ICampaignComponentLocalProcessBase)
CCampaignN33EightPetsMission = CCampaignN33EightPetsMission

function CCampaignN33EightPetsMission:Constructor()
  self._eightPetsMissionComponent = nil
  self._eightPetsMissionComponentInfo = nil
  self._campaignObj = nil
end

function CCampaignN33EightPetsMission:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_N33_EIGHT_PETS
end

function CCampaignN33EightPetsMission:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignN33EightPetsMission:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetEightPetsMissionComponent()
end

function CCampaignN33EightPetsMission:_GetEightPetsMissionComponent()
  self._eightPetsMissionComponent = self._campaignObj:GetComponent(ECampaignN33EightPetsMissionComponentID.ECAMPAIGN_N33_Eight_Pets_MISSION)
  if not self._eightPetsMissionComponent then
    return
  end
  self._eightPetsMissionComponentInfo = self._eightPetsMissionComponent:ComponentInfo()
end

function CCampaignN33EightPetsMission:GetComponent(componentID)
  if ECampaignN33EightPetsMissionComponentID.ECAMPAIGN_N33_Eight_Pets_MISSION == componentID then
    return self._eightPetsMissionComponent
  end
  return nil
end

function CCampaignN33EightPetsMission:GetComponentInfo(componentID)
  if ECampaignN33EightPetsMissionComponentID.ECAMPAIGN_N33_Eight_Pets_MISSION == componentID then
    return self._eightPetsMissionComponentInfo
  end
  return nil
end
