_class("CCampaignN25", ICampaignComponentLocalProcessBase)
CCampaignN25 = CCampaignN25

function CCampaignN25:Constructor()
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
  self._idolMiniGameComponent = nil
  self._idolMiniGameCompInfo = nil
  self._bloodsuckerComponet = nil
  self._bloodsuckerComponentInfo = nil
  self._camQuestComponet = nil
  self._camQuestComponetInfo = nil
  self._campaignObj = nil
end

function CCampaignN25:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_N25
end

function CCampaignN25:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignN25:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetCumulativeLoginComponent()
  self:_GetFixTeamComponent()
  self:_GetLineMissionComponent()
  self:_GetDifficultMissionComponent()
  self:_GetPower2ItemComponent()
  self:_GetShopComponent()
  self:_GetIdolMiniGameComponent()
  self:_GetBloodsuckerComponent()
  self:_GetCamQuestComponent()
end

function CCampaignN25:_GetCamQuestComponent()
  self._camQuestComponet = self._campaignObj:GetComponent(ECampaignN25ComponentID.ECAMPAIGN_N25_QUEST)
  if not self._camQuestComponet then
    return
  end
  self._camQuestComponetInfo = self._camQuestComponet:ComponentInfo()
end

function CCampaignN25:_GetCumulativeLoginComponent()
  self._cumulativeLoginComponent = self._campaignObj:GetComponent(ECampaignN25ComponentID.ECAMPAIGN_N25_CUMULATIVE_LOGIN)
  if not self._cumulativeLoginComponent then
    return
  end
  self._cumulativeLoginComponentInfo = self._cumulativeLoginComponent:ComponentInfo()
end

function CCampaignN25:_GetFixTeamComponent()
  self._fixTeamComponent = self._campaignObj:GetComponent(ECampaignN25ComponentID.ECAMPAIGN_N25_FIRST_MEET)
  if not self._fixTeamComponent then
    return
  end
  self._fixTeamCompInfo = self._fixTeamComponent:ComponentInfo()
end

function CCampaignN25:_GetLineMissionComponent()
  self._lineMissionComponent = self._campaignObj:GetComponent(ECampaignN25ComponentID.ECAMPAIGN_N25_LINE_MISSION)
  if not self._lineMissionComponent then
    return
  end
  self._lineMissionComponentInfo = self._lineMissionComponent:ComponentInfo()
end

function CCampaignN25:_GetDifficultMissionComponent()
  self._levelHardComponent = self._campaignObj:GetComponent(ECampaignN25ComponentID.ECAMPAIGN_N25_DIFFICULT_MISSION)
  if not self._levelHardComponent then
    return
  end
  self._levelHardCompInfo = self._levelHardComponent:ComponentInfo()
end

function CCampaignN25:_GetPower2ItemComponent()
  self._power2itemComponent = self._campaignObj:GetComponent(ECampaignN25ComponentID.ECAMPAIGN_N25_POWER2ITEM)
  if not self._power2itemComponent then
    return
  end
  self._power2itemComponentInfo = self._power2itemComponent:ComponentInfo()
end

function CCampaignN25:_GetShopComponent()
  self._powerShopComponent = self._campaignObj:GetComponent(ECampaignN25ComponentID.ECAMPAIGN_N25_SHOP)
  if not self._powerShopComponent then
    return
  end
  self._powerShopCompInfo = self._powerShopComponent:ComponentInfo()
end

function CCampaignN25:_GetIdolMiniGameComponent()
  self._idolMiniGameComponent = self._campaignObj:GetComponent(ECampaignN25ComponentID.ECAMPAIGN_N25_IDOL)
  if not self._idolMiniGameComponent then
    return
  end
  self._idolMiniGameCompInfo = self._idolMiniGameComponent:ComponentInfo()
end

function CCampaignN25:_GetBloodsuckerComponent()
  self._bloodsuckerComponet = self._campaignObj:GetComponent(ECampaignN25ComponentID.ECAMPAIGN_N25_BLOODSUCKER)
  if not self._bloodsuckerComponet then
    return
  end
  self._bloodsuckerComponentInfo = self._bloodsuckerComponet:ComponentInfo()
end

