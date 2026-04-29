_class("CCampaignN12", ICampaignComponentLocalProcessBase)
CCampaignN12 = CCampaignN12

function CCampaignN12:Constructor()
  self._entrustComponent = nil
  self._entrustCompInfo = nil
  self._dailyMissionComponent = nil
  self._dailyMissionCompInfo = nil
  self._cumulativeLoginComponent = nil
  self._cumulativeLoginCompInfo = nil
  self._fixTeamComponent = nil
  self._fixTeamCompInfo = nil
  self._personProgressScoreComponent = nil
  self._personProgressScoreCompInfo = nil
  self._storyComponent = nil
  self._storyCompInfo = nil
  self._personProgressMissionComponent = nil
  self._personProgressMissionCompInfo = nil
  self._challengeMissionComponent = nil
  self._challengeMissionCompInfo = nil
  self._campaignObj = nil
  self._recordScore = {}
  self._curScore = 0
  self._loginModule = GameGlobal.GetModule(LoginModule)
  self._svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
end

function CCampaignN12:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_N12
end

function CCampaignN12:CampaignObjInfo()
  return self._campaignObj
end

function CCampaignN12:InitComponent(campaignObj)
  self._campaignObj = campaignObj
  self:_GetEntrustComponent()
  self:_GetDailyComponent()
  self:_GetCumulativeLoginComponent()
  self:_GetFixTeamComponent()
  self:_GetPersonProgressScoreComponent()
  self:_GetStoryComponent()
  self:_GetPersonProgressMissionComponent()
  self:_GetChallengeComponent()
end

function CCampaignN12:_GetEntrustComponent()
  self._entrustComponent = self._campaignObj:GetComponent(ECampaignN12ComponentID.ECAMPAIGN_N12_ENTRUST)
  if not self._entrustComponent then
    return
  end
  self._entrustCompInfo = self._entrustComponent:ComponentInfo()
end

function CCampaignN12:_GetDailyComponent()
  self._dailyMissionComponent = self._campaignObj:GetComponent(ECampaignN12ComponentID.ECAMPAIGN_N12_DAILY_MISSION)
  if not self._dailyMissionComponent then
    return
  end
  self._dailyMissionCompInfo = self._dailyMissionComponent:ComponentInfo()
end

function CCampaignN12:_GetCumulativeLoginComponent()
  self._cumulativeLoginComponent = self._campaignObj:GetComponent(ECampaignN12ComponentID.ECAMPAIGN_N12_CUMULATIVE_LOGIN)
  if not self._cumulativeLoginComponent then
    return
  end
  self._cumulativeLoginCompInfo = self._cumulativeLoginComponent:ComponentInfo()
end

function CCampaignN12:_GetFixTeamComponent()
  self._fixTeamComponent = self._campaignObj:GetComponent(ECampaignN12ComponentID.ECAMPAIGN_N12_LEVEL_FIXTEAM)
  if not self._fixTeamComponent then
    return
  end
  self._fixTeamCompInfo = self._fixTeamComponent:ComponentInfo()
end

function CCampaignN12:_GetPersonProgressScoreComponent()
  self._personProgressScoreComponent = self._campaignObj:GetComponent(ECampaignN12ComponentID.ECAMPAIGN_N12_PERSON_PROGRESS_SCORE)
  if not self._personProgressScoreComponent then
    return
  end
  self._personProgressScoreCompInfo = self._personProgressScoreComponent:ComponentInfo()
end

function CCampaignN12:_GetStoryComponent()
  self._storyComponent = self._campaignObj:GetComponent(ECampaignN12ComponentID.ECAMPAIGN_N12_STORY)
  if not self._storyComponent then
    return
  end
  self._storyCompInfo = self._storyComponent:ComponentInfo()
end

function CCampaignN12:_GetPersonProgressMissionComponent()
  self._personProgressMissionComponent = self._campaignObj:GetComponent(ECampaignN12ComponentID.ECAMPAIGN_N12_QUEST_MISSION)
  if not self._personProgressMissionComponent then
    return
  end
  self._personProgressMissionCompInfo = self._personProgressMissionComponent:ComponentInfo()
end

function CCampaignN12:_GetChallengeComponent()
  self._challengeMissionComponent = self._campaignObj:GetComponent(ECampaignN12ComponentID.ECAMPAIGN_N12_CHALLENGE_MISSION)
  if not self._challengeMissionComponent then
    return
  end
  self._challengeMissionCompInfo = self._challengeMissionComponent:ComponentInfo()
  self:InitRecordScore()
end

function CCampaignN12:GetComponent(componentID)
  if ECampaignN12ComponentID.ECAMPAIGN_N12_ENTRUST == componentID then
    return self._entrustComponent
  end
  if ECampaignN12ComponentID.ECAMPAIGN_N12_DAILY_MISSION == componentID then
    return self._dailyMissionComponent
  end
  if ECampaignN12ComponentID.ECAMPAIGN_N12_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginComponent
  end
  if ECampaignN12ComponentID.ECAMPAIGN_N12_LEVEL_FIXTEAM == componentID then
    return self._fixTeamComponent
  end
  if ECampaignN12ComponentID.ECAMPAIGN_N12_PERSON_PROGRESS_SCORE == componentID then
    return self._personProgressScoreComponent
  end
  if ECampaignN12ComponentID.ECAMPAIGN_N12_STORY == componentID then
    return self._storyComponent
  end
  if ECampaignN12ComponentID.ECAMPAIGN_N12_QUEST_MISSION == componentID then
    return self._personProgressMissionComponent
  end
  if ECampaignN12ComponentID.ECAMPAIGN_N12_CHALLENGE_MISSION == componentID then
    return self._challengeMissionComponent
  end
  return nil
