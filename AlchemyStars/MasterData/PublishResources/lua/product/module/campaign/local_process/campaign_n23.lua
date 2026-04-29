_class("CCampaignN23", ICampaignComponentLocalProcessBase)
CCampaignN23 = CCampaignN23

function CCampaignN23:Constructor()
  self._cumulativeLoginComponent = nil
  self._cumulativeLoginCompInfo = nil
  self._fixTeamComponent = nil
  self._fixTeamCompInfo = nil
  self._lineMissionComponent = nil
  self._lineMissionComponentInfo = nil
  self._power2itemComponent = nil
  self._power2itemComponentInfo = nil
  self._powerShopComponent = nil
  self._powerShopCompInfo = nil
  self._pangolinComponent = nil
  self._pangolinCompInfo = nil
  self._campaignObj = nil
end

function CCampaignN23:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_N23
end

function CCampaignN23:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignN23:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetCumulativeLoginComponent()
  self:_GetFixTeamComponent()
  self:_GetLineMissionComponent()
  self:_GetPower2ItemComponent()
  self:_GetShopComponent()
  self:_GetPangolinComponent()
end

function CCampaignN23:_GetLineMissionComponent()
  self._lineMissionComponent = self._campaignObj:GetComponent(ECampaignN23ComponentID.ECAMPAIGN_N23_LINE_MISSION)
  if not self._lineMissionComponent then
    return
  end
  self._lineMissionComponentInfo = self._lineMissionComponent:ComponentInfo()
end

function CCampaignN23:_GetCumulativeLoginComponent()
  self._cumulativeLoginComponent = self._campaignObj:GetComponent(ECampaignN23ComponentID.ECAMPAIGN_N23_CUMULATIVE_LOGIN)
  if not self._cumulativeLoginComponent then
    return
  end
  self._cumulativeLoginComponentInfo = self._cumulativeLoginComponent:ComponentInfo()
end

function CCampaignN23:_GetShopComponent()
  self._powerShopComponent = self._campaignObj:GetComponent(ECampaignN23ComponentID.ECAMPAIGN_N23_SHOP)
  if not self._powerShopComponent then
    return
  end
  self._powerShopCompInfo = self._powerShopComponent:ComponentInfo()
end

function CCampaignN23:_GetFixTeamComponent()
  self._fixTeamComponent = self._campaignObj:GetComponent(ECampaignN23ComponentID.ECAMPAIGN_N23_FIRST_MEET)
  if not self._fixTeamComponent then
    return
  end
  self._fixTeamCompInfo = self._fixTeamComponent:ComponentInfo()
end

function CCampaignN23:_GetPower2ItemComponent()
  self._power2itemComponent = self._campaignObj:GetComponent(ECampaignN23ComponentID.ECAMPAIGN_N23_POWER2ITEM)
  if not self._power2itemComponent then
    return
  end
  self._power2itemComponentInfo = self._power2itemComponent:ComponentInfo()
end

function CCampaignN23:GetComponent(componentID)
  if ECampaignN23ComponentID.ECAMPAIGN_N23_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponent
  end
  if ECampaignN23ComponentID.ECAMPAIGN_N23_FIRST_MEET == componentID then
    return self._fixTeamComponent
  end
  if ECampaignN23ComponentID.ECAMPAIGN_N23_LINE_MISSION == componentID then
    return self._lineMissionComponent
  end
  if ECampaignN23ComponentID.ECAMPAIGN_N23_POWER2ITEM == componentID then
    return self._power2itemComponent
  end
  if ECampaignN23ComponentID.ECAMPAIGN_N23_SHOP == componentID then
    return self._powerShopComponent
  end
  if ECampaignN23ComponentID.ECAMPAIGN_N23_PANGOLIN == componentID then
    return self._pangolinComponent
  end
  return nil
end

function CCampaignN23:GetComponentInfo(componentID)
  if ECampaignN23ComponentID.ECAMPAIGN_N23_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponentInfo
  end
  if ECampaignN23ComponentID.ECAMPAIGN_N23_FIRST_MEET == componentID then
    return self._fixTeamCompInfo
  end
  if ECampaignN23ComponentID.ECAMPAIGN_N23_LINE_MISSION == componentID then
    return self._lineMissionComponentInfo
  end
  if ECampaignN23ComponentID.ECAMPAIGN_N23_POWER2ITEM == componentID then
    return self._power2itemComponentInfo
  end
  if ECampaignN23ComponentID.ECAMPAIGN_N23_SHOP == componentID then
    return self._powerShopCompInfo
  end
  if ECampaignN23ComponentID.ECAMPAIGN_N23_PANGOLIN == componentID then
    return self._pangolinCompInfo
  end
  return nil
end

function CCampaignN23:GetEntryNew()
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local sample = campaignModule:GetSampleByType(ECampaignType.CAMPAIGN_TYPE_N23)
  return sample and sample:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_NEW)
end

function CCampaignN23:GetEntryRedDot()
  return self:GetFixMissionRedDot() or self:HardLineMissionRedDot() or self:AccumulateLoginReddot() or self:GetEntrustMissionRedDot() or self:LineMissionRedDot()
end

function CCampaignN23:AccumulateLoginReddot()
  return self._cumulativeLoginComponent and self._cumulativeLoginComponent:HaveRedPoint()
end

function CCampaignN23:GetFixMissionRedDot()
  if not (self._fixTeamComponent and self._fixTeamCompInfo) or not self._fixTeamComponent:ComponentIsOpen() then
    return false
  end
  local cfgs = Cfg.cfg_campaign_pet_try({
    CampaignId = ECampaignType.CAMPAIGN_TYPE_N23
  })
  local lock = false
  if cfgs then
    for key, value in pairs(cfgs) do
      if not self._fixTeamComponent:IsPassCamMissionID(value.CampaignMissionId) then
        lock = true
        break
      end
    end
  end
  return self._fixTeamCompInfo.m_b_unlock and lock
end

function CCampaignN23:BattlePassRedPoint(battlePassCampaign)
  return UIActivityBattlePassHelper.CheckCampaignRedPoint(battlePassCampaign)
end

function CCampaignN23:LineMissionRedDot()
  if not self._lineMissionComponent:ComponentIsOpen() then
    return false
  end
  return self._lineMissionComponent:HaveRedPoint()
end

function CCampaignN23:_GetPangolinComponent()
  self._pangolinComponent = self._campaignObj:GetComponent(ECampaignN23ComponentID.ECAMPAIGN_N23_PANGOLIN)
  if not self._pangolinComponent then
    return
  end
  self._pangolinCompInfo = self._pangolinComponent:ComponentInfo()
end
