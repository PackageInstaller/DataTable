_class("PointProgressComponent", ICampaignComponent)
PointProgressComponent = PointProgressComponent
local CampaignPointProgressStatus = {
  CPPS_Accepted = 1,
  CPPS_Completed = 2,
  CPPS_Taken = 3
}
_enum("CampaignPointProgressStatus", CampaignPointProgressStatus)

function PointProgressComponent:Constructor()
  self.m_component_info = PointProgressComponentInfo:New()
end

function PointProgressComponent:ComponentInfo()
  if not self.m_component_info then
    self.m_component_info = PointProgressComponentInfo:New()
  end
  return self.m_component_info
end

function PointProgressComponent:GetComponentInfo()
  return self:ComponentInfo()
end

function PointProgressComponent:GetComponentType()
  return CampaignComType.E_CAMPAIGN_COM_POINT_PROGRESS
end

function PointProgressComponent:InitComponentInfo(a_load_info)
  local ret = ComponentDataHelper.ParseData(a_load_info.m_data, self.m_component_info)
  return ret
end

function PointProgressComponent:HandleReceiveReward(TT, asyncRes, progress)
  local request = PointProgressComponentReceiveRewardReq:New()
  local response = PointProgressComponentReceiveRewardRep:New()
  request.m_progress = progress
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][PointProgressComponent] HandleReceiveReward ret:", asyncRes.m_result)
    return nil
  end
  table.insert(self.m_component_info.m_received_progress, progress)
  return response.m_rewards
end

function PointProgressComponent:HandleOneKeyReceiveRewards(TT, asyncRes)
  local request = PointProgressComponentOneKeyReceiveRewardReq:New()
  local response = PointProgressComponentOneKeyReceiveRewardRep:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][PointProgressComponent] HandleReceiveReward ret:", asyncRes.m_result)
    return nil
  end
  self.m_component_info.m_current_progress = response.m_new_progress
  for progress, reward in pairs(self.m_component_info.m_progress_rewards) do
    if progress <= self.m_component_info.m_current_progress then
      local bFind = false
      for _, record in ipairs(self.m_component_info.m_received_progress) do
        if record == progress then
          bFind = true
          break
        end
      end
      if not bFind then
        table.insert(self.m_component_info.m_received_progress, progress)
      end
    end
  end
  return response.m_rewards
end

function PointProgressComponent:CampaignComponentPushNotify(notify_data)
  if PointProgressComponentNotifyType.PointProgressComponentNotify_StepChanged == notify_data.m_notify_type then
    local ev = NotifyPresonProgressComponentItemCountChanged:New()
    local ret = ComponentDataHelper.ParseData(notify_data.m_data, ev)
    if ret then
      self:OnItemCountChanged(ev)
    else
      Log.error("[CampaignCom][PointProgressComponent] CampaignComponentPushNotify ParseData error! ret:", ret)
    end
  end
end

function PointProgressComponent:OnItemCountChanged(ev)
  self.m_component_info.m_current_progress = ev.m_item_count
end

function PointProgressComponent:Start_HandleReceiveReward(progress, callback)
  GameGlobal.GetModule(PetModule):GetAllPetsSnapshoot()
  GameGlobal.UIStateManager():Lock("PointProgressComponent:Start_HandleReceiveReward")
  TaskManager:GetInstance():StartTask(function(TT)
    local res = AsyncRequestRes:New()
    local rewards = self:HandleReceiveReward(TT, res, progress)
    GameGlobal.UIStateManager():UnLock("PointProgressComponent:Start_HandleReceiveReward")
    callback(res, rewards)
  end)
end

function PointProgressComponent:Start_HandleOneKeyReceiveRewards(callback)
  GameGlobal.GetModule(PetModule):GetAllPetsSnapshoot()
  GameGlobal.UIStateManager():Lock("PointProgressComponent:Start_HandleOneKeyReceiveRewards")
  TaskManager:GetInstance():StartTask(function(TT)
    local res = AsyncRequestRes:New()
    local rewards = self:HandleOneKeyReceiveRewards(TT, res)
    GameGlobal.UIStateManager():UnLock("PointProgressComponent:Start_HandleOneKeyReceiveRewards")
    callback(res, rewards)
  end)
end

function PointProgressComponent:GetItemId()
  return self.m_component_info.m_item_id
end

function PointProgressComponent:GetItemIcon()
  local cfgItem = Cfg.cfg_item[self:GetItemId()]
  return cfgItem and cfgItem.Icon or nil
end

function PointProgressComponent:GetItemPriceIcon()
  return "toptoon_" .. self:GetItemId()
end

function PointProgressComponent:GetCurrentProgress()
  return self.m_component_info.m_current_progress
end

function PointProgressComponent:IsReceivedProgress(progress)
  for _, v in ipairs(self.m_component_info.m_received_progress) do
    if v == progress then
      return true
    end
  end
  return false
end

function PointProgressComponent:HasCanGetReward()
  local cur = self:GetCurrentProgress()
  for k, v in pairs(self.m_component_info.m_progress_rewards) do
    if k <= cur and not self:IsReceivedProgress(k) then
      return true
    end
  end
  return false
end

function PointProgressComponent:GetProgressList()
  local tb = {}
  for k, v in pairs(self.m_component_info.m_progress_rewards) do
    table.insert(tb, k)
  end
  table.sort(tb, function(a, b)
    return a < b
  end)
  return tb
end

function PointProgressComponent:GetProgressRewards(progress)
  return self.m_component_info.m_progress_rewards[progress]
end

function PointProgressComponent:CheckItemStatus(progress)
  local curProgress = self:GetCurrentProgress()
  local status = CampaignPointProgressStatus.CPPS_Accepted
  if progress <= curProgress then
    status = CampaignPointProgressStatus.CPPS_Completed
  end
  if self:IsReceivedProgress(progress) then
    status = CampaignPointProgressStatus.CPPS_Taken
  end
  return status
end

function PointProgressComponent:SortProgressListByCampaignPointProgressStatus(progressList)
  local status = {}
  local defaultIndex = {}
  for k, v in ipairs(progressList) do
    defaultIndex[v] = k
    status[v] = self:CheckItemStatus(v)
  end
  local val = {}
  val[CampaignPointProgressStatus.CPPS_Completed] = 0
  val[CampaignPointProgressStatus.CPPS_Accepted] = 1
  val[CampaignPointProgressStatus.CPPS_Taken] = 2
  table.sort(progressList, function(a, b)
    if val[status[a]] == val[status[b]] then
      return defaultIndex[a] < defaultIndex[b]
    end
    return val[status[a]] < val[status[b]]
  end)
end

function PointProgressComponent:IsSpecialRewards(progress_index)
  return self.m_component_info.m_special_rewards[progress_index] == 1
end

function PointProgressComponent:GetProgressItemCountInTable(tb)
  local itemId = self:GetItemId()
  for _, v in ipairs(tb) do
    if v.assetid == itemId then
      return v.count
    end
  end
  return 0
end

function PointProgressComponent:RemoveProgressItemInTable(tb)
  local itemId = self:GetItemId()
  local newTb = {}
  for _, v in ipairs(tb) do
    if v.assetid ~= itemId then
      table.insert(newTb, v)
    end
  end
  return newTb
end
