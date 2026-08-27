local UINMiniGameTaskDaily = class("UINMiniGameTaskDaily", UIBaseNode)
local base = UIBaseNode
local UINMiniGameTaskDailyItem = require("Game.ActivityHistoryTinyGame.UI.Task.UINMiniGameTaskDailyItem")
local TaskEnum = require("Game.Task.TaskEnum")
local JumpManager = require("Game.Jump.JumpManager")
local cs_MessageCommon = CS.MessageCommon

function UINMiniGameTaskDaily:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.down, self, self.OnClickReviewAll)
  self._taskPool = UIItemPool.New(UINMiniGameTaskDailyItem, self.ui.taskItem)
  self.ui.taskItem:SetActive(false)
  self.__OnReviewSingleCallback = BindCallback(self, self.__OnReviewSingle)
  self.__OnRefreshSingleCallback = BindCallback(self, self.__OnRefreshSingle)
  self._taskList = {}
end

function UINMiniGameTaskDaily:InitMiniGameTaskDaily(actTinyData)
  self._actTinyData = actTinyData
  self:RefreshMiniGameTaskDaily()
end

function UINMiniGameTaskDaily:RefreshMiniGameTaskDaily()
  local dailyIdList = self._actTinyData:GetTinyGameDailyTaskIds()
  local dailyDic = {}
  table.removeall(self._taskList)
  for i, taskId in ipairs(dailyIdList) do
    local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(taskId, true)
    dailyDic[taskId] = true
    table.insert(self._taskList, taskData)
  end
  for i, taskId in ipairs(self._actTinyData:GetTGCfgData().task_list) do
    local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(taskId, true)
    table.insert(self._taskList, taskData)
  end
  table.sort(self._taskList, function(a, b)
    if a.state ~= b.state then
      if a.state == TaskEnum.eTaskState.Picked then
        return false
      elseif b.state == TaskEnum.eTaskState.Picked then
        return true
      end
    end
    if dailyDic[a.id] ~= dailyDic[b.id] then
      return dailyDic[a.id] or false
    end
    local aComplect = a:CheckComplete()
    local bComplect = b:CheckComplete()
    if aComplect ~= bComplect then
      return aComplect and true or false
    end
    if a.stcData.order ~= b.stcData.order then
      return a.stcData.order < b.stcData.order
    end
    return a.id < b.id
  end)
  self._taskPool:HideAll()
  self.ui.down.gameObject:SetActive(false)
  local receiveCount = 0
  for i, taskData in ipairs(self._taskList) do
    local item = self._taskPool:GetOne()
    item:InitMiniGameTaskDailyItem(self._actTinyData, taskData, dailyDic[taskData.id], self.__OnReviewSingleCallback, self.__OnRefreshSingleCallback)
    if taskData:CheckComplete() then
      self.ui.down.gameObject:SetActive(true)
    end
    if taskData.state == TaskEnum.eTaskState.Picked then
      receiveCount = receiveCount + 1
    end
  end
  self.ui.tex_Progress:SetIndex(0, tostring(receiveCount), tostring(#self._taskList))
end

function UINMiniGameTaskDaily:OnClickReviewAll()
  local ids = {}
  local hasReceive = false
  for i, taskData in ipairs(self._taskList) do
    if taskData:CheckComplete() then
      ids[taskData.id] = true
      hasReceive = true
    end
  end
  if hasReceive then
    local taskNetCtrl = NetworkManager:GetNetwork(NetworkTypeID.Task)
    taskNetCtrl:CS_QUEST_OneKeyPick(ids, function()
      self._actTinyData:RefreshHTGTaskReddot(nil, true)
      if not IsNull(self.transform) then
        self:RefreshMiniGameTaskDaily()
      end
    end)
  end
end

function UINMiniGameTaskDaily:__OnReviewSingle(taskData)
  if taskData:CheckComplete() then
    local taskCtrl = ControllerManager:GetController(ControllerTypeId.Task)
    taskCtrl:SendCommitQuestReward(taskData, nil, function()
      if not IsNull(self.transform) then
        self:RefreshMiniGameTaskDaily()
      end
    end)
  elseif taskData.stcData.jump_id ~= nil and taskData.stcData.jump_id > 0 then
    JumpManager:Jump(taskData.stcData.jump_id, nil, nil, taskData.stcData.jumpArgs)
  end
end

function UINMiniGameTaskDaily:__OnRefreshSingle(taskData)
  if not self._actTinyData:IsActivityRunning() then
    return
  end
  local isComplete = taskData:CheckComplete()
  if isComplete then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(7502))
    return
  end
  local refreshTimes = self._actTinyData:GetTinyGameRefrehTimes()
  local refreshMax = self._actTinyData:GetTGCfgData().daily_task_refresh_max
  if refreshTimes >= refreshMax then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(7501))
    return
  end
  local tip = string.format(ConfigData:GetTipContent(7503), tostring(refreshMax - refreshTimes), tostring(refreshMax))
  cs_MessageCommon.ShowMessageBox(tip, function()
    self._actTinyData:ReqHTGDailyReplace(taskData.id, function()
      if not IsNull(self.transform) then
        self:RefreshMiniGameTaskDaily()
      end
    end)
  end, nil)
end

return UINMiniGameTaskDaily
