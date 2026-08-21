_class("SignInModule", GameModule)
SignInModule = SignInModule

function SignInModule:Constructor()
  self.m_is_sign_in_today = false
  self.m_next_sign_in_time = 0
  self.m_can_re_sign_in_ex_vig = false
  self.m_next_accept_login_reward_days = -1
  self.m_total_login_info = nil
  self.m_cur_total_login_days = 0
  self.m_next_total_login_refresh_time = 0
  self.predictionData = PetForecastData:New()
  self.main_dressup = MainDressUpMap:New()
end

function SignInModule:Init()
  self.caller:RegisterPushHandler(CEventNotifyPrediction, self.HandleNotifyPrediction, self)
  self.caller:RegisterPushHandler(CEventNotifyPredictionData, self.HandleNotifyPredictionData, self)
end

function SignInModule:GetNextSignInTime()
  return self.m_next_sign_in_time
end

function SignInModule:SetIsSignInToday(is_sign_in, next_sign_inTime, b_can_re_sign_in_ex_vig)
  self.m_is_sign_in_today = is_sign_in
  self.m_next_sign_in_time = next_sign_inTime
  self.m_can_re_sign_in_ex_vig = b_can_re_sign_in_ex_vig
end

function SignInModule:GetNextRefreshTotalLoginTime()
  return self.m_next_total_login_refresh_time
end

function SignInModule:SetCurChangeDayTotalLoginDays(login_day_change_day)
  self.m_cur_total_login_days = login_day_change_day
end

function SignInModule:SetTotalLoginNextRefreshTime(bNextRefreshTime)
  self.m_next_total_login_refresh_time = bNextRefreshTime
end

function SignInModule:SetNextTotalLoginRewardDays(nNextTotalLoginRewardDays)
  self.m_next_accept_login_reward_days = nNextTotalLoginRewardDays
end

function SignInModule:HaveTotalLoginReward()
  local l_cur_total_login_days = self.m_cur_total_login_days
  local time_mod = GameGlobal.GameLogic():GetModule(SvrTimeModule)
  local tmNowTime = math.modf(time_mod:GetServerTime() / 1000)
  if tmNowTime >= self:GetNextRefreshTotalLoginTime() then
    local l_addDay = math.floor((tmNowTime - self:GetNextRefreshTotalLoginTime()) / 86400) + 1
    l_cur_total_login_days = l_cur_total_login_days + l_addDay
  end
  if self.m_total_login_info ~= nil then
    for key, value in pairs(self.m_total_login_info) do
      if l_cur_total_login_days >= value.nDay and value.bIsAccept == false then
        return true
      end
    end
    return false
  else
    if self.m_next_accept_login_reward_days == -1 then
      return false
    end
    return l_cur_total_login_days >= self.m_next_accept_login_reward_days
  end
end

function SignInModule:IsSignInToday()
  local time_mod = GameGlobal.GameLogic():GetModule(SvrTimeModule)
  local tmNowTime = math.modf(time_mod:GetServerTime() / 1000)
  if self.m_is_sign_in_today and tmNowTime < self.m_next_sign_in_time then
    return true
  else
    return false
  end
end

function SignInModule:IsReSignInToday()
  local nNeedPoint = self:ReSignInNeedVigPoint()
  local l_quest_mod = self:GetModule(QuestModule)
  local nCurVigPoint = l_quest_mod:GetDailyQuestVigorous()
  if nNeedPoint > nCurVigPoint then
    return false
  end
  local time_mod = GameGlobal.GameLogic():GetModule(SvrTimeModule)
  local tmNowTime = math.modf(time_mod:GetServerTime() / 1000)
  if self.m_can_re_sign_in_ex_vig and tmNowTime < self.m_next_sign_in_time then
    return true
  else
    return false
  end
end

function SignInModule:NeedReSignInToday()
  local time_mod = GameGlobal.GameLogic():GetModule(SvrTimeModule)
  local tmNowTime = math.modf(time_mod:GetServerTime() / 1000)
  if self.m_can_re_sign_in_ex_vig and tmNowTime < self.m_next_sign_in_time then
    return true
  else
    return false
  end
end

