local TaskNetworkCtrl = class("TaskNetworkCtrl", NetworkCtrlBase)
local TaskData = require("Game.Task.Data.TaskData")
local TaskEnum = require("Game.Task.TaskEnum")
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance
local LastSendType = {UpgradeSchedule = 1, CommitQuest = 2}

function TaskNetworkCtrl:ctor()
  self.lastSendDataList = {}
end

function TaskNetworkCtrl:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_QUEST_UpgradeSchedule, self, proto_csmsg.SC_QUEST_UpgradeSchedule, self.OnRecvUpgradeSchedule)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_QUEST_CommitQuest, self, proto_csmsg.SC_QUEST_CommitQuest, self.OnRecvCommitQuest)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_QUEST_SyncUpdateDiff, self, proto_csmsg.SC_QUEST_SyncUpdateDiff, self.OnRecvSyncUpdateDiff)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_QUESTPERIOD_Detail, self, proto_csmsg.SC_QUESTPERIOD_Detail, self.OnQuestPeriodDetail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_QUESTPERIOD_RewardPicked, self, proto_csmsg.SC_QUESTPERIOD_RewardPicked, self.OnQuestPeriodRewardPicked)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_QUESTPERIOD_RewardOnePicked, self, proto_csmsg.SC_QUESTPERIOD_RewardOnePicked, self.SC_QUESTPERIOD_RewardOnePicked)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_QUEST_ClientAddSchedule, self, proto_csmsg.SC_QUEST_ClientAddSchedule, self.SC_QUEST_ClientAddSchedule)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_QUEST_OneKeyPick, self, proto_csmsg.SC_QUEST_OneKeyPick, self.SC_QUEST_OneKeyPick)
end

function TaskNetworkCtrl:SendUpgradeSchedule(qusetId, questStep)
  local tabMsg = {qusetId = qusetId, questStep = questStep}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_QUEST_UpgradeSchedule, proto_csmsg.CS_QUEST_UpgradeSchedule, tabMsg)
  local saveList = {}
  saveList.type = LastSendType.UpgradeSchedule
  saveList.qusetId = qusetId
  table.insert(self.lastSendDataList, saveList)
end

function TaskNetworkCtrl:OnRecvUpgradeSchedule(msg)
  if msg.ret == proto_csmsg_ErrorCode.None then
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
  else
    table.remove(self.lastSendDataList, 1)
    local err = "TaskNetworkCtrl:OnRecvUpgradeSchedule error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
  end
end

function TaskNetworkCtrl:SendCommitQuest(taskData, callbak)
  local tabMsg = {
    qusetId = taskData.id
  }
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_QUEST_CommitQuest, proto_csmsg.CS_QUEST_CommitQuest, tabMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_QUEST_CommitQuest, callbak, proto_csmsg_MSG_ID.MSG_SC_QUEST_CommitQuest)
  local saveList = {}
  saveList.type = LastSendType.CommitQuest
  saveList.taskId = taskData.id
  saveList.taskStcData = taskData.stcData
  table.insert(self.lastSendDataList, saveList)
end

function TaskNetworkCtrl:OnRecvCommitQuest(msg)
  if msg.ret == proto_csmsg_ErrorCode.None then
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
  else
    table.remove(self.lastSendDataList, 1)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_QUEST_CommitQuest)
    local err = "TaskNetworkCtrl:OnRecvCommitQuest error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
  end
end

