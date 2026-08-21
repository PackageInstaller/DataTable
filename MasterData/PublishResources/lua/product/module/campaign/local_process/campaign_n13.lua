_class("CCampaignN13", ICampaignComponentLocalProcessBase)
CCampaignN13 = CCampaignN13

function CCampaignN13:Constructor()
  self._levelCommonComponet = nil
  self._levelCommonCompInfo = nil
  self._fixTeamComponent = nil
  self._fixTeamCompInfo = nil
  self._cumulativeLoginComponent = nil
  self._cumulativeLoginCompInfo = nil
  self._buildComponent = nil
  self._buildComponentInfo = nil
  self._power2itemComponent = nil
  self._power2itemComponentInfo = nil
  self._campaignObj = nil
end

function CCampaignN13:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_N13
end

function CCampaignN13:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignN13:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetLevelComponent()
  self:_GetFixTeamComponent()
  self:_GetCumulativeLoginComponent()
  self:_GetBuildComponent()
  self:_GetPower2itemComponent()
end

function CCampaignN13:_GetLevelComponent()
  self._levelCommonComponet = self._campaignObj:GetComponent(ECampaignN13ComponentID.ECAMPAIGN_N13_LINE_MISSION)
  if not self._levelCommonComponet then
    return
  end
  self._levelCommonCompInfo = self._levelCommonComponet:ComponentInfo()
end

function CCampaignN13:_GetCumulativeLoginComponent()
  self._cumulativeLoginComponent = self._campaignObj:GetComponent(ECampaignN13ComponentID.ECAMPAIGN_N13_CUMULATIVE_LOGIN)
  if not self._cumulativeLoginComponent then
    return
  end
  self._cumulativeLoginCompInfo = self._cumulativeLoginComponent:ComponentInfo()
end

function CCampaignN13:_GetFixTeamComponent()
  self._fixTeamComponent = self._campaignObj:GetComponent(ECampaignN13ComponentID.ECAMPAIGN_N13_LEVEL_FIXTEAM)
  if not self._fixTeamComponent then
    return
  end
  self._fixTeamCompInfo = self._fixTeamComponent:ComponentInfo()
end

function CCampaignN13:_GetBuildComponent()
  self._buildComponent = self._campaignObj:GetComponent(ECampaignN13ComponentID.ECAMPAIGN_N13_BUILD)
  if not self._buildComponent then
    return
  end
  self._buildComponentInfo = self._buildComponent:ComponentInfo()
end

function CCampaignN13:_GetPower2itemComponent()
  self._power2itemComponent = self._campaignObj:GetComponent(ECampaignN13ComponentID.ECAMPAIGN_N13_POWER2ITEM)
  if not self._power2itemComponent then
    return
  end
  self._power2itemComponentInfo = self._power2itemComponent:ComponentInfo()
end

function CCampaignN13:GetComponent(componentID)
  if ECampaignN13ComponentID.ECAMPAIGN_N13_LINE_MISSION == componentID then
    return self._levelCommonComponet
  end
  if ECampaignN13ComponentID.ECAMPAIGN_N13_LEVEL_FIXTEAM == componentID then
    return self._fixTeamComponent
  end
  if ECampaignN13ComponentID.ECAMPAIGN_N13_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponent
  end
  if ECampaignN13ComponentID.ECAMPAIGN_N13_BUILD == componentID then
    return self._buildComponent
  end
  if ECampaignN13ComponentID.ECAMPAIGN_N13_POWER2ITEM == componentID then
    return self._power2itemComponent
  end
  return nil
end

function CCampaignN13:GetComponentInfo(componentID)
  if ECampaignN13ComponentID.ECAMPAIGN_N13_LINE_MISSION == componentID then
    return self._levelCommonCompInfo
  end
  if ECampaignN13ComponentID.ECAMPAIGN_N13_LEVEL_FIXTEAM == componentID then
    return self._fixTeamCompInfo
  end
  if ECampaignN13ComponentID.ECAMPAIGN_N13_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginCompInfo
  end
  if ECampaignN13ComponentID.ECAMPAIGN_N13_BUILD == componentID then
    return self._buildComponentInfo
  end
  if ECampaignN13ComponentID.ECAMPAIGN_N13_POWER2ITEM == componentID then
    return self._power2itemComponentInfo
  end
  return nil
end

function CCampaignN13:GetStepStatusNew()
  if self._campaignObj then
    local sampleInfo = self._campaignObj:GetSampleInfo()
    if sampleInfo then
      return sampleInfo:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_NEW)
    end
  end
  return false
end

function CCampaignN13:GetSakuragariNew()
  if not self._buildComponent:ComponentIsOpen() then
    return false
  end
  local dbStr = N13ToolFunctions.GetSakuragariNew()
  local hadSave = not LocalDB.HasKey(dbStr)
  return hadSave
end

function CCampaignN13:GetEntryRedDot()
  return self:GetFixMissionRedDot() or self:GetLoginAwardRedDot() or self:GetSakuragariRedDot()
end

function CCampaignN13:GetSakuragariRedDot()
  if self._buildComponent:HaveSakuragariRedPoint() then
    return true
  end
  return false
end

function CCampaignN13:GetLoginAwardRedDot()
  if not self._cumulativeLoginComponent:ComponentIsOpen() then
    return false
  end
  local info = self._cumulativeLoginCompInfo.m_cumulative_info
  for k, v in pairs(info) do
    if v.m_reward_status == ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_CAN_RECV then
      return true
    end
  end
  return false
end

function CCampaignN13:GetFixMissionRedDot()
  if not (self._fixTeamComponent and self._fixTeamCompInfo) or not self._fixTeamComponent:ComponentIsOpen() then
    return false
  end
  local cfgs = Cfg.cfg_campaign_pet_try({
    CampaignId = ECampaignType.CAMPAIGN_TYPE_N13
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
