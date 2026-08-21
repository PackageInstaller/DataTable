_class("CCampaingN7", ICampaignComponentLocalProcessBase)
CCampaingN7 = CCampaingN7

function CCampaingN7:Constructor()
  self._cumulativeLoginComponent = nil
  self._cumulativeLoginCompInfo = nil
  self._lineMissionComponet = nil
  self._lineMissionCompInfo = nil
  self._lineMissionComponet1 = nil
  self._lineMissionCompInfo1 = nil
  self._personProgressComponet = nil
  self._personProgressComponetInfo = nil
  self._blackfistComponet = nil
  self._blackfistComponetInfo = nil
  self._campaignObj = nil
end

function CCampaingN7:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_N7
end

function CCampaingN7:CampaignObjInfo()
  return self._campaignObj
end

function CCampaingN7:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetCumulativeLoginComponent()
  self:_GetLineMissionComponent()
  self:_GetFixTeamLineMissionComponent()
  self:_GetprestigeComponent()
  self:_GetBlackfistComponent()
end

function CCampaingN7:_GetCumulativeLoginComponent()
  self._cumulativeLoginComponent = self._campaignObj:GetComponent(ECampaignN7ComponentID.ECAMPAIGN_N7_CUMULATIVE_LOGIN)
  if not self._cumulativeLoginComponent then
    return
  end
  self._cumulativeLoginCompInfo = self._cumulativeLoginComponent:ComponentInfo()
end

function CCampaingN7:_GetLineMissionComponent()
  self._lineMissionComponet = self._campaignObj:GetComponent(ECampaignN7ComponentID.ECAMPAIGN_N7_LINE_MISSION)
  if not self._lineMissionComponet then
    return
  end
  self._lineMissionCompInfo = self._lineMissionComponet:ComponentInfo()
end

function CCampaingN7:_GetFixTeamLineMissionComponent()
  self._lineMissionComponet1 = self._campaignObj:GetComponent(ECampaignN7ComponentID.ECAMPAIGN_N7_LINE_MISSION_FIXTEAM)
  if not self._lineMissionComponet1 then
    return
  end
  self._lineMissionCompInfo1 = self._lineMissionComponet1:ComponentInfo()
end

function CCampaingN7:_GetprestigeComponent()
  self._personProgressComponet = self._campaignObj:GetComponent(ECampaignN7ComponentID.ECAMPAIGN_N7_LINE_PRESTIGE)
  if not self._personProgressComponet then
    return
  end
  self._personProgressComponetInfo = self._personProgressComponet:ComponentInfo()
end

function CCampaingN7:_GetBlackfistComponent()
  self._blackfistComponet = self._campaignObj:GetComponent(ECampaignN7ComponentID.ECAMPAIGN_N7_BLACKFIST)
  if not self._blackfistComponet then
    return
  end
  self._blackfistComponetInfo = self._blackfistComponet:ComponentInfo()
end

function CCampaingN7:GetComponent(componentID)
  if ECampaignN7ComponentID.ECAMPAIGN_N7_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponent
  end
  if ECampaignN7ComponentID.ECAMPAIGN_N7_LINE_MISSION == componentID then
    return self._lineMissionComponet
  end
  if ECampaignN7ComponentID.ECAMPAIGN_N7_LINE_MISSION_FIXTEAM == componentID then
    return self._lineMissionComponet1
  end
  if ECampaignN7ComponentID.ECAMPAIGN_N7_LINE_PRESTIGE == componentID then
    return self._personProgressComponet
  end
  if ECampaignN7ComponentID.ECAMPAIGN_N7_BLACKFIST == componentID then
    return self._blackfistComponet
  end
  return nil
end

function CCampaingN7:GetComponentInfo(componentID)
  if ECampaignN7ComponentID.ECAMPAIGN_N7_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginCompInfo
  end
  if ECampaignN7ComponentID.ECAMPAIGN_N7_LINE_MISSION == componentID then
    return self._lineMissionCompInfo
  end
  if ECampaignN7ComponentID.ECAMPAIGN_N7_LINE_MISSION_FIXTEAM == componentID then
    return self._lineMissionCompInfo1
  end
  if ECampaignN7ComponentID.ECAMPAIGN_N7_LINE_PRESTIGE == componentID then
    return self._personProgressComponetInfo
  end
  if ECampaignN7ComponentID.ECAMPAIGN_N7_BLACKFIST == componentID then
    return self._blackfistComponetInfo
  end
  return nil
end

function CCampaingN7:GetEntryRedDot()
  return self:GetBlackFistRedDot() or self:GetShadowTownRedDot() or self:GetPrestigeRedDot() or self:GetLoginAwardRedDot()
end

function CCampaingN7:GetBlackFistRedDot()
  if self._blackfistComponet then
    return self._blackfistComponet:ShowRedDot()
  end
end

function CCampaingN7:GetShadowTownRedDot()
  if self._lineMissionComponet1 == nil then
    return false
  end
  return self._lineMissionComponet1:HaveRedPoint()
end

function CCampaingN7:GetPrestigeRedDot()
  if not self._personProgressComponetInfo then
    return false
  end
  local complate = {}
  local received = {}
  local curProgress = self._personProgressComponetInfo.m_current_progress
  local receivedProgress = self._personProgressComponetInfo.m_received_progress
  for _, progress in pairs(receivedProgress) do
    received[progress] = true
  end
  local cfg = self._personProgressComponetInfo.m_progress_rewards
  for progress, _ in pairs(cfg) do
    if progress <= curProgress then
      complate[#complate + 1] = progress
    end
  end
  for i = 1, #complate do
    if not received[complate[i]] then
      return true
    end
  end
  return false
end

function CCampaingN7:GetLoginAwardRedDot()
  local info = self._cumulativeLoginCompInfo.m_cumulative_info
  for k, v in pairs(info) do
    if v.m_reward_status == ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_CAN_RECV then
      return true
    end
  end
  return false
end
