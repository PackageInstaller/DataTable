_class("CCampaignN37", ICampaignComponentLocalProcessBase)
CCampaignN37 = CCampaignN37

function CCampaignN37:Constructor()
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
  self._turncardComponent = nil
  self._turncardCompInfo = nil
  self._campaignQuestComponent = nil
  self._campaignQuestCompInfo = nil
  self._campaignObj = nil
end

function CCampaignN37:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_N37
end

function CCampaignN37:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignN37:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetCumulativeLoginComponent()
  self:_GetLineMissionComponent()
  self:_GetHardLineMissionComponent()
  self:_GetPower2ItemComponent()
  self:_GetBlackDifficultMissionComponent()
  self:_GetShopComponent()
  self:_GetTurnCardComponent()
  self:_GetCampaignQuestComponent()
end

function CCampaignN37:_GetCumulativeLoginComponent()
  self._cumulativeLoginComponent = self._campaignObj:GetComponent(ECampaignN37ComponentID.ECAMPAIGN_N37_CUMULATIVE_LOGIN)
  if not self._cumulativeLoginComponent then
    return
  end
  self._cumulativeLoginComponentInfo = self._cumulativeLoginComponent:ComponentInfo()
end

function CCampaignN37:_GetLineMissionComponent()
  self._lineMissionComponent = self._campaignObj:GetComponent(ECampaignN37ComponentID.ECAMPAIGN_N37_LINE_MISSION)
  if not self._lineMissionComponent then
    return
  end
  self._lineMissionComponentInfo = self._lineMissionComponent:ComponentInfo()
end

function CCampaignN37:_GetHardLineMissionComponent()
  self._hardLineMissionComponent = self._campaignObj:GetComponent(ECampaignN37ComponentID.ECAMPAIGN_N37_HARD_LINE_MISSION)
  if not self._hardLineMissionComponent then
    return
  end
  self._hardLineMissionComponentInfo = self._hardLineMissionComponent:ComponentInfo()
end

function CCampaignN37:_GetBlackDifficultMissionComponent()
  self._blackHardComponent = self._campaignObj:GetComponent(ECampaignN37ComponentID.ECAMPAIGN_N37_BLACK_DIFFICULT_MISSION)
  if not self._blackHardComponent then
    return
  end
  self._blackHardCompInfo = self._blackHardComponent:ComponentInfo()
end

function CCampaignN37:_GetPower2ItemComponent()
  self._power2itemComponent = self._campaignObj:GetComponent(ECampaignN37ComponentID.ECAMPAIGN_N37_POWER2ITEM)
  if not self._power2itemComponent then
    return
  end
  self._power2itemComponentInfo = self._power2itemComponent:ComponentInfo()
end

function CCampaignN37:_GetShopComponent()
  self._powerShopComponent = self._campaignObj:GetComponent(ECampaignN37ComponentID.ECAMPAIGN_N37_SHOP)
  if not self._powerShopComponent then
    return
  end
  self._powerShopCompInfo = self._powerShopComponent:ComponentInfo()
end

function CCampaignN37:_GetTurnCardComponent()
  self._turncardComponent = self._campaignObj:GetComponent(ECampaignN37ComponentID.ECAMPAIGN_N37_TURNCARD)
  if not self._turncardComponent then
    return
  end
  self._turncardCompInfo = self._turncardComponent:ComponentInfo()
end

function CCampaignN37:_GetCampaignQuestComponent()
  self._campaignQuestComponent = self._campaignObj:GetComponent(ECampaignN37ComponentID.ECAMPAIGN_N37_QUEST)
  if not self._campaignQuestComponent then
    return
  end
  self._campaignQuestCompInfo = self._campaignQuestComponent:ComponentInfo()
end

