_class("TalePetModule", GameModule)
TalePetModule = TalePetModule

function TalePetModule:Constructor()
  self.formationList_ = {}
  self.mCanDo = false
  self.mCanCall = false
  self.mFirstEnter = false
  self.mFirstBuff = false
  self.mSelectPetCfgId = 0
  self.mDatas = {}
  self.mStartTime = 0
  self.mEndTime = 0
  self.mReq = false
end

function TalePetModule:Init()
  TalePetModule.super.Init(self)
  self.caller:RegisterPushHandler(CEventNotifyTalePetChange, self.HandleChangeData, self)
  self.caller:RegisterPushHandler(CEventPushNewBuffInfo, self.HandlePushNewBuffInfo, self)
end

function TalePetModule:Dispose()
  self.caller:UnRegisterPushHandler(CEventNotifyTalePetChange)
  TalePetModule.super.Dispose(self)
  self.caller:UnRegisterPushHandler(CEventPushNewBuffInfo)
  self:ClearData()
end

function TalePetModule:Update()
end

function TalePetModule:ClearData()
  self.mCanDo = false
  self.mCanCall = false
  self._taskRed = false
  self.mFirstEnter = false
  self.mFirstBuff = false
  self.mSelectPetCfgId = 0
  self.mDatas = {}
  self.mStartTime = 0
  self.mEndTime = 0
  self.mReq = false
end

function TalePetModule:SetCanCall(isDo, isCall, taskRed)
  self.mCanDo = isDo
  self.mCanCall = isCall
  self._taskRed = taskRed
end

function TalePetModule:SetInitRewardRed(red)
  self._initRewardRed = red
end

function TalePetModule:HandleChangeData(info)
  for key, value in pairs(info.datas) do
    self:SetPetData(value)
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.TalePetInfoDataChange)
end

function TalePetModule:SetData(info)
  self.mFirstEnter = info.first_enter
  self.mFirstBuff = info.first_buff
  self.mSelectPetCfgId = info.select_cfg_id
  self.mDatas = {}
  for key, value in pairs(info.datas) do
    self:SetPetData(value)
  end
  self.mStartTime = info.start_time
  self.mEndTime = info.end_time
end

function TalePetModule:SetPetData(info)
  self.mDatas[info.pet_cfg_id] = info
  local rew = {}
  for key, value in pairs(info.task_phase_reward) do
    rew[value] = value
  end
  self.mDatas[info.pet_cfg_id].task_phase_reward = rew
end

function TalePetModule:IsAllGetReward()
  if self.mReq == false then
    return self._taskRed
  end
  local cfgs = Cfg.cfg_tale_pet({})
  for _, v in pairs(cfgs) do
    local vv = self:IsGetReward(v.ID)
    if vv == true then
      return true
    end
  end
  return false
end

function TalePetModule:IsGetReward(petCfgId)
  local cfg = Cfg.cfg_tale_pet[petCfgId]
  if cfg == nil then
    return false
  end
  local info = self.mDatas[petCfgId]
  if info == nil then
    return false
  end
  local listCfg = Cfg.cfg_tale_task_phase_reward({PetID = petCfgId})
  if listCfg == nil then
    return false
  end
  if info.pet_status == TalePetCallType.TPCT_Can_Do or info.pet_status == TalePetCallType.TPCT_Done then
    for key, value in pairs(listCfg) do
      if info.task_phase_reward[value.ID] == nil then
        return true
      end
    end
  else
    for key, value in pairs(listCfg) do
      if value.Phase <= info.task_phase and info.task_phase_reward[value.ID] == nil then
        return true
      end
    end
  end
  return false
end

function TalePetModule:IsCanDo()
  if self.mReq == true then
    return self:IsDoPet()
  end
  return self.mCanDo
end

function TalePetModule:IsCanCall()
  if self.mReq == true then
    return self:IsCallPet()
  end
  return self.mCanCall
