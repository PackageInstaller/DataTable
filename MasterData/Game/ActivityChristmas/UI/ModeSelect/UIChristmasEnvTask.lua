local UIChristmasEnvTask = class("UIChristmasEnvTask", UIBaseWindow)
local base = UIBaseWindow
local UINChristmasEnvTaskItem = require("Game.ActivityChristmas.UI.ModeSelect.UINChristmasEnvTaskItem")
local JumpManager = require("Game.Jump.JumpManager")

function UIChristmasEnvTask:OnInit()
  UIUtil.SetTopStatus(self, self.OnCloseTask, nil, nil, nil, true)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.OnClickBack)
  UIUtil.AddButtonListener(self.ui.btn_background, self, self.OnClickBack)
  UIUtil.AddButtonListener(self.ui.btn_ReceiveAll, self, self.OnClickGetAllTask)
  self.ui.loop_scroll.onInstantiateItem = BindCallback(self, self.__OnNewItem)
  self.ui.loop_scroll.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.__OnGetTaskDataCallback = BindCallback(self, self.__OnGetTaskData)
  self.__OnGotoTaskDataCallback = BindCallback(self, self.__OnGotoTaskData)
  self.__RefillFromExternalCallback = BindCallback(self, self.__RefillFromExternal)
  self.__TaskChangeCallback = BindCallback(self, self.__TaskProcessUpdate)
  MsgCenter:AddListener(eMsgEventId.TaskUpdate, self.__TaskChangeCallback)
  self._itemDic = {}
end

function UIChristmasEnvTask:InitChristmasEnvTask(taskIdlist, allGetCallback, singleGetCallback)
  self._taskIdDic = {}
  for i, v in ipairs(taskIdlist) do
    self._taskIdDic[v] = true
  end
  self._allGetCallback = allGetCallback
  self._singleGetCallback = singleGetCallback
  self:__Refill()
end

function UIChristmasEnvTask:__Refill()
  self._taskDataList = {}
  local totalCount = 0
  local finishCount = 0
  local isCanGet = false
  for taskId, _ in pairs(self._taskIdDic) do
    local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(taskId, true)
    table.insert(self._taskDataList, taskData)
    totalCount = totalCount + 1
    if taskData.isPicked then
      finishCount = finishCount + 1
    end
    isCanGet = isCanGet or taskData:CheckComplete()
  end
  table.sort(self._taskDataList, function(a, b)
    if a.isPicked ~= b.isPicked then
      return b.isPicked
    end
    local isComplete = a:CheckComplete()
    if isComplete ~= b:CheckComplete() then
      return isComplete
    end
    return a.id < b.id
  end)
  self._taskItemDic = {}
  self.ui.tex_taskCount:SetIndex(0, tostring(finishCount), tostring(totalCount))
  self.ui.loop_scroll.totalCount = totalCount
  self.ui.loop_scroll:RefreshCells()
  self.ui.btn_ReceiveAll.gameObject:SetActive(isCanGet)
end

function UIChristmasEnvTask:__RefillFromExternal()
  if not IsNull(self.transform) then
    self:__Refill()
  end
end

function UIChristmasEnvTask:SetChristmasEnvTaskTitle(titleName)
  self.ui.tex_SkillName.text = titleName
end

function UIChristmasEnvTask:__OnNewItem(go)
  local taskItem = UINChristmasEnvTaskItem.New()
  taskItem:Init(go)
  self._itemDic[go] = taskItem
end

function UIChristmasEnvTask:__OnChangeItem(go, index)
  local taskItem = self._itemDic[go]
  local taskData = self._taskDataList[index + 1]
  taskItem:InitChristmasEnvTaskItem(taskData, self.__OnGetTaskDataCallback, self.__OnGotoTaskDataCallback)
  self._taskItemDic[taskData.id] = taskItem
end

function UIChristmasEnvTask:__OnGetTaskData(taskData)
  if self._singleGetCallback ~= nil then
    self._singleGetCallback(taskData.id, self.__RefillFromExternalCallback)
  end
end

function UIChristmasEnvTask:__OnGotoTaskData(taskData)
  if taskData.stcData.jump_id ~= nil and taskData.stcData.jump_id > 0 then
    JumpManager:Jump(taskData.stcData.jump_id, nil, nil, taskData.stcData.jumpArgs)
  end
end

function UIChristmasEnvTask:OnClickGetAllTask()
  local list = {}
  for i, v in ipairs(self._taskDataList) do
    if v:CheckComplete() then
      table.insert(list, v.id)
    end
  end
  if self._allGetCallback ~= nil then
    self._allGetCallback(list, self.__RefillFromExternalCallback)
  end
end

function UIChristmasEnvTask:__TaskProcessUpdate(taskData)
  if self._taskIdDic[taskData.id] == nil then
    return
  end
  if taskData:CheckComplete() then
    self:__Refill()
    return
  end
  local item = self._taskItemDic[taskData.id]
  if item ~= nil and item:GetEnvTaskId() == taskData.id then
    item:RefreshChristmasEnvTaskItem()
  end
end

function UIChristmasEnvTask:OnClickBack()
  UIUtil.OnClickBackByUiTab(self)
end

function UIChristmasEnvTask:OnCloseTask()
  self:Delete()
end

function UIChristmasEnvTask:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.TaskUpdate, self.__TaskChangeCallback)
  base.OnDelete(self)
end

return UIChristmasEnvTask
