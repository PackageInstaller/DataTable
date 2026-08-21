require("component_base")
_class("CampaignQuestComponent", ICampaignComponent)
CampaignQuestComponent = CampaignQuestComponent
local CampaignQuestStatus = {
  CQS_NotStart = 1,
  CQS_Accepted = 2,
  CQS_Completed = 3,
  CQS_Taken = 4,
  CQS_Over = 5
}
_enum("CampaignQuestStatus", CampaignQuestStatus)

function CampaignQuestComponent:Constructor()
  self.m_component_info = CamQuestComponentInfo:New()
end

function CampaignQuestComponent:ComponentInfo()
  if not self.m_component_info then
    self.m_component_info = CamQuestComponentInfo:New()
  end
  return self.m_component_info
end

function CampaignQuestComponent:GetQuestInfo()
  local questModule = GameGlobal.GetModule(QuestModule)
  local l_ret_table = {}
  for index, value in ipairs(self.m_component_info.m_accept_cam_quest_list) do
    local quest = questModule:GetQuest(value)
    if quest then
      l_ret_table[index] = quest
    end
  end
  return l_ret_table
end

function CampaignQuestComponent:GetComponentInfo()
  return self:ComponentInfo()
end

function CampaignQuestComponent:GetComponentType()
  return CampaignComType.E_CAMPAIGN_COM_QUEST
end

function CampaignQuestComponent:InitComponentInfo(a_load_info)
  local ret = ComponentDataHelper.ParseData(a_load_info.m_data, self.m_component_info)
  return ret
end

function CampaignQuestComponent:HaveUnAcceptQuest(checkCost)
  local questModule = GameGlobal.GetModule(QuestModule)
  local itemModuel
  if checkCost then
    itemModuel = GameGlobal.GetModule(ItemModule)
  end
  for index, value in ipairs(self.m_component_info.m_accept_cam_quest_list) do
    local quest = questModule:GetQuest(value)
    if quest and quest:Status() == QuestStatus.QUEST_Completed then
      if checkCost then
        local questId = quest:QuestInfo().quest_id
        local cfg = Cfg.cfg_component_quest({QuestID = questId})
        local costItems
        if cfg and 0 < #cfg then
          costItems = cfg[1].CostItems
        end
        if not costItems or #costItems == 0 then
          return true
        end
        local enough = true
        for k, subCost in pairs(costItems) do
          local itemId = subCost[1]
          local costNum = subCost[2]
          if costNum > itemModuel:GetItemCount(itemId) then
            enough = false
            break
          end
        end
        if enough then
          return true
        end
      else
        return true
      end
    end
  end
  return false
end

function CampaignQuestComponent:HaveRedPoint()
  return self:ComponentIsOpen() and self:HaveUnAcceptQuest(true)
end

function CampaignQuestComponent:HandleQuestTake(TT, asyncRes, nQuestId)
  local request = CamQuestTakeReq:New()
  local response = CamQuestTakeRep:New()
  request.id = nQuestId
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][CampaignQuestComponent] HandleQuestTake ret:", asyncRes.m_result)
    return nil
  end
  if self:HaveUnAcceptQuest() == false then
    self:UpdateComponentStep(ECampaignStep.CAMPAIGN_STEP_CLOSE_REMIND)
  end
  return response.ret, response.rewards
end

function CampaignQuestComponent:HandleOneKeyTakeQuest(TT, asyncRes)
  local request = CamOneKeyQuestTakeReq:New()
  local response = CamOneKeyQuestTakeRsp:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][CampaignQuestComponent] HandleQuestTake ret:", asyncRes.m_result)
    return nil
  end
  if self:HaveUnAcceptQuest() == false then
    self:UpdateComponentStep(ECampaignStep.CAMPAIGN_STEP_CLOSE_REMIND)
  end
  return response.ret, response.rewards
end

function CampaignQuestComponent:HandleCamQuestDailyReset(TT, asyncRes)
  local request = CamQuestDailyResetReq:New()
  local response = CamQuestDailyResetRep:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][CampaignQuestComponent] HandleCamQuestDailyReset ret:", asyncRes.m_result)
    return nil
  end
  for key, value in pairs(response.m_reset_quest_map) do
    local param_info = self.m_component_info.m_quest_time_param_map[key]
    if param_info then
      param_info.m_end_time = value
    end
  end
  asyncRes:SetSucc(true)
