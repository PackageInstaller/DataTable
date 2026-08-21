_class("TowerModule", GameModule)
TowerModule = TowerModule

function TowerModule:Constructor()
  self.m_tower_data = nil
  self.m_tower_name = {
    [TowerElementType.TowerElementType_Blue] = StringTable.Get("str_tower_water"),
    [TowerElementType.TowerElementType_Red] = StringTable.Get("str_tower_fire"),
    [TowerElementType.TowerElementType_Green] = StringTable.Get("str_tower_wood"),
    [TowerElementType.TowerElementType_Yellow] = StringTable.Get("str_tower_thunder"),
    [TowerElementType.TowerElementType_Difficulty_Blue] = StringTable.Get("str_tower_water_diffcult"),
    [TowerElementType.TowerElementType_Difficulty_Red] = StringTable.Get("str_tower_fire_diffcult"),
    [TowerElementType.TowerElementType_Difficulty_Green] = StringTable.Get("str_tower_wood_diffcult"),
    [TowerElementType.TowerElementType_Difficulty_Yellow] = StringTable.Get("str_tower_thunder_diffcult")
  }
  self._tower_ceiling = nil
  self._cfg_tower_detail = nil
  self._next_unlock_tower_time = 0
  self._tower_unlock_time = {}
  self._cfg_tower_elemetn_detail = {}
end

function TowerModule:_NeedRefreshTowerDetail()
  if self._cfg_tower_detail == nil then
    return true
  end
  if self._next_unlock_tower_time == 0 or self._next_unlock_tower_time == nil then
    return true
  end
  if self._next_unlock_tower_time < 0 then
    return false
  end
  local time_mod = GameGlobal.GameLogic():GetModule(SvrTimeModule)
  local tmNowTime = math.modf(time_mod:GetServerTime() / 1000)
  if tmNowTime > self._next_unlock_tower_time then
    return true
  end
  return false
end

function TowerModule:GetCfgTowerDetail()
  local l_bNeedRefresh = self:_NeedRefreshTowerDetail()
  if l_bNeedRefresh == false then
    return self._cfg_tower_detail
  end
  local time_mod = GameGlobal.GameLogic():GetModule(SvrTimeModule)
  local tmNowTime = math.modf(time_mod:GetServerTime() / 1000)
  local l_detail_cfg = Cfg.cfg_tower_detail({})
  local l_small_unlock_time = -1
  local loginModule = self:GetModule(LoginModule)
  local l_UnlockTypeStageNum = {}
  self._tower_ceiling = {}
  self._tower_unlock_time = {}
  self._cfg_tower_detail = {}
  self._cfg_tower_elemetn_detail = {}
  for key, value in pairs(l_detail_cfg) do
    local l_OpenTimeStamp = 0
    if value.OpenGMTTime ~= nil and 0 < #value.OpenGMTTime then
      l_OpenTimeStamp = loginModule:GetTimeStampByTimeStr(value.OpenGMTTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
    end
    if self._tower_ceiling[value.Type] == nil then
      self._tower_ceiling[value.Type] = 0
    end
    self._tower_unlock_time[key] = l_OpenTimeStamp
    if tmNowTime < l_OpenTimeStamp then
      if l_UnlockTypeStageNum[value.Type] == nil or value.stage < l_UnlockTypeStageNum[value.Type] then
        l_UnlockTypeStageNum[value.Type] = value.stage
      end
      if l_small_unlock_time == -1 or l_small_unlock_time > l_OpenTimeStamp then
        l_small_unlock_time = l_OpenTimeStamp
      end
    end
  end
  for key, value in pairs(l_detail_cfg) do
    local l_OpenTimeStamp = self._tower_unlock_time[key]
    local l_nUnlockStage = l_UnlockTypeStageNum[value.Type]
    if tmNowTime >= l_OpenTimeStamp and (l_nUnlockStage == nil or l_nUnlockStage > value.stage) then
      self._cfg_tower_detail[key] = value
      if self._cfg_tower_elemetn_detail[value.Type] == nil then
        self._cfg_tower_elemetn_detail[value.Type] = {}
      end
      table.insert(self._cfg_tower_elemetn_detail[value.Type], value)
      self._tower_ceiling[value.Type] = self._tower_ceiling[value.Type] + 1
    end
  end
  self._next_unlock_tower_time = l_small_unlock_time
  return self._cfg_tower_detail
end

function TowerModule:GetElementTowerCfg(element)
  self:GetCfgTowerDetail()
  return self._cfg_tower_elemetn_detail[element]
end

function TowerModule:Init()
  self.caller:RegisterPushHandler(CEventPushTowerInfo, self.HandleTowerAllData, self)
end

function TowerModule:HandleTowerAllData(msg)
  self.m_tower_data = msg.Data
end

function TowerModule:SetTowerAllData(tower_data)
  self.m_tower_data = tower_data
end

function TowerModule:GetCfgTowerLevelInfoById(nId)
  return Cfg.cfg_tower_detail[nId]
end

function TowerModule:GetPlayerTowerData()
  return self.m_tower_data
end

function TowerModule:GetTowerLayer(eType)
  if eType == TowerElementType.TowerElementType_Blue then
    return self.m_tower_data.tower_water
  elseif eType == TowerElementType.TowerElementType_Red then
    return self.m_tower_data.tower_fire
  elseif eType == TowerElementType.TowerElementType_Green then
    return self.m_tower_data.tower_wood
  elseif eType == TowerElementType.TowerElementType_Yellow then
    return self.m_tower_data.tower_thunder
  elseif eType == TowerElementType.TowerElementType_Difficulty_Blue then
    return self.m_tower_data.difficulty_tower_water
  elseif eType == TowerElementType.TowerElementType_Difficulty_Red then
    return self.m_tower_data.difficulty_tower_fire
  elseif eType == TowerElementType.TowerElementType_Difficulty_Green then
    return self.m_tower_data.difficulty_tower_wood
  elseif eType == TowerElementType.TowerElementType_Difficulty_Yellow then
    return self.m_tower_data.difficulty_tower_thunder
  end
end

function TowerModule:SetPlayerTowerFormationInfo(formation_info)
  if self.m_tower_data == nil then
    self.m_tower_data = {}
  end
  self.m_tower_data.formation_info = formation_info
end

function TowerModule:GetPlayerTowerFormationInfo()
  if self.m_tower_data == nil then
    return {}
  end
  return self.m_tower_data.formation_info
end

function TowerModule:SetPlayerTowerMulFormationInfo(mul_formations)
  if self.m_tower_data == nil then
    self.m_tower_data = {}
  end
  self.m_tower_data.mul_formations = mul_formations
end

function TowerModule:GetPlayerTowerMulFormationInfo()
  if self.m_tower_data == nil then
    return {}
  end
  return self.m_tower_data.mul_formations
end

function TowerModule:GetMatchInfo()
  return GameGlobal.GetModule(MatchModule):GetMatchEnterData():GetTowerInfo()
end

function TowerModule:GetTowerName(element)
  return self.m_tower_name[element]
end

function TowerModule:GetTowerCeiling(element)
  if self._tower_ceiling == nil or self:_NeedRefreshTowerDetail() then
    self:GetCfgTowerDetail()
  end
  return self._tower_ceiling[element]
end

function TowerModule:ReqPlayerTowerData(TT)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventApplyTowerInfoReq)
  local reply = self:Call(TT, request)
  local AsyncRes = AsyncRequestRes:New()
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(TOWER_RESULT_CODE.TOWER_INVALID)
    return AsyncRes, nil
  end
  local nRet = reply.msg.nRet
  AsyncRes:SetResult(nRet)
  if nRet ~= TOWER_RESULT_CODE.TOWER_SUCCEED then
    return AsyncRes, nil
  end
  AsyncRes:SetSucc(true)
  self.m_tower_data = reply.msg.Data
  return AsyncRes, self.m_tower_data
