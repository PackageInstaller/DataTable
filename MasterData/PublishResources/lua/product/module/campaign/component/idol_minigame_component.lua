require("component_base")
_class("IdolMiniGameComponent", ICampaignComponent)
IdolMiniGameComponent = IdolMiniGameComponent

function IdolMiniGameComponent:Constructor()
  self.m_component_info = IdolComponentInfo:New()
  self.m_endingId = 0
end

function IdolMiniGameComponent:ComponentInfo()
  if not self.m_component_info then
    self.m_component_info = IdolComponentInfo:New()
  end
  return self.m_component_info
end

function IdolMiniGameComponent:GetComponentInfo()
  return self:ComponentInfo()
end

function IdolMiniGameComponent:GetComponentType()
  return CampaignComType.E_CAMPAIGN_COM_IDOL_GAME
end

function IdolMiniGameComponent:InitComponentInfo(a_load_info)
  local ret = ComponentDataHelper.ParseData(a_load_info.m_data, self.m_component_info)
  return ret
end

function IdolMiniGameComponent:GetCurrentEndingId()
  return self.m_endingId
end

function IdolMiniGameComponent:HandleIdolStartPlay(TT, asyncRes, startType, processType)
  local request = IdolStartPlayReq:New()
  local response = IdolStartPlayRep:New()
  request.start_type = startType
  request.process_type = processType
  local componentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, componentInfo.m_campaign_id, componentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][IdolComponent] HandleIdolStartPlay ret:", asyncRes.m_result)
    return -1
  end
  self.m_component_info.break_info = response.break_info
  return response.ret
end

function IdolMiniGameComponent:HandleIdolTrain(TT, asyncRes, roundIndex, roundState, trainType)
  local request = IdolTrainReq:New()
  local response = IdolTrainRep:New()
  request.round_index = roundIndex
  request.round_state = roundState
  request.train_type = trainType
  local componentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, componentInfo.m_campaign_id, componentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][IdolComponent] HandleIdolTrain ret:", asyncRes.m_result)
    return -1
  end
  self.m_component_info.break_info = response.break_info
  return response.ret
end

function IdolMiniGameComponent:HandleIdolCompleteEvent(TT, asyncRes, eventType, optionType, eventId, trainType)
  local request = IdolCompleteEventReq:New()
  local response = IdolCompleteEventRep:New()
  request.event_type = eventType
  request.option_type = optionType
  request.event_id = eventId
  request.train_type = trainType
  local componentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, componentInfo.m_campaign_id, componentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][IdolComponent] HandleIdolCompleteEvent ret:", asyncRes.m_result)
    return -1
  end
  self.m_component_info.break_info = response.break_info
  return response.ret
end

function IdolMiniGameComponent:HandleIdolCompleteActivity(TT, asyncRes, activityId)
  local request = IdolCompleteActivityReq:New()
  local response = IdolCompleteActivityRep:New()
  request.activity_id = activityId
  local componentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, componentInfo.m_campaign_id, componentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][IdolComponent] HandleIdolCompleteActivity ret:", asyncRes.m_result)
    return -1
  end
  self.m_component_info.break_info = response.break_info
  return response.ret
end

function IdolMiniGameComponent:HandleIdolGetAchieveReward(TT, asyncRes, achieveId)
  local request = IdolGetAchieveRewardReq:New()
  local response = IdolGetAchieveRewardRep:New()
  request.achieve_id = achieveId
  local componentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, componentInfo.m_campaign_id, componentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][IdolComponent] HandleIdolGetAchieveReward ret:", asyncRes.m_result)
    return -1
  end
  self.m_component_info.collect_info = response.collect_info
  return response.ret
end

function IdolMiniGameComponent:HandleIdolComplateEnding(TT, asyncRes, endingId)
  local request = IdolComplateEndingReq:New()
  local response = IdolComplateEndingRep:New()
  request.ending_id = endingId
  self.m_ending_list = {}
  local componentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, componentInfo.m_campaign_id, componentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    self.m_endingId = 0
    Log.error("[CampaignCom][IdolComponent] HandleIdolComplateEnding ret:", asyncRes.m_result)
    return -1
  end
  self.m_component_info.ending_list = response.ending_list
  self.m_endingId = endingId
  return response.ret
end