end

function CampaignQuestComponent:CampaignComponentPushNotify(notify_data)
  if CamQuestComponentNotifyType.CamQuestComponentNotify_DailyReset == notify_data.m_notify_type then
    local ev = NotifyCamQuesetComponentDailyReset:New()
    local ret = ComponentDataHelper.ParseData(notify_data.m_data, ev)
    if ret then
      self:OnQuesetDailyReset(ev)
    else
      Log.error("[CampaignCom][CampaignQuestComponent] CampaignComponentPushNotify ParseData error! ret:", ret)
    end
  end
end

function CampaignQuestComponent:OnQuesetDailyReset(ev)
  for key, value in pairs(ev.m_reset_quest_map) do
    local param_info = self.m_component_info.m_quest_time_param_map[key]
    if param_info then
      param_info.m_end_time = value
    end
  end
end

function CampaignQuestComponent:Start_HandleQuestTake(nQuestId, callback)
  local lockName = "CampaignQuestComponent:Start_HandleQuestTake"
  GameGlobal.UIStateManager():Lock(lockName)
  GameGlobal.TaskManager():StartTask(function(TT)
    local res = AsyncRequestRes:New()
    local ret = 0
    local rewards
    ret, rewards = self:HandleQuestTake(TT, res, nQuestId)
    if callback then
      callback(res, rewards)
    end
    GameGlobal.UIStateManager():UnLock(lockName)
  end)
end

function CampaignQuestComponent:Start_HandleOneKeyTakeQuest(callback)
  local lockName = "CampaignQuestComponent:Start_HandleOneKeyTakeQuest"
  GameGlobal.UIStateManager():Lock(lockName)
  GameGlobal.TaskManager():StartTask(function(TT)
    local res = AsyncRequestRes:New()
    local ret = 0
    local rewards
    ret, rewards = self:HandleOneKeyTakeQuest(TT, res)
    if callback then
      callback(res, rewards)
    end
    GameGlobal.UIStateManager():UnLock(lockName)
  end)
end

function CampaignQuestComponent:IsContainQuest(quests)
  local questList = self.m_component_info.m_accept_cam_quest_list
  local tb = table.reverse(questList)
  for _, v in pairs(quests) do
    if tb[v:ID()] then
      return true
    end
  end
  return false
end

function CampaignQuestComponent:IsDailyQuest(questId)
  local param_info = self.m_component_info.m_quest_time_param_map[questId] or {}
  return param_info.m_need_daily_reset
end

function CampaignQuestComponent:Check_CamQuestDailyReset()
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local nextTime = self:GetEarliestEndTimeInDailyQuest()
  local stamp = nextTime - curTime
  if 0 <= stamp then
    return false
  end
  return true
end

function CampaignQuestComponent:Start_HandleCamQuestDailyReset(callback)
  local lockName = "CampaignQuestComponent:Start_HandleCamQuestDailyReset"
  GameGlobal.UIStateManager():Lock(lockName)
  GameGlobal.TaskManager():StartTask(function(TT)
    local res = AsyncRequestRes:New()
    self:HandleCamQuestDailyReset(TT, res)
    if callback then
      callback(TT, res)
    end
    GameGlobal.UIStateManager():UnLock(lockName)
  end)
end

function CampaignQuestComponent:GetEarliestEndTimeInDailyQuest()
  local t = 0
  for index, value in ipairs(self.m_component_info.m_accept_cam_quest_list) do
    local timeParam = self.m_component_info.m_quest_time_param_map[value]
    if timeParam and timeParam.m_need_daily_reset and timeParam.m_end_time ~= 0 then
      t = t == 0 and timeParam.m_end_time or math.min(t, timeParam.m_end_time)
    end
  end
  return t
end

function CampaignQuestComponent:GetQuestInfo_ByCampaignQuestStatus(filter)
  filter = filter or {}
  local questModule = GameGlobal.GetModule(QuestModule)
  local l_ret_table = {}
  for index, value in ipairs(self.m_component_info.m_accept_cam_quest_list) do
    local quest = questModule:GetQuest(value)
    if quest then
      local status = self:CheckCampaignQuestStatus(quest:QuestInfo())
      if filter[status] then
        table.insert(l_ret_table, quest)
      end
    end
  end
  return l_ret_table
