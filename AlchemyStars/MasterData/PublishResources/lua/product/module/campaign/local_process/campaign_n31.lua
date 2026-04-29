_class("CCampaignN31", ICampaignComponentLocalProcessBase)
CCampaignN31 = CCampaignN31

function CCampaignN31:Constructor()
  self._cumulativeLoginComponent = nil
  self._cumulativeLoginCompInfo = nil
  self._lineMissionComponent = nil
  self._lineMissionComponentInfo = nil
  self._levelHardComponent = nil
  self._levelHardCompInfo = nil
  self._power2itemComponent = nil
  self._power2itemComponentInfo = nil
  self._powerShopComponent = nil
  self._powerShopCompInfo = nil
  self._campaignObj = nil
end

function CCampaignN31:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_N31
end

function CCampaignN31:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignN31:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetCumulativeLoginComponent()
  self:_GetLineMissionComponent()
  self:_GetDifficultMissionComponent()
  self:_GetPower2ItemComponent()
  self:_GetShopComponent()
end

function CCampaignN31:_GetCumulativeLoginComponent()
  self._cumulativeLoginComponent = self._campaignObj:GetComponent(ECampaignN31ComponentID.ECAMPAIGN_N31_CUMULATIVE_LOGIN)
  if not self._cumulativeLoginComponent then
    return
  end
  self._cumulativeLoginComponentInfo = self._cumulativeLoginComponent:ComponentInfo()
end

function CCampaignN31:_GetLineMissionComponent()
  self._lineMissionComponent = self._campaignObj:GetComponent(ECampaignN31ComponentID.ECAMPAIGN_N31_LINE_MISSION)
  if not self._lineMissionComponent then
    return
  end
  self._lineMissionComponentInfo = self._lineMissionComponent:ComponentInfo()
end

function CCampaignN31:_GetDifficultMissionComponent()
  self._levelHardComponent = self._campaignObj:GetComponent(ECampaignN31ComponentID.ECAMPAIGN_N31_DIFFICULT_MISSION)
  if not self._levelHardComponent then
    return
  end
  self._levelHardCompInfo = self._levelHardComponent:ComponentInfo()
end

function CCampaignN31:_GetPower2ItemComponent()
  self._power2itemComponent = self._campaignObj:GetComponent(ECampaignN31ComponentID.ECAMPAIGN_N31_POWER2ITEM)
  if not self._power2itemComponent then
    return
  end
  self._power2itemComponentInfo = self._power2itemComponent:ComponentInfo()
end

function CCampaignN31:_GetShopComponent()
  self._powerShopComponent = self._campaignObj:GetComponent(ECampaignN31ComponentID.ECAMPAIGN_N31_SHOP)
  if not self._powerShopComponent then
    return
  end
  self._powerShopCompInfo = self._powerShopComponent:ComponentInfo()
end

function CCampaignN31:GetComponent(componentID)
  if ECampaignN31ComponentID.ECAMPAIGN_N31_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponent
  end
  if ECampaignN31ComponentID.ECAMPAIGN_N31_LINE_MISSION == componentID then
    return self._lineMissionComponent
  end
  if ECampaignN31ComponentID.ECAMPAIGN_N31_DIFFICULT_MISSION == componentID then
    return self._levelHardComponent
  end
  if ECampaignN31ComponentID.ECAMPAIGN_N31_POWER2ITEM == componentID then
    return self._power2itemComponent
  end
  if ECampaignN31ComponentID.ECAMPAIGN_N31_SHOP == componentID then
    return self._powerShopComponent
  end
  return nil
end

function CCampaignN31:GetComponentInfo(componentID)
  if ECampaignN31ComponentID.ECAMPAIGN_N31_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponentInfo
  end
  if ECampaignN31ComponentID.ECAMPAIGN_N31_LINE_MISSION == componentID then
    return self._lineMissionComponentInfo
  end
  if ECampaignN31ComponentID.ECAMPAIGN_N31_DIFFICULT_MISSION == componentID then
    return self._levelHardCompInfo
  end
  if ECampaignN31ComponentID.ECAMPAIGN_N31_POWER2ITEM == componentID then
    return self._power2itemComponentInfo
  end
  if ECampaignN31ComponentID.ECAMPAIGN_N31_SHOP == componentID then
    return self._powerShopCompInfo
  end
  return nil
end

function CCampaignN31:GetEntryNew()
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local sample = campaignModule:GetSampleByType(ECampaignType.CAMPAIGN_TYPE_N31)
  return sample and sample:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_NEW)
end

function CCampaignN31:GetEntryRedDot()
  return self:HardLineMissionRedDot() or self:AccumulateLoginReddot() or self:LineMissionRedDot()
end

function CCampaignN31:AccumulateLoginReddot()
  return self._cumulativeLoginComponent and self._cumulativeLoginComponent:HaveRedPoint()
end

function CCampaignN31:BattlePassRedPoint(battlePassCampaign)
  return UIActivityBattlePassHelper.CheckCampaignRedPoint(battlePassCampaign)
end

function CCampaignN31:LineMissionRedDot()
  if not self._lineMissionComponent:ComponentIsOpen() then
    return false
  end
  return self._lineMissionComponent:HaveRedPoint()
end

function CCampaignN31:HardLineMissionRedDot()
  if not self._levelHardComponent:ComponentIsOpen() then
    return false
  end
  return self._levelHardComponent:HaveRedPoint()
end
