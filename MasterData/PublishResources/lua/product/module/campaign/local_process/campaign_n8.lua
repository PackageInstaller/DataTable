_class("CCampaignN8", ICampaignComponentLocalProcessBase)
CCampaignN8 = CCampaignN8

function CCampaignN8:Constructor()
  self._cumulativeLoginComponent = nil
  self._cumulativeLoginCompInfo = nil
  self._lineMissionComponent = nil
  self._lineMissionCompInfo = nil
  self._fixTeamLineMissionComponent = nil
  self._fixTeamLineMissionCompInfo = nil
  self._personProgressComponent = nil
  self._personProgressCompInfo = nil
  self._combatSimulatorComponent = nil
  self._combatSimulatorCompInfo = nil
  self._campaignObj = nil
end

function CCampaignN8:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_N8
end

function CCampaignN8:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignN8:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetCumulativeLoginComponent()
  self:_GetLineMissionComponent()
  self:_GetFixTeamLineMissionComponent()
  self:_GetPersonProgressComponent()
  self:_GetCombatSimulatorComponent()
end

function CCampaignN8:_GetCumulativeLoginComponent()
  self._cumulativeLoginComponent = self._campaignObj:GetComponent(ECampaignN8ComponentID.ECAMPAIGN_N8_CUMULATIVE_LOGIN)
  if not self._cumulativeLoginComponent then
    return
  end
  self._cumulativeLoginCompInfo = self._cumulativeLoginComponent:ComponentInfo()
end

function CCampaignN8:_GetLineMissionComponent()
  self._lineMissionComponent = self._campaignObj:GetComponent(ECampaignN8ComponentID.ECAMPAIGN_N8_LINE_MISSION)
  if not self._lineMissionComponent then
    return
  end
  self._lineMissionCompInfo = self._lineMissionComponent:ComponentInfo()
end

function CCampaignN8:_GetFixTeamLineMissionComponent()
  self._fixTeamLineMissionComponent = self._campaignObj:GetComponent(ECampaignN8ComponentID.ECAMPAIGN_N8_LINE_MISSION_FIXTEAM)
  if not self._fixTeamLineMissionComponent then
    return
  end
  self._fixTeamLineMissionCompInfo = self._fixTeamLineMissionComponent:ComponentInfo()
end

function CCampaignN8:_GetPersonProgressComponent()
  self._personProgressComponent = self._campaignObj:GetComponent(ECampaignN8ComponentID.ECAMPAIGN_N8_PERSON_PROGRESS)
  if not self._personProgressComponent then
    return
  end
  self._personProgressCompInfo = self._personProgressComponent:ComponentInfo()
end

function CCampaignN8:_GetCombatSimulatorComponent()
  self._combatSimulatorComponent = self._campaignObj:GetComponent(ECampaignN8ComponentID.ECAMPAIGN_N8_COMBAT_SIMULATOR)
  if not self._combatSimulatorComponent then
    return
  end
  self._combatSimulatorCompInfo = self._combatSimulatorComponent:ComponentInfo()
end

function CCampaignN8:GetComponent(componentID)
  if ECampaignN8ComponentID.ECAMPAIGN_N8_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponent
  end
  if ECampaignN8ComponentID.ECAMPAIGN_N8_LINE_MISSION == componentID then
    return self._lineMissionComponent
  end
  if ECampaignN8ComponentID.ECAMPAIGN_N8_LINE_MISSION_FIXTEAM == componentID then
    return self._fixTeamLineMissionComponent
  end
  if ECampaignN8ComponentID.ECAMPAIGN_N8_PERSON_PROGRESS == componentID then
    return self._personProgressComponent
  end
  if ECampaignN8ComponentID.ECAMPAIGN_N8_COMBAT_SIMULATOR == componentID then
    return self._combatSimulatorComponent
  end
  return nil
end

function CCampaignN8:GetComponentInfo(componentID)
  if ECampaignN8ComponentID.ECAMPAIGN_N8_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginCompInfo
  end
  if ECampaignN8ComponentID.ECAMPAIGN_N8_LINE_MISSION == componentID then
    return self._lineMissionCompInfo
  end
  if ECampaignN8ComponentID.ECAMPAIGN_N8_LINE_MISSION_FIXTEAM == componentID then
    return self._fixTeamLineMissionCompInfo
  end
  if ECampaignN8ComponentID.ECAMPAIGN_N8_PERSON_PROGRESS == componentID then
    return self._personProgressCompInfo
  end
  if ECampaignN8ComponentID.ECAMPAIGN_N8_COMBAT_SIMULATOR == componentID then
    return self._combatSimulatorCompInfo
  end
  return nil
end

function CCampaignN8:GetStepStatusNew()
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local sample = campaignModule:GetSampleByType(ECampaignType.CAMPAIGN_TYPE_N8)
  return sample and sample:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_NEW)
end

function CCampaignN8:GetEntryRedDot()
  return self:GetSimulatorRedDot() or self:GetShadowTownRedDot() or self:GetPrestigeRedDot() or self:GetLoginAwardRedDot()
end

function CCampaignN8:GetSimulatorRedDot()
  if not self._combatSimulatorComponent:ComponentIsOpen() then
    return false
  end
  return self._combatSimulatorComponent:GetCartridgeGiftCount() > 0
end

function CCampaignN8:GetNewCartridgeList()
  cart = self._combatSimulatorComponent:GetCartridgeItemList()
  item = {}
  for k, v in pairs(cart) do
    if v:IsNewDealy() then
      item.insert(v)
    end
  end
  return item
end

function CCampaignN8:GetShadowTownRedDot()
  if not self._fixTeamLineMissionComponent:ComponentIsOpen() then
    return false
  end
  return self._fixTeamLineMissionComponent:HaveRedPoint()
end

function CCampaignN8:GetPrestigeRedDot()
  if not self._personProgressComponent:ComponentIsOpen() then
    return false
  end
  local complate = {}
  local received = {}
  local curProgress = self._personProgressCompInfo.m_current_progress
  local receivedProgress = self._personProgressCompInfo.m_received_progress
  for _, progress in pairs(receivedProgress) do
    received[progress] = true
  end
  local cfg = self._personProgressCompInfo.m_progress_rewards
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

function CCampaignN8:GetLoginAwardRedDot()
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