function SignInModule:GetActivityTime(dataStr)
  local lm = GameGlobal.GameLogic():GetModule(LoginModule)
  return lm:GetCommonActivityTime(CommonActivityType.CAT_SignIn, dataStr)
end

function SignInModule:ReSignInNeedVigPoint()
  local re_sign_in_vig_point = Cfg.cfg_global.re_sign_in_vig_point.IntValue
  return re_sign_in_vig_point
end

function SignInModule:GetCurMonthData(TT)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventCurMonthSignDataReq)
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(SIGN_IN_RESULT_CODE.SIGN_IN_INVALID)
    return AsyncRes, nil
  end
  local reply_msg = reply.msg
  local nRet = reply_msg.nRet
  AsyncRes:SetResult(nRet)
  if nRet == SIGN_IN_RESULT_CODE.SIGN_IN_SUCCEED then
    local l_sign_in_state = reply_msg.sign_in_base_info.RoleSignInState
    self:SetIsSignInToday(l_sign_in_state.is_sign_in_today, l_sign_in_state.next_sign_in_time, l_sign_in_state.b_can_re_sign_in_ex_vig)
    AsyncRes:SetSucc(true)
  end
  return AsyncRes, reply_msg
end

function SignInModule:SignInTodayReq(TT, bIsReSignIn)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventSignInReq)
  request.bIsReSignIn = bIsReSignIn
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(SIGN_IN_RESULT_CODE.SIGN_IN_INVALID)
    return AsyncRes, nil
  end
  local reply_msg = reply.msg
  local nRet = reply_msg.nRet
  AsyncRes:SetResult(nRet)
  if nRet == SIGN_IN_RESULT_CODE.SIGN_IN_SUCCEED then
    local l_sign_in_state = reply_msg.sign_in_base_info.RoleSignInState
    self:SetIsSignInToday(l_sign_in_state.is_sign_in_today, l_sign_in_state.next_sign_in_time, l_sign_in_state.b_can_re_sign_in_ex_vig)
    AsyncRes:SetSucc(true)
  elseif not bIsReSignIn and nRet == SIGN_IN_RESULT_CODE.SIGN_IN_FULL then
    self:SetIsSignInToday(true, self.m_next_sign_in_time + 86400, false)
  end
  return AsyncRes, reply_msg
end

function SignInModule:TotalLoginReq(TT)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventTotalLoginReq)
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(SIGN_IN_RESULT_CODE.SIGN_IN_INVALID)
    return AsyncRes, nil
  end
  local reply_msg = reply.msg
  AsyncRes:SetResult(0)
  AsyncRes:SetSucc(true)
  self.m_total_login_info = reply_msg.total_login_info
  self.m_cur_total_login_days = reply_msg.nTotalLoginDays
  self.m_next_total_login_refresh_time = reply_msg.tmNextRefreshTime
  return AsyncRes, reply_msg
end

function SignInModule:RecvTotalLoginRewardReq(TT, nRecvDays)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventRecvTotalLoginRewardReq)
  request.nRecvDays = nRecvDays
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(SIGN_IN_RESULT_CODE.SIGN_IN_INVALID)
    return AsyncRes, nil
  end
  local reply_msg = reply.msg
  local nRet = reply_msg.nRet
  AsyncRes:SetResult(nRet)
  if nRet == SIGN_IN_RESULT_CODE.SIGN_IN_SUCCEED then
    AsyncRes:SetSucc(true)
    if self.m_total_login_info ~= nil then
      if self.m_total_login_info[reply_msg.nRecvDays] == nil then
        self.m_total_login_info[reply_msg.nRecvDays] = {}
      end
      self.m_total_login_info[reply_msg.nRecvDays].bIsAccept = true
    end
  end
  return AsyncRes, reply_msg.nRecvDays
end

function SignInModule:Dispose()
  self.caller:UnRegisterPushHandler(CEventNotifyPrediction)
  self.caller:UnRegisterPushHandler(CEventNotifyPredictionData)
  SignInModule.super.Dispose(self)
end

function SignInModule:FillNewPlayerSignupStatus(acceptStatus, rewardCfg)
  self._newPlayerLoginStatus = acceptStatus
  self._rewardCfg = rewardCfg
end

