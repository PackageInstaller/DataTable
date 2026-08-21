_class("CCampaignN11LuckLand", ICampaignComponentLocalProcessBase)
CCampaignN11LuckLand = CCampaignN11LuckLand

function CCampaignN11LuckLand:Constructor()
  self._lucklandMissionComponent = nil
  self._lucklandMissionComponentInfo = nil
  self._campaignObj = nil
end

function CCampaignN11LuckLand:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_LUCKLAND
end

function CCampaignN11LuckLand:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignN11LuckLand:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetLuckLandComponent()
end

function CCampaignN11LuckLand:_GetLuckLandComponent()
  self._lucklandMissionComponent = self._campaignObj:GetComponent(ECampaignN11CenterComponentID.ECAMPAIGN_N11_LUCK_LAND)
  if not self._lucklandMissionComponent then
    return
  end
  self._lucklandMissionComponentInfo = self._lucklandMissionComponent:ComponentInfo()
end

function CCampaignN11LuckLand:GetComponent(componentID)
  if ECampaignN11CenterComponentID.ECAMPAIGN_N11_LUCK_LAND == componentID then
    return self._lucklandMissionComponent
  end
  return nil
end

function CCampaignN11LuckLand:GetComponentInfo(componentID)
  if ECampaignN11CenterComponentID.ECAMPAIGN_N11_LUCK_LAND == componentID then
    return self._lucklandMissionComponentInfo
  end
  return nil
end

function CCampaignN11LuckLand:GetEntryNew()
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local sample = campaignModule:GetSampleByType(ECampaignType.CAMPAIGN_TYPE_LUCKLAND)
  return sample and sample:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_NEW)
end

function CCampaignN11LuckLand:GetEntryRedDot()
  return self:LuckLandMissionReddot()
end

function CCampaignN11LuckLand:LuckLandMissionReddot()
  return self._lucklandMissionComponent and self._lucklandMissionComponent:HaveRedPoint()
end
