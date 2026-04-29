_class("GambleModule", GameModule)
GambleModule = GambleModule

function GambleModule:Constructor()
  self._prizePoolList = {}
  self._uiContext = nil
  self._gambleConfig = {}
  self._gambleExternInfo = {}
  self._showPoolCountCalc = false
  self.hasShowNotIncluePedPoolTips = nil
  self.pool_2_times = {}
  self.pool_five_star = {}
end

function GambleModule:GetPrizePools()
  return self._prizePoolList
end

function GambleModule:GetPoolDrawTimes(poolId)
  return self.pool_2_times[poolId]
end

function GambleModule:CheckAlreadyGainFiveStarCard(poolId)
  for _, v in pairs(self.pool_five_star) do
    if poolId == v then
      return true
    end
  end
  return false
end

function GambleModule:GetPrizePoolExtandData(poolID)
  for k, v in pairs(self._prizePoolList) do
    if poolID == v.prize_pool_id then
      return {
        v.close_type,
        v.extend_data
      }
    end
  end
  return {}
end

function GambleModule:_GetPrizePoolExternInfo(index, ext_info_type)
  local l_pool_extern_map = self._gambleExternInfo[index]
  if not l_pool_extern_map then
    return nil
  end
  local l_extern_info = l_pool_extern_map[ext_info_type]
  if not l_extern_info then
    return nil
  end
  return l_extern_info
end

function GambleModule:GetNotIncludePetPoolGambleTimes(index)
  local l_nipp_extern_info = self:_GetPrizePoolExternInfo(index, EPrizePoolExtInfoType.EPPEIT_NIPP)
  if not l_nipp_extern_info then
    return -1
  end
  return l_nipp_extern_info.times
end

function GambleModule:GetNotIncludePetPool(index)
  local l_nipp_extern_info = self:_GetPrizePoolExternInfo(index, EPrizePoolExtInfoType.EPPEIT_NIPP)
  if not l_nipp_extern_info then
    return {}
  end
  return l_nipp_extern_info.param_pool
end

function GambleModule:GetCfgOptionalPoolId(index)
  local l_op_extern_info = self:_GetPrizePoolExternInfo(index, EPrizePoolExtInfoType.EPPEIT_OPP)
  if not l_op_extern_info then
    return -1
  end
  return l_op_extern_info.id
end

function GambleModule:GetOptionalPool(index)
  local l_op_extern_info = self:_GetPrizePoolExternInfo(index, EPrizePoolExtInfoType.EPPEIT_OPP)
  if not l_op_extern_info then
    return {}
  end
  local l_ret_map = {}
  for i = ElementType.ElementType_Blue, ElementType.ElementType_Yellow do
    l_ret_map[i] = 0
    if l_op_extern_info.param_pool[i] ~= nil then
      l_ret_map[i] = l_op_extern_info.param_pool[i]
    end
  end
  return l_ret_map
end

function GambleModule:IsOpenOptional(index)
  local idOptional = self:GetCfgOptionalPoolId(index)
  local cfgOptional = Cfg.cfg_optional_pool[idOptional]
  local selCount = ElementType.ElementType_Yellow
  if cfgOptional ~= nil then
    selCount = 0
    local selWish = self:GetOptionalPool(index)
    for sk, sv in pairs(selWish) do
      if sv ~= 0 then
        selCount = selCount + 1
      end
    end
  end
  return cfgOptional ~= nil, selCount
end

function GambleModule:CheckOptionalRed(index)
  local isOpenOptional = false
  local selCount = ElementType.ElementType_Yellow
  isOpenOptional, selCount = self:IsOpenOptional(index)
  return selCount ~= ElementType.ElementType_Yellow
end

function GambleModule:GetOptionalPoolComfirmDBKey()
  local dbKey = "GambleModule::OptionalPoolComfirm"
  local roleModule = self:GetModule(RoleModule)
  dbKey = roleModule:GetPstId() .. dbKey
  return dbKey
end

function GambleModule:OptionalPoolComfirmLoadDB()
  local dbKey = self:GetOptionalPoolComfirmDBKey()
  local content = LocalDB.GetString(dbKey, "")
  local fnString = string.format("return {%s}", content)
  local fnTable = load(fnString)
  local dbData = fnTable()
  self._optionalPoolComfirm = {}
  for k, v in pairs(dbData) do
    self._optionalPoolComfirm[v] = v
  end
end

function GambleModule:OptionalPoolComfirmSaveDB()
  local content = ""
  for k, v in pairs(self._optionalPoolComfirm) do
    content = content .. string.format("%d, ", v)
  end
  local dbKey = self:GetOptionalPoolComfirmDBKey()
  LocalDB.SetString(dbKey, content)
