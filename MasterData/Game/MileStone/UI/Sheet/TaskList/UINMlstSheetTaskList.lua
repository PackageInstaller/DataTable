local base = UIBaseNode
local UINMlstSheetTaskList = class("UINMlstSheetTaskList", base)
local cs_Ease = CS.DG.Tweening.Ease
local UINMlstShetTaskListItem = require("Game.MileStone.UI.Sheet.TaskList.UINMlstShetTaskListItem")
local TaskData = require("Game.Task.Data.TaskData")
local MilestoneUtil = require("Game.MileStone.MilestoneUtil")
local TaskUtil = require("Game.Task.TaskUtil")
local TaskEnum = require("Game.Task.TaskEnum")

function UINMlstSheetTaskList:ctor(sheetRoot)
  self._sheetRoot = sheetRoot
end

function UINMlstSheetTaskList:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_PickAll, self, self._OnClickPickAll)
  self._taskItemDic = {}
  self.ui.scrollRect.onInstantiateItem = BindCallback(self, self.__OnNewItem)
  self.ui.scrollRect.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.__OnPickTaskFunc = BindCallback(self, self._OnPickTask)
  self._OnTaskUpdateFunc = BindCallback(self, self._OnTaskUpdate)
  MsgCenter:AddListener(eMsgEventId.TaskUpdate, self._OnTaskUpdateFunc)
  self._OnTaskRemoveFunc = BindCallback(self, self._OnTaskRemove)
  MsgCenter:AddListener(eMsgEventId.TaskDelete, self._OnTaskRemoveFunc)
end

function UINMlstSheetTaskList:InitMlstSheetTaskList(mlstDemitionData)
  self:Show()
  self._mlstDemitionData = mlstDemitionData
  self:_UpdList(true)
  self:_PlayTween()
end

function UINMlstSheetTaskList:_UpdList(refill)
  self:_UpdTaskData()
  self:_UpdatePickAll()
  self:_RefillScrollRect(refill)
  self._updTimer = nil
end

function UINMlstSheetTaskList:_UpdTaskData()
  self._taskDataList = {}
  self._completedTaskIdDic = {}
  self._taskIdDic = {}
  local pickableNum = 0
  local pickableScore = 0
  local scoreItemId = self._mlstDemitionData:GetMlstDimensionScoreItemId()
  local moduleId = self._mlstDemitionData:GetMlstDimensionId()
  local typeNum = #ConfigData.milestones_mile_task[moduleId]
  for i = 1, typeNum do
    local taskType = MilestoneUtil.GetMlstTaskType(moduleId, i)
    local taskIdDic = ConfigData.milestones_mile_task.mlstTaskTypeIdDic[taskType] or table.emptytable
    for taskId, v in pairs(taskIdDic) do
      if PlayerDataCenter.allTaskData.completedMilestoneTaskDic[taskId] then
        local taskCfg = ConfigData.task[taskId]
        if #taskCfg.next_task == 0 then
          local taskData = TaskData.CreatePickedTaskData(taskCfg)
          table.insert(self._taskDataList, taskData)
        end
      else
        local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(taskId)
        if taskData ~= nil then
          table.insert(self._taskDataList, taskData)
          self._taskIdDic[taskData.id] = taskData
          if not taskData:IsPickedTaskReward() and taskData:CheckComplete() then
            local score = MilestoneUtil.GetMlstTaskScore(taskData, scoreItemId)
            pickableScore = pickableScore + score
            pickableNum = pickableNum + 1
            self._completedTaskIdDic[taskData.id] = true
          end
        end
      end
    end
  end
  TaskUtil.SortTaskDataList(self._taskDataList)
  self._pickableNum = pickableNum
  self._pickableScore = pickableScore
end

function UINMlstSheetTaskList:_UpdatePickAll()
  self._canPickAll = self._pickableNum > 1
  local size = self.transform.sizeDelta
  size.y = self._canPickAll and size.y - self.ui.PickAll.transform.sizeDelta.y or size.y
  self.ui.scrollRect.transform.sizeDelta = size
  self.ui.PickAll:SetActive(self._canPickAll)
  if not self._canPickAll then
    return
  end
  self.ui.tex_AllPoint:SetIndex(0, tostring(self._pickableScore))
