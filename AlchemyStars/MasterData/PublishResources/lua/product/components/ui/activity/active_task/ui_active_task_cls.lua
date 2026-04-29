_class("ActiveTaskData", Object)
ActiveTaskData = ActiveTaskData

function ActiveTaskData:Constructor()
  self._dailyTaskList = nil
  self._accumTaskList = nil
  self._matrixIndex = nil
end

function ActiveTaskData:SetCampaign(campaign)
  self._campaign = campaign
end

function ActiveTaskData:GetCampaign()
  return self._campaign
end

function ActiveTaskData:GetCampaignID()
  return ECampaignType.CAMPAIGN_TYPE_N32_VIG_QUEST
end

function ActiveTaskData:GetSample()
  return self._campaign:GetSample()
end

function ActiveTaskData:GetCampaignLocalProgress()
  local campaign = self:GetCampaign()
  if campaign then
    return campaign:GetLocalProcess()
  end
end

function ActiveTaskData:GetCampaignEndTime()
  local sample = self:GetSample()
  return sample.end_time
end

function ActiveTaskData:CheckFlipRed()
  local comp = self:GetFlipComp()
  local hasRed = comp:HaveRedPoint()
  return hasRed
end

function ActiveTaskData:CheckMissionRed()
  local comp = self:GetMissionComp()
  local hasRed = comp:HaveRedPoint()
  return hasRed or self:CheckDailyTaskRed()
end

function ActiveTaskData:GetFlipComp()
  local localProcess = self:GetCampaignLocalProgress()
  if localProcess then
    return localProcess:GetComponent(ECampaignVigQuestComponentID.ECAMPAIGN_VIGQUEST_TURNCARD)
  end
end

function ActiveTaskData:GetFlipCompInfo()
  local localProcess = self:GetCampaignLocalProgress()
  if localProcess then
    return localProcess:GetComponentInfo(ECampaignVigQuestComponentID.ECAMPAIGN_VIGQUEST_TURNCARD)
  end
end

function ActiveTaskData:GetMissionComp()
  local localProcess = self:GetCampaignLocalProgress()
  if localProcess then
    return localProcess:GetComponent(ECampaignVigQuestComponentID.ECAMPAIGN_VIGQUEST_QUEST)
  end
end

function ActiveTaskData:GetMissionCompInfo()
  local localProcess = self:GetCampaignLocalProgress()
  if localProcess then
    return localProcess:GetComponentInfo(ECampaignVigQuestComponentID.ECAMPAIGN_VIGQUEST_QUEST)
  end
end

function ActiveTaskData:_GetAllTask()
  local dailyTaskList = {}
  local accumTaskList = {}
  local compInfo = self:GetMissionCompInfo()
  local questList = compInfo.m_accept_cam_quest_list
  local timeMap = compInfo.m_quest_time_param_map
  for i, v in pairs(questList) do
    local item = timeMap[v]
    if item.m_need_daily_reset then
      table.insert(dailyTaskList, v)
    else
      table.insert(accumTaskList, v)
    end
  end
  return dailyTaskList, accumTaskList
end

function ActiveTaskData:GetDailyTaskEndTime()
  local comp = self:GetMissionComp()
  return comp:GetEarliestEndTimeInDailyQuest()
end

function ActiveTaskData:GetDailyTask()
  local dailyTaskList, accumTaskList = self:_GetAllTask()
  dailyTaskList = self:_SortTask(dailyTaskList)
  return dailyTaskList
end

function ActiveTaskData:GetAccumTask()
  local dailyTaskList, accumTaskList = self:_GetAllTask()
  accumTaskList = self:_SortTask(accumTaskList)
  return accumTaskList
end

function ActiveTaskData:_SortTask(taskList)
  local questModule = GameGlobal.GetModule(QuestModule)
  local resTaskTb = {}
  local unFinish = {}
  local received = {}
  for _, taskId in pairs(taskList) do
    local task = questModule:GetQuest(taskId)
    local status = task:Status()
    if status == QuestStatus.QUEST_Accepted then
      table.insert(unFinish, task)
    elseif status == QuestStatus.QUEST_Completed then
      table.insert(resTaskTb, task)
    elseif status == QuestStatus.QUEST_Taken then
      table.insert(received, task)
    end
  end
  for _, task in pairs(unFinish) do
    table.insert(resTaskTb, task)
  end
  for _, task in pairs(received) do
    table.insert(resTaskTb, task)
  end
  return resTaskTb
