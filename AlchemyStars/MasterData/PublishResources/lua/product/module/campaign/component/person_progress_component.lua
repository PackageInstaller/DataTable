_class("PersonProgressComponent", ICampaignComponent)
PersonProgressComponent = PersonProgressComponent
local CampaignPersonProgressStatus = {
  CPPS_Accepted = 1,
  CPPS_Completed = 2,
  CPPS_Taken = 3
}
_enum("CampaignPersonProgressStatus", CampaignPersonProgressStatus)

function PersonProgressComponent:Constructor()
  self.m_component_info = PersonProgressComponentInfo:New()
end

function PersonProgressComponent:ComponentInfo()
  if not self.m_component_info then
    self.m_component_info = PersonProgressComponentInfo:New()
  end
  return self.m_component_info
end

function PersonProgressComponent:GetComponentInfo()
  return self:ComponentInfo()
end

function PersonProgressComponent:GetComponentType()
  return CampaignComType.E_CAMPAIGN_COM_PERSON_PROGESS
end

function PersonProgressComponent:InitComponentInfo(a_load_info)
  local ret = ComponentDataHelper.ParseData(a_load_info.m_data, self.m_component_info)
  return ret
end

function PersonProgressComponent:GetProgress(showLV)
  local lv = 0
  local curLevelProgress = self.m_component_info.m_progress
  for key, value in pairs(self.m_component_info.m_progress_rewards) do
    if key <= self.m_component_info.m_progress then
      curLevelProgress = curLevelProgress - key
      lv = lv + 1
    end
  end
  if showLV == nil then
    return lv, curLevelProgress
  end
  return lv + showLV, curLevelProgress
end

function PersonProgressComponent:GetCurProgress(showLV)
  local lv = 0
  local curLevelNeedProgress = -1
  for key, value in pairs(self.m_component_info.m_progress_rewards) do
    if key <= self.m_component_info.m_current_progress then
      if key > curLevelNeedProgress then
        curLevelNeedProgress = key
      end
      lv = lv + 1
    end
  end
  local curLevelProgress = curLevelNeedProgress - self.m_component_info.m_current_progress
  if showLV == nil then
    return lv, curLevelProgress
  end
  return lv + showLV, curLevelProgress
end

function PersonProgressComponent:GetProgressLevel(progress, showLV)
  local lv = 0
  for key, value in pairs(self.m_component_info.m_progress_rewards) do
    if key <= progress then
      lv = lv + 1
    end
  end
  if showLV == nil then
    return lv
  end
  return lv + showLV
end

function PersonProgressComponent:GetNextLevelNeedProgress()
  local progressList = self:GetProgressList()
  local curProgressLevel = self:GetCurProgress(1)
  local curLevelProgress
  if curProgressLevel >= #progressList then
    curLevelProgress = progressList[#progressList]
  else
    curLevelProgress = progressList[curProgressLevel]
  end
  local needProgress = curLevelProgress - self:GetCurrentProgress()
  return needProgress
end

function PersonProgressComponent:GetCurLevelProgressRate()
  local progressList = self:GetProgressList()
  local curProgressLevel = self:GetCurProgress(1)
  local curLevelProgress, preLevelProgress
  if curProgressLevel >= #progressList then
    curLevelProgress = progressList[#progressList]
    preLevelProgress = progressList[#progressList - 1]
  elseif curProgressLevel == 1 then
    curLevelProgress = progressList[curProgressLevel]
    preLevelProgress = 0
  else
    curLevelProgress = progressList[curProgressLevel]
    preLevelProgress = progressList[curProgressLevel - 1]
  end
  if preLevelProgress < self:GetCurrentProgress() then
    local rate = (self:GetCurrentProgress() - preLevelProgress) / (curLevelProgress - preLevelProgress)
    return rate
  else
    return 0
  end
end

function PersonProgressComponent:HandleReceiveReward(TT, asyncRes, progress)
  local request = PersonProgressComponentReceiveRewardReq:New()
  local response = PersonProgressComponentReceiveRewardRep:New()
  request.m_progress = progress
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][PersonProgressComponent] HandleReceiveReward ret:", asyncRes.m_result)
    return nil
  end
  self.m_component_info.m_current_progress = response.m_new_progress
  table.insert(self.m_component_info.m_received_progress, progress)
  return response.m_rewards
end

function PersonProgressComponent:HandleOneKeyReceiveRewards(TT, asyncRes)
  local request = PersonProgressComponentOneKeyReceiveRewardReq:New()
  local response = PersonProgressComponentOneKeyReceiveRewardRep:New()
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][PersonProgressComponent] HandleReceiveReward ret:", asyncRes.m_result)
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

function PersonProgressComponent:HandlePersonProgressCollect(TT, asyncRes, item_num, mark, mark2)
  local request = PersonProgressComponentCollectReq:New()
  local response = PersonProgressComponentCollectRep:New()
  request.m_item_num = item_num
  request.m_mark = mark
  request.m_mark_else = mark2
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][PersonProgressComponent] HandlePersonProgressCollect ret:", asyncRes.m_result)
    return nil
  else
    self.m_component_info.m_mark = mark
    self.m_component_info.m_mark_else = mark2
  end
  return response
