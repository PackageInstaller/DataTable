_class("CCampaingN5", ICampaignComponentLocalProcessBase)
CCampaingN5 = CCampaingN5

function CCampaingN5:Constructor()
  self._battlefieldComponent = nil
  self._battlefieldCompInfo = nil
  self._personProgressComponent = nil
  self._personProgressCompInfo = nil
  self._cumulativeLoginComponent = nil
  self._cumulativeLoginCompInfo = nil
  self._lineMissionComponet = nil
  self._lineMissionCompInfo = nil
  self._lineMissionComponet1 = nil
  self._lineMissionCompInfo1 = nil
  self._campaignObj = nil
  self._recordMilitaryExploit = {}
end

function CCampaingN5:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_N5
end

function CCampaingN5:CampaignObjInfo()
  return self._campaignObj
end

function CCampaingN5:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetBattlefieldComponent()
  self:_GetPersonProgressComponent()
  self:_GetCumulativeLoginComponent()
  self:_GetLineMissionComponent()
  self:_GetFixTeamLineMissionComponent()
end

function CCampaingN5:_GetBattlefieldComponent()
  self._battlefieldComponent = self._campaignObj:GetComponent(ECampaignN5ComponentID.ECAMPAIGN_N5_BATTLEFIELD)
  if not self._battlefieldComponent then
    return
  end
  self._battlefieldCompInfo = self._battlefieldComponent:ComponentInfo()
  self:RefreshRecordMilitaryExploit()
end

function CCampaingN5:_GetPersonProgressComponent()
  self._personProgressComponent = self._campaignObj:GetComponent(ECampaignN5ComponentID.ECAMPAIGN_N5_PERSON_PROGRESS)
  if not self._personProgressComponent then
    return
  end
  self._personProgressCompInfo = self._personProgressComponent:ComponentInfo()
end

function CCampaingN5:_GetCumulativeLoginComponent()
  self._cumulativeLoginComponent = self._campaignObj:GetComponent(ECampaignN5ComponentID.ECAMPAIGN_N5_CUMULATIVE_LOGIN)
  if not self._cumulativeLoginComponent then
    return
  end
  self._cumulativeLoginCompInfo = self._cumulativeLoginComponent:ComponentInfo()
end

function CCampaingN5:_GetLineMissionComponent()
  self._lineMissionComponet = self._campaignObj:GetComponent(ECampaignN5ComponentID.ECAMPAIGN_N5_LINE_MISSION)
  if not self._lineMissionComponet then
    return
  end
  self._lineMissionCompInfo = self._lineMissionComponet:ComponentInfo()
end

function CCampaingN5:_GetFixTeamLineMissionComponent()
  self._lineMissionComponet1 = self._campaignObj:GetComponent(ECampaignN5ComponentID.ECAMPAIGN_N5_LINE_MISSION_FIXTEAM)
  if not self._lineMissionComponet1 then
    return
  end
  self._lineMissionCompInfo1 = self._lineMissionComponet1:ComponentInfo()
end

function CCampaingN5:GetComponent(componentID)
  if ECampaignN5ComponentID.ECAMPAIGN_N5_BATTLEFIELD == componentID then
    return self._battlefieldComponent
  end
  if ECampaignN5ComponentID.ECAMPAIGN_N5_PERSON_PROGRESS == componentID then
    return self._personProgressComponent
  end
  if ECampaignN5ComponentID.ECAMPAIGN_N5_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponent
  end
  if ECampaignN5ComponentID.ECAMPAIGN_N5_LINE_MISSION == componentID then
    return self._lineMissionComponet
  end
  if ECampaignN5ComponentID.ECAMPAIGN_N5_LINE_MISSION_FIXTEAM == componentID then
    return self._lineMissionComponet1
  end
  return nil
end

function CCampaingN5:GetComponentInfo(componentID)
  if ECampaignN5ComponentID.ECAMPAIGN_N5_BATTLEFIELD == componentID then
    return self._battlefieldCompInfo
  end
  if ECampaignN5ComponentID.ECAMPAIGN_N5_PERSON_PROGRESS == componentID then
    return self._personProgressCompInfo
  end
  if ECampaignN5ComponentID.ECAMPAIGN_N5_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginCompInfo
  end
  if ECampaignN5ComponentID.ECAMPAIGN_N5_LINE_MISSION == componentID then
    return self._lineMissionCompInfo
  end
  if ECampaignN5ComponentID.ECAMPAIGN_N5_LINE_MISSION_FIXTEAM == componentID then
    return self._lineMissionCompInfo1
  end
  return nil
end

function CCampaingN5:RefreshRecordMilitaryExploit()
  for key, value in pairs(self._battlefieldCompInfo.m_battlefield_info.m_challenge_mission_info) do
    self._recordMilitaryExploit[key] = value.military_exploit
  end
end

function CCampaingN5:GetRecordMilitaryExploit(id)
  local militaryExploit = self._recordMilitaryExploit[id]
  if self._battlefieldCompInfo then
    self._recordMilitaryExploit[id] = self._battlefieldCompInfo.m_battlefield_info.m_challenge_mission_info[id].military_exploit
  end
  return militaryExploit
end