function TaskNetworkCtrl:OnRecvSyncUpdateDiff(msg, syncUpdateDiff)
  local deleteGuideTaskList
  local changedTaskTypeDic = {}
  for taskId, deleteReason in pairs(msg.delete) do
    local taskData = PlayerDataCenter.allTaskData.taskDatas[taskId]
    if taskData ~= nil then
      if deleteReason == proto_object_QuestDeleteReason.QuestDeleteReasonCompleted or deleteReason == proto_object_QuestDeleteReason.QuestDeleteReasonCompletedShowOver then
        if taskData.stcData.type == TaskEnum.eTaskType.MainTask then
          PlayerDataCenter.allTaskData:RecordCompletedMainTask(taskId)
        elseif PlayerDataCenter.allTaskData:IsMilestoneType(taskData.stcData.type) then
          PlayerDataCenter.allTaskData:RecordCompletedMilestoneTask(taskId)
        end
      end
      if #taskData.stcData.guide_id > 0 then
        table.removebyvalue(PlayerDataCenter.allTaskData.guideTaskDatas, taskData)
        deleteGuideTaskList = deleteGuideTaskList or {}
        table.insert(deleteGuideTaskList, taskData)
      end
      PlayerDataCenter.allTaskData:RemoveTaskData(taskData)
      changedTaskTypeDic[taskData.stcData.type] = true
    end
  end
  local newGuideTaskCount = 0
  local newTaskDataList
  for k, v in pairs(msg.update) do
    local taskData = PlayerDataCenter.allTaskData.taskDatas[k]
    local isNewTask = false
    if taskData == nil then
      local stcData = ConfigData.task[k]
      if stcData == nil then
        error("Cant't find taskCfg,id = " .. k)
      else
        taskData = TaskData.CreateTaskData(v, stcData)
        PlayerDataCenter.allTaskData:AddTaskData(taskData)
        if #stcData.guide_id > 0 then
          newGuideTaskCount = newGuideTaskCount + 1
        end
        isNewTask = true
        else
          taskData:UpdateTaskData(v)
        end
        if isNewTask then
          if newTaskDataList == nil then
            newTaskDataList = {}
          end
          table.insert(newTaskDataList, taskData)
        end
        if taskData.stcData.isShow then
          PlayerDataCenter.activityStarUpData:UpdateTask(taskData)
          PlayerDataCenter.allTaskData:AllTaskOnTaskUpdate(taskData)
          MsgCenter:Broadcast(eMsgEventId.TaskUpdate, taskData, isNewTask)
        end
        if taskData.stcData.type == TaskEnum.eTaskType.MainTask and taskData:CheckComplete() then
          PlayerDataCenter.allTaskData:RecordCompletedMainTask(k)
        elseif PlayerDataCenter.allTaskData:IsMilestoneType(taskData.stcData.type) and taskData:IsPickedTaskReward() then
          PlayerDataCenter.allTaskData:RecordCompletedMilestoneTask(k)
        end
        PlayerDataCenter.allTaskData:TryAutoCompleteHidenTask(taskData)
        changedTaskTypeDic[taskData.stcData.type] = true
      end
  end
  PlayerDataCenter.allTaskData:UpdateAllTaskData(false, changedTaskTypeDic)
  if #self.lastSendDataList ~= 0 then
    local lastData = table.remove(self.lastSendDataList, 1)
    if lastData.type == LastSendType.UpgradeSchedule then
    elseif lastData.type == LastSendType.CommitQuest and lastData.taskStcData.isShow then
      local isSectorType, sectorId = PlayerDataCenter.allTaskData:IsSectorType(lastData.taskStcData.type)
      if isSectorType then
        PlayerDataCenter.sectorAchievementDatas:UpdateCompleteTaskData(sectorId, lastData.taskStcData.id)
      end
      PlayerDataCenter.allTaskData:AllTaskOnTaskCommit(lastData.taskStcData)
      PlayerDataCenter.activityStarUpData:UpdateStage(lastData.taskStcData.id)
      local addInfo = {}
      if syncUpdateDiff.resource ~= nil and syncUpdateDiff.resource.backpack ~= nil then
        local randomPackage = syncUpdateDiff.resource.backpack.randomPackage
        if randomPackage ~= nil then
          addInfo.task_randomPackage = randomPackage
        end
        local overflow = syncUpdateDiff.resource.backpack.overflow
        if overflow ~= nil then
          addInfo.task_overflowInfo = overflow
        end
      end
      MsgCenter:Broadcast(eMsgEventId.TaskCommitComplete, lastData.taskStcData, addInfo)
    end
  end
  if newTaskDataList ~= nil then
    table.sort(newTaskDataList, function(a, b)
      return a.stcData.id < b.stcData.id
    end)
    MsgCenter:Broadcast(eMsgEventId.TaskReceived, newTaskDataList)
  end
  MsgCenter:Broadcast(eMsgEventId.TaskSyncFinish)
  if deleteGuideTaskList ~= nil and 0 < #deleteGuideTaskList then
    GuideManager:OnGuideTaskDelete(deleteGuideTaskList)
  end
  if newTaskDataList ~= nil and GuideManager.firstBattleGuideCtrl:TryStartFirstBattleGuide(newTaskDataList) then
    return
  end
  if 0 < newGuideTaskCount then
    GuideManager:TryTriggerGuide(nil, newTaskDataList)
  end
