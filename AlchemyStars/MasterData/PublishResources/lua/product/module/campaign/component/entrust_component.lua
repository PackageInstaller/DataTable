_class("EntrustComponent", ICampaignComponent)
EntrustComponent = EntrustComponent

function EntrustComponent:Constructor()
  self.m_component_info = EntrustComponentInfo:New()
  self.m_client_data = EntrustComponetClientData:New()
  self.m_flag_levelId = 0
  self.m_flag_player = 0
  self.m_flag_Banner = 0
  self.m_local_last_mission = -1
end

function EntrustComponent:ComponentInfo()
  if not self.m_component_info then
    self.m_component_info = EntrustComponentInfo:New()
  end
  return self.m_component_info
end

function EntrustComponent:GetComponentInfo()
  return self:ComponentInfo()
end

function EntrustComponent:GetComponentType()
  return CampaignComType.E_CAMPAIGN_COM_ENTRUST
end

function EntrustComponent:InitComponentInfo(a_load_info)
  local ret = ComponentDataHelper.ParseData(a_load_info.m_data, self.m_component_info)
  self:_RefreshClientData()
  return ret
end

function EntrustComponent:GetCampaignMissionComponentId()
  return ECampaignMissionComponentId.ECampaignMissionComponentId_Entrust
end

function EntrustComponent:GetCampaignMissionParamKeyMap()
  local ComponentInfo = self:ComponentInfo()
  local nCfgId = self:GetComponetCfgId(ComponentInfo.m_campaign_id, ComponentInfo.m_component_id)
  return {
    [ECampaignMissionParamKey.ECampaignMissionParamKey_ComCfgId] = nCfgId
  }
end

function EntrustComponent:_inference_open(openlines, openevents, alllines, rewared_events)
  if alllines == nil then
    return
  end
  for k, v in pairs(alllines) do
    local cfg_entrust_line = Cfg.cfg_campaign_entrust_line[v]
    for i, eventid in pairs(rewared_events) do
      local peer_event_id = 0
      if eventid == cfg_entrust_line.LeftEventID then
        peer_event_id = cfg_entrust_line.RightEventID
      elseif eventid == cfg_entrust_line.RightEventID then
        peer_event_id = cfg_entrust_line.LeftEventID
      end
      if peer_event_id ~= 0 then
        openlines[v] = v
        openevents[peer_event_id] = peer_event_id
      end
      local cfg_entrust_event = Cfg.cfg_campaign_entrust_event[eventid]
      if cfg_entrust_event and cfg_entrust_event.TargetID then
        openevents[cfg_entrust_event.TargetID] = cfg_entrust_event.TargetID
      end
    end
  end
end

function EntrustComponent:_passed(rewarded_events)
  if rewarded_events == nil then
    return false
  end
  for k, v in pairs(rewarded_events) do
    local cfg_event = Cfg.cfg_campaign_entrust_event[v]
    if cfg_event.EventType == EntrustEventType.EntrustEventType_End then
      return true
    end
  end
  return false
end

function EntrustComponent:_IsNotCountEventType(eventType)
  local tb = {
    [EntrustEventType.EntrustEventType_Start] = true,
    [EntrustEventType.EntrustEventType_Transfer] = true
  }
  return tb[eventType]
end

function EntrustComponent:_IsBoxEventType(eventType)
  return eventType == EntrustEventType.EntrustEventType_Box
end

function EntrustComponent:_totalevents(entrustid)
  local cfg_entrust = Cfg.cfg_component_entrust[entrustid]
  local total = 0
  local box_num = 0
  if cfg_entrust == nil then
    return box_num, total
  end
  for k, v in pairs(cfg_entrust.EventID) do
    local cfg_event = Cfg.cfg_campaign_entrust_event[v]
    if cfg_event ~= nil then
      local isBox = self:_IsBoxEventType(cfg_event.EventType) and 1 or 0
      box_num = box_num + isBox
      local notCount = self:_IsNotCountEventType(cfg_event.EventType) and -1 or 0
      total = total + 1 + notCount
    end
  end
  return box_num, total
end

