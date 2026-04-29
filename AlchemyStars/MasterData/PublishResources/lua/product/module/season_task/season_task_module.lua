_class("SeasonTaskModule", GameModule)
SeasonTaskModule = SeasonTaskModule

function SeasonTaskModule:Constructor()
  self.season_task_list_info = client_season_task_info:New()
  self.client_quest_progress_info = ClientQuestProgressInfo:New()
end

function SeasonTaskModule:Init()
  self.caller:RegisterPushHandler(CEventPushUpdateTaskNode, self.HandleSeasonTaskRefresh, self)
end

function SeasonTaskModule:ReqSeasonTaskInfoData(TT)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventGetSeasonTaskInfoReq)
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(WorldBossErrorType.E_WORLDBOSS_ERROR_UNLOCK)
    return AsyncRes
  end
  local replyEvent = reply.msg
  self.season_task_list_info = replyEvent.cur_task_info
  self.client_quest_progress_info = replyEvent.client_infos
  if replyEvent.n_ret == SeasonTaskErrorType.E_SEASONTASK_ERROR_TYPE_SUCCESS then
    AsyncRes:SetSucc(true)
  else
    AsyncRes:SetResult(replyEvent.n_ret)
  end
  return AsyncRes
end

function SeasonTaskModule:HandleSeasonTaskRefresh(msg)
  self.season_task_list_info = msg.cur_task_info
  if msg.is_cross_day == true then
    if self.client_quest_progress_info ~= nil then
      self.client_quest_progress_info.rand_quest_progress_info = {}
    end
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnSeasonTaskReset)
  end
end

function SeasonTaskModule:ReqSubmitClientInfo(TT, info)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventClientSubmitInfoReq)
  request.info = info
  local cfgQuest = Cfg.cfg_quest[info.quest_id]
  if cfgQuest == nil then
    AsyncRes:SetResult(false)
    return AsyncRes
  end
  if cfgQuest.QuestType ~= QuestType.QT_SeasonTaskLine and cfgQuest.QuestType ~= QuestType.QT_SeasonTaskRand then
    AsyncRes:SetResult(false)
    return AsyncRes
  end
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(false)
    return AsyncRes
  end
  local replyEvent = reply.msg
  if replyEvent.n_ret == SeasonTaskErrorType.E_SEASONTASK_ERROR_TYPE_SUCCESS then
    if cfgQuest.QuestType == QuestType.QT_SeasonTaskLine then
      self.client_quest_progress_info.line_quest_progress_info[replyEvent.info.quest_id] = replyEvent.info
    else
      self.client_quest_progress_info.rand_quest_progress_info[replyEvent.info.quest_id] = replyEvent.info
    end
    AsyncRes:SetSucc(true)
  else
    AsyncRes:SetResult(replyEvent.n_ret)
  end
  return AsyncRes
end

function SeasonTaskModule:IsTaskStageType_Line()
  return self.season_task_list_info.stage == TaskStageType.LINETASK
end

function SeasonTaskModule:_FixNodesByCfg(tb)
  if self:IsTaskStageType_Line() then
    return
  end
  local nodeCount = 0
  local seasonId = GameGlobal.GetModule(SeasonModule):GetCurSeasonID() or 0
  local cfgs = Cfg.cfg_season_task_node_rand_rule({SeasonId = seasonId})
  for _, v in ipairs(cfgs) do
    nodeCount = nodeCount + v.Num
  end
  if #tb ~= nodeCount then
    local node = self.season_task_list_info.cur_line_task
    table.insert(tb, 1, node)
  end
end

function SeasonTaskModule:GetAllNode()
  local tb = {}
  if self:IsTaskStageType_Line() then
    local node = self.season_task_list_info.cur_line_task
    table.insert(tb, node)
  end
  for i, v in ipairs(self.season_task_list_info.cur_rand_task) do
    table.insert(tb, v)
  end
  self:_FixNodesByCfg(tb)
  return tb
end

function SeasonTaskModule:GetAllNodeLock()
  local nodes = self:GetAllNode()
  local tb = {}
  local isLock = false
  for i, v in ipairs(nodes) do
    table.insert(tb, isLock)
    isLock = isLock or not v.is_finish
  end
  return tb
end

function SeasonTaskModule:GetCurNodeIndex()
  local nodes = self:GetAllNode()
  for i, v in ipairs(nodes) do
    if v.is_finish == false then
      return i
    end
  end
  return #nodes
end

function SeasonTaskModule:GetCurNode()
  local nodes = self:GetAllNode()
  local idx = self:GetCurNodeIndex()
  return nodes[idx]
end

function SeasonTaskModule:TaskListShow()
  local node = self:GetCurNode()
  local isShow = node ~= nil and node.node_id ~= 0
  return isShow
end

function SeasonTaskModule:TaskListRed()
  local node = self:GetCurNode()
  local questId, isFin = UISeasonTaskListHelper.CheckLastQuestFin(node)
  Log.info("SeasonTaskModule:TaskListRed() node =", node.node_id, ", questId =", questId, ", isFin =", isFin)
  local isNodeValid = node ~= nil and node.node_id ~= 0
  local isQuestValid = questId ~= nil and questId ~= 0
  local isRed = isNodeValid and isQuestValid and not isFin
  return isRed
end

function SeasonTaskModule:GetCurQuestId(node)
  return UISeasonTaskListHelper.GetCurQuestId(node)
end

function SeasonTaskModule:GetConditionMap(otherMap)
  local map = {}
  if otherMap then
    map = otherMap
  end
  
  local function AddMapFunc(data)
    local info = data
    if info then
      for _, value in pairs(info.event_infos) do
        if value then
          map[value.event_id] = value.status
        end
      end
    end
  end
  
  if self.client_quest_progress_info then
    local lineInfos = self.client_quest_progress_info.line_quest_progress_info
    if lineInfos then
      for _, questProgress in pairs(lineInfos) do
        AddMapFunc(questProgress)
      end
    end
    local randInfos = self.client_quest_progress_info.rand_quest_progress_info
    if randInfos then
      for _, questProgress in pairs(randInfos) do
        AddMapFunc(questProgress)
      end
    end
  end
  return map
end

function SeasonTaskModule:ReqSubmitEventPointInfo(TT, info)
  local AsyncRes = AsyncRequestRes:New()
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventClientSubmitEventPointInfoReq)
  request.info = info
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    AsyncRes:SetResult(false)
    return AsyncRes
  end
  local replyEvent = reply.msg
  if replyEvent.n_ret == SeasonTaskErrorType.E_SEASONTASK_ERROR_TYPE_SUCCESS then
    self.client_quest_progress_info.eventpoint_info[replyEvent.info.event_id] = replyEvent.info
    AsyncRes:SetSucc(true)
    GameGlobal.GetUIModule(SeasonModule):OnTrackEventpointDataChged(replyEvent.info)
  else
    AsyncRes:SetResult(replyEvent.n_ret)
  end
  return AsyncRes
end

function SeasonTaskModule:GetTrackPointInfo(eventId)
  local info = self.client_quest_progress_info.eventpoint_info[eventId]
  return info
end