end

function ActiveTaskData:GetActiveTaskCfg()
  local comp = self:GetFlipComp()
  local cfg = Cfg.cfg_active_task_main({
    ComponentID = comp:GetComponentCfgId()
  })[1]
  return cfg
end

function ActiveTaskData:GetTurnCardCfg()
  local comp = self:GetFlipComp()
  local cfg = Cfg.cfg_component_turn_card({
    ComponentID = comp:GetComponentCfgId()
  })[1]
  return cfg
end

function ActiveTaskData:CheckTaskStatus(questId)
  local questModule = GameGlobal.GetModule(QuestModule)
  local quest = questModule:GetQuest(questId)
  if not quest then
    return
  end
  local questComponent = self:GetMissionComp()
  local status = questComponent:CheckCampaignQuestStatus(quest:QuestInfo())
  return status
end

function ActiveTaskData:CheckTaskIsOver()
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local questInfo = self:GetMissionCompInfo()
  local closeTime = questInfo.m_close_time
  if curTime > closeTime then
    local result = self._campaign:CheckComponentOpenClientError(ECampaignVigQuestComponentID.ECAMPAIGN_VIGQUEST_QUEST)
    self._campaign:CheckErrorCode(result)
    return true
  else
    return false
  end
end

function ActiveTaskData:CheckFlipIsOver()
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local questInfo = self:GetFlipCompInfo()
  local closeTime = questInfo.m_close_time
  if curTime > closeTime then
    local result = self._campaign:CheckComponentOpenClientError(ECampaignVigQuestComponentID.ECAMPAIGN_VIGQUEST_QUEST)
    self._campaign:CheckErrorCode(result)
    return true
  else
    return false
  end
end

function ActiveTaskData:CheckDailyTaskIsOver()
  local closeTime = self:GetDailyTaskEndTime()
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  if closeTime < curTime then
    return true
  else
    return false
  end
end

function ActiveTaskData:GetMatrixIndex()
  if not self._matrixIndex then
    local flipInfo = self:GetFlipCompInfo()
    for i, v in pairs(flipInfo.m_matrix) do
      self._matrixIndex = i
      return self._matrixIndex
    end
  end
  return self._matrixIndex
end

function ActiveTaskData:GetTurnCardInfo()
  local flipInfo = self:GetFlipCompInfo()
  local m_matrix
  for _, v in pairs(flipInfo.m_matrix) do
    m_matrix = v.m_matrix_item
    break
  end
  local itemList = {}
  local maskList = {}
  for _, v in pairs(m_matrix) do
    local item = {}
    item.id = v.m_id
    item.isGet = true
    item.maskList = v.m_is_turn
    for i, isFlip in pairs(v.m_is_turn) do
      if not item.index then
        item.index = i
      else
        item.index = math.min(item.index, i)
      end
      local mask = {}
      mask.index = i
      mask.isFlip = isFlip
      item.isGet = item.isGet and isFlip
      table.insert(maskList, mask)
    end
    table.insert(itemList, item)
  end
  return itemList, maskList
end

function ActiveTaskData:ReloadCampaignInfo(TT)
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N32_VIG_QUEST, ECampaignVigQuestComponentID.ECAMPAIGN_VIGQUEST_TURNCARD, ECampaignVigQuestComponentID.ECAMPAIGN_VIGQUEST_QUEST)
  if res and not res:GetSucc() then
    local result = self._campaign:CheckComponentOpenClientError(ECampaignVigQuestComponentID.ECAMPAIGN_VIGQUEST_QUEST)
    self._campaign:CheckErrorCode(result)
    return
  end
end

function ActiveTaskData:CheckDailyTaskRed()
  local dailyTask = self:_GetAllTask()
  local firstTaskID = dailyTask[1]
  local open_id = GameGlobal.GameLogic():GetOpenId()
  local str = "ActiveTaskData_CheckDailyTaskRed" .. open_id .. firstTaskID
  local v = LocalDB.GetInt(str)
  if v ~= 1 then
    return true
  else
    return false
  end
end

function ActiveTaskData:CancelDailyTaskRed()
  local dailyTask = self:_GetAllTask()
  local firstTaskID = dailyTask[1]
  local open_id = GameGlobal.GameLogic():GetOpenId()
  local str = "ActiveTaskData_CheckDailyTaskRed" .. open_id .. firstTaskID
  LocalDB.SetInt(str, 1)
end