function SignInModule:RequestNewPlayerSignupStatus(TT)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventNewPlayerLoginStatusReq)
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  res:SetResult(reply.msg.ret)
  if reply.msg.ret == SIGN_IN_RESULT_CODE.SIGN_IN_SUCCEED then
    self._newPlayerLoginStatus = reply.msg.accept_status
    self._rewardCfg = reply.msg.reward_cfg
  end
  return res
end

function SignInModule:GetNewPlayerSignupStatus()
  return self._newPlayerLoginStatus, self._rewardCfg
end

function SignInModule:RequestAcceptNewPlayerReward(TT, dayNum)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventAcceptNewPlayerRewardReq)
  request.day_num = dayNum
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  res:SetResult(reply.msg.ret)
  if reply.msg.ret == SIGN_IN_RESULT_CODE.SIGN_IN_SUCCEED then
    self._newPlayerLoginStatus[dayNum] = NewPlayerLoginStatus.NPLS_Accepted
  end
  return res
end

function SignInModule:GetTotalSignInDayNum()
  local ret_day = 0
  for k, v in pairs(self._newPlayerLoginStatus) do
    if v ~= NewPlayerLoginStatus.NPLS_UnReach then
      ret_day = ret_day + 1
    end
  end
  return ret_day
end

function SignInModule:PassedDayNeedRequest()
  local time_mod = GameGlobal.GameLogic():GetModule(SvrTimeModule)
  local tmNowTime = math.modf(time_mod:GetServerTime() / 1000)
  if tmNowTime >= self:GetNextRefreshTotalLoginTime() then
    return true
  else
    return false
  end
end

function SignInModule:HandleNotifyPrediction(info)
  local day = info.index + 1
  self.predictionData:UpdateState(day, info.status)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.PredictionStateChanged, day)
end

function SignInModule:HandleNotifyPredictionData(info)
  self.predictionData:Init(info.info)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.PredictionDataChanged)
end

function SignInModule:GetPredictionData()
  return self.predictionData
end

function SignInModule:PredictionReq(TT)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventPredictionReq)
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

function SignInModule:PredictionAwardReq(TT, day, id)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventPredictionAwardReq)
  request.day = day - 1
  request.id = id
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

function SignInModule:GetMainDressUp(index)
  return self.main_dressup.info[index]
end

function SignInModule:GetMainDressUpCurIndex()
  return self.main_dressup.cur_index
end

function SignInModule:SetMainDressUpCurIndex(index)
  self.main_dressup.cur_index = index
end

function SignInModule:GetDressInfos()
  if GameSingle and (self.main_dressup == nil or self.main_dressup.info == nil) then
    self:GameSingleHandleGetMainDressUp()
  end
  return self.main_dressup.info
end

function SignInModule:GameSingleLoadMainDressUp()
  local saveKey = "MainDressUp"
  local jsonStr = PlayerPrefsGetPersonString(saveKey, nil)
  if jsonStr == nil or jsonStr == "" then
    jsonStr = "{\"cur_index\":1,\"_className\":\"MainDressUpMap\",\"info\":[{\"is_static\":false,\"pet_y\":0,\"_className\":\"MainDressUpInfo\",\"spine_id\":0,\"bg_x\":0,\"pet_grade\":0,\"pet_cfg_id\":0,\"is_hand_operate\":false,\"range_select\":1,\"bg_type\":1,\"pet_scale\":1,\"bg_id\":2,\"bg_scale\":1,\"pet_x\":0,\"pet_skin_id\":0,\"board_pet\":0,\"bg_y\":0},{\"is_static\":false,\"pet_y\":0,\"_className\":\"MainDressUpInfo\",\"spine_id\":1,\"bg_x\":0,\"pet_grade\":0,\"pet_cfg_id\":0,\"is_hand_operate\":false,\"bg_y\":0,\"bg_type\":1,\"range_select\":0,\"bg_id\":2,\"bg_scale\":1,\"pet_x\":0,\"pet_skin_id\":0,\"board_pet\":0,\"pet_scale\":1},{\"is_static\":false,\"pet_y\":0,\"_className\":\"MainDressUpInfo\",\"spine_id\":1,\"bg_x\":0,\"pet_grade\":0,\"pet_cfg_id\":0,\"is_hand_operate\":false,\"bg_y\":0,\"bg_type\":1,\"range_select\":0,\"bg_id\":2,\"bg_scale\":1,\"pet_x\":0,\"pet_skin_id\":0,\"board_pet\":0,\"pet_scale\":1},{\"is_static\":false,\"pet_y\":0,\"_className\":\"MainDressUpInfo\",\"spine_id\":1,\"bg_x\":0,\"pet_grade\":0,\"pet_cfg_id\":0,\"is_hand_operate\":false,\"bg_y\":0,\"bg_type\":1,\"range_select\":0,\"bg_id\":2,\"bg_scale\":1,\"pet_x\":0,\"pet_skin_id\":0,\"board_pet\":0,\"pet_scale\":1},{\"is_static\":false,\"pet_y\":0,\"_className\":\"MainDressUpInfo\",\"spine_id\":1,\"bg_x\":0,\"pet_grade\":0,\"pet_cfg_id\":0,\"is_hand_operate\":false,\"bg_y\":0,\"bg_type\":1,\"range_select\":0,\"bg_id\":2,\"bg_scale\":1,\"pet_x\":0,\"pet_skin_id\":0,\"board_pet\":0,\"pet_scale\":1}]}"
  end
  Log.debug("GameSingleLoadMainDressUp jsonStr=", jsonStr)
  local jsonData = cjson.decode(jsonStr)
  return jsonData