function EntrustComponent:_completeddevents(rewarded_events)
  local completed = 0
  local box_num = 0
  if rewarded_events == nil then
    return box_num, completed
  end
  for k, v in pairs(rewarded_events) do
    local cfg_event = Cfg.cfg_campaign_entrust_event[v]
    if cfg_event ~= nil then
      local isBox = self:_IsBoxEventType(cfg_event.EventType) and 1 or 0
      box_num = box_num + isBox
      local notCount = self:_IsNotCountEventType(cfg_event.EventType) and -1 or 0
      completed = completed + 1 + notCount
    end
  end
  return box_num, completed
end

function EntrustComponent:_put_start_to_open_events(openevents, allevents)
  for k, v in pairs(allevents) do
    local cfg_event = Cfg.cfg_campaign_entrust_event[v]
    if cfg_event.EventType == EntrustEventType.EntrustEventType_Start then
      openevents[v] = v
    end
  end
end

function EntrustComponent:_get_rewards(allevents)
  local box_rewards = {}
  local passed_rewards = {}
  for k, v in pairs(allevents) do
    local cfg_event = Cfg.cfg_campaign_entrust_event[v]
    if cfg_event.EventType == EntrustEventType.EntrustEventType_End then
      for i = 1, #cfg_event.RewardList do
        local reward = RoleAsset:New()
        reward.assetid = cfg_event.RewardList[i][1]
        reward.count = cfg_event.RewardList[i][2]
        table.insert(passed_rewards, reward)
      end
    elseif cfg_event.EventType == EntrustEventType.EntrustEventType_Box then
      for i = 1, #cfg_event.RewardList do
        local reward = RoleAsset:New()
        reward.assetid = cfg_event.RewardList[i][1]
        reward.count = cfg_event.RewardList[i][2]
        table.insert(box_rewards, reward)
      end
    end
  end
  return box_rewards, passed_rewards
end

function EntrustComponent:_RefreshClientData()
  local refreshClientData = self.RefreshClientData
  local id = self:GetComponentCfgId()
  if self._hook ~= nil and self._hook[id] ~= nil then
    refreshClientData = self._hook[id]
  end
  refreshClientData(self)
end

function EntrustComponent:RefreshClientData()
  self.m_client_data = EntrustComponetClientData:New()
  local cfg_entrust = Cfg.cfg_component_entrust({
    ComponentID = self:GetComponentCfgId()
  })
  for _, v in pairs(cfg_entrust) do
    local k = v.ID
    local data = EntrustLevelData:New()
    if self.m_component_info.rewarded_events[k] ~= nil then
      data.rewarded_events = self.m_component_info.rewarded_events[k]
    end
    self:_inference_open(data.open_lines, data.open_events, v.LineID, data.rewarded_events)
    data.passed = self:_passed(data.rewarded_events)
    data.total_box, data.total_events = self:_totalevents(k)
    data.opened_box, data.complete_events = self:_completeddevents(data.rewarded_events)
    if self.m_component_info.open_time[k] ~= nil then
      data.open_time = self.m_component_info.open_time[k]
    end
    if data.open_events == nil or #data.open_events == 0 then
      self:_put_start_to_open_events(data.open_events, v.EventID)
    end
    data.box_rewards, data.passed_rewards = self:_get_rewards(v.EventID)
    self.m_client_data.datas[k] = data
  end
end

function EntrustComponent:GetRewardedEvents()
  return self.m_component_info.rewarded_events
end

function EntrustComponent:GetClientData()
  return self.m_client_data
end

function EntrustComponent:HookClientData(cfgId, target)
  if self._hook == nil then
    self._hook = {
      [cfgId] = target
    }
  else
    self._hook[cfgId] = target
  end
end

function EntrustComponent:CampaignComponentPushNotify(notify_data)
  if EntrustComponentNotifyType.EntrustComponentNotifyType_EventsRefresh == notify_data.m_notify_type then
    local ev = NotifyEntrustEventsRefresh:New()
    local ret = ComponentDataHelper.ParseData(notify_data.m_data, ev)
    if ret then
      self:EventsRefresh(ev)
    else
      Log.error("[CampaignCom][EntrustComponent] CampaignComponentPushNotify ParseData error! ret:", ret)
    end
  end
end

function EntrustComponent:EventsRefresh(notify_data)
  self.m_component_info.rewarded_events = notify_data.rewarded_events
  self.m_component_info.mission_infos = notify_data.mission_infos
  self:_RefreshClientData()
end

