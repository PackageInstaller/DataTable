_class("UIN5NewFlagRedPoint", Object)
UIN5NewFlagRedPoint = UIN5NewFlagRedPoint

function UIN5NewFlagRedPoint:Constructor()
  self._campaignModule = GameGlobal.GetModule(CampaignModule)
  self._loginModule = GameGlobal.GetModule(LoginModule)
end

function UIN5NewFlagRedPoint:RequestCampaign()
  GameGlobal.TaskManager():StartTask(self._RequestCampaign, self)
end

function UIN5NewFlagRedPoint:_RequestCampaign(TT)
  self:_RequestCampaignN5(TT)
  self:_RequestCampaignBattlePass(TT)
end

function UIN5NewFlagRedPoint:_RequestCampaignN5(TT)
  local res = AsyncRequestRes:New()
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N5, ECampaignN5ComponentID.ECAMPAIGN_N5_BATTLEFIELD, ECampaignN5ComponentID.ECAMPAIGN_N5_LINE_MISSION_FIXTEAM)
  if res:GetSucc() then
    self._fixteamMissionComponent = self._campaign:GetComponent(ECampaignN5ComponentID.ECAMPAIGN_N5_LINE_MISSION_FIXTEAM)
    self._fixteamMissionComponentInfo = self._campaign:GetComponentInfo(ECampaignN5ComponentID.ECAMPAIGN_N5_LINE_MISSION_FIXTEAM)
    self._battlefieldComponent = self._campaign:GetComponent(ECampaignN5ComponentID.ECAMPAIGN_N5_BATTLEFIELD)
    self._battlefieldComponentInfo = self._campaign:GetComponentInfo(ECampaignN5ComponentID.ECAMPAIGN_N5_BATTLEFIELD)
  end
end

function UIN5NewFlagRedPoint:_RequestCampaignBattlePass(TT)
  local res = AsyncRequestRes:New()
  self._battlePassCampaign = UIActivityCampaign:New()
  self._battlePassCampaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_BATTLEPASS)
end

function UIN5NewFlagRedPoint:LoginRewardRedPoint()
  return self._campaign and self._campaign:CheckComponentOpen(ECampaignN5ComponentID.ECAMPAIGN_N5_CUMULATIVE_LOGIN) and self._campaign:CheckComponentRed(ECampaignN5ComponentID.ECAMPAIGN_N5_CUMULATIVE_LOGIN)
end

function UIN5NewFlagRedPoint:MilitaryExploitRedPoint()
  return self._campaign and self._campaign:CheckComponentOpen(ECampaignN5ComponentID.ECAMPAIGN_N5_PERSON_PROGRESS) and self._campaign:CheckComponentRed(ECampaignN5ComponentID.ECAMPAIGN_N5_PERSON_PROGRESS)
end

function UIN5NewFlagRedPoint:BattlePassRedPoint()
  return UIActivityBattlePassHelper.CheckCampaignRedPoint(self._battlePassCampaign)
end

function UIN5NewFlagRedPoint:PetStageRedPoint()
  if not self._campaign or not self._campaign:CheckComponentOpen(ECampaignN5ComponentID.ECAMPAIGN_N5_LINE_MISSION_FIXTEAM) then
    return false
  end
  if not self._fixteamMissionComponent then
    return false
  end
  if not self._fixteamMissionComponentInfo then
    return false
  end
  local cfgs = Cfg.cfg_campaign_pet_try({
    CampaignId = self._campaign._type
  })
  local lock = false
  if cfgs then
    for key, value in pairs(cfgs) do
      if not self._fixteamMissionComponent:IsPassCamMissionID(value.CampaignMissionId) then
        lock = true
        break
      end
    end
  end
  return self._fixteamMissionComponentInfo.m_b_unlock and lock
end

function UIN5NewFlagRedPoint:BattleFieldReSetRedPoint()
  if not self._battlefieldComponentInfo or not self._campaign:CheckComponentOpen(ECampaignN5ComponentID.ECAMPAIGN_N5_BATTLEFIELD) then
    return false
  end
  local challenge_mission_info = self._battlefieldComponentInfo.m_battlefield_info.m_challenge_mission_info
  local challenged = true
  for key, value in pairs(challenge_mission_info) do
    if value.military_exploit > 0 then
      challenged = false
      break
    end
  end
  return challenged
end

function UIN5NewFlagRedPoint:HaveRedPoint()
  return self:LoginRewardRedPoint() or self:MilitaryExploitRedPoint() or self:PetStageRedPoint() or self:BattleFieldReSetRedPoint()
end

function UIN5NewFlagRedPoint:UnLockNew()
  return self._campaign and self._campaign:CheckCampaignNew()
end

function UIN5NewFlagRedPoint:HaveNewFlag()
  return self:UnLockNew()
end
