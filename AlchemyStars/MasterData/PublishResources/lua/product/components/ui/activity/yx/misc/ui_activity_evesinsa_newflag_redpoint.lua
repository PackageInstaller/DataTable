_class("UIActivityEveSinaNewFlagRedPoint", Object)
UIActivityEveSinaNewFlagRedPoint = UIActivityEveSinaNewFlagRedPoint

function UIActivityEveSinaNewFlagRedPoint:Constructor()
  self._campaignModule = GameGlobal.GetModule(CampaignModule)
  self._loginModule = GameGlobal.GetModule(LoginModule)
end

function UIActivityEveSinaNewFlagRedPoint:RequestCampaign()
  GameGlobal.TaskManager():StartTask(self._RequestCampaign, self)
end

function UIActivityEveSinaNewFlagRedPoint:_RequestCampaign(TT)
  local res = AsyncRequestRes:New()
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_EVERESCUEPLAN, ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_PERSON_PROGRESS, ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_CUMULATIVE_LOGIN, ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_QUEST, ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_TREE_MISSION, ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_MISSION_FIXTEAM, ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_ACTION_POINT)
  if res:GetSucc() then
    self._treeMissionComponentInfo = self._campaign:GetComponentInfo(ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_TREE_MISSION)
    self._fixteamMissionComponent = self._campaign:GetComponent(ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_MISSION_FIXTEAM)
    self._fixteamMissionComponentInfo = self._campaign:GetComponentInfo(ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_MISSION_FIXTEAM)
    self._actionPointComponent = self._campaign:GetComponent(ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_ACTION_POINT)
  else
    self._campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
  end
end

function UIActivityEveSinaNewFlagRedPoint:LoginRewardRedPoint()
  return self._campaign and self._campaign:CheckComponentOpen(ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_CUMULATIVE_LOGIN) and self._campaign:CheckComponentRed(ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_CUMULATIVE_LOGIN)
end

function UIActivityEveSinaNewFlagRedPoint:QuestRewardRedPoint()
  return not self._campaign or self:_QuestRedPoint() or self:_PersonProgressRedPoint()
end

function UIActivityEveSinaNewFlagRedPoint:_QuestRedPoint()
  return self._campaign:CheckComponentOpen(ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_QUEST) and self._campaign:CheckComponentRed(ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_QUEST)
end

function UIActivityEveSinaNewFlagRedPoint:_PersonProgressRedPoint()
  return self._campaign:CheckComponentOpen(ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_PERSON_PROGRESS) and self._campaign:CheckComponentRed(ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_PERSON_PROGRESS)
end

function UIActivityEveSinaNewFlagRedPoint:PetStageRedPoint()
  if not self._campaign or not self._campaign:CheckComponentOpen(ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_MISSION_FIXTEAM) then
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

function UIActivityEveSinaNewFlagRedPoint:ActionPointRedPoint()
  if not self._actionPointComponent or not self._campaign:CheckComponentOpen(ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_ACTION_POINT) then
    return false
  end
  local cmpID = self._actionPointComponent:GetComponentCfgId()
  local pointCfg = self._actionPointComponent:GetActionPointConfig()
  local count = GameGlobal.GetModule(ItemModule):GetItemCount(pointCfg.ItemID)
  return count >= pointCfg.RegainMax
end

function UIActivityEveSinaNewFlagRedPoint:HaveRedPoint()
  return self:LoginRewardRedPoint() or self:QuestRewardRedPoint() or self:PetStageRedPoint() or self:ActionPointRedPoint()
end

function UIActivityEveSinaNewFlagRedPoint:UnLockNew()
  return self._campaign and self._campaign:CheckCampaignNew()
end

function UIActivityEveSinaNewFlagRedPoint:P2StageUnLockNew()
  return self._treeMissionComponentInfo and self._campaign:CheckComponentOpen(ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_TREE_MISSION) and self._treeMissionComponentInfo.m_b_unlock and self:P2StageUnLockLocalRecord()
end

function UIActivityEveSinaNewFlagRedPoint:P1SStageUnLockNew()
  return self:P1SStageUnLock() and self._campaign:CheckComponentOpen(ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_TREE_MISSION) and self._campaign:CheckComponentOpen(ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_LINE_MISSION) and self:P1StageUnLockLocalRecord()
end

function UIActivityEveSinaNewFlagRedPoint:P1SStageUnLock()
  return self._campaign and UIActivityEveSinsaHelper.CheckSpecialMissionCanPlay(self._campaign)
end

function UIActivityEveSinaNewFlagRedPoint:HaveNewFlag()
  return self:UnLockNew() or self:P2StageUnLockNew() or self:P1SStageUnLockNew()
end

function UIActivityEveSinaNewFlagRedPoint:P2StageUnLockLocalRecord()
  return LocalDB.GetInt("ACTIVITY_EVE_SINA_P2_NEWFLAG" .. self._loginModule:GetRoleShowID(), 0) <= 0
end

function UIActivityEveSinaNewFlagRedPoint:P1StageUnLockLocalRecord()
  return LocalDB.GetInt("ACTIVITY_EVE_SINA_P1S_NEWFLAG" .. self._loginModule:GetRoleShowID(), 0) <= 0
end