end

function TowerModule:ReqTowerChangeFormationInfo(TT, nId, formation_pet_list)
  local AsyncRes = AsyncRequestRes:New()
  local tower_level_info = self:GetCfgTowerLevelInfoById(nId)
  if tower_level_info == nil then
    AsyncRes:SetResult(TOWER_RESULT_CODE.TOWER_ID_INVALID)
    return AsyncRes
  end
  if formation_pet_list == nil then
    AsyncRes:SetResult(TOWER_RESULT_CODE.TOWER_FORMATION_INVALID_PETCOUNT)
    return AsyncRes
  end
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventApplyChangeTowerFormationReq)
  request.nId = nId
  request.formation_pet_list = formation_pet_list
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(TOWER_RESULT_CODE.TOWER_INVALID)
    return AsyncRes
  end
  local replyEvent = reply.msg
  self:SetPlayerTowerFormationInfo(replyEvent.formation_info)
  if replyEvent.nRet == TOWER_RESULT_CODE.TOWER_SUCCEED then
    AsyncRes:SetSucc(true)
  else
    AsyncRes:SetResult(replyEvent.nRet)
  end
  return AsyncRes, self:GetPlayerTowerFormationInfo()
end

function TowerModule:ReqTowerChangeMulFormationInfo(TT, nId, formation_info)
  local asyncRes = AsyncRequestRes:New()
  local tower_level_info = self:GetCfgTowerLevelInfoById(nId)
  if tower_level_info == nil then
    asyncRes:SetResult(TOWER_RESULT_CODE.TOWER_ID_INVALID)
    return asyncRes
  end
  if formation_info.pet_list == nil then
    asyncRes:SetResult(TOWER_RESULT_CODE.TOWER_FORMATION_INVALID_PETCOUNT)
    return asyncRes
  end
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventApplyChangeTowerFormationReq)
  request.nId = nId
  request.formation_info = formation_info
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    asyncRes:SetResult(TOWER_RESULT_CODE.TOWER_INVALID)
    return asyncRes
  end
  local replyEvent = reply.msg
  self:SetPlayerTowerMulFormationInfo(replyEvent.mul_formations_info)
  if replyEvent.nRet == TOWER_RESULT_CODE.TOWER_SUCCEED then
    asyncRes:SetSucc(true)
  else
    asyncRes:SetResult(replyEvent.nRet)
  end
  return asyncRes, self:GetPlayerTowerMulFormationInfo()
