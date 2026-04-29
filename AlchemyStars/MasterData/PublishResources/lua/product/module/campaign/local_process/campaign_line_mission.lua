_class("CCampaignLineMission", ICampaignComponentLocalProcessBase)
CCampaignLineMission = CCampaignLineMission

function CCampaignLineMission:Constructor()
  self._lineMissionComponent = nil
  self._lineMissionComponentInfo = nil
end

function CCampaignLineMission:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_LINE_MISSION
end

function CCampaignLineMission:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignLineMission:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetLineMissionComponent()
end

function CCampaignLineMission:_GetLineMissionComponent()
  self._lineMissionComponent = self._campaignObj:GetComponent(ECampaignLineMissionComponentID.ECAMPAIGN_LINE_MISSION)
  if not self._lineMissionComponent then
    return
  end
  self._lineMissionComponentInfo = self._lineMissionComponent:ComponentInfo()
end

function CCampaignLineMission:GetComponent(componentID)
  if ECampaignLineMissionComponentID.ECAMPAIGN_LINE_MISSION == componentID then
    return self._lineMissionComponent
  end
  return nil
end

function CCampaignLineMission:GetComponentInfo(componentID)
  if ECampaignLineMissionComponentID.ECAMPAIGN_LINE_MISSION == componentID then
    return self._lineMissionComponentInfo
  end
  return nil
end

function CCampaignLineMission:GetEntryNew()
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local sample = campaignModule:GetSampleByType(ECampaignType.CAMPAIGN_TYPE_LINE_MISSION)
  return sample and sample:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_NEW)
end

function CCampaignLineMission:GetEntryRedDot()
  return self:LineMissionRedDot()
end

function CCampaignLineMission:LineMissionRedDot()
  if not self._lineMissionComponent:ComponentIsOpen() then
    return false
  end
  return self._lineMissionComponent:HaveRedPoint()
end