end

function CampaignQuestComponent:GetCampaignQuestStatus(quests)
  local ret = {}
  for _, v in pairs(quests) do
    ret[v] = self:CheckCampaignQuestStatus(v:QuestInfo())
  end
  return ret
end

function CampaignQuestComponent:CheckCampaignQuestStatus(quest)
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local questId = quest.quest_id
  local componentInfo = self:GetComponentInfo()
  local timeInfo = componentInfo.m_quest_time_param_map[questId]
  if timeInfo.m_open_time ~= 0 and curTime < timeInfo.m_open_time then
    return CampaignQuestStatus.CQS_NotStart
  end
  if timeInfo.m_end_time ~= 0 and curTime > timeInfo.m_end_time then
    if quest.status == QuestStatus.QUEST_Completed then
      return CampaignQuestStatus.CQS_Completed
    end
    if quest.status ~= QuestStatus.QUEST_Taken then
      return CampaignQuestStatus.CQS_Over
    end
  end
  local questStatus2campaignQuestStatus = {
    [QuestStatus.QUEST_NotStart] = CampaignQuestStatus.CQS_NotStart,
    [QuestStatus.QUEST_Accepted] = CampaignQuestStatus.CQS_Accepted,
    [QuestStatus.QUEST_Completed] = CampaignQuestStatus.CQS_Completed,
    [QuestStatus.QUEST_Taken] = CampaignQuestStatus.CQS_Taken
  }
  return questStatus2campaignQuestStatus[quest.status]
end

function CampaignQuestComponent:SortQuestInfoByCampaignQuestStatus(questList)
  local status = {}
  local defaultIndex = {}
  for k, v in ipairs(questList) do
    defaultIndex[v] = k
    status[v] = self:CheckCampaignQuestStatus(v:QuestInfo())
  end
  local val = {}
  val[CampaignQuestStatus.CQS_Completed] = 0
  val[CampaignQuestStatus.CQS_Accepted] = 1
  val[CampaignQuestStatus.CQS_Taken] = 2
  val[CampaignQuestStatus.CQS_NotStart] = 3
  val[CampaignQuestStatus.CQS_Over] = 4
  table.sort(questList, function(a, b)
    if val[status[a]] == val[status[b]] then
      return defaultIndex[a] < defaultIndex[b]
    end
    return val[status[a]] < val[status[b]]
  end)
end

function CampaignQuestComponent:SortQuestInfoByDaily(questList)
  local status = {}
  local defaultIndex = {}
  for k, v in ipairs(questList) do
    defaultIndex[v] = k
    status[v] = self:IsDailyQuest(v:QuestInfo().quest_id)
  end
  table.sort(questList, function(a, b)
    if status[a] == status[b] then
      return defaultIndex[a] < defaultIndex[b]
    end
    return status[a]
  end)
end

function CampaignQuestComponent:GetQuestProgressString(quest)
  local cur = quest.cur_progress
  local total = quest.total_progress
  local str = ""
  if quest.ShowType == 1 then
    local c, d = math.modf(cur * 100 / total)
    if c < 1 and 0 < d then
      c = 1
    end
    str = c .. "%"
  else
    str = cur .. "/" .. total
  end
  return cur, total, str
end

function CampaignQuestComponent:HasQuestCanClaim(questInfos)
  for _, v in ipairs(questInfos) do
    local questInfo = v:QuestInfo()
    if questInfo.status == QuestStatus.QUEST_Completed then
      return true
    end
  end
  return false
end

function CampaignQuestComponent:GetQuestCanClaim(questInfos)
  local tb = {}
  for _, v in ipairs(questInfos) do
    local questInfo = v:QuestInfo()
    if questInfo.status == QuestStatus.QUEST_Completed then
      table.insert(tb, questInfo.quest_id)
    end
  end
  return tb
end

function CampaignQuestComponent:GetQuestInfoById(questId)
  local list = self:GetQuestInfo()
  for _, v in ipairs(list) do
    if v:ID() == questId then
      return v
    end
  end
end
