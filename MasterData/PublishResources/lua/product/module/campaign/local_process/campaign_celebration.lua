_class("CCampaignCelebration", ICampaignComponentLocalProcessBase)
CCampaignCelebration = CCampaignCelebration

function CCampaignCelebration:Constructor()
  self._missionDropComponent = nil
  self._missionDropCompInfo = nil
  self._personProgressComponent = nil
  self._personProgressCompInfo = nil
  self._campaignObj = nil
end

function CCampaignCelebration:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_CELEBRATION
end

function CCampaignCelebration:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignCelebration:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetMissionDropComponent()
  self:_GetPersonProgressComponent()
end

function CCampaignCelebration:_GetMissionDropComponent()
  self._missionDropComponent = self._campaignObj:GetComponent(ECampaignCelebrationComponentID.ECAMPAIGN_CELEBRATION_MISSION_DROP)
  if not self._missionDropComponent then
    return
  end
  self._missionDropCompInfo = self._missionDropComponent:ComponentInfo()
end

function CCampaignCelebration:_GetPersonProgressComponent()
  self._personProgressComponent = self._campaignObj:GetComponent(ECampaignCelebrationComponentID.ECAMPAIGN_CELEBRATION_PERSON_PROGRESS)
  if not self._personProgressComponent then
    return
  end
  self._personProgressCompInfo = self._personProgressComponent:ComponentInfo()
end

function CCampaignCelebration:GetComponent(componentID)
  if ECampaignCelebrationComponentID.ECAMPAIGN_CELEBRATION_MISSION_DROP == componentID then
    return self._missionDropComponent
  end
  if ECampaignCelebrationComponentID.ECAMPAIGN_CELEBRATION_PERSON_PROGRESS == componentID then
    return self._personProgressComponent
  end
  return nil
end

function CCampaignCelebration:GetComponentInfo(componentID)
  if ECampaignCelebrationComponentID.ECAMPAIGN_CELEBRATION_MISSION_DROP == componentID then
    return self._missionDropCompInfo
  end
  if ECampaignCelebrationComponentID.ECAMPAIGN_CELEBRATION_PERSON_PROGRESS == componentID then
    return self._personProgressCompInfo
  end
  return nil
end