end

function UINMlstSheetTaskList:_RefillScrollRect(refill)
  self.ui.scrollRect.totalCount = #self._taskDataList
  if refill then
    self.ui.scrollRect:RefillCells()
  else
    self.ui.scrollRect:RefreshCells()
  end
end

function UINMlstSheetTaskList:__OnNewItem(go)
  local item = UINMlstShetTaskListItem.New()
  item:Init(go)
  self._taskItemDic[go] = item
end

function UINMlstSheetTaskList:__OnChangeItem(go, index)
  local item = self._taskItemDic[go]
  if item == nil then
    error("Can't find item by gameObject")
    return
  end
  local taskData = self._taskDataList[index + 1]
  if taskData == nil then
    error("Can't find taskData by index, index = " .. tonumber(index))
  end
  local scoreItemId = self._mlstDemitionData:GetMlstDimensionScoreItemId()
  item:InitMlstShetTaskListItem(taskData, scoreItemId, self.__OnPickTaskFunc)
end

function UINMlstSheetTaskList:_OnClickPickAll()
  self._sheetRoot:PickMlstTaskDicReward(self._completedTaskIdDic)
end

function UINMlstSheetTaskList:_OnPickTask(taskData)
  self._sheetRoot:PickMlstTaskReward(taskData)
end

function UINMlstSheetTaskList:_OnTaskUpdate(taskData, isNewTask)
  if not self.active or self._taskIdDic[taskData.id] == nil then
    return
  end
  if self._updTimer == nil then
    self._updTimer = TimerManager:StartTimer(1, self._UpdList, self, true, true)
  end
end

function UINMlstSheetTaskList:_OnTaskRemove(taskId)
  if not self.active or self._taskIdDic[taskId] == nil then
    return
  end
  if self._updTimer == nil then
    self._updTimer = TimerManager:StartTimer(1, self._UpdList, self, true, true)
  end
end

function UINMlstSheetTaskList:_PlayTween()
  self:_ClearTween()
  local durationTime = 0.5
  if self._canPickAll then
    self.ui.PickAll.transform:DOLocalMoveX(-70, durationTime):From():SetLink(self.gameObject):SetEase(cs_Ease.OutQuart):SetDelay(0.1)
    self.ui.canvas_PickAll:DOFade(0, durationTime):From():SetLink(self.gameObject):SetEase(cs_Ease.OutQuart):SetDelay(0.1)
  end
  for index, _ in ipairs(self._taskDataList) do
    local obj = self.ui.scrollRect:GetCellByIndex(index - 1)
    local taskItem = self._taskItemDic[obj]
    if taskItem == nil then
      return
    end
    if self._canPickAll then
      index = index + 1
    end
    taskItem.transform:DOLocalMoveX(-70, durationTime):From():SetLink(self.gameObject):SetEase(cs_Ease.OutQuart):SetDelay(0.1 + (index - 1) * 0.05)
    taskItem.ui.canvas_taskItem:DOFade(0, durationTime):From():SetLink(self.gameObject):SetEase(cs_Ease.OutQuart):SetDelay(0.1 + (index - 1) * 0.05)
  end
end

function UINMlstSheetTaskList:_ClearTween()
  self.ui.PickAll.transform:DOComplete()
  self.ui.canvas_PickAll:DOComplete()
  for go, taskItem in pairs(self._taskItemDic) do
    taskItem.transform:DOComplete()
    taskItem.ui.canvas_taskItem:DOComplete()
  end
end

function UINMlstSheetTaskList:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.TaskUpdate, self._OnTaskUpdateFunc)
  MsgCenter:RemoveListener(eMsgEventId.TaskDelete, self._OnTaskRemoveFunc)
  if self._updTimer then
    TimerManager:StopTimer(self._updTimer)
  end
  for k, v in pairs(self._taskItemDic) do
    v:Delete()
  end
  base.OnDelete(self)
end

return UINMlstSheetTaskList
