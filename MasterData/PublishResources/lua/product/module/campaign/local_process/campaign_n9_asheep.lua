_class("CCampaignN9ASheep", ICampaignComponentLocalProcessBase)
CCampaignN9ASheep = CCampaignN9ASheep

function CCampaignN9ASheep:Constructor()
  self._asheepMissionComponent = nil
  self._asheepMissionComponentInfo = nil
  self._campaignObj = nil
end

function CCampaignN9ASheep:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_INLAND_N9_ASHEEP
end

function CCampaignN9ASheep:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignN9ASheep:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetPopStarMissionComponent()
end

function CCampaignN9ASheep:_GetPopStarMissionComponent()
  self._asheepMissionComponent = self._campaignObj:GetComponent(ECampaignN9CenterComponentID.ECAMPAIGN_N9_ASHEEP)
  if not self._asheepMissionComponent then
    return
  end
  self._asheepMissionComponentInfo = self._asheepMissionComponent:ComponentInfo()
end

function CCampaignN9ASheep:GetComponent(componentID)
  if ECampaignN9CenterComponentID.ECAMPAIGN_N9_ASHEEP == componentID then
    return self._asheepMissionComponent
  end
  return nil
end

function CCampaignN9ASheep:GetComponentInfo(componentID)
  if ECampaignN9CenterComponentID.ECAMPAIGN_N9_ASHEEP == componentID then
    return self._asheepMissionComponentInfo
  end
  return nil
end

function CCampaignN9ASheep:GetEntryNew()
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local sample = campaignModule:GetSampleByType(ECampaignType.CAMPAIGN_TYPE_INLAND_N9_ASHEEP)
  return sample and sample:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_NEW)
end

function CCampaignN9ASheep:GetEntryRedDot()
  return self:ASheepMissionReddot()
end

function CCampaignN9ASheep:ASheepMissionReddot()
  return self._asheepMissionComponent and self._asheepMissionComponent:HaveRedPoint()
end