end

function TaskNetworkCtrl:SendQuestPeriodDetail()
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_QUESTPERIOD_Detail, proto_csmsg.CS_QUESTPERIOD_Detail, table.emptytable)
  cs_WaitNetworkResponse:StartOrAddWait(proto_csmsg_MSG_ID.MSG_CS_QUESTPERIOD_Detail, proto_csmsg_MSG_ID.MSG_SC_QUESTPERIOD_Detail)
end

function TaskNetworkCtrl:OnQuestPeriodDetail(msg)
  if msg.ret == proto_csmsg_ErrorCode.None then
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
    ControllerManager:GetController(ControllerTypeId.Task, true):RecvPeriodTaskDetail(msg)
    local window = UIManager:GetWindow(UIWindowTypeID.Home)
    if window ~= nil then
      window.homeLeftNode:RefreshTaskBtn()
    end
    local navigationWin = UIManager:GetWindow(UIWindowTypeID.NavigationBar)
    if navigationWin ~= nil then
      navigationWin:UpdateNaviTaskQucikPreview()
    end
  else
    local err = "TaskNetworkCtrl:OnQuestPeriodDetail error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_QUESTPERIOD_Detail)
  end
end

function TaskNetworkCtrl:SendQuestPeriodRewardPicked(index, showingActiveType, callback)
  local msg = {cat = showingActiveType, idx = index}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_QUESTPERIOD_RewardPicked, proto_csmsg.CS_QUESTPERIOD_RewardPicked, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_QUESTPERIOD_RewardPicked, callback, proto_csmsg_MSG_ID.MSG_SC_QUESTPERIOD_RewardPicked)
end

function TaskNetworkCtrl:OnQuestPeriodRewardPicked(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "TaskNetworkCtrl:OnQuestPeriodRewardPicked error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_QUESTPERIOD_RewardPicked)
  else
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
  end
end

function TaskNetworkCtrl:CS_QUESTPERIOD_RewardOnePicked(indexDic, cat, callback)
  local msg = {quest = indexDic, cat = cat}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_QUESTPERIOD_RewardOnePicked, proto_csmsg.CS_QUESTPERIOD_RewardOnePicked, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_QUESTPERIOD_RewardOnePicked, callback, proto_csmsg_MSG_ID.MSG_SC_QUESTPERIOD_RewardOnePicked)
end

function TaskNetworkCtrl:SC_QUESTPERIOD_RewardOnePicked(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "TaskNetworkCtrl:SC_QUESTPERIOD_RewardOnePicked error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_QUESTPERIOD_RewardOnePicked)
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
  else
    local rewardDic = GameGlobalUtil.CollectDiffReward(msg.syncUpdateDiff)
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_QUESTPERIOD_RewardOnePicked, rewardDic)
  end
end

function TaskNetworkCtrl:CS_QUEST_ClientAddSchedule(action)
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_QUEST_ClientAddSchedule, proto_csmsg.CS_QUEST_ClientAddSchedule, table.emptytable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_QUEST_ClientAddSchedule, action, proto_csmsg_MSG_ID.MSG_SC_QUEST_ClientAddSchedule)
end

function TaskNetworkCtrl:SC_QUEST_ClientAddSchedule(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "TaskNetworkCtrl:SC_QUEST_ClientAddSchedule error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_QUEST_ClientAddSchedule)
  end
end

function TaskNetworkCtrl:CS_QUEST_OneKeyPick(ids, backAction, afterRewardFunc)
  self._OneKeyPick_AfterRewardFunc = afterRewardFunc
  local msg = {}
  msg.ids = ids
  self.oneKeyPickOverflowTransItemDic = {}
  for i, v in pairs(ids) do
    if v then
      local taskCfg = ConfigData.task[i]
      for ri, rv in pairs(taskCfg.rewardIds) do
        local itemCfg = ConfigData.item[rv]
        local num = 0
        if itemCfg.overflow_type == eItemTransType.actMoneyX then
          num = PlayerDataCenter:GetItemOverflowNum(rv, taskCfg.rewardNums[ri])
        end
        if num ~= 0 then
          if not self.oneKeyPickOverflowTransItemDic[rv] then
            self.oneKeyPickOverflowTransItemDic[rv] = num
          else
            self.oneKeyPickOverflowTransItemDic[rv] = self.oneKeyPickOverflowTransItemDic[rv] + num
          end
        end
      end
    end
  end
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_QUEST_OneKeyPick, proto_csmsg.CS_QUEST_OneKeyPick, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_QUEST_OneKeyPick, backAction, proto_csmsg_MSG_ID.MSG_SC_QUEST_OneKeyPick)
end

