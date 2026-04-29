_class("CCampaignN26", ICampaignComponentLocalProcessBase)
CCampaignN26 = CCampaignN26

function CCampaignN26:Constructor()
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
  self._newyearDinnerComponent = nil
  self._newyearDinnerCompInfo = nil
  self._campaignObj = nil
end

function CCampaignN26:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_N26
end

function CCampaignN26:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignN26:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetCumulativeLoginComponent()
  self:_GetFixTeamComponent()
  self:_GetLineMissionComponent()
  self:_GetDifficultMissionComponent()
  self:_GetPower2ItemComponent()
  self:_GetShopComponent()
  self:_GetNewYearDinnerComponent()
end

function CCampaignN26:_GetLineMissionComponent()
  self._lineMissionComponent = self._campaignObj:GetComponent(ECampaignN26ComponentID.ECAMPAIGN_N26_LINE_MISSION)
  if not self._lineMissionComponent then
    return
  end
  self._lineMissionComponentInfo = self._lineMissionComponent:ComponentInfo()
end

function CCampaignN26:_GetCumulativeLoginComponent()
  self._cumulativeLoginComponent = self._campaignObj:GetComponent(ECampaignN26ComponentID.ECAMPAIGN_N26_CUMULATIVE_LOGIN)
  if not self._cumulativeLoginComponent then
    return
  end
  self._cumulativeLoginComponentInfo = self._cumulativeLoginComponent:ComponentInfo()
end

function CCampaignN26:_GetDifficultMissionComponent()
  self._levelHardComponent = self._campaignObj:GetComponent(ECampaignN26ComponentID.ECAMPAIGN_N26_DIFFICULT_MISSION)
  if not self._levelHardComponent then
    return
  end
  self._levelHardCompInfo = self._levelHardComponent:ComponentInfo()
end

function CCampaignN26:_GetShopComponent()
  self._powerShopComponent = self._campaignObj:GetComponent(ECampaignN26ComponentID.ECAMPAIGN_N26_SHOP)
  if not self._powerShopComponent then
    return
  end
  self._powerShopCompInfo = self._powerShopComponent:ComponentInfo()
end

function CCampaignN26:_GetFixTeamComponent()
  self._fixTeamComponent = self._campaignObj:GetComponent(ECampaignN26ComponentID.ECAMPAIGN_N26_FIRST_MEET)
  if not self._fixTeamComponent then
    return
  end
  self._fixTeamCompInfo = self._fixTeamComponent:ComponentInfo()
end

function CCampaignN26:_GetPower2ItemComponent()
  self._power2itemComponent = self._campaignObj:GetComponent(ECampaignN26ComponentID.ECAMPAIGN_N26_POWER2ITEM)
  if not self._power2itemComponent then
    return
  end
  self._power2itemComponentInfo = self._power2itemComponent:ComponentInfo()
end

function CCampaignN26:_GetNewYearDinnerComponent()
  self._newyearDinnerComponent = self._campaignObj:GetComponent(ECampaignN26ComponentID.ECAMPAIGN_N26_NEWYEQR_DINNER)
  if not self._newyearDinnerComponent then
    return
  end
  self._newyearDinnerCompInfo = self._newyearDinnerComponent:ComponentInfo()
end

function CCampaignN26:GetComponent(componentID)
  if ECampaignN26ComponentID.ECAMPAIGN_N26_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponent
  end
  if ECampaignN26ComponentID.ECAMPAIGN_N26_FIRST_MEET == componentID then
    return self._fixTeamComponent
  end
  if ECampaignN26ComponentID.ECAMPAIGN_N26_LINE_MISSION == componentID then
    return self._lineMissionComponent
  end
  if ECampaignN26ComponentID.ECAMPAIGN_N26_DIFFICULT_MISSION == componentID then
    return self._levelHardComponent
  end
  if ECampaignN26ComponentID.ECAMPAIGN_N26_POWER2ITEM == componentID then
    return self._power2itemComponent
  end
  if ECampaignN26ComponentID.ECAMPAIGN_N26_SHOP == componentID then
    return self._powerShopComponent
  end
  if ECampaignN26ComponentID.ECAMPAIGN_N26_NEWYEQR_DINNER == componentID then
    return self._newyearDinnerComponent
  end
  return nil
