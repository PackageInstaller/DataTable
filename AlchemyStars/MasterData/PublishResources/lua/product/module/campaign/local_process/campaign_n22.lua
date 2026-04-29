_class("CCampaignN22", ICampaignComponentLocalProcessBase)
CCampaignN22 = CCampaignN22

function CCampaignN22:Constructor()
  self._cumulativeLoginComponent = nil
  self._cumulativeLoginCompInfo = nil
  self._fixTeamComponent = nil
  self._fixTeamCompInfo = nil
  self._lineMissionComponent = nil
  self._lineMissionComponentInfo = nil
  self._levelHardComponent = nil
  self._levelHardCompInfo = nil
  self._power2itemComponent = nil
  self._power2itemComponentInfo = nil
  self._powerShopComponent = nil
  self._powerShopCompInfo = nil
  self._entrustComponent = nil
  self._entrustCompInfo = nil
  self._campaignObj = nil
end

function CCampaignN22:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_N22
end

function CCampaignN22:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignN22:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetCumulativeLoginComponent()
  self:_GetFixTeamComponent()
  self:_GetLineMissionComponent()
  self:_GetDifficultMissionComponent()
  self:_GetPower2ItemComponent()
  self:_GetShopComponent()
  self:_GetEntrustComponent()
end

function CCampaignN22:_GetLineMissionComponent()
  self._lineMissionComponent = self._campaignObj:GetComponent(ECampaignN22ComponentID.ECAMPAIGN_N22_LINE_MISSION)
  if not self._lineMissionComponent then
    return
  end
  self._lineMissionComponentInfo = self._lineMissionComponent:ComponentInfo()
end

function CCampaignN22:_GetCumulativeLoginComponent()
  self._cumulativeLoginComponent = self._campaignObj:GetComponent(ECampaignN22ComponentID.ECAMPAIGN_N22_CUMULATIVE_LOGIN)
  if not self._cumulativeLoginComponent then
    return
  end
  self._cumulativeLoginComponentInfo = self._cumulativeLoginComponent:ComponentInfo()
end

function CCampaignN22:_GetDifficultMissionComponent()
  self._levelHardComponent = self._campaignObj:GetComponent(ECampaignN22ComponentID.ECAMPAIGN_N22_DIFFICULT_MISSION)
  if not self._levelHardComponent then
    return
  end
  self._levelHardCompInfo = self._levelHardComponent:ComponentInfo()
end

function CCampaignN22:_GetShopComponent()
  self._powerShopComponent = self._campaignObj:GetComponent(ECampaignN22ComponentID.ECAMPAIGN_N22_SHOP)
  if not self._powerShopComponent then
    return
  end
  self._powerShopCompInfo = self._powerShopComponent:ComponentInfo()
end

function CCampaignN22:_GetFixTeamComponent()
  self._fixTeamComponent = self._campaignObj:GetComponent(ECampaignN22ComponentID.ECAMPAIGN_N22_FIRST_MEET)
  if not self._fixTeamComponent then
    return
  end
  self._fixTeamCompInfo = self._fixTeamComponent:ComponentInfo()
end

function CCampaignN22:_GetPower2ItemComponent()
  self._power2itemComponent = self._campaignObj:GetComponent(ECampaignN22ComponentID.ECAMPAIGN_N22_POWER2ITEM)
  if not self._power2itemComponent then
    return
  end
  self._power2itemComponentInfo = self._power2itemComponent:ComponentInfo()
end

function CCampaignN22:_GetEntrustComponent()
  self._entrustComponent = self._campaignObj:GetComponent(ECampaignN22ComponentID.ECAMPAIGN_N22_ENTRUST)
  if not self._entrustComponent then
    return
  end
  self._entrustCompInfo = self._entrustComponent:ComponentInfo()
end

function CCampaignN22:GetComponent(componentID)
  if ECampaignN22ComponentID.ECAMPAIGN_N22_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponent
  end
  if ECampaignN22ComponentID.ECAMPAIGN_N22_FIRST_MEET == componentID then
    return self._fixTeamComponent
  end
  if ECampaignN22ComponentID.ECAMPAIGN_N22_LINE_MISSION == componentID then
    return self._lineMissionComponent
  end
  if ECampaignN22ComponentID.ECAMPAIGN_N22_DIFFICULT_MISSION == componentID then
    return self._levelHardComponent
  end
  if ECampaignN22ComponentID.ECAMPAIGN_N22_POWER2ITEM == componentID then
    return self._power2itemComponent
  end
  if ECampaignN22ComponentID.ECAMPAIGN_N22_SHOP == componentID then
    return self._powerShopComponent
  end
  if ECampaignN22ComponentID.ECAMPAIGN_N22_ENTRUST == componentID then
    return self._entrustComponent
  end
  return nil
end

function CCampaignN22:GetComponentInfo(componentID)
  if ECampaignN22ComponentID.ECAMPAIGN_N22_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponentInfo
  end
  if ECampaignN22ComponentID.ECAMPAIGN_N22_FIRST_MEET == componentID then
    return self._fixTeamCompInfo
  end
  if ECampaignN22ComponentID.ECAMPAIGN_N22_LINE_MISSION == componentID then
    return self._lineMissionComponentInfo
  end
  if ECampaignN22ComponentID.ECAMPAIGN_N22_DIFFICULT_MISSION == componentID then
    return self._levelHardCompInfo
  end
  if ECampaignN22ComponentID.ECAMPAIGN_N22_POWER2ITEM == componentID then
    return self._power2itemComponentInfo
  end
  if ECampaignN22ComponentID.ECAMPAIGN_N22_SHOP == componentID then
    return self._powerShopCompInfo
  end
  if ECampaignN22ComponentID.ECAMPAIGN_N22_ENTRUST == componentID then
    return self._entrustCompInfo
  end
  return nil
end

function CCampaignN22:GetEntryNew()
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local sample = campaignModule:GetSampleByType(ECampaignType.CAMPAIGN_TYPE_N22)
  return sample and sample:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_NEW)
end

function CCampaignN22:GetEntryRedDot()
  return self:GetFixMissionRedDot() or self:HardLineMissionRedDot() or self:AccumulateLoginReddot() or self:GetEntrustMissionRedDot() or self:LineMissionRedDot()
end

function CCampaignN22:AccumulateLoginReddot()
  return self._cumulativeLoginComponent and self._cumulativeLoginComponent:HaveRedPoint()
end

function CCampaignN22:GetFixMissionRedDot()
  if not (self._fixTeamComponent and self._fixTeamCompInfo) or not self._fixTeamComponent:ComponentIsOpen() then
    return false
  end
  local cfgs = Cfg.cfg_campaign_pet_try({
    CampaignId = ECampaignType.CAMPAIGN_TYPE_N22
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

function CCampaignN22:BattlePassRedPoint(battlePassCampaign)
  return UIActivityBattlePassHelper.CheckCampaignRedPoint(battlePassCampaign)
end

function CCampaignN22:LineMissionRedDot()
  if not self._lineMissionComponent:ComponentIsOpen() then
    return false
  end
  return self._lineMissionComponent:HaveRedPoint()
end

function CCampaignN22:HardLineMissionRedDot()
  if not self._levelHardComponent:ComponentIsOpen() then
    return false
  end
  return self._levelHardComponent:HaveRedPoint()
end

function CCampaignN22:GetEntrustMissionRedDot()
  if not self._entrustComponent:ComponentIsOpen() then
    return false
  end
  return self._entrustComponent:HaveRedPoint()
end