function IdolMiniGameComponent:HandleIdolConcertFail(TT, asyncRes, is_sucess)
  local request = IdolConcertFailReq:New()
  local response = IdolConcertFailRep:New()
  request.isSucess = is_sucess
  local componentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, componentInfo.m_campaign_id, componentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][IdolComponent] HandleIdolConcertFail ret:", asyncRes.m_result)
    return -1
  end
  return response.ret
end

function IdolMiniGameComponent:Start_HandleIdolTrain(roundIndex, roundState, trainType, callback)
  local lockName = "IdolMiniGameComponent:Start_HandleIdolTrain"
  GameGlobal.UIStateManager():Lock(lockName)
  TaskManager:GetInstance():StartTask(function(TT)
    local res = AsyncRequestRes:New()
    local ret = self:HandleIdolTrain(TT, res, roundIndex, roundState, trainType)
    GameGlobal.UIStateManager():UnLock(lockName)
    if res and res:GetSucc() then
      local breakInfo = self.m_component_info.break_info
      local str = "IdolMiniGameComponent:Start_HandleIdolTrain() Succ, RoundState = " .. breakInfo.round_state
      Log.info(str)
      if callback then
        callback()
      end
    else
      local str = "IdolMiniGameComponent:Start_HandleIdolTrain() Failed, res = %d, round = %d, state = %d, trainType = %d"
      str = string.format(str, res.m_result, roundIndex, roundState, trainType)
      Log.error(str)
      if res.m_result == CampaignErrorType.E_COMPONENT_IDOL_ROUND_NO_OPEN then
        CutsceneManager.ExcuteCutsceneIn("UIN25Idol_Common_Switch", function()
          GameGlobal.UIStateManager():ShowDialog("UIN25IdolNotOpenNextDay")
        end)
      end
    end
  end)
end

function IdolMiniGameComponent:Start_HandleIdolCompleteEvent(eventType, optionType, eventId, trainType, callback)
  local lockName = "IdolMiniGameComponent:Start_HandleIdolCompleteEvent"
  GameGlobal.UIStateManager():Lock(lockName)
  TaskManager:GetInstance():StartTask(function(TT)
    local res = AsyncRequestRes:New()
    local ret = self:HandleIdolCompleteEvent(TT, res, eventType, optionType, eventId, trainType)
    GameGlobal.UIStateManager():UnLock(lockName)
    if res and res:GetSucc() then
      local str = "IdolMiniGameComponent:Start_HandleIdolCompleteEvent() Succ"
      Log.info(str)
      if callback then
        callback()
      end
    else
      local str = "IdolMiniGameComponent:Start_HandleIdolCompleteEvent() Failed, res = %d, eventType = %d, optionType = %d, eventId = %d, trainType = %d"
      str = string.format(str, res.m_result, eventType, optionType, eventId, trainType)
      Log.error(str)
    end
  end)
end

function IdolMiniGameComponent:UI_GetRoundIndex()
  local breakInfo = self.m_component_info.break_info
  local roundIndex = breakInfo.round_index
  roundIndex = roundIndex and 0 < roundIndex and roundIndex or 1
  return roundIndex
end

function IdolMiniGameComponent:UI_GetRoundState()
  local breakInfo = self.m_component_info.break_info
  return breakInfo.round_state
end

function IdolMiniGameComponent:UI_GetTrainPoint(trainType)
  local breakInfo = self.m_component_info.break_info
  return breakInfo.train_data[trainType]
end

function IdolMiniGameComponent:UI_GetFunNum()
  local breakInfo = self.m_component_info.break_info
  return breakInfo.funs_num
end

function IdolMiniGameComponent:UI_GetLevel(trainType)
  local breakInfo = self.m_component_info.break_info
  return breakInfo.level[trainType]
end

function IdolMiniGameComponent:UI_Cfg_GetLevelInfo(level)
  local cfgComponentId = self:GetComponentCfgId()
  local cfgs = Cfg.cfg_component_idol_level({ComponentID = cfgComponentId, Level = level})
  local cfg = cfgs and cfgs[1]
  if not cfg then
    Log.exception("IdolMiniGameComponent:UI_Cfg_GetLevelInfo() cfg = nil, level = ", level)
  end
  return cfg
end

