_class("CCampaignN43", ICampaignComponentLocalProcessBase)
CCampaignN43 = CCampaignN43

function CCampaignN43:Constructor()
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

function CCampaignN43:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_N43
end

function CCampaignN43:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignN43:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetCumulativeLoginComponent()
  self:_GetPower2ItemComponent()
  self:_GetShopComponent()
end

function CCampaignN43:_GetCumulativeLoginComponent()
  self._cumulativeLoginComponent = self._campaignObj:GetComponent(ECampaignN43ComponentID.ECAMPAIGN_N43_CUMULATIVE_LOGIN)
  if not self._cumulativeLoginComponent then
    return
  end
  self._cumulativeLoginComponentInfo = self._cumulativeLoginComponent:ComponentInfo()
end

function CCampaignN43:_GetPower2ItemComponent()
  self._power2itemComponent = self._campaignObj:GetComponent(ECampaignN43ComponentID.ECAMPAIGN_N43_POWER2ITEM)
  if not self._power2itemComponent then
    return
  end
  self._power2itemComponentInfo = self._power2itemComponent:ComponentInfo()
end

function CCampaignN43:_GetShopComponent()
  self._powerShopComponent = self._campaignObj:GetComponent(ECampaignN43ComponentID.ECAMPAIGN_N43_SHOP)
  if not self._powerShopComponent then
    return
  end
  self._powerShopCompInfo = self._powerShopComponent:ComponentInfo()
end

function CCampaignN43:GetComponent(componentID)
  if ECampaignN43ComponentID.ECAMPAIGN_N43_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponent
  end
  if ECampaignN43ComponentID.ECAMPAIGN_N43_POWER2ITEM == componentID then
    return self._power2itemComponent
  end
  if ECampaignN43ComponentID.ECAMPAIGN_N43_SHOP == componentID then
    return self._powerShopComponent
  end
  return nil
end

function CCampaignN43:GetComponentInfo(componentID)
  if ECampaignN43ComponentID.ECAMPAIGN_N43_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponentInfo
  end
  if ECampaignN43ComponentID.ECAMPAIGN_N43_POWER2ITEM == componentID then
    return self._power2itemComponentInfo
  end
  if ECampaignN43ComponentID.ECAMPAIGN_N43_SHOP == componentID then
    return self._powerShopCompInfo
  end
  return nil
end

function CCampaignN43:GetEntryNew()
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local sample = campaignModule:GetSampleByType(ECampaignType.CAMPAIGN_TYPE_N39)
  return sample and sample:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_NEW)
end

function CCampaignN43:GetEntryRedDot()
  return self:ShopReddot() or self:AccumulateLoginReddot()
end

function CCampaignN43:AccumulateLoginReddot()
  return self._cumulativeLoginComponent and self._cumulativeLoginComponent:HaveRedPoint()
end

function CCampaignN43:BattlePassRedPoint(battlePassCampaign)
  return UIActivityBattlePassHelper.CheckCampaignRedPoint(battlePassCampaign)
end