function CCampaignN37:GetComponent(componentID)
  if ECampaignN37ComponentID.ECAMPAIGN_N37_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponent
  end
  if ECampaignN37ComponentID.ECAMPAIGN_N37_LINE_MISSION == componentID then
    return self._lineMissionComponent
  end
  if ECampaignN37ComponentID.ECAMPAIGN_N37_HARD_LINE_MISSION == componentID then
    return self._hardLineMissionComponent
  end
  if ECampaignN37ComponentID.ECAMPAIGN_N37_BLACK_DIFFICULT_MISSION == componentID then
    return self._blackHardComponent
  end
  if ECampaignN37ComponentID.ECAMPAIGN_N37_POWER2ITEM == componentID then
    return self._power2itemComponent
  end
  if ECampaignN37ComponentID.ECAMPAIGN_N37_SHOP == componentID then
    return self._powerShopComponent
  end
  if ECampaignN37ComponentID.ECAMPAIGN_N37_TURNCARD == componentID then
    return self._turncardComponent
  end
  if ECampaignN37ComponentID.ECAMPAIGN_N37_QUEST == componentID then
    return self._campaignQuestComponent
  end
  return nil
end

function CCampaignN37:GetComponentInfo(componentID)
  if ECampaignN37ComponentID.ECAMPAIGN_N37_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponentInfo
  end
  if ECampaignN37ComponentID.ECAMPAIGN_N37_LINE_MISSION == componentID then
    return self._lineMissionComponentInfo
  end
  if ECampaignN37ComponentID.ECAMPAIGN_N37_HARD_LINE_MISSION == componentID then
    return self._hardLineMissionComponentInfo
  end
  if ECampaignN37ComponentID.ECAMPAIGN_N37_BLACK_DIFFICULT_MISSION == componentID then
    return self._blackHardCompInfo
  end
  if ECampaignN37ComponentID.ECAMPAIGN_N37_POWER2ITEM == componentID then
    return self._power2itemComponentInfo
  end
  if ECampaignN37ComponentID.ECAMPAIGN_N37_SHOP == componentID then
    return self._powerShopCompInfo
  end
  if ECampaignN37ComponentID.ECAMPAIGN_N37_TURNCARD == componentID then
    return self._turncardCompInfo
  end
  if ECampaignN37ComponentID.ECAMPAIGN_N37_QUEST == componentID then
    return self._campaignQuestCompInfo
  end
  return nil
end

function CCampaignN37:GetEntryNew()
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local sample = campaignModule:GetSampleByType(ECampaignType.CAMPAIGN_TYPE_N37)
  return sample and sample:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_NEW)
end

function CCampaignN37:GetEntryRedDot()
  return self:BlackHardLineMissionRedDot() or self:LineMissionRedDot() or self:HardLineMissionRedDot() or self:AccumulateLoginReddot() or self:ShopReddot()
end

function CCampaignN37:AccumulateLoginReddot()
  return self._cumulativeLoginComponent and self._cumulativeLoginComponent:HaveRedPoint()
end

function CCampaignN37:BattlePassRedPoint(battlePassCampaign)
  return UIActivityBattlePassHelper.CheckCampaignRedPoint(battlePassCampaign)
end

function CCampaignN37:LineMissionRedDot()
  if not self._lineMissionComponent:ComponentIsOpen() then
    return false
  end
  return self._lineMissionComponent:HaveRedPoint()
end

function CCampaignN37:HardLineMissionRedDot()
  if not self._hardLineMissionComponent:ComponentIsOpen() then
    return false
  end
  return self._hardLineMissionComponent:HaveRedPoint()
end

function CCampaignN37:BlackHardLineMissionRedDot()
  if not self._blackHardComponent:ComponentIsOpen() then
    return false
  end
  return self._blackHardComponent:HaveRedPoint()
end

function CCampaignN37:TurnCardReddot()
  return self._turncardComponent and self._turncardComponent:HaveRedPoint()
end

function CCampaignN37:CampQuestReddot()
  return self._campaignQuestComponent and self._campaignQuestComponent:HaveRedPoint()
end