function EntrustComponent:HandleCompleteEvent(TT, asyncRes, entrustid, eventid)
  local request = EntrustComponentCompleteReq:New()
  request.entrustid = entrustid
  request.eventid = eventid
  local response = EntrustComponentCompleteRep:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][EntrustComponent] HandleCompleteEvent ret:", asyncRes.m_result)
    return asyncRes, nil
  end
  if self.m_component_info.rewarded_events[entrustid] == nil then
    self.m_component_info.rewarded_events[entrustid] = {}
    table.insert(self.m_component_info.rewarded_events[entrustid], eventid)
  else
    table.insert(self.m_component_info.rewarded_events[entrustid], eventid)
  end
  self:_RefreshClientData()
  return asyncRes, response
end

function EntrustComponent:HandleMoveCompleteEvent(TT, asyncRes, entrustid, teamevents)
  local request = EntrustComponentMoveEventReq:New()
  request.entrustid = entrustid
  request.team_events = teamevents
  local response = EntrustComponentMoveEventRep:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][EntrustComponent] HandleMoveCompleteEvent ret:", asyncRes.m_result)
    return asyncRes, nil
  end
  self.m_component_info.mission_infos[entrustid] = response.mission_info
  return asyncRes, response
end

local EEntrustStageNodeState = {
  LockWithTime = 1,
  Lock = 2,
  Unlock = 3,
  Pass = 4
}
_enum("EEntrustStageNodeState", EEntrustStageNodeState)

function EntrustComponent:Start_HandleCompleteEvent(entrustid, eventid, callback)
  local lockName = "EntrustComponent:Start_HandleCompleteEvent"
  GameGlobal.UIStateManager():Lock(lockName)
  GameGlobal.TaskManager():StartTask(function(TT)
    local AsyncRequestRes = AsyncRequestRes:New()
    local res, msg = self:HandleCompleteEvent(TT, AsyncRequestRes, entrustid, eventid)
    GameGlobal.UIStateManager():UnLock(lockName)
    if res:GetSucc() then
      local rewards = msg.rewards
      callback(res, rewards)
    else
      local result = res:GetResult()
      Log.error("EntrustComponent:Start_HandleCompleteEvent() fail ! ", "stageId[", entrustid, "] eventId[", eventid, "] result = ", result)
      callback(res, {})
    end
  end)
end

function EntrustComponent:_Map2List(tb_in)
  local tb_out = {}
  for k, v in pairs(tb_in) do
    table.insert(tb_out, k)
  end
  table.sort(tb_out)
  return tb_out
end

function EntrustComponent:GetAllLevelId()
  return self:_Map2List(self.m_client_data.datas)
end

function EntrustComponent:CheckStageState(entrustid)
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local _time = self:GetStageOpenTime(entrustid) or 0
  local stamp = _time - curTime
  if 0 < stamp then
    return EEntrustStageNodeState.LockWithTime
  end
  if not self:GetStagePreUnlock(entrustid) then
    return EEntrustStageNodeState.Lock
  end
  if not self:IsStagePass(entrustid) then
    return EEntrustStageNodeState.Unlock
  end
  return EEntrustStageNodeState.Pass
end

function EntrustComponent:GetStageOpenTime(entrustid)
  local clientData = self.m_client_data.datas[entrustid]
  return clientData.open_time
end

function EntrustComponent:GetStagePointPos(entrustid)
  local cfg = Cfg.cfg_component_entrust[entrustid]
  local x = cfg.PointPos and cfg.PointPos[1] or 0
  local y = cfg.PointPos and cfg.PointPos[2] or 0
  return Vector2(x, y)
end

function EntrustComponent:GetStagePreUnlock(entrustid)
  local cfg = Cfg.cfg_component_entrust[entrustid]
  return cfg ~= nil and (cfg.PreID == 0 or self:IsStagePass(cfg.PreID))
end

function EntrustComponent:GetStageTitleDesc(entrustid)
  local cfg = Cfg.cfg_component_entrust[entrustid]
  return cfg.StrTitle, cfg.StrDesc
end

function EntrustComponent:GetStagePassReward(entrustid)
  local cfg = Cfg.cfg_component_entrust[entrustid]
  local stage_rewards = {}
  local received = {}
  for k, v in pairs(cfg.EventID) do
    local cfg_event = Cfg.cfg_campaign_entrust_event[v]
    if cfg_event.EventType == EntrustEventType.EntrustEventType_End then
      local flag = self:IsStagePass(entrustid)
      for i = 1, #cfg_event.RewardList do
        local reward = RoleAsset:New()
        reward.assetid = cfg_event.RewardList[i][1]
        reward.count = cfg_event.RewardList[i][2]
        table.insert(stage_rewards, reward)
        table.insert(received, flag)
      end
    end
  end
  return stage_rewards, received
