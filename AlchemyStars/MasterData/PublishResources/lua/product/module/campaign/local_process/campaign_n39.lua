_class("CCampaignN39", ICampaignComponentLocalProcessBase)
CCampaignN39 = CCampaignN39

function CCampaignN39:Constructor()
  self._cumulativeLoginComponent = nil
  self._cumulativeLoginCompInfo = nil
  self._lineMissionComponent = nil
  self._lineMissionComponentInfo = nil
  self._hardLineMissionComponent = nil
  self._hardLineMissionComponentInfo = nil
  self._blackHardComponent = nil
  self._blackHardCompInfo = nil
  self._power2itemComponent = nil
  self._power2itemComponentInfo = nil
  self._powerShopComponent = nil
  self._powerShopCompInfo = nil
  self._campaignObj = nil
end

function CCampaignN39:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_N39
end

function CCampaignN39:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignN39:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetCumulativeLoginComponent()
  self:_GetLineMissionComponent()
  self:_GetHardLineMissionComponent()
  self:_GetPower2ItemComponent()
  self:_GetBlackDifficultMissionComponent()
  self:_GetShopComponent()
end

function CCampaignN39:_GetCumulativeLoginComponent()
  self._cumulativeLoginComponent = self._campaignObj:GetComponent(ECampaignN39ComponentID.ECAMPAIGN_N39_CUMULATIVE_LOGIN)
  if not self._cumulativeLoginComponent then
    return
  end
  self._cumulativeLoginComponentInfo = self._cumulativeLoginComponent:ComponentInfo()
end

function CCampaignN39:_GetLineMissionComponent()
  self._lineMissionComponent = self._campaignObj:GetComponent(ECampaignN39ComponentID.ECAMPAIGN_N39_LINE_MISSION)
  if not self._lineMissionComponent then
    return
  end
  self._lineMissionComponentInfo = self._lineMissionComponent:ComponentInfo()
end

function CCampaignN39:_GetHardLineMissionComponent()
  self._hardLineMissionComponent = self._campaignObj:GetComponent(ECampaignN39ComponentID.ECAMPAIGN_N39_HARD_LINE_MISSION)
  if not self._hardLineMissionComponent then
    return
  end
  self._hardLineMissionComponentInfo = self._hardLineMissionComponent:ComponentInfo()
end

function CCampaignN39:_GetBlackDifficultMissionComponent()
  self._blackHardComponent = self._campaignObj:GetComponent(ECampaignN39ComponentID.ECAMPAIGN_N39_BLACK_DIFFICULT_MISSION)
  if not self._blackHardComponent then
    return
  end
  self._blackHardCompInfo = self._blackHardComponent:ComponentInfo()
end

function CCampaignN39:_GetPower2ItemComponent()
  self._power2itemComponent = self._campaignObj:GetComponent(ECampaignN39ComponentID.ECAMPAIGN_N39_POWER2ITEM)
  if not self._power2itemComponent then
    return
  end
  self._power2itemComponentInfo = self._power2itemComponent:ComponentInfo()
end

function CCampaignN39:_GetShopComponent()
  self._powerShopComponent = self._campaignObj:GetComponent(ECampaignN39ComponentID.ECAMPAIGN_N39_SHOP)
  if not self._powerShopComponent then
    return
  end
  self._powerShopCompInfo = self._powerShopComponent:ComponentInfo()
end

function CCampaignN39:GetComponent(componentID)
  if ECampaignN39ComponentID.ECAMPAIGN_N39_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponent
  end
  if ECampaignN39ComponentID.ECAMPAIGN_N39_LINE_MISSION == componentID then
    return self._lineMissionComponent
  end
  if ECampaignN39ComponentID.ECAMPAIGN_N39_HARD_LINE_MISSION == componentID then
    return self._hardLineMissionComponent
  end
  if ECampaignN39ComponentID.ECAMPAIGN_N39_BLACK_DIFFICULT_MISSION == componentID then
    return self._blackHardComponent
  end
  if ECampaignN39ComponentID.ECAMPAIGN_N39_POWER2ITEM == componentID then
    return self._power2itemComponent
  end
  if ECampaignN39ComponentID.ECAMPAIGN_N39_SHOP == componentID then
    return self._powerShopComponent
  end
  return nil
end

function CCampaignN39:GetComponentInfo(componentID)
  if ECampaignN39ComponentID.ECAMPAIGN_N39_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponentInfo
  end
  if ECampaignN39ComponentID.ECAMPAIGN_N39_LINE_MISSION == componentID then
    return self._lineMissionComponentInfo
  end
  if ECampaignN39ComponentID.ECAMPAIGN_N39_HARD_LINE_MISSION == componentID then
    return self._hardLineMissionComponentInfo
  end
  if ECampaignN39ComponentID.ECAMPAIGN_N39_BLACK_DIFFICULT_MISSION == componentID then
    return self._blackHardCompInfo
  end
  if ECampaignN39ComponentID.ECAMPAIGN_N39_POWER2ITEM == componentID then
    return self._power2itemComponentInfo
  end
  if ECampaignN39ComponentID.ECAMPAIGN_N39_SHOP == componentID then
    return self._powerShopCompInfo
  end
  return nil
end

function CCampaignN39:GetEntryNew()
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local sample = campaignModule:GetSampleByType(ECampaignType.CAMPAIGN_TYPE_N39)
  return sample and sample:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_NEW)
end

function CCampaignN39:GetEntryRedDot()
  return self:BlackHardLineMissionRedDot() or self:LineMissionRedDot() or self:HardLineMissionRedDot() or self:AccumulateLoginReddot() or self:ShopReddot()
end

function CCampaignN39:AccumulateLoginReddot()
  return self._cumulativeLoginComponent and self._cumulativeLoginComponent:HaveRedPoint()
end

function CCampaignN39:BattlePassRedPoint(battlePassCampaign)
  return UIActivityBattlePassHelper.CheckCampaignRedPoint(battlePassCampaign)
end

function CCampaignN39:LineMissionRedDot()
  if not self._lineMissionComponent:ComponentIsOpen() then
    return false
  end
  return self._lineMissionComponent:HaveRedPoint()
end

function CCampaignN39:HardLineMissionRedDot()
  if not self._hardLineMissionComponent:ComponentIsOpen() then
    return false
  end
  return self._hardLineMissionComponent:HaveRedPoint()
end

function CCampaignN39:BlackHardLineMissionRedDot()
  if not self._blackHardComponent:ComponentIsOpen() then
    return false
  end
  return self._blackHardComponent:HaveRedPoint()
end