end

function CCampaignN26:GetComponentInfo(componentID)
  if ECampaignN26ComponentID.ECAMPAIGN_N26_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponentInfo
  end
  if ECampaignN26ComponentID.ECAMPAIGN_N26_FIRST_MEET == componentID then
    return self._fixTeamCompInfo
  end
  if ECampaignN26ComponentID.ECAMPAIGN_N26_LINE_MISSION == componentID then
    return self._lineMissionComponentInfo
  end
  if ECampaignN26ComponentID.ECAMPAIGN_N26_DIFFICULT_MISSION == componentID then
    return self._levelHardCompInfo
  end
  if ECampaignN26ComponentID.ECAMPAIGN_N26_POWER2ITEM == componentID then
    return self._power2itemComponentInfo
  end
  if ECampaignN26ComponentID.ECAMPAIGN_N26_SHOP == componentID then
    return self._powerShopCompInfo
  end
  if ECampaignN26ComponentID.ECAMPAIGN_N26_NEWYEQR_DINNER == componentID then
    return self._newyearDinnerCompInfo
  end
  return nil
end

function CCampaignN26:GetEntryNew()
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local sample = campaignModule:GetSampleByType(ECampaignType.CAMPAIGN_TYPE_N26)
  return sample and sample:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_NEW)
end

function CCampaignN26:GetEntryRedDot()
  return self:GetFixMissionRedDot() or self:HardLineMissionRedDot() or self:AccumulateLoginReddot() or self:LineMissionRedDot()
end

function CCampaignN26:AccumulateLoginReddot()
  return self._cumulativeLoginComponent and self._cumulativeLoginComponent:HaveRedPoint()
end

function CCampaignN26:GetFixMissionRedDot()
  if not (self._fixTeamComponent and self._fixTeamCompInfo) or not self._fixTeamComponent:ComponentIsOpen() then
    return false
  end
  local cfgs = Cfg.cfg_campaign_pet_try({
    CampaignId = ECampaignType.CAMPAIGN_TYPE_N26
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

function CCampaignN26:BattlePassRedPoint(battlePassCampaign)
  return UIActivityBattlePassHelper.CheckCampaignRedPoint(battlePassCampaign)
end

function CCampaignN26:LineMissionRedDot()
  if not self._lineMissionComponent:ComponentIsOpen() then
    return false
  end
  return self._lineMissionComponent:HaveRedPoint()
end

function CCampaignN26:HardLineMissionRedDot()
  if not self._levelHardComponent:ComponentIsOpen() then
    return false
  end
  local dbHardLineMission = self:HardLineMissionGetChallenge()
  local dbCount = 0
  for k, v in pairs(dbHardLineMission) do
    dbCount = dbCount + 1
  end
  local componentInfo = self._levelHardComponent:ComponentInfo()
  local passMission = componentInfo.m_pass_mission_info
  local passCount = 0
  for k, v in pairs(passMission) do
    passCount = passCount + 1
  end
  if dbCount == 12 then
    return false
  else
    return dbCount <= passCount
  end
  return self._levelHardComponent:HaveRedPoint()
end

function CCampaignN26:HardLineMissionGetChallenge()
  local dbHardLineMission = {}
  local key = "UIN26HardLevel.dbKey"
  local content = LocalDB.GetString(key, "")
  local fnString = string.format("return {%s}", content)
  local fnTable = load(fnString)
  local dbData = fnTable()
  for k, v in pairs(dbData) do
    dbHardLineMission[v] = v
  end
  return dbHardLineMission
end

function CCampaignN26:HardLineMissionChallenge(missionID)
  local dbHardLineMission = self:HardLineMissionGetChallenge()
  dbHardLineMission[missionID] = missionID
  local content = ""
  for k, v in pairs(dbHardLineMission) do
    content = content .. string.format("%d, ", v)
  end
  local key = "UIN26HardLevel.dbKey"
  LocalDB.SetString(key, content)
end