end

function TalePetModule:IsDoPet()
  local num = 0
  local cfgs = Cfg.cfg_tale_pet({})
  for _, v in pairs(cfgs) do
    num = num + 1
  end
  for _, info in pairs(self.mDatas) do
    num = num - 1
    if info.pet_status == TalePetCallType.TPCT_Doing then
      return false
    end
  end
  if self.mSelectPetCfgId ~= 0 then
    local minfo = self:GetPetInfo(self.mSelectPetCfgId)
    if minfo ~= nil and minfo.pet_status == TalePetCallType.TPCT_Done then
      return true
    else
      return false
    end
  end
  if 0 < num then
    return true
  end
  return false
end

function TalePetModule:IsCallPet()
  local cfgs = Cfg.cfg_tale_pet({})
  for _, v in pairs(cfgs) do
    local info = self:GetPetInfo(v.ID)
    if info ~= nil and info.pet_status == TalePetCallType.TPCT_Can_Do then
      return true
    end
  end
  return false
end

function TalePetModule:IsCanCallPet(petId)
  local info = self:GetPetInfo(petId)
  if info ~= nil and info.pet_status == TalePetCallType.TPCT_Can_Do then
    return true
  end
  return false
end

function TalePetModule:IsFirstEnter()
  return self.mFirstEnter
end

function TalePetModule:IsFirstBuff()
  return self.mFirstBuff
end

function TalePetModule:SelectPetCfgId()
  return self.mSelectPetCfgId
end

function TalePetModule:GetActityTime()
  return self.mStartTime, self.mEndTime
end

function TalePetModule:IsOpenActity()
  if self.mStartTime == 0 or self.mEndTime == 0 then
    return false
  end
  local timeModule = GameGlobal.GetModule(SvrTimeModule)
  local nowTime = timeModule:GetServerTime() / 1000
  if nowTime < self.mStartTime or nowTime > self.mEndTime then
    return false
  end
  return true
end

function TalePetModule:IsCalled(petCfgId)
  local cfg = Cfg.cfg_tale_pet[petCfgId]
  if cfg == nil then
    return false
  end
  local info = self.mDatas[petCfgId]
  if info == nil then
    return false
  end
  return info.pet_status == TalePetCallType.TPCT_Done
end

function TalePetModule:GetPetInfo(petCfgId)
  local cfg = Cfg.cfg_tale_pet[petCfgId]
  if cfg == nil then
    return nil
  end
  local info = self.mDatas[petCfgId]
  return info
end

function TalePetModule:ReqTalePet(TT)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventTalePetReq)
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res, nil
  end
  self.mReq = true
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.ret)
  self:SetData(replyEvent)
  return res, replyEvent
end

function TalePetModule:ReqTaleChoose(TT, petCfgId)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventTaleChooseReq)
  request.cfg_id = petCfgId
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res, nil
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.ret)
  if replyEvent.ret == TALE_PET_RESULT_CODE.TALE_PET_SUCCEED then
    self.mSelectPetCfgId = petCfgId
  end
  return res, replyEvent
end

function TalePetModule:ReqTaleTaskReward(TT, rewardCfgId)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventTaleTaskRewardReq)
  request.cfg_id = rewardCfgId
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res, nil
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.ret)
  return res, replyEvent
end

function TalePetModule:ReqTaleCall(TT, petCfgId)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventTalePetCallReq)
  request.cfg_id = petCfgId
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res, nil
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.ret)
  return res, replyEvent
end

function TalePetModule:ReqTaleFirst(TT, tfType, cfgId)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventTaleFirstReq)
  request.types = tfType
  request.cfg_id = cfgId ~= nil and cfgId or 0
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res, nil
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.ret)
  if replyEvent.ret == TALE_PET_RESULT_CODE.TALE_PET_SUCCEED then
    if tfType == TaleFirstType.TFT_Enter then
      self.mFirstEnter = true
    elseif tfType == TaleFirstType.TFT_Buff then
      self.mFirstBuff = true
    end
  end
  return res, replyEvent
