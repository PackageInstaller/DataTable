_class("CCampaignN19Common", ICampaignComponentLocalProcessBase)
CCampaignN19Common = CCampaignN19Common

function CCampaignN19Common:Constructor()
  self._hardLevelComponent = nil
  self._hardLevelCompInfo = nil
  self._fixTeamComponent = nil
  self._fixTeamCompInfo = nil
  self._pangolinComponent = nil
  self._pangolinCompInfo = nil
  self._campaignObj = nil
end

function CCampaignN19Common:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_N19_COMMON
end

function CCampaignN19Common:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignN19Common:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetHardLevelComponent()
  self:_GetFixTeamComponent()
  self:_GetPangolinComponent()
end

function CCampaignN19Common:_GetHardLevelComponent()
  self._hardLevelComponent = self._campaignObj:GetComponent(ECampaignN19CommonComponentID.HARD_LEVEL)
  if not self._hardLevelComponent then
    return
  end
  self._hardLevelCompInfo = self._hardLevelComponent:ComponentInfo()
end

function CCampaignN19Common:_GetFixTeamComponent()
  self._fixTeamComponent = self._campaignObj:GetComponent(ECampaignN19CommonComponentID.COMMON_LEVEL)
  if not self._fixTeamComponent then
    return
  end
  self._fixTeamCompInfo = self._fixTeamComponent:ComponentInfo()
end

function CCampaignN19Common:_GetPangolinComponent()
  self._pangolinComponent = self._campaignObj:GetComponent(ECampaignN19CommonComponentID.PANGOLIN)
  if not self._pangolinComponent then
    return
  end
  self._pangolinCompInfo = self._pangolinComponent:ComponentInfo()
end

function CCampaignN19Common:GetComponent(componentID)
  if ECampaignN19CommonComponentID.HARD_LEVEL == componentID then
    return self._hardLevelComponent
  end
  if ECampaignN19CommonComponentID.COMMON_LEVEL == componentID then
    return self._fixTeamComponent
  end
  if ECampaignN19CommonComponentID.PANGOLIN == componentID then
    return self._pangolinComponent
  end
  return nil
end

function CCampaignN19Common:GetComponentInfo(componentID)
  if ECampaignN19CommonComponentID.HARD_LEVEL == componentID then
    return self._hardLevelCompInfo
  end
  if ECampaignN19CommonComponentID.COMMON_LEVEL == componentID then
    return self._fixTeamCompInfo
  end
  if ECampaignN19CommonComponentID.PANGOLIN == componentID then
    return self._pangolinCompInfo
  end
  return nil
end
