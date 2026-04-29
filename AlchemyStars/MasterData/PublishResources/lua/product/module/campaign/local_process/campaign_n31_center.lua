_class("CCampaignN31Center", ICampaignComponentLocalProcessBase)
CCampaignN31Center = CCampaignN31Center

function CCampaignN31Center:Constructor()
  self._popstarMissionComponent = nil
  self._popstarMissionComponentInfo = nil
  self._campaignObj = nil
end

function CCampaignN31Center:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_N31_CENTER
end

function CCampaignN31Center:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignN31Center:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetPopStarMissionComponent()
end

function CCampaignN31Center:_GetPopStarMissionComponent()
  self._popstarMissionComponent = self._campaignObj:GetComponent(ECampaignN31CenterComponentID.ECAMPAIGN_N31Center_POPSTAR_MISSION)
  if not self._popstarMissionComponent then
    return
  end
  self._popstarMissionComponentInfo = self._popstarMissionComponent:ComponentInfo()
end

function CCampaignN31Center:GetComponent(componentID)
  if ECampaignN31CenterComponentID.ECAMPAIGN_N31Center_POPSTAR_MISSION == componentID then
    return self._popstarMissionComponent
  end
  return nil
end

function CCampaignN31Center:GetComponentInfo(componentID)
  if ECampaignN31CenterComponentID.ECAMPAIGN_N31Center_POPSTAR_MISSION == componentID then
    return self._popstarMissionComponentInfo
  end
  return nil
end

function CCampaignN31Center:GetEntryNew()
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local sample = campaignModule:GetSampleByType(ECampaignType.CAMPAIGN_TYPE_N31_CENTER)
  return sample and sample:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_NEW)
end

function CCampaignN31:GetEntryRedDot()
  return self:PopStarMissionReddot()
end

function CCampaignN31:PopStarMissionReddot()
  return self._popstarMissionComponent and self._popstarMissionComponent:HaveRedPoint()
end