end

function EntrustComponent:GetStageBoxReward(entrustid)
  local cfg = Cfg.cfg_component_entrust[entrustid]
  local box_rewards = {}
  local received = {}
  for k, v in pairs(cfg.EventID) do
    local cfg_event = Cfg.cfg_campaign_entrust_event[v]
    if cfg_event.EventType == EntrustEventType.EntrustEventType_Box then
      local flag = self:IsEventPass(entrustid, v)
      for i = 1, #cfg_event.RewardList do
        local reward = RoleAsset:New()
        reward.assetid = cfg_event.RewardList[i][1]
        reward.count = cfg_event.RewardList[i][2]
        table.insert(box_rewards, reward)
        table.insert(received, flag)
      end
    end
  end
  return box_rewards, received
end

function EntrustComponent:GetExplorNum(entrustid)
  local clientData = self.m_client_data.datas[entrustid]
  local n = math.floor(100 * clientData.complete_events / clientData.total_events)
  return n
end

function EntrustComponent:IsStagePass(entrustid)
  local clientData = self.m_client_data.datas[entrustid]
  return clientData.passed
end

function EntrustComponent:GetTreasureBoxText(entrustid)
  local clientData = self.m_client_data.datas[entrustid]
  return clientData.opened_box .. "/" .. clientData.total_box
end

function EntrustComponent:GetAllOpenEvents(entrustid)
  return self:_Map2List(self.m_client_data.datas[entrustid].open_events)
end

function EntrustComponent:FindEventStart(entrustid)
  local tb = self:GetAllOpenEvents(entrustid)
  for _, v in ipairs(tb) do
    if self:GetEventType(v) == EntrustEventType.EntrustEventType_Start then
      return v
    end
  end
end

function EntrustComponent:GetOpenAdjacentNode(entrustid, eventid)
  local tb_out = {}
  local lines = self:GetOpenAdjacentLineByNode(entrustid, eventid)
  for lineid, _ in pairs(lines) do
    local leftEventId, rightEventId = self:GetLineConecctEvents(lineid)
    table.insert(tb_out, leftEventId)
    table.insert(tb_out, rightEventId)
  end
  return tb_out
end

function EntrustComponent:IsEventPass(entrustid, eventid)
  for _, v in ipairs(self.m_client_data.datas[entrustid].rewarded_events) do
    if eventid == v then
      return true
    end
  end
  return false
end

function EntrustComponent:GetEventType(eventid)
  local cfg = Cfg.cfg_campaign_entrust_event[eventid]
  local type = cfg.EventType
  local subType = type == 3 and cfg.Params and cfg.Params[1].Type == 1 and 2 or 1
  return type, subType
end

function EntrustComponent:GetEventPointPos(eventid)
  local cfg = Cfg.cfg_campaign_entrust_event[eventid]
  local x = cfg.PointPos and cfg.PointPos[1] or 0
  local y = cfg.PointPos and cfg.PointPos[2] or 0
  return Vector2(x, y)
end

function EntrustComponent:GetOpenEventLine(entrustid)
  return self:_Map2List(self.m_client_data.datas[entrustid].open_lines)
end

function EntrustComponent:GetLineConecctEvents(lineid)
  local cfg = Cfg.cfg_campaign_entrust_line[lineid]
  local extra = cfg.ExtraPointPos or {}
  return cfg.LeftEventID, cfg.RightEventID, extra
end

function EntrustComponent:GetOpenAdjacentLineByNode(entrustid, eventid)
  local openEvents = self.m_client_data.datas[entrustid].open_events
  local tb_in = self:_Map2List(self.m_client_data.datas[entrustid].open_lines)
  local tb_out = {}
  for _, v in ipairs(tb_in) do
    local leftEventId, rightEventId = self:GetLineConecctEvents(v)
    if openEvents[leftEventId] and openEvents[rightEventId] then
      if leftEventId == eventid then
        tb_out[v] = true
      elseif rightEventId == eventid then
        tb_out[v] = false
      end
    end
  end
  return tb_out
end

