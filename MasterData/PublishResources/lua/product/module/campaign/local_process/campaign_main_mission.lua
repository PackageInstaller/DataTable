_class("CCampaignMainMission", ICampaignComponentLocalProcessBase)
CCampaignMainMission = CCampaignMainMission

function CCampaignMainMission:Constructor()
  self._cumulativeLoginComponent = nil
  self._cumulativeLoginCompInfo = nil
  self._power2itemComponent = nil
  self._power2itemComponentInfo = nil
  self._powerShopComponent = nil
  self._powerShopCompInfo = nil
  self._storySharedComponent = nil
  self._storySharedComponentInfo = nil
  self._campaignObj = nil
end

function CCampaignMainMission:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_MAIN_MISSION
end

function CCampaignMainMission:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignMainMission:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetCumulativeLoginComponent()
  self:_GetPower2ItemComponent()
  self:_GetShopComponent()
  self:_GetSharedStoryComponent()
end

function CCampaignMainMission:_GetCumulativeLoginComponent()
  self._cumulativeLoginComponent = self._campaignObj:GetComponent(ECampaignMainMissionComponentID.ECAMPAIGN_MAIN_MISSION_CUMULATIVE_LOGIN)
  if not self._cumulativeLoginComponent then
    return
  end
  self._cumulativeLoginComponentInfo = self._cumulativeLoginComponent:ComponentInfo()
end

function CCampaignMainMission:_GetPower2ItemComponent()
  self._power2itemComponent = self._campaignObj:GetComponent(ECampaignMainMissionComponentID.ECAMPAIGN_MAIN_MISSION_POWER2ITEM)
  if not self._power2itemComponent then
    return
  end
  self._power2itemComponentInfo = self._power2itemComponent:ComponentInfo()
end

function CCampaignMainMission:_GetShopComponent()
  self._powerShopComponent = self._campaignObj:GetComponent(ECampaignMainMissionComponentID.ECAMPAIGN_MAIN_MISSION_SHOP)
  if not self._powerShopComponent then
    return
  end
  self._powerShopCompInfo = self._powerShopComponent:ComponentInfo()
end

function CCampaignMainMission:_GetSharedStoryComponent()
  self._storySharedComponent = self._campaignObj:GetComponent(ECampaignMainMissionComponentID.ECAMPAIGN__MAIN_MISSION_SHARED)
  if not self._storySharedComponent then
    return
  end
  self._storySharedComponentInfo = self._storySharedComponent:ComponentInfo()
end

function CCampaignMainMission:GetComponent(componentID)
  if ECampaignMainMissionComponentID.ECAMPAIGN_MAIN_MISSION_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponent
  end
  if ECampaignMainMissionComponentID.ECAMPAIGN_MAIN_MISSION_POWER2ITEM == componentID then
    return self._power2itemComponent
  end
  if ECampaignMainMissionComponentID.ECAMPAIGN_MAIN_MISSION_SHOP == componentID then
    return self._powerShopComponent
  end
  if ECampaignMainMissionComponentID.ECAMPAIGN__MAIN_MISSION_SHARED == componentID then
    return self._storySharedComponent
  end
  return nil
end

function CCampaignMainMission:GetComponentInfo(componentID)
  if ECampaignMainMissionComponentID.ECAMPAIGN_MAIN_MISSION_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponentInfo
  end
  if ECampaignMainMissionComponentID.ECAMPAIGN_MAIN_MISSION_POWER2ITEM == componentID then
    return self._power2itemComponentInfo
  end
  if ECampaignMainMissionComponentID.ECAMPAIGN_MAIN_MISSION_SHOP == componentID then
    return self._powerShopCompInfo
  end
  if ECampaignMainMissionComponentID.ECAMPAIGN__MAIN_MISSION_SHARED == componentID then
    return self._storySharedComponentInfo
  end
  return nil
end

function CCampaignMainMission:GetEntryNew()
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local sample = campaignModule:GetSampleByType(ECampaignType.CAMPAIGN_TYPE_N39)
  return sample and sample:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_NEW)
end

function CCampaignMainMission:GetEntryRedDot()
  return self:ShopReddot() or self:AccumulateLoginReddot()
end

function CCampaignMainMission:AccumulateLoginReddot()
  return self._cumulativeLoginComponent and self._cumulativeLoginComponent:HaveRedPoint()
end

function CCampaignMainMission:BattlePassRedPoint(battlePassCampaign)
  return UIActivityBattlePassHelper.CheckCampaignRedPoint(battlePassCampaign)
end