end

function GambleModule:OptionalPoolAlert(poolIndex, comfirmCB, cancelCB)
  local idRecruit
  local isOpenOptional = false
  local wishCount = 0
  isOpenOptional, wishCount = self:IsOpenOptional(poolIndex)
  if not isOpenOptional then
    cancelCB()
    return false
  elseif isOpenOptional and wishCount == ElementType.ElementType_Yellow then
    cancelCB()
    return false
  else
    local awardPools = self:GetPrizePools()
    idRecruit = awardPools[poolIndex].performance_id
  end
  if self._optionalPoolComfirm == nil then
    self:OptionalPoolComfirmLoadDB()
  end
  if self._optionalPoolComfirm[idRecruit] ~= nil then
    cancelCB()
  else
    local allOpenPool = {}
    local awardPools = self:GetPrizePools()
    for k, v in pairs(awardPools) do
      allOpenPool[v.performance_id] = v.performance_id
    end
    local rmList = {}
    for k, v in pairs(self._optionalPoolComfirm) do
      if allOpenPool[v] == nil then
        table.insert(rmList, v)
      end
    end
    for k, v in pairs(rmList) do
      self._optionalPoolComfirm[v] = nil
    end
    self._optionalPoolComfirm[idRecruit] = idRecruit
    self:OptionalPoolComfirmSaveDB()
    PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, "", StringTable.Get("str_draw_card_wishsel_drawcomfirm"), function(param)
      comfirmCB()
    end, nil, function(param)
      cancelCB()
    end, nil)
    return true
  end
  return false
end

function GambleModule:GetProbs(index)
  local state = self._gambleConfig[index]
  if state == nil or next(state) == nil then
    Log.fatal("haven't prob config when calculate prob")
    return 0, 0
  end
  local prob_01 = tonumber(state[FishForStateType.FFST_Inirate])
  local prob_02 = 0
  local counter = tonumber(state[FishForStateType.FFST_NormalCounter])
  local maxTime = tonumber(state[FishForStateType.FFST_Maxtime])
  local step = tonumber(state[FishForStateType.FFST_Step])
  local addRate = tonumber(state[FishForStateType.FFST_AddRate])
  local active = tonumber(state[FishForStateType.FFST_Active])
  if counter >= active then
    local redouble = (counter - active) // step
    redouble = redouble + 1
    prob_02 = redouble * addRate
  end
  if counter == maxTime then
    prob_01 = 1000
    prob_02 = 0
  end
  return prob_01 / 10, prob_02 / 10
end

function GameModule:GetCounterNum(index)
  local state = self._gambleConfig[index]
  if state == nil or next(state) == nil then
    Log.fatal("haven't prob config when calculate prob")
    return -1
  end
  return tonumber(state[FishForStateType.FFST_NormalCounter])
end

function GambleModule:ApplyAllPoolInfo(TT)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventApplyAllPoolInfo)
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(-1)
    return res
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.ret)
  self._prizePoolList = reply.msg.all_prize_pool
  self._gambleConfig = reply.msg.state_info
  self._gambleExternInfo = {}
  for key, value in pairs(reply.msg.pool_extern_info) do
    self._gambleExternInfo[key + 1] = value
  end
  self.pool_2_times = reply.msg.pool_2_times
  self.pool_five_star = reply.msg.pool_five_star
  return res
end

function GambleModule:HandleOptionalPoolReq(TT, index, pet_element, nOptionalVec)
  local l_optional_pool_ex_info = self:_GetPrizePoolExternInfo(index, EPrizePoolExtInfoType.EPPEIT_OPP)
  if not l_optional_pool_ex_info then
    return GAMBLE_CODE.GAMBLE_OPTIONAL_POOL_INVALID
  end
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventOptionalPoolReq)
  request.nIndex = pet_element
  request.nOptionalPoolId = l_optional_pool_ex_info.id
  request.nOptionalVec = nOptionalVec
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    return GAMBLE_CODE.GAMBLE_SERVER_NORESPONSE
  end
  local replyEvent = reply.msg
  if replyEvent.nRet == COMMON_RANDOM_CODE.COMMON_RANDOM_SUCCESS then
    l_optional_pool_ex_info.param_pool[pet_element] = nOptionalVec[1]
    return GAMBLE_CODE.GAMBLE_SUCCESS
  end
  return replyEvent.nRet + 100
end

function GambleModule:SetAllPoolInfo(all_prize_pool)
  self._prizePoolList = all_prize_pool
end