function EntrustComponent:GetLinePosWithDirection(lineid, dir)
  local tb_out = {}
  local leftEventId, rightEventId, extraPos = self:GetLineConecctEvents(lineid)
  local left = self:GetEventPointPos(leftEventId)
  local right = self:GetEventPointPos(rightEventId)
  for i = 1, table.count(extraPos), 2 do
    local x, y = extraPos[i], extraPos[i + 1]
    table.insert(tb_out, {
      left,
      Vector2(x, y)
    })
    left = Vector2(x, y)
  end
  table.insert(tb_out, {left, right})
  if dir then
    for i = 1, #tb_out / 2 do
      tb_out[i], tb_out[#tb_out - i + 1] = tb_out[#tb_out - i + 1], tb_out[i]
    end
    for _, v in ipairs(tb_out) do
      v[1], v[2] = v[2], v[1]
    end
  end
  return tb_out
end

function EntrustComponent:SetCurLevelId(entrustid)
  self.m_flag_levelId = entrustid
end

function EntrustComponent:GetCurLevelId()
  return self.m_flag_levelId
end

function EntrustComponent:SetPlayerPos(eventid)
  self.m_flag_player = eventid
end

function EntrustComponent:GetPlayerPos()
  return self.m_flag_player
end

function EntrustComponent:SetBannerState(flag)
  self.m_flag_Banner = flag
end

function EntrustComponent:GetBannerState()
  return self.m_flag_Banner == 0
end

function EntrustComponent:HaveRedPoint()
  local id = self:GetComponentCfgId()
  if self._hook ~= nil and self._hook[id] ~= nil then
    return self.m_client_data:HasNew()
  end
  return false
end

function EntrustComponent:HasNew()
  local key = self:GetEntrustNewKey()
  local isNew = LocalDB.HasKey(key)
  return isNew or self:EntrustStageHasNew()
end

function EntrustComponent:GetEntrustNewKey()
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  local componentId = self:GetComponentCfgId()
  return "EntrustComponent_GetEntrustNewKey_" .. pstId .. "_" .. componentId
end

function EntrustComponent:GetEntrustEventNewKey(eventid)
  local key = self:GetEntrustNewKey()
  return key .. "_Event_" .. eventid
end

function EntrustComponent:GetEntrustStageNewKey()
  local key = self:GetEntrustNewKey()
  return key .. "_Stage"
end

function EntrustComponent:EntrustStageHasNew()
  local key = self:GetEntrustStageNewKey()
  local historyTime = 0
  if LocalDB.HasKey(key) then
    historyTime = LocalDB.GetFloat(key)
  end
  local timeModule = GameGlobal.GetModule(SvrTimeModule)
  local nowTime = timeModule:GetServerTime()
  Log.info("EntrustComponent:EntrustStageHasNew() key = ", key, " nowTime = ", nowTime, " historyTime = ", historyTime)
  local levels = self:GetAllLevelId()
  for _, levelId in ipairs(levels) do
    local openTime = self:GetStageOpenTime(levelId) * 1000
    if nowTime >= openTime and historyTime < openTime then
      Log.info("UIN22EntrustHelper.EntrustStageHasNew() return true, levelId = ", levelId, " openTime = ", openTime)
      return true
    end
  end
  Log.info("EntrustComponent:EntrustStageHasNew() return false")
  return false
end

function EntrustComponent:EntrustStageClearNew()
  local key = self:GetEntrustStageNewKey()
  local timeModule = GameGlobal.GetModule(SvrTimeModule)
  local nowTime = timeModule:GetServerTime()
  Log.info("EntrustComponent:EntrustStageClearNew() key = ", key, " nowTime = ", nowTime)
  LocalDB.SetFloat(key, nowTime)
end

function EntrustComponent:GetPath_BFS(entrustid, start_id, target_id, limit_step)
  limit_step = limit_step or 100
  local queue = {start_id}
  local path = {
    [start_id] = {start_id}
  }
  while table.count(queue) ~= 0 do
    local cur = queue[1]
    table.remove(queue, 1)
    if target_id == cur then
      return path[cur]
    end
    local step = #path[cur] - 1
    if step == limit_step then
      break
    end
    local next = self:GetOpenAdjacentNode(entrustid, cur)
    for _, v in ipairs(next) do
      if not path[v] then
        path[v] = table.collect(path[cur])
        table.insert(path[v], v)
        table.insert(queue, v)
      end
    end
  end
  return {}
end