end

function TalePetModule:GetCurCallState()
  local cfg = Cfg.cfg_tale_pet({})
  if cfg == nil then
    return nil
  end
  for index, value in pairs(cfg) do
    local info = self.mDatas[value.ID]
    if info ~= nil and info.pet_status == TalePetCallType.TPCT_Doing then
      return value.ID
    end
  end
  return nil
end

function TalePetModule:GetTaskPhase(petId)
  local listCfg = Cfg.cfg_tale_task({PetID = petId})
  if listCfg == nil then
    return 0
  end
  local count = 0
  for index, value in pairs(listCfg) do
    count = count < value.Phase and value.Phase or count
  end
  return count
end

function TalePetModule:GetTaskCounts(petId, index)
  local listCfg = Cfg.cfg_tale_task({PetID = petId, Phase = index})
  if listCfg == nil then
    return 0
  end
  local count = 0
  for index, value in pairs(listCfg) do
    count = count + 1
  end
  return count
end

function TalePetModule:CanGetTaskPhaseAward(petId)
  local info = self:GetPetInfo(petId)
  local task_phase_reward = info.task_phase_reward
  local curStage = info.task_phase
  local count = table.count(task_phase_reward)
  if info.pet_status == TalePetCallType.TPCT_Can_Do or info.pet_status == TalePetCallType.TPCT_Done then
    return count + 1
  end
  if curStage > count then
    return count + 1
  end
  return 0
end

function TalePetModule:IsGetAll()
  local cfgs = Cfg.cfg_tale_pet({})
  for _, v in pairs(cfgs) do
    local info = self:GetPetInfo(v.ID)
    if info == nil then
      return false
    end
    if info.pet_status ~= TalePetCallType.TPCT_Done then
      return false
    end
  end
  return true
end

function TalePetModule:IsGetPetAlready()
  local cfgs = Cfg.cfg_tale_pet({})
  if cfgs == nil then
    return false
  end
  for index, value in pairs(cfgs) do
    local info = self:GetPetInfo(value.ID)
    if info ~= nil and info.pet_status == TalePetCallType.TPCT_Done then
      return true
    end
  end
  return false
end