function IdolMiniGameComponent:UI_Cfg_GetLevelInfoByTrainType(level, trainType, name)
  local cfg = self:UI_Cfg_GetLevelInfo(level)
  local info = cfg and cfg[name]
  return info[trainType]
end

function IdolMiniGameComponent:UI_Cfg_GetTrainPointAddValue(trainType)
  local roundIndex = self:UI_GetRoundIndex()
  local level = self:UI_GetLevel(trainType)
  local cfg = self:UI_Cfg_GetLevelInfo(level)
  local values = {
    cfg.Music,
    cfg.Dance,
    cfg.Perform
  }
  local value = values[trainType]
  local muse = self:UI_Cfg_GetTrainMuse(roundIndex, trainType)
  return muse or value
end

function IdolMiniGameComponent:UI_Cfg_GetTrainPointSong(trainType)
  local level = self:UI_GetLevel(trainType)
  return self:UI_Cfg_GetLevelInfoByTrainType(level, trainType, "TrainContent")
end

function IdolMiniGameComponent:UI_Cfg_GetTrainResult(trainType)
  local level = self:UI_GetLevel(trainType)
  local resultA = self:UI_Cfg_GetLevelInfoByTrainType(level, trainType, "TrainResultA")
  local resultB = self:UI_Cfg_GetLevelInfoByTrainType(level, trainType, "TrainResultB")
  return resultA, resultB
end

function IdolMiniGameComponent:UI_Cfg_GetRoundInfo(roundIndex)
  if roundIndex then
    local cfgComponentId = self:GetComponentCfgId()
    local cfgs = Cfg.cfg_component_idol_round({ComponentID = cfgComponentId, Round = roundIndex})
    return cfgs and cfgs[1]
  end
end

function IdolMiniGameComponent:UI_Cfg_GetRoundInfoByTrainType(roundIndex, trainType, name)
  local cfg = self:UI_Cfg_GetRoundInfo(roundIndex)
  local info = cfg and cfg[name]
  if info then
    for _, v in pairs(info) do
      if v[1] == trainType then
        return v[2]
      end
    end
  end
end

function IdolMiniGameComponent:UI_Cfg_GetAgreedEvent(roundIndex, trainType)
  return self:UI_Cfg_GetRoundInfoByTrainType(roundIndex, trainType, "AgreedEventId")
end

function IdolMiniGameComponent:UI_Cfg_GetSuddenlyEvent(roundIndex, trainType)
  return self:UI_Cfg_GetRoundInfoByTrainType(roundIndex, trainType, "SuddenlyEventId")
end

function IdolMiniGameComponent:UI_Cfg_GetTrainMuse(roundIndex, trainType)
  return self:UI_Cfg_GetRoundInfoByTrainType(roundIndex, trainType, "Muse")
end

function IdolMiniGameComponent:UI_Cfg_GetEventInfo(eventId)
  if eventId then
    local cfgComponentId = self:GetComponentCfgId()
    local cfgs = Cfg.cfg_component_idol_event({ComponentID = cfgComponentId, EventId = eventId})
    return cfgs and cfgs[1]
  end
end

function IdolMiniGameComponent:UI_Cfg_GetSuddenlyEventItemInfo(eventId)
  local cfg = self:UI_Cfg_GetEventInfo(eventId)
  if not cfg then
    return {}
  end
  local tb_out = {}
  for i = 1, 3 do
    local tb = {}
    tb.DesFuns = cfg.DesFuns[i]
    tb.StoryId = cfg.StoryId
    local condLimits = {
      cfg.CondLimit1,
      cfg.CondLimit2,
      cfg.CondLimit3
    }
    tb.CondLimit = condLimits[i]
    tb.CondLimitHead = cfg.CondLimitHead[i]
    tb.CondLimitName = cfg.CondLimitName[i]
    tb.CondLimitResult = cfg.CondLimitResult[i]
    tb.CondLimitSpine = cfg.CondLimitSpine[i]
    tb.Question = cfg.Question
    tb.Enable = self:UI_CheckSuddenlyEventEnable(tb.CondLimit)
    table.insert(tb_out, tb)
  end
  return tb_out
end

function IdolMiniGameComponent:UI_CheckSuddenlyEventEnable(condLimit)
  if condLimit then
    for _, v in ipairs(condLimit) do
      local trainPoint = self:UI_GetTrainPoint(v[1])
      if trainPoint < v[2] then
        return false
      end
    end
  end
  return true