end

function TowerModule:ReqTowerPassData(TT, nId)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventApplyTowerPassDataReq)
  request.nId = nId
  local reply = self:Call(TT, request)
  local AsyncRes = AsyncRequestRes:New()
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(-1)
    return AsyncRes, nil
  end
  AsyncRes:SetSucc(true)
  return AsyncRes, reply.msg.info
end

function TowerModule:StartMatchTask(TT, nId)
  local game = GameGlobal.GetModule(GameMatchModule)
  local info = TowerCreateInfo:New()
  local cfgTowerLevel = self:GetCfgTowerLevelInfoById(nId)
  if not cfgTowerLevel then
    local AsyncRes = AsyncRequestRes:New()
    AsyncRes:SetResult(TOWER_RESULT_CODE.TOWER_ID_INVALID)
    return AsyncRes
  end
  info.nId = nId
  local res = game:StartMatchTask(TT, MatchType.MT_Tower, cfgTowerLevel.Type, info)
  return res
end

function TowerModule:Module_ConvertMatchResult(recvResult)
  local uiMatchResult = UI_MatchResult:New()
  uiMatchResult.m_nMatchType = MatchType.MT_Tower
  uiMatchResult.m_nID = recvResult.tower_id
  local cfg = self:GetCfgTowerLevelInfoById(recvResult.tower_id)
  if not cfg then
    return uiMatchResult
  end
  uiMatchResult.m_vecFirstPassAward = recvResult.rewards
  uiMatchResult.m_matchResRolInfo = recvResult.match_result_role_info
  return uiMatchResult
end

function TowerModule:GetErrorMsg(errno)
  if errno == TOWER_RESULT_CODE.TOWER_INVALID then
    return StringTable.Get("str_tower_error_-1")
  elseif errno == TOWER_RESULT_CODE.TOWER_PlayerTowerNotOpen then
    return StringTable.Get("str_tower_error_1")
  elseif errno == TOWER_RESULT_CODE.TOWER_INVALID_PET then
    return StringTable.Get("str_tower_error_2")
  elseif errno == TOWER_RESULT_CODE.TOWER_FORMATION_INVALID_PETCOUNT then
    return StringTable.Get("str_tower_error_3")
  elseif errno == TOWER_RESULT_CODE.TOWER_ID_INVALID then
    return StringTable.Get("str_tower_error_4")
  elseif errno == TOWER_RESULT_CODE.TOWER_DB_LOAD_ERR then
    return StringTable.Get("str_tower_error_5")
  elseif errno == TOWER_RESULT_CODE.TOWER_DB_SAVE_ERR then
    return StringTable.Get("str_tower_error_6")
  elseif errno == TOWER_RESULT_CODE.TOWER_FORMATION_INVALID_PETTYPE then
    return StringTable.Get("str_tower_error_7")
  elseif errno == TOWER_RESULT_CODE.TOWER_FORMATION_PET_REPEAT then
    return StringTable.Get("str_tower_error_8")
  elseif errno == TOWER_RESULT_CODE.TOWER_TYPE_INVALID then
    return StringTable.Get("str_tower_error_9")
  elseif errno == TOWER_RESULT_CODE.TOWER_FORMATION_ELEMENT_TYPE_ERR then
    return StringTable.Get("str_tower_error_10")
  else
    return StringTable.Get("str_tower_error_999") .. errno
  end
end

function TowerModule:IsTowerPass(nID)
  local cfgTower = self:GetCfgTowerLevelInfoById(nID)
  local nElementType = cfgTower.Type
  local nStage = cfgTower.stage
  local nLarer = self:GetTowerLayer(nElementType)
  if nLarer and nStage <= nLarer then
    return true
  end
end

function TowerModule:GetNextStageCfg(nID)
  local cfgTower = self:GetCfgTowerLevelInfoById(nID)
  local nElementType = cfgTower.Type
  local nextStage = cfgTower.stage + 1
  return self._cfg_tower_elemetn_detail[nElementType][nextStage]
end

function TowerModule:IsNextStageActive(nID)
  local cfg = self:GetNextStageCfg(nID)
  local active = cfg ~= nil
  return active
end

function TowerModule:GetTowerNameByID(nID)
  local cfgTower = self:GetCfgTowerLevelInfoById(nID)
  local nElementType = cfgTower.Type
  local nStage = cfgTower.stage
  return self:GetTowerName(nElementType), nStage
end