function TalePetModule:GetEnterTrailLevelStoryIds()
  local templateIdList = self:GetTalePetList()
  local storyIds = {}
  local templateIds = {}
  for i = 1, #templateIdList do
    local templateId = templateIdList[i]
    local result = self:IsCalled(templateId)
    if result then
      local ret = self:GetPetInfo(templateId)
      local status = ret.first_status
      local result = status & 1 << TalePetDBFirstType.TPDBFT_Story
      if result == 0 then
        local cfg = Cfg.cfg_tale_pet[templateId]
        if cfg then
          storyIds[#storyIds + 1] = cfg.StoryId
          templateIds[#templateIds + 1] = templateId
        end
      end
    end
  end
  return storyIds, templateIds
end

function TalePetModule:PlayTrailLevelStroyComplete(TT, templateId)
  self:ReqTaleFirst(TT, TaleFirstType.TFT_Story, templateId)
end

function TalePetModule:IsShowBuffTips()
  return not self:IsFirstBuff()
end

function TalePetModule:ShowBuffTips(TT)
  self:ReqTaleFirst(TT, TaleFirstType.TFT_Buff)
end

function TalePetModule:RequestTrailLevelData(TT)
  local res = self:ReqTalePet(TT)
  if not res:GetSucc() or res:GetResult() ~= TALE_PET_RESULT_CODE.TALE_PET_SUCCEED then
    return -1
  end
  res = self:ApplyBuffInfo(TT)
  if not res:GetSucc() or res:GetResult() ~= TALE_PET_RESULT_CODE.TALE_PET_SUCCEED then
    return -1
  end
  res = self:ApplyPassedTaleStage(TT)
  if not res:GetSucc() or res:GetResult() ~= TALE_PET_RESULT_CODE.TALE_PET_SUCCEED then
    return -1
  end
  res = self:ApplyRewardStatus(TT)
  if not res:GetSucc() or res:GetResult() ~= TALE_PET_RESULT_CODE.TALE_PET_SUCCEED then
    return -1
  end
  return 0
end

function TalePetModule:GetBuffLevel()
  local exp = self:GetBuffExperience()
  local cfgs = Cfg.cfg_trail_level_buff_level({})
  local maxLevel = #cfgs
  for i = 1, #cfgs do
    local needExp = cfgs[i].Exp
    if exp < needExp then
      local level = i - 1
      if level < 1 then
        level = 1
      end
      return level, maxLevel
    end
  end
  return maxLevel, maxLevel
end

function TalePetModule:GetBuffExp()
  local level, maxLevel = self:GetBuffLevel()
  if maxLevel <= level then
    return 1, 1
  end
  local cfgNext = Cfg.cfg_trail_level_buff_level[level + 1]
  local cfg = Cfg.cfg_trail_level_buff_level[level]
  local maxExp = cfgNext.Exp - cfg.Exp
  local exp = self:GetBuffExperience()
  return exp - cfg.Exp, maxExp
end

function TalePetModule:GetTalePetList()
  local cfgs = Cfg.cfg_tale_pet({})
  local list = {}
  for _, v in pairs(cfgs) do
    list[#list + 1] = v.ID
  end
  return list
end

function TalePetModule:IsGetTalePet(templateId)
  return self:IsCalled(templateId)
end

function TalePetModule:GetLevelCount()
  local count = 0
  local completeLevel = 0
  local layerCfgs = Cfg.cfg_tale_stage_layer({})
  for i = 1, #layerCfgs do
    local layerCfg = layerCfgs[i]
    local levelCfgs = Cfg.cfg_tale_stage({
      Type = 2,
      Tier = layerCfg.ID
    })
    if levelCfgs then
      for k, v in pairs(levelCfgs) do
        if self:HasCompletLevel(v.ID) then
          completeLevel = completeLevel + 1
        end
      end
      count = count + table.count(levelCfgs)
    end
  end
  return completeLevel, count
end

function TalePetModule:HasCompletLevel(levelId)
  local passedDatas = self:GetPassedTaleStageData()
  if passedDatas == nil or passedDatas[levelId] == nil then
    return false
  end
  if 0 < passedDatas[levelId] then
    return true
  end
  return false
end

function TalePetModule:HasOpenFinalLevel()
  local cfgs = Cfg.cfg_tale_stage_layer({
    LayerType = TrailLevelLayerType.Final
  })
  if cfgs and cfgs[1] then
    local cfgStages = Cfg.cfg_tale_stage({
      Tier = cfgs[1].ID,
      UnlockType = UnlockType.UT_HaveAll
    })
    if cfgStages and cfgStages[1] then
      local petIDs = cfgStages[1].UnlockPetId
      if petIDs then
        for _, petID in pairs(petIDs) do
          if self:IsGetTalePet(petID) == false then
            return false
          end
        end
        return true
      end
    end
  end
  return false
end

function TalePetModule:IsShowRewardRed()
  if self._initRewardRed ~= nil then
    local ret = self._initRewardRed
    return ret
  end
  local rewardList = self:GetTrailLevelRewardList()
  for i = 1, #rewardList do
    if rewardList[i][2] == AwardAcceptStatus.AAS_WaitingForAccept then
      return true
    end
  end
  return false
end

function TalePetModule:IsShowTrailFinalLevelRed()
  if self:HasOpenFinalLevel() then
    local layerCfgs = Cfg.cfg_tale_stage_layer({
      LayerType = TrailLevelLayerType.Final
    })
    for i = 1, #layerCfgs do
      local layerCfg = layerCfgs[i]
      local levelCfgs = Cfg.cfg_tale_stage({
        Type = 2,
        Tier = layerCfg.ID
      })
      if levelCfgs then
        for j = 1, #levelCfgs do
          local hasCompleteLevel = self:HasCompletLevel(levelCfgs[j].ID)
          if not hasCompleteLevel then
            return true
          end
        end
      end
    end
  end
  return false
end

function TalePetModule:UltimateMissionUnPassed()
end

function TalePetModule:GetTrailLevelRewardList()
  return self:DirectGetStatusList()
end

function TalePetModule:GetEnterTalePetStoryIds()
  local cfg = Cfg.cfg_tale_pet_global({})
  local storyId = cfg.TalePetEnterStoryId.IntValue
  return storyId
end

function TalePetModule:GetActivityTalePet()
  local talePets = {}
  local cfgs = Cfg.cfg_tale_pet({})
  for i = 1, table.count(cfgs) do
    local cfg = Cfg.cfg_tale_pet({Sort = i})[1]
    table.insert(talePets, cfg)
  end
  return talePets
end

local AwardAcceptStatus = {
  AAS_WaitingForAccept = 0,
  AAS_Accepted = 1,
  AAS_UnReach = 2
}
_enum("AwardAcceptStatus", AwardAcceptStatus)

function TalePetModule:RequestServerFormationList(TT)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventReqTaleletFormation)
  local res = AsyncRequestRes:New()
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  res:SetResult(reply.msg.ret)
  if reply.msg.ret == TALE_PET_RESULT_CODE.TALE_PET_SUCCEED then
    self.formationList_ = reply.msg.formation_info
    Log.debug("self.formationList_.size() : ", #self.formationList_)
  end
  return res
end

function TalePetModule:GetFormationList()
  return self.formationList_.formation_list
end

function TalePetModule:UpdateMainFormationInfo(TT, formationID, formationName, petList)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventRequestChangeTalepetFormation)
  local res = AsyncRequestRes:New()
  request.m_formation_id = formationID
  request.m_formation_name = formationName
  request.m_formation_pet_list = petList
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  res:SetResult(reply.msg.ret)
  if reply.msg.ret == TALE_PET_RESULT_CODE.TALE_PET_SUCCEED then
    self.formationList_ = reply.msg.formation_info
    Log.debug("self.formationList_.size() : ", #self.formationList_)
  end
  return res
end

function TalePetModule:ApplyPassedTaleStage(TT)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventReqPassedTaleMission)
  local res = AsyncRequestRes:New()
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  res:SetResult(reply.msg.ret)
  if reply.msg.ret == TALE_PET_RESULT_CODE.TALE_PET_SUCCEED then
    self.taleStageList_ = reply.msg.tale_mission_list
    Log.debug("self.formationList_.size() : ", table.count(self.taleStageList_))
  end
  return res
end

function TalePetModule:GetPassedTaleStageData()
  return self.taleStageList_
end

function TalePetModule:GetPassedTaleStageCount()
  local count = 0
  if not self.taleStageList_ then
    return 0
  end
  for k, v in pairs(self.taleStageList_) do
    local cfg = Cfg.cfg_tale_stage[k]
    if cfg ~= nil and cfg.Type == TaleType.TT_FightMission then
      count = count + 1
    end
  end
  return count
end

function TalePetModule:ApplyRewardStatus(TT)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventReqRewardStatus)
  local res = AsyncRequestRes:New()
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  res:SetResult(reply.msg.ret)
  if reply.msg.ret == TALE_PET_RESULT_CODE.TALE_PET_SUCCEED then
    self.acceptStageIDs_ = reply.msg.accepted_stage_ids
    Log.debug("AcceptStageIDs.size() : ", table.count(self.acceptStageIDs_))
  end
  return res
end

function TalePetModule:GetRewardStatusData()
  return self.acceptStageIDs_
end

function TalePetModule:DirectGetStatusList()
  self._initRewardRed = nil
  local reward_cfg = Cfg.cfg_tale_stage_reward({})
  local ret = {}
  local acceptIDs = self:GetRewardStatusData()
  for k, v in pairs(reward_cfg) do
    if self:GetPassedTaleStageCount() < v.Count then
      ret[#ret + 1] = {
        v.ID,
        AwardAcceptStatus.AAS_UnReach
      }
      Log.debug(v.ID, "AwardAcceptStatus.AAS_UnReach")
    elseif table.icontains(acceptIDs, v.ID) then
      ret[#ret + 1] = {
        v.ID,
        AwardAcceptStatus.AAS_Accepted
      }
      Log.debug(v.ID, "AwardAcceptStatus.AAS_Accepted")
    else
      ret[#ret + 1] = {
        v.ID,
        AwardAcceptStatus.AAS_WaitingForAccept
      }
      Log.debug(v.ID, "AwardAcceptStatus.AAS_WaitingForAccept")
    end
  end
  return ret
end

function TalePetModule:ApplyGetReward(TT, stage_reward_id)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventReqAcceptStageReward)
  local res = AsyncRequestRes:New()
  request.stage_id = stage_reward_id
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  res:SetResult(reply.msg.ret)
  if reply.msg.ret == TALE_PET_RESULT_CODE.TALE_PET_SUCCEED then
    table.insert(self.acceptStageIDs_, stage_reward_id)
    Log.debug("CEventReqAcceptStageReward success")
  end
  return res