end

function IdolMiniGameComponent:UI_Cfg_CheckSuddenlyEventLimit()
  local cfgComponentId = self:GetComponentCfgId()
  local cfgs = Cfg.cfg_component_idol_const({ComponentID = cfgComponentId, ConstID = 100})
  local limit = cfgs and cfgs[1] and cfgs[1].Value or 0
  local events = self.m_component_info.break_info.suddenly_events
  local weekIdx, weekDay = self:UI_Calc_WeekDay(self:UI_GetRoundIndex())
  return limit > events[weekIdx]
end

function IdolMiniGameComponent:UI_CheckSuddenlyEvent(trainType)
  local roundState = self:UI_GetRoundState()
  if roundState ~= IdolRoundState.IdolRoundState_Begin then
    return false
  end
  local roundIndex = self:UI_GetRoundIndex()
  local eventId = self:UI_Cfg_GetSuddenlyEvent(roundIndex, trainType)
  local isShow = eventId and self:UI_Cfg_CheckSuddenlyEventLimit()
  return isShow and eventId
end

function IdolMiniGameComponent:UI_IsFinishAgreedEvent(eventId)
  local breakInfo = self.m_component_info.break_info
  local finishList = breakInfo.agree_events
  return finishList and table.icontains(finishList, eventId)
end

function IdolMiniGameComponent:UI_Cfg_IsFinishAgreedPreEvent(eventId)
  local eventInfo = self:UI_Cfg_GetEventInfo(eventId)
  local preEventId = eventInfo and eventInfo.PreEventId
  return not preEventId or self:UI_IsFinishAgreedEvent(preEventId)
end

function IdolMiniGameComponent:UI_CheckAgreedEvent(trainType)
  local roundIndex = self:UI_GetRoundIndex()
  local eventId = self:UI_Cfg_GetAgreedEvent(roundIndex, trainType)
  local isPreFinish = self:UI_Cfg_IsFinishAgreedPreEvent(eventId)
  local isOpen = isPreFinish and not self:UI_IsFinishAgreedEvent(eventId)
  return isOpen and eventId
end

function IdolMiniGameComponent:UI_GetWeekApEvent(filterFinish)
  local roundIndex = self:UI_GetRoundIndex()
  local monday = self:UI_Calc_Monday(roundIndex)
  local tb_out = {}
  for round = monday, monday + 6 do
    local cfg = self:UI_Cfg_GetRoundInfo(round)
    local events = cfg and cfg.AgreedEventId
    if events then
      for _, v in pairs(events) do
        local trainType = v[1]
        local eventId = v[2]
        local isPreFinish = self:UI_Cfg_IsFinishAgreedPreEvent(eventId)
        local isCurFinish = self:UI_IsFinishAgreedEvent(eventId)
        local filterAndNotFinish = filterFinish and not isCurFinish
        local notFilterAndPreFinish = not filterFinish and isPreFinish
        if filterAndNotFinish or notFilterAndPreFinish then
          local data = {}
          data.roomid = trainType
          data.eventid = eventId
          data.round = round
          data.finish = isCurFinish
          table.insert(tb_out, data)
        end
      end
    end
  end
  return tb_out
end

function IdolMiniGameComponent:UI_Cfg_GetConcertInfo()
  local cfgs
  local cfgComponentId = self:GetComponentCfgId()
  if cfgComponentId == 107610808 then
  end
  cfgs = Cfg.cfg_n25_concert({})
  if not cfgs or table.count(cfgs) <= 0 then
    Log.error("###[IdolMiniGameComponent] UI_Cfg_GetConcertInfo cfg is nil !")
  end
  return cfgs
end

function IdolMiniGameComponent:UI_GetCurrentConcertId()
  local currentTurn = self:UI_GetRoundIndex()
  local cfgClone = self:UI_Cfg_GetConcertInfo()
  for i = 1, #cfgClone do
    local cfg = cfgClone[i]
    if currentTurn <= cfg.Turn then
      return i
    end
  end
end

function IdolMiniGameComponent:UI_GetNextConcertInfo()
  local id = self:UI_GetCurrentConcertId()
  local cfgClone = self:UI_Cfg_GetConcertInfo()
  return id and cfgClone[id]