end

function CCampaignN12:GetComponentInfo(componentID)
  if ECampaignN12ComponentID.ECAMPAIGN_N12_ENTRUST == componentID then
    return self._entrustCompInfo
  end
  if ECampaignN12ComponentID.ECAMPAIGN_N12_DAILY_MISSION == componentID then
    return self._dailyMissionCompInfo
  end
  if ECampaignN12ComponentID.ECAMPAIGN_N12_CUMULATIVE_LOGIN == componentID then
    return self._cumulativeLoginCompInfo
  end
  if ECampaignN12ComponentID.ECAMPAIGN_N12_LEVEL_FIXTEAM == componentID then
    return self._fixTeamCompInfo
  end
  if ECampaignN12ComponentID.ECAMPAIGN_N12_PERSON_PROGRESS_SCORE == componentID then
    return self._personProgressScoreCompInfo
  end
  if ECampaignN12ComponentID.ECAMPAIGN_N12_STORY == componentID then
    return self._storyCompInfo
  end
  if ECampaignN12ComponentID.ECAMPAIGN_N12_QUEST_MISSION == componentID then
    return self._personProgressMissionCompInfo
  end
  if ECampaignN12ComponentID.ECAMPAIGN_N12_CHALLENGE_MISSION == componentID then
    return self._challengeMissionCompInfo
  end
  return nil
end

function CCampaignN12:GetStepStatusNew()
  return self._campaignObj.m_sample_info:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_NEW) or self:GetEntrustMissionNew()
end

function CCampaignN12:GetEntryRedDot()
  return self:GetScoreRedDot() or self:GetStoryRedDot() or self:GetChallengeMissionRedDot() or self:GetFixMissionRedDot() or self:GetDailyMissionRedDot() or self:GetEntrustMissionRedDot() or self:GetLoginAwardRedDot()
end

function CCampaignN12:GetLoginAwardRedDot()
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

function CCampaignN12:GetScoreRedDot()
  if not self._personProgressScoreComponent:ComponentIsOpen() then
    return false
  end
  local complate = {}
  local received = {}
  local curProgress = self._personProgressScoreCompInfo.m_current_progress
  local receivedProgress = self._personProgressScoreCompInfo.m_received_progress
  for _, progress in pairs(receivedProgress) do
    received[progress] = true
  end
  local cfg = self._personProgressScoreCompInfo.m_progress_rewards
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

function CCampaignN12:GetStoryRedDot()
  if not self._storyComponent:ComponentIsOpen() then
    return false
  end
  return self._storyComponent:HaveRedPoint()
end

function CCampaignN12:GetChallengeMissionRedDot()
  if not self._challengeMissionComponent:ComponentIsOpen() then
    return false
  end
  return self._challengeMissionComponent:HaveRedPoint()
end

function CCampaignN12:GetFixMissionRedDot()
  if not (self._fixTeamComponent and self._fixTeamCompInfo) or not self._fixTeamComponent:ComponentIsOpen() then
    return false
  end
  local cfgs = Cfg.cfg_campaign_pet_try({
    CampaignId = ECampaignType.CAMPAIGN_TYPE_N12
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

function CCampaignN12:GetDailyMissionRedDot()
  if not self._dailyMissionComponent:ComponentIsOpen() then
    return false
  end
  if self._dailyMissionCompInfo.m_total_score >= self._dailyMissionCompInfo.m_score_limit then
    return N12ToolFunctions.GetLocalDBInt("N12NormalLevelCurDay", 0) ~= self._dailyMissionCompInfo.m_cur_day_index
  else
    return self._dailyMissionComponent:HaveRedPoint()
  end
end

function CCampaignN12:GetEntrustMissionRedDot()
  if not self._entrustComponent:ComponentIsOpen() then
    return false
  end
  return self._entrustComponent:HaveRedPoint()
end

function CCampaignN12:GetEntrustMissionNew()
  if not self._entrustComponent:ComponentIsOpen() then
    return false
  end
  local new = N12ToolFunctions.GetLocalDBInt(N12OperationRecordKey.EnteredEntrust, 0) <= 0
  return new or UIActivityN12Helper.EntrustHasNew(self._entrustComponent)
end

function CCampaignN12:InitRecordScore()
  for key, value in pairs(self._challengeMissionCompInfo.m_max_score) do
    self._recordScore[key] = value
  end
end

function CCampaignN12:GetRecordScore(index)
  local score = self._recordScore[index]
  if self._challengeMissionCompInfo then
    self._recordScore[index] = self._challengeMissionCompInfo.m_max_score[index]
  end
  return score
end

function CCampaignN12:SetCurScore(score)
  self._curScore = score
end

function CCampaignN12:GetCurScore()
  return self._curScore
end