end

function PersonProgressComponent:HandlePersonProgressProgressReq(TT, asyncRes, progress)
  local request = PersonProgressProgressReq:New()
  local response = PersonProgressProgressResult:New()
  request.m_progress = progress
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][PersonProgressComponent] HandleReceiveReward ret:", asyncRes.m_result)
    return nil
  else
    self.m_component_info.m_progress = progress
  end
  return response
end

function PersonProgressComponent:HandlePersonProgressCollect(TT, asyncRes, item_num, mark, mark2)
  local request = PersonProgressComponentCollectReq:New()
  local response = PersonProgressComponentCollectRep:New()
  request.m_item_num = item_num
  request.m_mark = mark
  request.m_mark_else = mark2
  local ComponentInfo = self:ComponentInfo()
  self.m_campaign_com_module:CampaignComProtoRequest(TT, asyncRes, ComponentInfo.m_campaign_id, ComponentInfo.m_component_id, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= asyncRes.m_result then
    Log.error("[CampaignCom][PersonProgressComponent] HandlePersonProgressCollect ret:", asyncRes.m_result)
    return nil
  else
    self.m_component_info.m_mark = mark
    self.m_component_info.m_mark_else = mark2
  end
  return response
end

function PersonProgressComponent:CampaignComponentPushNotify(notify_data)
  if PersonProgressComponentNotifyType.PersonProgressComponentNotify_StepChanged == notify_data.m_notify_type then
    local ev = NotifyPresonProgressComponentItemCountChanged:New()
    local ret = ComponentDataHelper.ParseData(notify_data.m_data, ev)
    if ret then
      self:OnItemCountChanged(ev)
    else
      Log.error("[CampaignCom][PersonProgressComponent] CampaignComponentPushNotify ParseData error! ret:", ret)
    end
  end
end

function PersonProgressComponent:OnItemCountChanged(ev)
  self.m_component_info.m_current_progress = ev.m_item_count
end

function PersonProgressComponent:Start_HandleReceiveReward(progress, callback)
  GameGlobal.GetModule(PetModule):GetAllPetsSnapshoot()
  GameGlobal.UIStateManager():Lock("PersonProgressComponent:Start_HandleReceiveReward")
  TaskManager:GetInstance():StartTask(function(TT)
    local res = AsyncRequestRes:New()
    local rewards = self:HandleReceiveReward(TT, res, progress)
    GameGlobal.UIStateManager():UnLock("PersonProgressComponent:Start_HandleReceiveReward")
    callback(res, rewards)
  end)
end

function PersonProgressComponent:Start_HandleOneKeyReceiveRewards(callback)
  GameGlobal.GetModule(PetModule):GetAllPetsSnapshoot()
  GameGlobal.UIStateManager():Lock("PersonProgressComponent:Start_HandleOneKeyReceiveRewards")
  TaskManager:GetInstance():StartTask(function(TT)
    local res = AsyncRequestRes:New()
    local rewards = self:HandleOneKeyReceiveRewards(TT, res)
    GameGlobal.UIStateManager():UnLock("PersonProgressComponent:Start_HandleOneKeyReceiveRewards")
    callback(res, rewards)
  end)
end

function PersonProgressComponent:GetItemId()
  return self.m_component_info.m_item_id
end

function PersonProgressComponent:GetItemIcon()
  local cfgItem = Cfg.cfg_item[self:GetItemId()]
  return cfgItem and cfgItem.Icon or nil
end

function PersonProgressComponent:GetItemPriceIcon()
  return "toptoon_" .. self:GetItemId()
end

function PersonProgressComponent:GetCurrentProgress()
  return self.m_component_info.m_current_progress
end

function PersonProgressComponent:GetMaxProgress()
  local progress_list = self:GetProgressList()
  return progress_list[#progress_list] or 0
end

function PersonProgressComponent:CalcProtressRate()
  local cur = self:GetCurrentProgress()
  local max = self:GetMaxProgress()
  local rate = cur * 100 / max
  return rate
end

function PersonProgressComponent:CalcProtressRate_Multi(uiRate)
  local cur = self:GetCurrentProgress()
  local prgList = self:GetProgressList()
  local pre = 0
  for i, v in ipairs(prgList) do
    local left = i <= #uiRate and uiRate[i][1] or 1
    local right = i <= #uiRate and uiRate[i][2] or 1
    if cur >= pre and v >= cur then
      local r = (cur - pre) / (v - pre)
      return left + r * (right - left)
    end
    pre = v
  end
  return 1
end

function PersonProgressComponent:IsReceivedProgress(progress)
  if self.m_component_info.m_lv_limit ~= 0 and progress > self.m_component_info.m_progress then
    return false
  end
  for _, v in ipairs(self.m_component_info.m_received_progress) do
    if v == progress then
      return true
    end
  end
  return false
end

function PersonProgressComponent:HasCanLevelUp()
  if self.m_component_info.m_lv_limit == 0 then
    return false
  end
  local m_current_progress = self:GetCurrentProgress()
  local OrderList = self:GetProgressList()
  local m_progress = self.m_component_info.m_progress
  local max = OrderList[1]
  for i, v in ipairs(OrderList) do
    if v > m_progress then
      max = v
      break
    end
  end
  if m_progress == OrderList[table.count(OrderList)] then
    return false
  end
  if m_current_progress < max then
    return false
  else
    return true
  end
end

function PersonProgressComponent:HasCanGetReward()
  local cur = self:GetCurrentProgress()
  if self.m_component_info.m_lv_limit ~= 0 then
    cur = self.m_component_info.m_progress
  end
  for k, v in pairs(self.m_component_info.m_progress_rewards) do
    if k <= cur and not self:IsReceivedProgress(k) then
      return true
    end
  end
  return false
end

function PersonProgressComponent:GetProgressList()
  local tb = {}
  for k, v in pairs(self.m_component_info.m_progress_rewards) do
    table.insert(tb, k)
  end
  table.sort(tb, function(a, b)
    return a < b
  end)
  return tb
end

function PersonProgressComponent:GetProgressRewards(progress)
  return self.m_component_info.m_progress_rewards[progress]
end

function PersonProgressComponent:CheckItemStatus(progress)
  local curProgress = self:GetCurrentProgress()
  local status = CampaignPersonProgressStatus.CPPS_Accepted
  if self.m_component_info.m_lv_limit == 0 then
    if progress <= curProgress then
      status = CampaignPersonProgressStatus.CPPS_Completed
    end
    if self:IsReceivedProgress(progress) then
      status = CampaignPersonProgressStatus.CPPS_Taken
    end
  else
    if progress <= self.m_component_info.m_progress then
      status = CampaignPersonProgressStatus.CPPS_Completed
    else
      status = CampaignPersonProgressStatus.CPPS_Accepted
    end
    if self:IsReceivedProgress(progress) then
      status = CampaignPersonProgressStatus.CPPS_Taken
    end
  end
  return status
end

function PersonProgressComponent:SortProgressListByCampaignPersonProgressStatus(progressList)
  local status = {}
  local defaultIndex = {}
  for k, v in ipairs(progressList) do
    defaultIndex[v] = k
    status[v] = self:CheckItemStatus(v)
  end
  local val = {}
  val[CampaignPersonProgressStatus.CPPS_Completed] = 0
  val[CampaignPersonProgressStatus.CPPS_Accepted] = 1
  val[CampaignPersonProgressStatus.CPPS_Taken] = 2
  table.sort(progressList, function(a, b)
    if val[status[a]] == val[status[b]] then
      return defaultIndex[a] < defaultIndex[b]
    end
    return val[status[a]] < val[status[b]]
  end)
end

function PersonProgressComponent:IsSpecialRewards(progress_index)
  return self.m_component_info.m_special_rewards[progress_index] ~= nil
end

function PersonProgressComponent:GetProgressItemCountInTable(tb)
  local itemId = self:GetItemId()
  for _, v in ipairs(tb) do
    if v.assetid == itemId then
      return v.count
    end
  end
  return 0
end

function PersonProgressComponent:RemoveProgressItemInTable(tb)
  local itemId = self:GetItemId()
  local newTb = {}
  for _, v in ipairs(tb) do
    if v.assetid ~= itemId then
      table.insert(newTb, v)
    end
  end
  return newTb
end