end

function SignInModule:GameSingleHandleGetMainDressUp()
  self.main_dressup = self:GameSingleLoadMainDressUp()
  local jsonStr = cjson.encode(self.main_dressup)
  Log.debug("GameSingleHandleGetMainDressUp jsonstr=", jsonStr)
  return EmptyRes, self.main_dressup
end

function SignInModule:HandleGetMainDressUpReq(TT)
  if GameSingle then
    return self:GameSingleHandleGetMainDressUp()
  end
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventGetMainDressUpReq)
  local reply = self:Call(TT, request)
  Log.debug("=======================", reply.info)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res, nil
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  self.main_dressup = replyEvent.info
  return res, replyEvent.info
end

function SignInModule:GameSingleHandleSetMainDressUp(tableDatas)
  self:GameSingleSaveMainDressUp(tableDatas)
  return EmptyRes, nil
end

function SignInModule:GameSingleSaveMainDressUp(tableDatas)
  for key, value in pairs(tableDatas) do
    self.main_dressup.info[key] = value
  end
  local saveKey = "MainDressUp"
  local jsonStr = cjson.encode(self.main_dressup)
  PlayerPrefsSetPersonString(saveKey, jsonStr)
end

function SignInModule:HandleSetMainDressUpReq(TT, tableDatas)
  if GameSingle then
    return self:GameSingleHandleSetMainDressUp(tableDatas)
  end
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventSetMainDressUpReq)
  request.info = tableDatas
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res, nil
  end
  local replyEvent = reply.msg
  res:SetResult(replyEvent.ret)
  if replyEvent.ret == ROLE_RESULT_CODE.ROLE_SUCCESS then
    for key, value in pairs(tableDatas) do
      self.main_dressup.info[key] = value
    end
  end
  res:SetSucc(true)
  return res, replyEvent
end

function SignInModule:GameSingleHandleCurMainDressUp(index)
  local saveKey = "CurMainDressUp"
  PlayerPrefsSetPersonInt(saveKey, index)
  self.main_dressup.cur_index = index
  return EmptyRes, nil
end

function SignInModule:GameSingleHandleGetCurMainDressUp()
  local saveKey = "CurMainDressUp"
  return PlayerPrefsGetPersonInt(saveKey, 1)
end

function SignInModule:HandleCurMainDressUpReq(TT, index)
  if GameSingle then
    return self:GameSingleHandleCurMainDressUp(index)
  end
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventCurMainDressUpReq)
  request.cur_index = index
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res, nil
  end
  local replyEvent = reply.msg
  res:SetResult(replyEvent.ret)
  if replyEvent.ret == ROLE_RESULT_CODE.ROLE_SUCCESS then
    self.main_dressup.cur_index = index
  end
  res:SetSucc(true)
  return res, replyEvent
end
