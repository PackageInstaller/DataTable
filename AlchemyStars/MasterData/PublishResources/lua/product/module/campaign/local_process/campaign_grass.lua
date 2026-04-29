_class("CampaignGrass", ICampaignComponentLocalProcessBase)
CampaignGrass = CampaignGrass

function CampaignGrass:Constructor()
  self._missionComponent = nil
  self._missionCompInfo = nil
  self._campaignObj = nil
end

function CampaignGrass:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_GRASS
end

function CampaignGrass:CampaignObjInfo()
  return self._campaignObj
end

function CampaignGrass:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetMissionComponent()
end

function CampaignGrass:_GetMissionComponent()
  self._missionComponent = self._campaignObj:GetComponent(ECampaignGrassComponentID.ECAMPAIGN_GRASS_MISSION)
  if not self._missionComponent then
    return
  end
  self._missionCompInfo = self._missionComponent:ComponentInfo()
end

function CampaignGrass:GetComponent(componentID)
  if ECampaignGrassComponentID.ECAMPAIGN_GRASS_MISSION == componentID then
    return self._missionComponent
  end
  return nil
end

function CampaignGrass:GetComponentInfo(componentID)
  if ECampaignGrassComponentID.ECAMPAIGN_GRASS_MISSION == componentID then
    return self._missionCompInfo
  end
  return nil
end