end

function IdolMiniGameComponent:UI_CheckConcert()
  local roundState = self:UI_GetRoundState()
  if roundState ~= IdolRoundState.IdolRoundState_End then
    return false
  end
  local roundIndex = self:UI_GetRoundIndex()
  local concertInfo = self:UI_GetNextConcertInfo()
  local isToday = roundIndex == concertInfo.Turn
  local fansNum = self:UI_GetFunNum()
  local fansEnough = fansNum >= concertInfo.Fans
  local gapFans = concertInfo.Fans - fansNum
  return isToday, fansEnough, gapFans
end

function IdolMiniGameComponent:UI_Cfg_GetActivityInfo(weekIdx)
  local cfgComponentId = self:GetComponentCfgId()
  return Cfg.cfg_component_idol_activity({ComponentID = cfgComponentId, BeginWeek = weekIdx})
end

function IdolMiniGameComponent:UI_GetWeekIdolAct()
  local currentTurn = self:UI_GetRoundIndex()
  local weekIdx, weekDay = self:UI_Calc_WeekDay(currentTurn)
  return self:UI_Cfg_GetActivityInfo(weekIdx)
end

function IdolMiniGameComponent:UI_GetActLimit(activityCfg, trainType)
  for _, v in ipairs(activityCfg.Limit) do
    if trainType == v[1] then
      return v[2]
    end
  end
end

function IdolMiniGameComponent:UI_CheckActLimit(activityCfg, trainType)
  local limitValue = self:UI_GetActLimit(activityCfg, trainType)
  return limitValue <= self:UI_GetTrainPoint(trainType)
end

function IdolMiniGameComponent:UI_CheckActOnWeekend()
  local currentTurn = self:UI_GetRoundIndex()
  local roundState = self:UI_GetRoundState()
  if currentTurn % 7 == 0 and roundState == IdolRoundState.IdolRoundState_End then
    local cfgs = self:UI_GetWeekIdolAct()
    for key, value in pairs(cfgs) do
      local id = value.ActId
      if not self:UI_GetActFinishStatus(id) then
        local limit = value.Limit
        if self:UI_CheckActEnough(limit) then
          return true
        end
      end
    end
  end
  return false
end

function IdolMiniGameComponent:UI_CheckActEnough(limits)
  local enough = true
  if limits then
    for key, limit in pairs(limits) do
      local type = limit[1]
      local needValue = limit[2]
      local train_data = self.m_component_info.break_info.train_data
      local hadValue = train_data[type]
      if needValue > hadValue then
        enough = false
        break
      end
    end
  end
  return enough
end

function IdolMiniGameComponent:UI_GetActFinishStatus(id)
  local break_info = self.m_component_info.break_info
  local finish_activity = break_info.finish_activity
  return table.icontains(finish_activity, id)
end

function IdolMiniGameComponent:UI_Calc_WeekDay(roundIndex)
  local weekIdx = (roundIndex + 6) // 7
  local weekDay = roundIndex % 7
  weekDay = weekDay == 0 and 7 or weekDay
  return weekIdx, weekDay
end

function IdolMiniGameComponent:UI_Calc_Monday(roundIndex)
  local weekIdx, weekDay = self:UI_Calc_WeekDay(roundIndex)
  return roundIndex - weekDay + 1
end

function IdolMiniGameComponent:UI_SetActRed()
  local key_l = "N25IdolActRed_"
  local break_info = self.m_component_info.break_info
  local turn = break_info.round_index
  local week, day = self:UI_Calc_WeekDay(turn)
  local key = key_l .. week
  LocalDB.SetInt(key, 1)
end

function IdolMiniGameComponent:UI_GetActRed()
  local key_l = "N25IdolActRed_"
  local break_info = self.m_component_info.break_info
  local turn = break_info.round_index
  local week, day = self:UI_Calc_WeekDay(turn)
  local key = key_l .. week
  local val = LocalDB.GetInt(key, 0)
  return val == 0
end

function IdolMiniGameComponent:UI_ResetActRed()
  local key_l = "N25IdolActRed_"
  for i = 1, 7 do
    local key = key_l .. i
    LocalDB.Delete(key)
  end
end