function GambleModule:Shake(TT, shakeType, prizePoolId, costId, costCount)
  local res = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventShake)
  request.shake_type = shakeType
  request.prize_pool_id = prizePoolId
  request.cost_id = costId
  request.cost_count = costCount
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    res:SetSucc(false)
    res:SetResult(GAMBLE_CODE.GAMBLE_SERVER_NORESPONSE)
    return res, {}
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.ret)
  local award_role_asset = {}
  for k, v in pairs(replyEvent.award_cards) do
    local tmp_role_asset = RoleAsset:New()
    tmp_role_asset.assetid = v
    tmp_role_asset.count = 1
    award_role_asset[#award_role_asset + 1] = tmp_role_asset
  end
  return res, award_role_asset, replyEvent.exchange_mark, replyEvent.fixed_reward
end

function GambleModule:GetReasonByErrorCode(code)
  if code == GAMBLE_CODE.GAMBLE_SERVER_NORESPONSE then
    return StringTable.Get("str_draw_card_gamble_server_noresponse")
  end
  if code == GAMBLE_CODE.GAMBLE_SUCCESS then
    return StringTable.Get("str_draw_card_gamble_success")
  end
  if code == GAMBLE_CODE.GAMBLE_POOL_UNEXIST then
    return StringTable.Get("str_draw_card_gamble_pool_unexist")
  end
  if code == GAMBLE_CODE.GAMBLE_COST_UNENOUGH then
    return StringTable.Get("str_draw_card_gameble_cost_unenough")
  end
  if code == GAMBLE_CODE.GAMBLE_SHAKETYPE_ERROR then
    return StringTable.Get("str_draw_card_gameble_shaketype_error")
  end
  if code == GAMBLE_CODE.GAMBLE_COST_ERROR then
    return StringTable.Get("str_draw_card_gameble_cost_error")
  end
  return "gamble error"
end

function GambleModule:InitContext(sceneReq)
  self._uiContext = DrawCardUIContext:New(sceneReq)
end

function GambleModule:ClearContext()
  self._uiContext:Dispose()
  self._uiContext = nil
end

function GambleModule:Context()
  return self._uiContext
end

function GambleModule:SetShowPoolCountCalc(value)
  self._showPoolCountCalc = value
end

function GambleModule:GetShowPoolCountCalc()
  return self._showPoolCountCalc
end

function GambleModule:HasFreeDraw_Multi()
  local pools = self:GetPrizePools()
  for _, pool in ipairs(pools) do
    if pool.mul_remain_free_count > 0 then
      return true
    end
  end
  return false
end

function GambleModule:IsNewPool(pool)
  local newKey = self:_GetNewPoolLocalDBKey(pool)
  local new = LocalDB.GetInt(newKey, 0) == 0
  return new
end

function GambleModule:HasNewPool()
  local pools = self:GetPrizePools()
  for _, pool in ipairs(pools) do
    local cfg = Cfg.cfg_recruit_pool_view[pool.performance_id]
    if not cfg then
      Log.exception("cfg_recruit_pool_view中缺少配置:", pool.performance_id)
    end
    local startTime = self:GetIntervalStartTime(cfg)
    if self:IsNewPool(pool) and startTime ~= -1 then
      return true
    end
  end
  return false
end

function GambleModule:_GetNewPoolLocalDBKey(pool)
  local id = pool.prize_pool_id
  local openId = GameGlobal.GameLogic():GetOpenId()
  local cfg = Cfg.cfg_recruit_pool_view[pool.performance_id]
  if not cfg then
    Log.exception("cfg_recruit_pool_view中缺少配置:", pool.performance_id)
  end
  local startTime = self:GetIntervalStartTime(cfg)
  local newKey = openId .. "_RecruitPoolNew_" .. id .. startTime
  return newKey
end

function GambleModule:GetIntervalStartTime(cfg)
  local poolCfg = Cfg.cfg_gamble_pool_putaway[cfg.ID]
  if not poolCfg then
    return 0
  end
  if not poolCfg.OpenTimeInterval then
    return 0
  end
  local loginModule = GameGlobal.GetModule(LoginModule)
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local curTime = svrTimeModule and math.floor(svrTimeModule:GetServerTime() * 0.001) or 0
  for _, timePairArray in pairs(poolCfg.OpenTimeInterval) do
    local startTime = loginModule:GetTimeStampByTimeStr(timePairArray[1], Enum_DateTimeZoneType.E_ZoneType_GMT)
    local endTime = loginModule:GetTimeStampByTimeStr(timePairArray[2], Enum_DateTimeZoneType.E_ZoneType_GMT)
    if curTime < endTime and curTime > startTime then
      return startTime
    end
  end
  return -1
end

function GambleModule:CancelPoolNew(pool)
  local newKey = self:_GetNewPoolLocalDBKey(pool)
  LocalDB.SetInt(newKey, 1)
end