function CCampaignN25:GetComponent(componentID)
  if ECampaignN25ComponentID.ECAMPAIGN_N25_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponent
  end
  if ECampaignN25ComponentID.ECAMPAIGN_N25_FIRST_MEET == componentID then
    return self._fixTeamComponent
  end
  if ECampaignN25ComponentID.ECAMPAIGN_N25_LINE_MISSION == componentID then
    return self._lineMissionComponent
  end
  if ECampaignN25ComponentID.ECAMPAIGN_N25_DIFFICULT_MISSION == componentID then
    return self._levelHardComponent
  end
  if ECampaignN25ComponentID.ECAMPAIGN_N25_POWER2ITEM == componentID then
    return self._power2itemComponent
  end
  if ECampaignN25ComponentID.ECAMPAIGN_N25_SHOP == componentID then
    return self._powerShopComponent
  end
  if ECampaignN25ComponentID.ECAMPAIGN_N25_IDOL == componentID then
    return self._idolMiniGameComponent
  end
  if ECampaignN25ComponentID.ECAMPAIGN_N25_BLOODSUCKER == componentID then
    return self._bloodsuckerComponet
  end
  if ECampaignN25ComponentID.ECAMPAIGN_N25_QUEST == componentID then
    return self._camQuestComponet
  end
  return nil
end

function CCampaignN25:GetComponentInfo(componentID)
  if ECampaignN25ComponentID.ECAMPAIGN_N25_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponentInfo
  end
  if ECampaignN25ComponentID.ECAMPAIGN_N25_FIRST_MEET == componentID then
    return self._fixTeamCompInfo
  end
  if ECampaignN25ComponentID.ECAMPAIGN_N25_LINE_MISSION == componentID then
    return self._lineMissionComponentInfo
  end
  if ECampaignN25ComponentID.ECAMPAIGN_N25_DIFFICULT_MISSION == componentID then
    return self._levelHardCompInfo
  end
  if ECampaignN25ComponentID.ECAMPAIGN_N25_POWER2ITEM == componentID then
    return self._power2itemComponentInfo
  end
  if ECampaignN25ComponentID.ECAMPAIGN_N25_SHOP == componentID then
    return self._powerShopCompInfo
  end
  if ECampaignN25ComponentID.ECAMPAIGN_N25_IDOL == componentID then
    return self._idolMiniGameCompInfo
  end
  if ECampaignN25ComponentID.ECAMPAIGN_N25_BLOODSUCKER == componentID then
    return self._bloodsuckerComponentInfo
  end
  if ECampaignN25ComponentID.ECAMPAIGN_N25_QUEST == componentID then
    return self._camQuestComponetInfo
  end
  return nil
end

function CCampaignN25:GetEntryNew()
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local sample = campaignModule:GetSampleByType(ECampaignType.CAMPAIGN_TYPE_N25)
  return sample and sample:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_NEW)
end

function CCampaignN25:GetEntryRedDot()
  return self:GetFixMissionRedDot() or self:HardLineMissionRedDot() or self:AccumulateLoginReddot() or self:LineMissionRedDot()
end

function CCampaignN25:AccumulateLoginReddot()
  return self._cumulativeLoginComponent and self._cumulativeLoginComponent:HaveRedPoint()
end

function CCampaignN25:GetFixMissionRedDot()
  if not (self._fixTeamComponent and self._fixTeamCompInfo) or not self._fixTeamComponent:ComponentIsOpen() then
    return false
  end
  local cfgs = Cfg.cfg_campaign_pet_try({
    CampaignId = ECampaignType.CAMPAIGN_TYPE_N25
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

function CCampaignN25:BattlePassRedPoint(battlePassCampaign)
  return UIActivityBattlePassHelper.CheckCampaignRedPoint(battlePassCampaign)
end

function CCampaignN25:LineMissionRedDot()
  if not self._lineMissionComponent:ComponentIsOpen() then
    return false
  end
  return self._lineMissionComponent:HaveRedPoint()
end

function CCampaignN25:HardLineMissionRedDot()
  if not self._levelHardComponent:ComponentIsOpen() then
    return false
  end
  return self._levelHardComponent:HaveRedPoint()
end