function TaskNetworkCtrl:SC_QUEST_OneKeyPick(msg)
  local items = {}
  for itemId, num in pairs(msg.rewards) do
    local itemCfg = ConfigData.item[itemId]
    if not itemCfg.is_shielded then
      table.insert(items, {
        id = itemId,
        warehouse_order = itemCfg.warehouse_order,
        count = num
      })
    end
  end
  table.sort(items, function(a, b)
    if a.warehouse_order == b.warehouse_order then
      return a.id < b.id
    else
      return a.warehouse_order < b.warehouse_order
    end
  end)
  local rewardIds = {}
  local rewardNums = {}
  for k, v in pairs(items) do
    table.insert(rewardIds, v.id)
    table.insert(rewardNums, v.count)
  end
  local afterRewardFunc = self._OneKeyPick_AfterRewardFunc
  self._OneKeyPick_AfterRewardFunc = nil
  local addInfo = {}
  if msg.syncUpdateDiff and msg.syncUpdateDiff.resource ~= nil and msg.syncUpdateDiff.resource.backpack ~= nil then
    local randomPackage = msg.syncUpdateDiff.resource.backpack.randomPackage
    if randomPackage ~= nil then
      addInfo.task_randomPackage = randomPackage
    end
    local overflow = msg.syncUpdateDiff.resource.backpack.overflow
    if overflow ~= nil then
      addInfo.task_overflowInfo = overflow
    end
  end
  if 0 < #rewardIds then
    self._heroIdSnapShoot = PlayerDataCenter:TakeHeroIdSnapShoot()
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
      if window == nil then
        return
      end
      local overflowInfo
      local rewardDic = {}
      for index, id in pairs(rewardIds) do
        rewardDic[id] = rewardNums[index]
      end
      if addInfo ~= nil then
        overflowInfo = addInfo.task_overflowInfo
        local randomPackage = addInfo.task_randomPackage or table.emptytable
        for parentItemId, data in pairs(randomPackage) do
          rewardDic[parentItemId] = (rewardDic[parentItemId] or 0) - data.itemNum
          if rewardDic[parentItemId] <= 0 then
            rewardDic[parentItemId] = nil
          end
          local resultDic = data.product
          for itemId, num in pairs(resultDic) do
            rewardDic[itemId] = (rewardDic[itemId] or 0) + num
          end
        end
      end
      local CommonRewardData = require("Game.CommonUI.CommonRewardData")
      local CRData = CommonRewardData.CreateCRDataUseDic(rewardDic):SetCRItemCustomTransDic(overflowInfo):SetCRHeroSnapshoot(self._heroIdSnapShoot, false):SetCRNotHandledGreat(true):SetCRShowOverFunc(function()
        local achievementSystemWin = UIManager:GetWindow(UIWindowTypeID.AchievementSystem)
        if achievementSystemWin ~= nil then
          achievementSystemWin.achievementLevelNode.__NeedRefreshPlayerLevel()
        end
        if afterRewardFunc then
          afterRewardFunc()
        end
      end)
      CRData:SetCRItemTransDic(self.oneKeyPickOverflowTransItemDic)
      window:AddAndTryShowReward(CRData)
    end)
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "TaskNetworkCtrl:SC_QUEST_OneKeyPick error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_QUEST_OneKeyPick)
  end
  if msg.refreshPeriodQuest then
    self:SendQuestPeriodDetail()
  end
end

function TaskNetworkCtrl:Reset()
  self.lastSendDataList = {}
end

return TaskNetworkCtrl
