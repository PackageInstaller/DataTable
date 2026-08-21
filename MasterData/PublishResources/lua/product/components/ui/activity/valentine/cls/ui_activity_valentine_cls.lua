_class("ActivityValentineData", Object)
ActivityValentineData = ActivityValentineData

function ActivityValentineData:Constructor()
end

function ActivityValentineData:LoadData(TT, res)
  self._campaign = UIActivityCampaign.New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N27_MINI_GAME, ECampaignN27MiniGameComponentID.QUEST, ECampaignN27MiniGameComponentID.MINI_MAIL)
  if res and not res:GetSucc() then
    return
  end
  if not self._campaign then
    return
  end
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
end

function ActivityValentineData:GetCampaign()
  return self._campaign
end

function ActivityValentineData:GetCampaignLocalProgress()
  local campaign = self:GetCampaign()
  if campaign then
    return campaign:GetLocalProcess()
  end
end

function ActivityValentineData:GetCampaignSample()
  local campaign = self:GetCampaign()
  if campaign then
    return campaign:GetSample()
  end
end

function ActivityValentineData:GetCampaignID()
  return ECampaignType.CAMPAIGN_TYPE_N27_MINI_GAME
end

function ActivityValentineData:GetMailComponent()
  local localProcess = self:GetCampaignLocalProgress()
  if localProcess then
    return localProcess:GetComponent(ECampaignN27MiniGameComponentID.MINI_MAIL)
  end
end

function ActivityValentineData:GetMailComponentInfo()
  local localProcess = self:GetCampaignLocalProgress()
  if localProcess then
    return localProcess:GetComponentInfo(ECampaignN27MiniGameComponentID.MINI_MAIL)
  end
end

function ActivityValentineData:GetQuestComponent()
  local localProcess = self:GetCampaignLocalProgress()
  if localProcess then
    return localProcess:GetComponent(ECampaignN27MiniGameComponentID.QUEST)
  end
end

function ActivityValentineData:GetQuestComponentInfo()
  local localProcess = self:GetCampaignLocalProgress()
  if localProcess then
    return localProcess:GetComponentInfo(ECampaignN27MiniGameComponentID.QUEST)
  end
end

function ActivityValentineData:GetEntryNew()
  local campaign_module = GameGlobal.GetModule(CampaignModule)
  if campaign_module.m_campaign_manager then
    local new = UIActivityHelper.CheckCampaignSampleNewPoint(self._campaign)
    return new
  end
  return false
end

function ActivityValentineData:CancelEntryNew()
  if self:GetEntryNew() then
    GameGlobal.TaskManager():StartTask(self._CancelEntryNew, self)
  end
end

function ActivityValentineData:_CancelEntryNew(TT)
  self._campaign:ClearCampaignNew(TT)
end

function ActivityValentineData:GetEntryRed()
  if self:CheckMailIsOver() then
    return false
  end
  local hasTaskRed = self:_CheckTaskGroupRed()
  local hasCompRed = self:GetMailRed()
  return hasCompRed or hasTaskRed
end

function ActivityValentineData:GetMailRed()
  local component = self:GetMailComponent()
  if component then
    local hasCompRed = component:HaveRedPoint()
    return hasCompRed
  end
end

function ActivityValentineData:CheckTaskIsLock(taskId)
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local questInfo = self:GetQuestComponentInfo()
  local openTime = questInfo.m_quest_time_param_map[taskId].m_open_time
  if curTime > openTime then
    return false, openTime
  else
    return true, openTime
  end
end

function ActivityValentineData:CheckTaskIsOver()
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local questInfo = self:GetQuestComponentInfo()
  local closeTime = questInfo.m_close_time
  if curTime > closeTime then
    return true
  else
    return false
  end
end

function ActivityValentineData:CheckMailIsOver()
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local questInfo = self:GetMailComponentInfo()
  local closeTime = questInfo.m_close_time
  if curTime > closeTime then
    return true
  else
    return false
  end
end

function ActivityValentineData:CheckSendTaskIsDone(questId)
  local questModule = GameGlobal.GetModule(QuestModule)
  local quest = questModule:GetQuest(questId)
  if not quest then
    return
  end
  local questComponent = self:GetQuestComponent()
  local status = questComponent:CheckCampaignQuestStatus(quest:QuestInfo())
  return status
end

function ActivityValentineData:_CheckTaskGroupRed()
  local cfg = Cfg.cfg_valentine_task_group({})
  for _, v in pairs(cfg) do
    local taskId = v.TaskIDGroup[1]
    local isLock = self:CheckTaskIsLock(taskId)
    if not isLock then
      local localID = self:_GetTaskLocalID(taskId)
      local res = LocalDB.GetInt(localID)
      if res ~= 1 then
        return true
      end
    end
    local sendTaskStatus = self:CheckSendTaskIsDone(v.TaskIDGroup[4])
    if sendTaskStatus == CampaignQuestStatus.CQS_Completed then
      return true
    end
  end
  return false
end

function ActivityValentineData:ClearTaskGroupRed()
  local cfg = Cfg.cfg_valentine_task_group({})
  for _, v in pairs(cfg) do
    local taskId = v.TaskIDGroup[1]
    local isLock = self:CheckTaskIsLock(taskId)
    if not isLock then
      local localID = self:_GetTaskLocalID(taskId)
      LocalDB.SetInt(localID, 1)
    end
  end
end

function ActivityValentineData:_GetTaskLocalID(taskId)
  local roleModule = GameGlobal.GetModule(RoleModule)
  local openID = roleModule:GetPstId()
  local key = "ActivityValentineData" .. openID .. taskId
  return key
end
