_class("CCampaignFLTT", ICampaignComponentLocalProcessBase)
CCampaignFLTT = CCampaignFLTT

function CCampaignFLTT:Constructor()
  self._lineMissionComponent = nil
  self._lineMissionComponentInfo = nil
  self._campaignObj = nil
end

function CCampaignFLTT:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_FLTT
end

function CCampaignFLTT:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignFLTT:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetLineMissionComponent()
end

function CCampaignFLTT:_GetLineMissionComponent()
  self._lineMissionComponent = self._campaignObj:GetComponent(ECampaignFLTTComponentID.ECAMPAIGN_FLTT_LINE_MISSION)
  if not self._lineMissionComponent then
    return
  end
  self._lineMissionComponentInfo = self._lineMissionComponent:ComponentInfo()
end

function CCampaignFLTT:GetComponent(componentID)
  if ECampaignFLTTComponentID.ECAMPAIGN_FLTT_LINE_MISSION == componentID then
    return self._lineMissionComponent
  end
  return nil
end

function CCampaignFLTT:GetComponentInfo(componentID)
  if ECampaignFLTTComponentID.ECAMPAIGN_FLTT_LINE_MISSION == componentID then
    return self._lineMissionComponentInfo
  end
  return nil
end