end

function TalePetModule:ApplyBuffInfo(TT)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventReqCurrentBuffInfo)
  local res = AsyncRequestRes:New()
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  res:SetResult(reply.msg.ret)
  if reply.msg.ret == TALE_PET_RESULT_CODE.TALE_PET_SUCCEED then
    self.TalePetBuff_ = reply.msg.TalePetBuff
    self.NormalPetBuff_ = reply.msg.NormalPetBuff
    self.experience_value_ = reply.msg.experience_value
    self.trailBuffLevelID_ = reply.msg.trail_buff_level_id
    Log.debug("self.experience_value_ : ", self.experience_value_)
  end
  return res
end

function TalePetModule:GetTrailBuffLevelID()
  return self.trailBuffLevelID_
end

function TalePetModule:GetBuffExperience()
  return self.experience_value_
end

function TalePetModule:GetTalePetBuff()
  return self.TalePetBuff_
end

function TalePetModule:GetNormalPetBuff()
  return self.NormalPetBuff_
end

function TalePetModule:HandlePushNewBuffInfo(msg)
  self.trailBuffLevelID_ = msg.trail_buff_level_id
  self.experience_value_ = msg.experience_value
  GameGlobal.EventDispatcher():Dispatch(GameEventType.TalePetBuffChange)
end

function TalePetModule:Module_ConvertMatchResult(recvResult)
  local uiMatchResult = UI_MatchResult:New()
  uiMatchResult.m_nMatchType = MatchType.MT_TalePet
  uiMatchResult.m_nID = recvResult.stage_id
  uiMatchResult.m_vecFirstPassAward = recvResult.rewards
  return uiMatchResult
end

function TalePetModule:HaveCallRestriction(id)
  return false
end

function TalePetModule:RestrictionIsUnlock(id)
  local cfg = Cfg.cfg_tale_pet[id]
  if cfg then
    if cfg.HasPetNum and cfg.HasPetNum > 0 then
      local count = 0
      for _id, info in pairs(self.mDatas) do
        if _id ~= id and info and info.pet_status == TalePetCallType.TPCT_Done then
          count = count + 1
        end
      end
      return count >= cfg.HasPetNum, count
    else
      return true, 0
    end
  end
  return false, 0
end
